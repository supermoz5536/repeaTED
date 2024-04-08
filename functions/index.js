const functions = require("firebase-functions");
const {getSubtitles} = require("youtube-captions-scraper");

exports.getCaptions = functions.https.onCall(async (data, context) => {
  const videoId = data.videoId;
  const languages = ["en", "ja"];
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
