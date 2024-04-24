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
  // 'v=' 以降の文字列において、
  // 次の&文字が出現するか、
  // URLの末尾に到達するまでの部分にマッチします。

  // 'be/(.+)$' は
  // Youtubeの短縮URL形式を扱います。
  // 'be/' 以降の文字列において、
  // 次の&文字が出現するか、
  // URLの末尾に到達するまでの部分にマッチしま
  final RegExp regExp = RegExp(r'[&?]v=([^&]+)|be/(.+)$');

  // 作成した正規表現オブジェクトを用いて、
  // 引数のurl文字列に対する最初のマッチを検索し、
  // 結果をmatchに格納します。
  // Match型は、
  // マッチした文字列の具体的な内容、
  // マッチした部分の位置（インデックス）、
  // および正規表現内で区分けられた各グループに関する情報を提供します。
  final Match? match = regExp.firstMatch(url!);

  if (match != null && match.groupCount >= 1) {
    // 最初のグループが空でない場合、それを使用
    if (match.group(1) != null) {
      return match.group(1)!;
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






}

