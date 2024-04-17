import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repea_ted/riverpod/notifier/recommend_list_notifier.dart';
import 'package:repea_ted/service/video.dart';


final recommendListProvider = StateNotifierProvider<RecommendListNotifier, List<Video?>?>((ref) {

  /// StateNotifierProvider の初期値の設定（初めて参照された時にのみ使用される）
  List<Video?>? initialRecommendList = [];

  // 生成したインスタンスの保持する状態を consumer が読み取る。
  return RecommendListNotifier(initialRecommendList);
});






