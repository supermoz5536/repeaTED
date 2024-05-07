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
import 'package:repea_ted/shared_prefes.dart';


class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}



class _TutorialPageState extends State<TutorialPage> {

  // @override
  // void initState() {
  //   super.initState();
  // } 

  @override
  Widget build(BuildContext context) {
      final pages = [
    PageModel(
        color: const Color(0xFF81C784),
        imageAssetPath: 'assets/pics/listening.png',
        title: 'YouTube動画を使う\n英語多聴アプリ！',
        body: 'TraceSpeakerは\nリスニング力の向上に特化して\n"ながら"インプットを強力サポート',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFFF28B82),
        imageAssetPath: 'assets/pics/enjoy.png',
        title: '楽しむ > 上達',
        body: '英語の上達自体が目的じゃなくて\n動画を楽しむ過程で上達したい\n\nそういう英語のマッチョイズムから\n解放されたい人のためのアプリです',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/pics/2step.png',
        title: '使い方の2ステップ',
        body: '①まず英語を"全集中"で聞きます。\n②聞き取れなかった部分を直後に流れる日本語を頼りにして、脳内で答え合わせをします。このプロセスの積み重ねで耳が開発されます。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF5886d6),
        imageAssetPath: 'assets/pics/continue.png',
        title: '止めずに聴き流す', 
        body: '聞き取れない箇所があっても、動画を止めて確認しないでください。\n脳が動画を停止できることを学習すると、一発勝負の緊張感がなくなって学習効果が下がってしまいます。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF81C784),
        imageAssetPath: 'assets/pics/cheese.png',
        title: '穴だらけでもOK', 
        body: 'なので一回の視聴で単語や文法を\n完璧にしようとしないでください。\nそれは英語マッチョイズムです。\n動画を楽しむことが優先。遠回りに見えてそれが上達の秘訣です。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFFF28B82),
        imageAssetPath: 'assets/pics/interesting.png',
        title: 'Easy to Hard',
        body: '動画は英検の級別になってるので\n簡単なレベルから始めましょう。\n徐々に難しい動画に移行していくと\n難しい動画だけ取り組むよりも高い学習効果があります。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF5886d6),
        imageAssetPath: 'assets/pics/search.png',
        title: '好きだと上達も早い',
        body: '興味のある事柄はより少ない反復で習熟できます。ぜひ、他の誰かではなく "あなた" が興味を感じる動画を探してください。',
        doAnimateImage: true),
    PageModel(
        color: const Color(0xFF9B90BC),
        imageAssetPath: 'assets/pics/repeat.png',
        title: '継続は力なり',
        body: '動画は自動でループするので、飽きるまで繰り返しましょう。無意識レベルの深い部分まで学習が浸透すると、スムーズなアウトプットの下地となるような応用の効く知識になります。',
        doAnimateImage: true),
    PageModel.withChild(
        child: const Padding(
            padding: EdgeInsets.only(bottom: 25.0),
            child: Text(
              "さぁ、はじめましょう!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            )),
        color: const Color(0xFF95cedd),
        doAnimateChild: true)
  ];

    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipText: 'スキップ',
        nextText: '次へ',
        finishText: '閉じる',
        skipCallback: () {
          setState(() {
           transitionToTopPage(context);   
          });
        },
        finishCallback: () {
          setState(() {
            transitionToTopPage(context);  
          });
        },
      ),
    );


  }

  void transitionToTopPage(BuildContext context) {
    if (context.mounted) {
      // チュートリアルの視聴履歴のローカルフラグをTrueにwrite
      SharedPrefes.setHasHistory();
      PageTransitionConstructor? constructor = PageTransitionConstructor(
                                                  flagNumber: 0,
                                                  currentPageIndex: 0
                                               );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TopPage(constructor)),
        );
    }
  }

}