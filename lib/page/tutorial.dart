import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:repea_ted/analytics/custom_analytics.dart';
import 'package:repea_ted/firebase_options.dart';
import 'package:repea_ted/model/page_transition_constructor.dart';
import 'package:repea_ted/page/1_top.dart';


class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          transitionToTopPage(context);
        },
        finishCallback: () {
          transitionToTopPage(context);
        },
      ),
    );
  }

  void transitionToTopPage(BuildContext context) {
    if (context.mounted) {
      PageTransitionConstructor? constructor = PageTransitionConstructor(
                                                  flagNumber: -2,
                                                  currentPageIndex: 0
                                               );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TopPage(constructor)),
        );
    }
  }


  final pages = [
    PageModel(
        color: const Color(0xFF95cedd),
        imageAssetPath: 'assets/pics/icon.png',
        title: '文字を表示できます',
        body: '細かい説明をbodyに指定して書くことが出来ます',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/pics/icon.png',
        title: '左右のスワイプ',
        body: 'NEXTを押さなくても左右にスワイプすることで画面の切替が出来ます',
        doAnimateImage: true),
    PageModel.withChild(
        child: Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              "さあ、始めましょう",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            )),
        color: const Color(0xFF5886d6),
        doAnimateChild: true)
  ];

}