import 'package:repea_ted/service/video.dart';

class Utility {

/// String型のurlを引数として受け取り、文字列を返します。
static String? extractVideoId(String? url) {

  // RegExpクラスを用いて、
  // YouTube URLからビデオIDを抽出するパターンに
  // マッチする正規表現オブジェクト regExp を生成します。
  // 二つのマッチパターンがあります。

  // '[&?]v=([^&]+)' は
  // Youtubeの通常のURL形式を扱います。
  // [&?]: これは文字クラスで、& または ? のどちらかにマッチします。
  // これは、YouTubeのURLパラメータが & または ? で始まることを考慮しています。
  // v=: これは固定文字列で、YouTubeのビデオIDパラメータ v にマッチします。
  // ( と ): これはキャプチャグループで、この中にマッチした文字列が後で参照できるようになります。
  // [^&]: これは否定の文字クラスで、& 以外の任意の文字にマッチします。
  // +: これは直前の要素が1回以上繰り返されることを示します。
  // したがって、[^&]+ は & 以外の文字が1回以上連続する部分にマッチします。
  // URLの末尾に到達するまでの部分にマッチします。

  // |: これは論理ORを意味し、前の部分または後の部分のいずれかにマッチします。

  // 'be/(.+)$' は
  // Youtubeの短縮URL形式を扱います。
  // be/: これは固定文字列で、YouTubeの短縮URL形式の be/ にマッチします。
  // ( と ): これはキャプチャグループで、この中にマッチした文字列が後で参照できるようになります。
  // ^: これは否定の意味を持つ文字クラスの開始です。次に続く文字を否定します。
  // ?&: 否定する文字をリストしています。この場合、? と & を否定しています。
  // [^?&]: これは ? と & 以外の任意の文字にマッチします。
  // つまり、([^?&]+) という部分は、? や & が現れた瞬間にマッチが終了します。
  final RegExp regExp = RegExp(r'[&?]v=([^&]+)|be/([^?&]+)');

  // 作成した正規表現オブジェクトを用いて、
  // 引数のurl文字列に対する最初のマッチを検索し、
  // 結果をmatchに格納します。
  // Match型は、
  // マッチした文字列の具体的な内容、
  // マッチした部分の位置（インデックス）、
  // および正規表現内で区分けられた各グループに関する情報を提供します。
  final Match? match = regExp.firstMatch(url!);

  if (match != null && match.groupCount >= 1) {
    // 通常URLと共有用URLで2つのキャプチャグループ()()を使ってるので
    // 取得できてる場合は各々出力
    if (match.group(1) != null) {
      return match.group(1)!;
    }
    if (match.group(2) != null) {
      return match.group(2)!;
    }
  }
  // マッチしない場合、空の文字列を返す
  return null;
}



  static String? extractTitle(Video? videoObject) {
    String? extractedTitle;
      extractedTitle = videoObject!.titleJa!.split(RegExp(r':|：')).last.trim();
      return extractedTitle;
  }



  static String? extractSpeakerName(Video? videoObject) {
    String? extractedSpeakerName;
      extractedSpeakerName = videoObject!.titleJa!.split(RegExp(r':|：')).first.trim();
      return extractedSpeakerName;
  }


  static String? extractChannelName(Video? videoObject) {
    String? extractedChannelName;
      extractedChannelName = videoObject!.channel;
      return extractedChannelName;
  }


  static List<List<Video?>?>? splitToPagedList(List<Video?>? wholeItems) {
    List<List<Video?>?>? pagedList = [];
    int? itemsPerPage = 33;
      // 配列の最後の値を超えるまで
      // indexを30ずつ加算してループ処理を行います
      for (int i = 0; i < wholeItems!.length; i = i + itemsPerPage ) {
        pagedList.add(
          wholeItems.sublist(
            i, i + itemsPerPage < wholeItems.length
            ? i + itemsPerPage
            : wholeItems.length,
          )
        );
      }
      return pagedList;
  }


static String? extractJapaneseText(String? captionText) {
  // 英語の単語で始まる行を特定する正規表現
  // (?!.*[ぁ-んァ-ヶ]). の部分で、
  // まず行内に日本語がある場合は除く処理を行う
  // その後で、
  // 英語で始まるか、
  // 数字で始まり、0回以上の空白行を挟んで、英語が続くか
  // の行を取得する。
  RegExp regExp = RegExp(
    r'^(?!.*[ぁ-んァ-ヶ]).*?([A-Za-z]+|\d+[ \t]*[A-Za-z]+).*',
    multiLine: true
  );

  // 取得した行を空文字に変換してトリムする。
  return captionText!.replaceAll(regExp, '').trim();
}



}

