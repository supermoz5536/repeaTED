import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:repea_ted/model/top_page_constructor.dart';
import 'package:repea_ted/page/ted_talk.dart';
import 'package:repea_ted/page/top.dart';


class CustomOverlayPortal extends StatelessWidget {
  final OverlayPortalController? customController;
  final int? flagNumber; 
    // const CustomOverlayPortal({Key? key, this.flagNumber}) : super(key: key);
    // const CustomOverlayPortal({super.key});
  const CustomOverlayPortal({
    required this.customController,
    required this.flagNumber,
    super.key
  });

//   @override
//   State<CustomOverlayPortal> createState() => _CustomOverlayPortalState();
// }

// class _CustomOverlayPortalState extends State<CustomOverlayPortal> {


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
          top: screenSize.height * 0.15, // 画面高さの15%の位置から開始
          left: screenSize.width * 0.1, // 画面幅の5%の位置から開始
          height: screenSize.height * 0.7, // 画面高さの30%の高さ
          width: MediaQuery.of(context).size.width < 600
            ? screenSize.width * 0.8 // 画面幅の90%の幅
            : 350,

          child: Container(
            decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  border: Border.all(
                    color: Colors.white,  // 枠線の色
                    width: 3.5,           // 枠線の太さ
                  ),
                ),
            child: Column(
                children: [
                  // ■ タイトル
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
                                text: '本日のおすすめ人気動画',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 1 && context.mounted) {  
                                      PageTransitionConstructor? constructor =
                                        PageTransitionConstructor(flagNumber: 1);
                                      // Navigator.push(
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

                  // ■ TED Talk
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
                                text: 'TEDx Talk(ローカル開催)',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    if (flagNumber != 2 && context.mounted) {
                                      PageTransitionConstructor? constructor =
                                        PageTransitionConstructor(flagNumber: 2);
                                      // Navigator.push(
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


                ],
              )

            ),
          ),
        ],
      );
  }
}


