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
      final String response = await rootBundle.loadString('assets/jsons/1_recommend.json');
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
      final String response = await rootBundle.loadString('assets/jsons/2_ted_stage_talk.json');
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
      final String response = await rootBundle.loadString('assets/jsons/3_ted_ed.json');
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
      final String response = await rootBundle.loadString('assets/jsons/4_ted_talk.json');
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
      final String response = await rootBundle.loadString('assets/jsons/5_ted_institute_talk.json');
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
      final String response = await rootBundle.loadString('assets/jsons/6_ted_salon_talk.json');
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
      final String response = await rootBundle.loadString('assets/jsons/7_original_content.json');
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
      final String response = await rootBundle.loadString('assets/jsons/8_tabi_eats.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadRachelAndJun() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/9_rachel_and_jun.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }

  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadPaoloromTokyo() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/10_paolo_from_tokyo.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadAbroadInJapan() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/11_abroad_in_japan.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadPinkfong() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/12_pinkfong.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadCookingWithDog() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/13_cooking_with_dog.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadJunsKitchen() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/14_juns_kitchen.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadWaoRyuOnlyInJapan() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/15_wao_ryu_only_in_japan.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadDocumentary() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/16_documentary.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadEigaCom() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/17_eiga_com.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadAnimeIllustration() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/18_anime_illustration.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadUnrealEngineJp() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/19_unreal_engine_jp.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }

  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadhealing() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/20_healing.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTripVlog() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/21_trip_vlog.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadSamuraiJunjiroChannel() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/22_samurai_junjiro_channel.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadTalesFromOurPocket() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/23_tales_from_our_pocket.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }

  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadGlitch() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/24_glitch.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }

  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadGoodKids() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/25_good_kids.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }

  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadLearnEnglish() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/26_learn_english.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }

  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadQualityOfEnglishLife() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/27_quality_of_english_life.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }


  /// List<Video>?型のオブジェクトを生成する関数です。
  static Future<List<Video>?> loadAnimeCG() async {
    try {
      final String response = await rootBundle.loadString('assets/jsons/28_anime_cg.json');
      final List<dynamic> data = jsonDecode(response!) as List;
        return data.map((item) => Video.fromJson(item as Map<String, dynamic>)).toList();
    } catch (error) {
      print('loadTedEd の実行失敗  ==  $error');
      return null;
    }
  }

}


