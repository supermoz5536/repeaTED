import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 動画視聴ページの読み上げ速度を管理するNotifierクラスです。
class SpeedValueNotifier extends StateNotifier<double?> {

  SpeedValueNotifier(double? initialSpeedValue) : super(initialSpeedValue);

  void setSpeedValue(double? newSpeedValue) {
    state = newSpeedValue;
  }

}

