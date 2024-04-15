import 'dart:convert';

import 'package:flutter/services.dart';

class Video {
  String? titleIndex;
  String? titleEn;
  String? titleJa;
  String? videoId;

  // デフォルトのコンストラクタ
  Video({
    this.titleIndex,
    this.titleEn,
    this.titleJa,
    this.videoId,
  });

  // jsonファイルのdataを使ってVideoオブジェクトを生成するコンストラクタです。
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      titleIndex: json['title_index'] as String?,
      titleEn: json['title_en'] as String?,
      titleJa: json['title_ja'] as String?,
      videoId: json['video_id'] as String?,
    );
  }

  /// TEDx Talk.json のdataから
  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadVideos() async {
    try {
      final String? response = await rootBundle.loadString('assets/videos/TEDx Talk.json');
      // リストの各要素に対して型キャストを行う場合は、
      // asキーワードをmap()メソッド内で各アイテムに適用する必要があります。
      // なのでjsonDecodeの出力時にはキャストできません
      if (response != null) {
        final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
      } else {
        return null;
      }
    } catch (error) {
      print('loadVideosの実行失敗: jsonファイルからのVideoオブジェクトの変換取得に失敗しました');
      return null;
    }
  }
}

