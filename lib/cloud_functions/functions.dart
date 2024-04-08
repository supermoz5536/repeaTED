import 'package:cloud_functions/cloud_functions.dart';
import 'package:repea_ted/model/caption_tracks.dart';


class CloudFunctions{

/// 字幕データをスクレイピングする getCaptions関数 の呼び出し関数
static Future<CaptionTracks?> callGetCaptions(String? videoId) async {
  try {
    final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('getCaptions');
    final HttpsCallableResult result = await callable.call({
      'videoId': videoId,
    });
    Map<String, dynamic> mapResult = result.data as Map<String, dynamic>;
    CaptionTracks captions = CaptionTracks(
                               en: mapResult['en'],
                               ja: mapResult['ja'],
                             );
    return captions;
  } catch (error) {
    print('callGetCaptions エラー == $error');
    return null;
  }
}


}