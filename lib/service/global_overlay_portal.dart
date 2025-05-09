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
import 'package:repea_ted/page/16_documentary.dart';
import 'package:repea_ted/page/17_eiga_com.dart';
import 'package:repea_ted/page/18_anime_illustration.dart';
import 'package:repea_ted/page/19_unreal_engine_jp.dart';
import 'package:repea_ted/page/20_healing.dart';
import 'package:repea_ted/page/21_trip_vlog.dart';
import 'package:repea_ted/page/22_samurai_junjiro_channel.dart';
import 'package:repea_ted/page/23_tales_from_our_pocket.dart';
import 'package:repea_ted/page/24_glitch.dart';
import 'package:repea_ted/page/25_good_kids.dart';
import 'package:repea_ted/page/26_learn_english.dart';
import 'package:repea_ted/page/27_quality_of_english_life.dart';
import 'package:repea_ted/page/28_anime_cg.dart';
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
            : 1200,

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

  Scrollbar listForPC(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Scrollbar(
      thumbVisibility: true,
      trackVisibility: true,
      thickness: 10,
      controller: scrollController,
      child: SingleChildScrollView(
        controller: scrollController, 
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
                child: Center(
                  child: Text(
                    'メニュー（英検グレード別）',
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
                                    text: '1-準1級: TED ステージトーク',
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
                                    text: '1-準1級: TED-Ed (教育系)',
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
                                    text: '1-準1級: TEDx Talk(コラボ開催)',
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
                                    text: '1-準1級: TED ビジネス系',
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
                                    text: '1-準1級: TED 少人数開催',
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
                                    text: '1-準1級: TED オリジナル',
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
                                    text: '1-準1級: WAO RYU!ONLY',
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
        
                      // ■ 16_documentary
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
                                    text: '1-準1級: ドキュメンタリー系',
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
                                            MaterialPageRoute(builder: (context) => DocumentaryPage(constructor)),
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
                                    text: '1-準1級: Unreal Engine JP',
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
        
                 
                      // ■ 21_trip_vlog
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
                                    text: '1-準1級: 旅 & Vlog系',
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
                                            MaterialPageRoute(builder: (context) => TripVlogPage(constructor)),
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
        
                      // // ■ 23_tales_from_our_pocket
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 30),
                      //   child: Row(
                      //     children: [
                      //       // アイコン
                      //       const Padding(
                      //         padding: EdgeInsets.only(
                      //           left: 30,
                      //           right: 10
                      //         ),
                      //         child: Icon(Icons.chevron_right_rounded,
                      //           color: Colors.white,
                      //           size: 25,
                      //         ),
                      //       ),
                      //       // リンク部分
                      //       RichText(
                      //         text: TextSpan(
                      //           children: [
                      //             // カスケード記法（..）を使用
                      //             // = が挟まっているのは
                      //             // TapGestureRecognizerクラスに onTap プロパティがあるので
                      //             // その値として応答関数を代入してる
                      //             TextSpan(
                      //               text: '1-準1級: Tales From Our Pocket',
                      //               style: const TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 17.5,
                      //                 fontWeight: FontWeight.bold
                      //               ),
                      //               recognizer: TapGestureRecognizer()
                      //                 ..onTap = () {
                      //                   if (flagNumber != 23 && context.mounted) {
                      //                     PageTransitionConstructor? constructor =
                      //                     PageTransitionConstructor(
                      //                         flagNumber: 23,
                      //                         currentPageIndex: 0
                      //                       );
                      //                     Navigator.pushReplacement(  
                      //                       context,
                      //                       MaterialPageRoute(builder: (context) => TalesFromOurPocketPage(constructor)),
                      //                     );
                      //                   }
                      //                 }
                      //             ),
                      //           ]
                      //         )
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // ■ 24_glitch
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
                                    text: '1-2級: [アニメ] グリッチ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 24 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 24,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => GlitchPage(constructor)),
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
                                    text: '準1-2級: Tabi Eats',
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
                                    text: '準1-2級: Rachel And Jun',
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
                                  text: '準1-2級: Paolo fromTOKYO',
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
                                    text: '準1-2級: Abroad in Japan',
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
                                    text: '準1-2級: Cooking With Dog',
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
                                    text: '準1-2級: JunsKitchen',
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

                      // ■ 27_quality_of_english_life
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
                                    text: '準1-準2級: 星の王子さま',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 27 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 27,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => QualityOfEnglishLifePage(constructor)),
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
      
                      // ■ 26_learn_english
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
                                    text: '2級: 英語を学ぶ系',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 26 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 26,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => LearnEnglishPage(constructor)),
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

                      // ■ 20_healing
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
                                    text: '2級: ヒーリング系',
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
                                            MaterialPageRoute(builder: (context) => HealingPage(constructor)),
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

                      // ■ 17_eiga_com
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
                                    text: '2級: 映画.com',
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
                                            MaterialPageRoute(builder: (context) => EigaComPage(constructor)),
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

                      // ■ 28_anime_cg
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
                                    text: '2級: [アニメ] CG系',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 28 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 28,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => AnimeCGPage(constructor)),
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

        
                      // ■ 18_anime_ illustration
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
                                    text: '2級: [アニメ] イラスト系',
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
                                            MaterialPageRoute(builder: (context) => AnimeIllustrationPage(constructor)),
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
                                    text: '2-準2級: SAMURAI JUNJIRO Channel',
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
                                    text: '準2-3級: [アニメ] 世界名作童話',
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

                      // ■ 25_good_kids
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
                                    text: '4-5級: Good Kids',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 25 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 25,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => GoodKidsPage(constructor)),
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
                  ),
      ),
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

          // ■ 16_documentary
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
                        text: 'ドキュメンタリー系',
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
                                MaterialPageRoute(builder: (context) => DocumentaryPage(constructor)),
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
                        text: '映画.com',
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
                                MaterialPageRoute(builder: (context) => EigaComPage(constructor)),
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
                                MaterialPageRoute(builder: (context) => AnimeIllustrationPage(constructor)),
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
      
          // ■ 20_healing
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
                        text: 'ヒーリング系',
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
                                MaterialPageRoute(builder: (context) => HealingPage(constructor)),
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
                                MaterialPageRoute(builder: (context) => TripVlogPage(constructor)),
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

                      // ■ 24_glitch
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
                                    text: '1-2級: [アニメ] グリッチ',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 24 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 24,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => GlitchPage(constructor)),
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
        
                      // ■ 25_good_kids
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
                                    text: '4-5級: Good Kids',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 25 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 25,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => GoodKidsPage(constructor)),
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
        
                      // ■ 26_learn_english_conversation_in_english
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
                                    text: '2-3級: 英語で学ぶ英会話',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 26 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 26,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => LearnEnglishPage(constructor)),
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
        
                      // ■ 27_quality_of_english_life
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
                                    text: '準1-準2級: 星の王子さま',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 27 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 27,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => QualityOfEnglishLifePage(constructor)),
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
        
                      // ■ 28_service_english
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
                                    text: '2級: [アニメ] CG系',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.bold
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (flagNumber != 28 && context.mounted) {
                                          PageTransitionConstructor? constructor =
                                          PageTransitionConstructor(
                                              flagNumber: 28,
                                              currentPageIndex: 0
                                            );
                                          Navigator.pushReplacement(  
                                            context,
                                            MaterialPageRoute(builder: (context) => AnimeCGPage(constructor)),
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















  