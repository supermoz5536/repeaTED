import 'package:firebase_analytics/firebase_analytics.dart';


class CustomAnalytics {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;


static Future<void> logMainIn() async {
    await _analytics.logEvent(name: 'MainIn');
  }

}

