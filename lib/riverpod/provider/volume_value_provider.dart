import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repea_ted/riverpod/notifier/volume_value_notifier.dart';

final volumeValueProvider = StateNotifierProvider<VolumeValueNotifier, double?>((ref) {

  /// 初期値の設定（初めて参照された時にのみ使用される）
  double? initialVolumeValue = 0.8;

  // 生成したインスタンスの保持する状態を consumer が読み取る。
  return VolumeValueNotifier(initialVolumeValue);
});






