import 'dart:convert';

import 'package:flutter/services.dart';

class Video {
  String? titleIndex;
  String? channel;
  String? titleEn;
  String? titleJa;
  String? videoId;

  // デフォルトのコンストラクタ
  Video({
    this.titleIndex,
    this.channel,
    this.titleEn,
    this.titleJa,
    this.videoId,
  });

  // jsonファイルのdataを使ってVideoオブジェクトを生成するコンストラクタです。
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      titleIndex: json['title_index'] as String?,
      channel: json['video_channel'] as String?,
      titleEn: json['title_en'] as String?,
      titleJa: json['title_ja'] as String?,
      videoId: json['video_id'] as String?,
    );
  }



  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadRecommend() async {
    try {
      final String response = await rootBundle.loadString('jsons/1_recommend.json');
      // リストの各要素に対して型キャストを行う場合は、
      // asキーワードをmap()メソッド内で各アイテムに適用する必要があります。
      // なのでjsonDecodeの出力時にはキャストできません
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadRecommend の実行失敗  ==  $error');
      return null;
    }
  }

  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTedStageTalk() async {
    try {
      final String response = await rootBundle.loadString('jsons/2_ted_stage_talk.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedStageTalk の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTedEd() async {
    try {
      final String response = await rootBundle.loadString('jsons/3_ted_ed.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTedTalk() async {
    try {
      final String response = await rootBundle.loadString('jsons/4_ted_talk.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTedInstituteTalk() async {
    try {
      final String response = await rootBundle.loadString('jsons/5_ted_institute_talk.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTedSalonTalk() async {
    try {
      final String response = await rootBundle.loadString('jsons/6_ted_salon_talk.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadOriginalContent() async {
    try {
      final String response = await rootBundle.loadString('jsons/7_original_content.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTabiEats() async {
    try {
      final String response = await rootBundle.loadString('jsons/8_tabi_eats.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


}

