import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repea_ted/service/video.dart';

/// RecommendListNotifier
/// StateNotifier<List<Video?>?> 拡張しており、
/// 状態を編集するのが目的のクラスです。
class RecommendListNotifier extends StateNotifier<List<Video?>?> {

  RecommendListNotifier(List<Video?>? initialRecommendList) : super(initialRecommendList);


  /// [...shuffledRecommendList] はスプレッド演算子を使用して
  /// リスト shuffledRecommendList の各要素を新しいリストに再構築します。
  /// つまり、再インスタンス化しているので
  /// メモリのアドレスが変更されてriverpodが
  /// 通知をキャッチし、UIの再描画を行うことができます。
  void setShuffledRecommendList(List<Video?>? shuffledRecommendList) {
    state = [...shuffledRecommendList!];
  }

  void clearDMNotifications() {
    state = null;
  }

}

