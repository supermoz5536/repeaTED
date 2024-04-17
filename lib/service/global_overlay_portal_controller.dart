import 'package:flutter/material.dart';


class GlobalOverlayPortalController {
  static final OverlayPortalController controller = OverlayPortalController();

  static void toggleOverlay() {
    controller.toggle();
  }
}