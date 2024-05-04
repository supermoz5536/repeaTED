import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:repea_ted/model/page_transition_constructor.dart';
import 'package:repea_ted/page/10_paolo_from_tokyo.dart';
import 'package:repea_ted/page/11_abroad_in_japan.dart';
import 'package:repea_ted/page/12_pinkfong.dart';
import 'package:repea_ted/page/13_cooking_with_dog.dart';
import 'package:repea_ted/page/14_juns_kitchen.dart';
import 'package:repea_ted/page/15_wao_ryu_only_in_japan.dart';
import 'package:repea_ted/page/16_life_where_in_from.dart';
import 'package:repea_ted/page/17_oli_barrett_travel.dart';
import 'package:repea_ted/page/18_sharmeleon.dart';
import 'package:repea_ted/page/19_unreal_engine_jp.dart';
import 'package:repea_ted/page/20_currently_hannah.dart';
import 'package:repea_ted/page/21_here_is_good.dart';
import 'package:repea_ted/page/22_samurai_junjiro_channel.dart';
import 'package:repea_ted/page/23_tales_from_our_pocket.dart';
import 'package:repea_ted/page/7_original_content.dart';
import 'package:repea_ted/page/3_ted_ed.dart';
import 'package:repea_ted/page/5_ted_institute_talk.dart';
import 'package:repea_ted/page/6_ted_salon_talk.dart';
import 'package:repea_ted/page/2_ted_stage_talk.dart';
import 'package:repea_ted/page/4_ted_talk.dart';
import 'package:repea_ted/page/1_top.dart';
import 'package:repea_ted/page/8_tabi_eats.dart';
import 'package:repea_ted/page/9_rachel_and_jun.dart';


