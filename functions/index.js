const functions = require("firebase-functions");
const {getSubtitles} = require("youtube-captions-scraper");
// heはHTML内の各要素のエンコードおよびデコードを行うライブラリです。
// HTMLデータに含まれている字幕データをデコードするために使用します。
const he = require("he");
// axiosは、HTTPリクエストを行うためのライブラリです。
// データを取得するために使用します。
const axios = require("axios");
// lodashは、多くのユーティリティ関数を提供するライブラリです。
// ここでは、配列内の特定の要素を見つけるためのfind関数を使用します。
const {find} = require("lodash");
// HTMLタグを除去するためのライブラリです。
// 字幕のテキストから不要なHTMLタグを削除するために使用します。
const striptags = require("striptags");


exports.getCaptionsURL = functions.https.onCall(async (data, context) => {
  const videoId = data.videoId;
  const results = {};
  try {
    // 動画視聴ページのhtmlデータを丸ごとダウンロード
    const htmlResponse = await axios.get(`https://youtube.com/watch?v=${videoId}`);
    const htmlData = htmlResponse.data;

    // * ensure we have access to captions data
    // html内にcaptionデータにアクセスするための
    // captionTracksの文字列がない場合は、例外をスロー
    if (!htmlData.includes("captionTracks")) {
      throw new Error(`Could not find captions for video: ${videoId}`);
    }

    // json配列の文字列を正規表現で抽出します。
    // "captionTracks" の文字列から始まり
    // \[から始まり、次に現れる最短の\]までの間を
    // 取得する表現です。
    const regex = /"captionTracks":(\[.*?\])/;

    // 分割代入によって、
    // 正規表現のマッチ結果のキャプチャグループの最初の要素
    // つまり、[.*?] に一致する部分（マッチした JSON 配列の文字列）
    // つまり、マッチ結果の最初の要素（マッチした全体の文字列）を代入します。
    // 具体的には "captionTracks": とその後に続く JSON 配列全体が含まれます。
    const [match] = regex.exec(htmlData);

    // match には "captionTracks":[{...}]の形式で文字列が含まれており、
    // その前後に {} を追加することで、{ "captionTracks": [{...}] } という
    // 完全なJSONオブジェクトの形式にします。
    // それをJson.parseメソッドで、
    // メソッドで扱えるように、JavaScriptオブジェクトに変換します。
    const {captionTracks} = JSON.parse(`{${match}}`);

    const subtitle =
      find(captionTracks, {
        vssId: ".ja",
      }) ||
      find(captionTracks, {
        vssId: ".en",
      }) ||
      find(captionTracks, {
        vssId: ".en-US",
      }) ||
      find(captionTracks, {
        vssId: ".en-GB",
      }) ||
      find(captionTracks, {
        vssId: ".en-CA",
      }) ||
      find(captionTracks, (track) => track.vssId.startsWith(".en")) ||
      find(captionTracks, {
        vssId: "a.en",
      });

    // 字幕の検索処理の結果を判定します
    // !subtitle: 字幕が見つからなかった場合（nullの場合）
    // subtitle == nullではないが、中身にbaseUrlが存在しない場合）、

    // subtitleには次のいずれかのデータが格納されます
    // 条件に一致する字幕トラックオブジェクト（{ vssId: '.en', baseUrl: 'http//....' }など）。
    if (!subtitle || (subtitle && !subtitle.baseUrl)) {
      throw new Error(`Could not find captions for ${videoId}`);
    }

    // vssIdが .ja の場合は、baseUrlをそのまま使用して字幕を取得
    // vssIdが .ja でない時は、baseUrlの末尾に&tlang=jaを加えて日本語翻訳字幕を取得
    const transcriptResponse = subtitle.vssId === ".ja" ?
      await axios.get(subtitle.baseUrl) :
      await axios.get(subtitle.baseUrl + "&tlang=ja");

    const transcript = transcriptResponse.data;

    const lines = transcript
    // transcriptの文字列から、必要のないシステムメッセージの
    // XMLヘッダー<?xml version="1.0" encoding="utf-8" ?><transcript>
    // を空文字に書き換えて削除します。
        .replace("<?xml version=\"1.0\" encoding=\"utf-8\" ?><transcript>", "")
        .replace("</transcript>", "")

    // </text>タグは、字幕の各行の終了タグであるため、これを使って行ごとに分割します。
        .split("</text>")

    // 該当の行が存在する場合に、空白部分をトリムした文字列を返します
        .filter((line) => line && line.trim())

    // 各Lineごとに、字幕の開始時間、継続時間、およびテキストを抽出します。
        .map((line) => {
          const startRegex = /start="([\d.]+)"/;
          const durRegex = /dur="([\d.]+)"/;

          const [, start] = startRegex.exec(line);
          const [, dur] = durRegex.exec(line);

          const htmlText = line
              .replace(/<text.+>/, "")
              .replace(/&amp;/gi, "&")
              .replace(/<\/?[^>]+(>|$)/g, "");

          const decodedText = he.decode(htmlText);
          const text = striptags(decodedText);

          return {
            start,
            dur,
            text,
          };
        });

    // 以下でMap型のresultsに格納されます。
    // キー：language
    // 値 : subtitles
    results["ja"] = lines;
    return results;
  } catch (error) {
    console.error(`Error fetching captions:`, error);
    throw new functions.https.HttpsError(
        "internal",
        `Failed to fetch captions`,
    );
  }
});

exports.getCaptionsJa = functions.https.onCall(async (data, context) => {
  const videoId = data.videoId;
  const languages = ["ja"];
  // 異なる言語コードをキーとして、
  // それぞれの言語に対応する字幕データ（配列形式）を
  // 値として持たせるため
  // 空のオブジェクトとして初期化します。
  const results = {};
  // languages配列に含まれる言語コードについて、一つずつ処理を行います。
  for (const language of languages) {
    try {
      const captions = await getSubtitles({
        videoID: videoId,
        lang: language,
      });
      // 以下でMap型のresultsに格納されます。
      // キー：language
      // 値 : subtitles
      results[language] = captions;
    } catch (error) {
      results[language] = [];
      console.error(`Error fetching captions for lang ${language}:`, error);
      throw new functions.https.HttpsError(
          "internal",
          `Failed to fetch captions for lang ${language}`,
      );
    }
  }
  return results;
});
