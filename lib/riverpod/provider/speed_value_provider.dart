import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repea_ted/riverpod/notifier/speed_value_notifier.dart';

final speedValueProvider = StateNotifierProvider<SpeedValueNotifier, double?>((ref) {

  /// 初期値の設定（初めて参照された時にのみ使用される）
  double? initialSpeedValue = 1.0;

  // 生成したインスタンスの保持する状態を consumer が読み取る。
  return SpeedValueNotifier(initialSpeedValue);
});






