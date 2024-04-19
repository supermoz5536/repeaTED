import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:repea_ted/analytics/custom_analytics.dart';
import 'package:repea_ted/firebase_options.dart';
import 'package:repea_ted/model/page_transition_constructor.dart';
import 'package:repea_ted/page/top.dart';


void main() async {
  // splashの設定のために変数に格納して、メソッドの引数にしてる 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await CustomAnalytics.logMainIn();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const ProviderScope(child: MyApp()),
  ));
}



class MyApp extends ConsumerWidget {
// class MyApp extends StatelessWidget {
// Riverpod用の書き換えバックアップ
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
  PageTransitionConstructor? constructor =  PageTransitionConstructor(
                                              flagNumber: 0,
                                              currentPageIndex: 0
                                            );

    return MaterialApp(
      title: 'repeaTED',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TopPage(constructor),
    );
  }
}