class CustomOverlayPortal extends StatelessWidget {
  final OverlayPortalController? customController;
  final int? flagNumber; 
  final int? currentPageIndex; 
  const CustomOverlayPortal({
    required this.customController,
    required this.flagNumber,
    required this.currentPageIndex,
    super.key
  });


  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: customController!,
      overlayChildBuilder: (BuildContext context) {
        final Size screenSize = MediaQuery.of(context).size;
        return yourOverlayContent(screenSize, context);
      },
      child: IconButton(
        onPressed: () => customController!.toggle(),
        icon: const Icon(Icons.menu),
        // icon: Image.asset('assets/icon.png'),
        iconSize: 35,
        tooltip: 'メニューを開きます',
      ),
    );
  }
  

  Widget yourOverlayContent(Size screenSize, BuildContext context) {
    return Stack(
      children: [

        /// 範囲外をタップしたときにOverlayを非表示する処理
        /// Stack()最下層の全領域がスコープの範囲
        GestureDetector(
          onTap: () {
            customController!.toggle();
          },
          child: Container(color: Colors.black.withOpacity(0.6)),
        ),

        /// ポップアップの表示位置, 表示内容
        Positioned(
          top: MediaQuery.of(context).size.width < 600
          ? screenSize.height * 0.1 // 画面高さの15%の位置から開始
          : screenSize.height * 0.05,
          left: screenSize.width * 0.05, // 画面幅の5%の位置から開始
          height: MediaQuery.of(context).size.width < 600
            ? screenSize.height * 0.8 // 画面幅の90%の幅
            : 650,
          width: MediaQuery.of(context).size.width < 600
            ? screenSize.width * 0.9 // 画面幅の90%の幅
            : 1000,

          child: Container(
            decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(
                    color: Colors.white,  // 枠線の色
                    width: 3.5,           // 枠線の太さ
                  ),
                ),
            child: MediaQuery.of(context).size.width < 600
              ? listForMobile(context)
              : listForPC(context),
              ),
            ),
          ],
        );
    }

  Column listForPC(BuildContext context) {
    return Column(
      children: [
  
        // ■ ヘッダータイトル
        Container(
          width: double.infinity,
          color: Colors.blueAccent,
          child: const Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 30
            ),
            child: Center(
              child: Text(
                'メニュー',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          )
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ■ 本日のおすすめ人気動画
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: '本日のおすすめ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 1 && context.mounted) {  
                                      PageTransitionConstructor? constructor =
                                        PageTransitionConstructor(
                                          flagNumber: 1,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TopPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
                            
                  // ■ TED Stage Talk
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'TED ステージトーク',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 2 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 2,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TedStageTalkPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
    
                  // ■ TED-ed
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'TED-Ed (教育系)',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 3 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 3,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TedEdPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
    
                  // ■ TEDx Talk
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'TEDx Talk(コラボ開催)',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 4 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 4,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TedTalkPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
    
                  // ■ TED Institute Talk
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'TED Institute(ビジネス系)',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 5 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 5,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TedInstituteTalkPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
    
                  // ■ TED Salon Talk
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'TED サロントーク(少人数開催)',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 6 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 6,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TedSalonTalkPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
    
                  // ■ Original Content
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'TED オリジナルコンテンツ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 7 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 7,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => OriginalContentPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
    
                  // ■ Tabi Eats
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Tabi Eats',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 8 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 8,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TabiEatsPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
            
                  // ■ Rachel And Jun
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Rachel And Jun',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 9 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 9,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => RachelAndJunPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50)
                                    
                ]
              ),
            ),

            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ■ 10_paolo_from_tokyo
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                    children: [
                      // アイコン
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 30,
                          right: 10
                        ),
                        child: Icon(Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      // リンク部分
                      RichText(
                        text: TextSpan(
                          children: [
                            // カスケード記法（..）を使用
                            // = が挟まっているのは
                            // TapGestureRecognizerクラスに onTap プロパティがあるので
                            // その値として応答関数を代入してる
                            TextSpan(
                              text: 'Paolo fromTOKYO',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.5,
                                fontWeight: FontWeight.bold
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (flagNumber != 10 && context.mounted) {
                                    PageTransitionConstructor? constructor =
                                    PageTransitionConstructor(
                                        flagNumber: 10,
                                        currentPageIndex: 0
                                      );
                                    Navigator.pushReplacement(  
                                      context,
                                      MaterialPageRoute(builder: (context) => PaoloFromTokyoPage(constructor)),
                                    );
                                  }
                                }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
              
                  // ■ 11_abroad_in_japan
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Abroad in Japan',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 11 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 11,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => AbroadInJapanPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 12_pinkfong
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: '世界名作童話',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 12 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 12,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => PinkfongPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 13_cooking_with_dog
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Cooking With Dog',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 13 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 13,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => CookingWithDogPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 14_juns_kitchen
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'JunsKitchen',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 14 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 14,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => JunsKitchenPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 15_wao_ryu_only_in_japan
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'WAO RYU!ONLY in JAPAN',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 15 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 15,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => WaoRyuOnlyInJapanPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 16_life where im from
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Life Where im From',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 16 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 16,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => LifeWhereImFromPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 17_oli barrett travel
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Oli Barrett Travel',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 17 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 17,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => OliBarrettTravelPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 18_sharmeleon
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Sharmeleon',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 18 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 18,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => SharmeleonPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50)
                ]
              ),
            ),

            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ■ 19_unreal_engine_jp
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Unreal Engine JP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 19 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 19,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => UnrealEngineJpPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 20_currently_hannah
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Currently Hannah',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 20 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 20,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => CurrentlyHannahPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),
             
                  // ■ 21_here_is_good
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Here\'s Good',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 21 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 21,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => HereIsGoodPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 22_samurai_junjiro_channel
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'SAMURAI JUNJIRO Channel',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 22 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 22,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => SamuraiJunjiroChannelPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  // ■ 23_tales_from_our_pocket
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        // アイコン
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 30,
                            right: 10
                          ),
                          child: Icon(Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        // リンク部分
                        RichText(
                          text: TextSpan(
                            children: [
                              // カスケード記法（..）を使用
                              // = が挟まっているのは
                              // TapGestureRecognizerクラスに onTap プロパティがあるので
                              // その値として応答関数を代入してる
                              TextSpan(
                                text: 'Tales From Our Pocket',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 23 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                      PageTransitionConstructor(
                                          flagNumber: 23,
                                          currentPageIndex: 0
                                        );
                                      Navigator.pushReplacement(  
                                        context,
                                        MaterialPageRoute(builder: (context) => TalesFromOurPocketPage(constructor)),
                                      );
                                    }
                                  }
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 50)
                ]
              ),
            ),
            
          ]
        ),

                ],
              );
  }

  Scrollbar listForMobile(BuildContext context) {
    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 10,
      child: SingleChildScrollView(
        child: Column(
          children: [
      
            // ■ ヘッダータイトル
            Container(
              width: double.infinity,
              color: Colors.blueAccent,
              child: const Padding(
                padding: EdgeInsets.only(
                  top: 30,
                  left: 30
                ),
                child: Text(
                  'メニュー',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold
                  )
                ),
              )
            ),
      
            // ■ 本日のおすすめ人気動画
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: '本日のおすすめ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 1 && context.mounted) {  
                                PageTransitionConstructor? constructor =
                                  PageTransitionConstructor(
                                    flagNumber: 1,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => TopPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ TED Stage Talk
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'TED ステージトーク',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 2 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 2,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => TedStageTalkPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ TED-ed
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'TED-Ed (教育系)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 3 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 3,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => TedEdPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ TEDx Talk
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'TEDx Talk(コラボ開催)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 4 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 4,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => TedTalkPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ TED Institute Talk
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'TED Institute(ビジネス系)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 5 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 5,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => TedInstituteTalkPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ TED Salon Talk
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'TED サロントーク(少人数開催)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 6 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 6,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => TedSalonTalkPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ Original Content
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'TED オリジナルコンテンツ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 7 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 7,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => OriginalContentPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ Tabi Eats
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'Tabi Eats',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 8 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 8,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => TabiEatsPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
            // ■ Rachel And Jun
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'Rachel And Jun',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 9 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 9,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => RachelAndJunPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
      
            // ■ 10_paolo_from_tokyo
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'Paolo fromTOKYO',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 10 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 10,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => PaoloFromTokyoPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      
      
            // ■ 11_abroad_in_japan
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: 'Abroad in Japan',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 11 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 11,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => AbroadInJapanPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
      

            // ■ 12_pinkfong
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  // アイコン
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 10
                    ),
                    child: Icon(Icons.chevron_right_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  // リンク部分
                  RichText(
                    text: TextSpan(
                      children: [
                        // カスケード記法（..）を使用
                        // = が挟まっているのは
                        // TapGestureRecognizerクラスに onTap プロパティがあるので
                        // その値として応答関数を代入してる
                        TextSpan(
                          text: '世界名作童話',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17.5,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (flagNumber != 12 && context.mounted) {
                                PageTransitionConstructor? constructor =
                                PageTransitionConstructor(
                                    flagNumber: 12,
                                    currentPageIndex: 0
                                  );
                                Navigator.pushReplacement(  
                                  context,
                                  MaterialPageRoute(builder: (context) => PinkfongPage(constructor)),
                                );
                              }
                            }
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),

          // ■ 13_cooking_with_dog
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Cooking With Dog',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 13 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 13,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => CookingWithDogPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 14_juns_kitchen
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'JunsKitchen',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 14 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 14,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => JunsKitchenPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 15_wao_ryu_only_in_japan
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'WAO RYU!ONLY in JAPAN',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 15 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 15,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => WaoRyuOnlyInJapanPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 16_life where im from
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Life Where im From',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 16 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 16,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => LifeWhereImFromPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 17_oli barrett travel
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Oli Barrett Travel',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 17 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 17,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => OliBarrettTravelPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 18_sharmeleon
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Sharmeleon',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 18 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 18,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => SharmeleonPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 19_unreal_engine_jp
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Unreal Engine JP',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 19 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 19,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => UnrealEngineJpPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),
      
          // ■ 20_currently_hannah
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Currently Hannah',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 20 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 20,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => CurrentlyHannahPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),
      
          // ■ 21_here_is_good
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Here\'s Good',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 21 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 21,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => HereIsGoodPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 22_samurai_junjiro_channel
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'SAMURAI JUNJIRO Channel',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 22 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 22,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => SamuraiJunjiroChannelPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          // ■ 23_tales_from_our_pocket
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                // アイコン
                const Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 10
                  ),
                  child: Icon(Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                // リンク部分
                RichText(
                  text: TextSpan(
                    children: [
                      // カスケード記法（..）を使用
                      // = が挟まっているのは
                      // TapGestureRecognizerクラスに onTap プロパティがあるので
                      // その値として応答関数を代入してる
                      TextSpan(
                        text: 'Tales From Our Pocket',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (flagNumber != 23 && context.mounted) {
                              PageTransitionConstructor? constructor =
                              PageTransitionConstructor(
                                  flagNumber: 23,
                                  currentPageIndex: 0
                                );
                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => TalesFromOurPocketPage(constructor)),
                              );
                            }
                          }
                      ),
                    ]
                  )
                ),
              ],
            ),
          ),

          const SizedBox(height: 50)

        ],
      ),
      ),
    );
  }
}















  