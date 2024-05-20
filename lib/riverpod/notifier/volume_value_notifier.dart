import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 動画視聴ページの読み上げ音量を管理するNotifierクラスです。
class VolumeValueNotifier extends StateNotifier<double?> {

  VolumeValueNotifier(double? initialVolumeValue) : super(initialVolumeValue);

  void setVolumeValue(double? newVolumeValue) {
    state = newVolumeValue;
  }

}

