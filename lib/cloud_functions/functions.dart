import 'package:cloud_functions/cloud_functions.dart';
import 'package:repea_ted/model/caption_tracks.dart';


class CloudFunctions{

/// 字幕データをスクレイピングする getCaptions関数 の呼び出し関数
static Future<CaptionTracks?> callGetCaptions(String? videoId) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getCaptionsJa');
    final HttpsCallableResult result = await callable.call({
      'videoId': videoId,
    });
    Map<String, dynamic> mapResult = result.data as Map<String, dynamic>;
    CaptionTracks captions = CaptionTracks(
                               en: mapResult['en'] ?? [],
                               ja: mapResult['ja'] ?? [],
                             );
    return captions;
  } catch (error) {
    print('callGetCaptions エラー == $error');
    return null;
  }
}


/// 動画URLの直接入力で字幕をスクレイピングする getCaptions関数 の呼び出し関数
static Future<CaptionTracks?> callGetCaptionsURL(String? videoId) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getCaptionsURL');
    final HttpsCallableResult result = await callable.call({
      'videoId': videoId,
    });
    Map<String, dynamic> mapResult = result.data as Map<String, dynamic>;        
    CaptionTracks captions = CaptionTracks(
                               en: mapResult['en'] ?? [],
                               ja: mapResult['ja'] ?? [],
                             );
    return captions;
  } catch (error) {
    print('callGetCaptionsURL エラー == $error');
    return null;
  }
}



}