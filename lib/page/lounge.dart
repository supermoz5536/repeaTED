// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repea_ted/cloud_functions/functions.dart';
import 'package:repea_ted/model/caption_tracks.dart';
import 'package:repea_ted/model/linked_captions.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_tts/flutter_tts.dart';

// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class LoungePage extends ConsumerStatefulWidget {
  const LoungePage({super.key});

  @override
  ConsumerState<LoungePage> createState() => _LoungePageState();
}

class _LoungePageState extends ConsumerState<LoungePage> {
  final _overlayController1st = OverlayPortalController();
  final _overlayController2nd = OverlayPortalController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController showDialogNameController = TextEditingController();
  final TextEditingController statementController = TextEditingController();
  late final YoutubePlayerController iFrameController;
  final FlutterTts tts = FlutterTts();
  // var yt = YoutubeExplode();
  var videoId = 'sYOS4qOHxdg';
  // late ClosedCaptionManifest trackManifest;
  late PairCaption pairCaption;
  List<PairCaption>? pairCaptions = [];
  bool? isUnStarted = false;
  bool? isPlayingTriggered = false;
  int? currentCaptionIndex = 0;
  dynamic captionsEn;
  dynamic captionsJa;

  @override
  void initState() {
    super.initState();


    // ■ YoutubePlayerControllerの初期化
    iFrameController = YoutubePlayerController.fromVideoId(
      videoId: 'sYOS4qOHxdg',
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
        enableCaption: true,
        captionLanguage: 'ja',
      ),
    );


    // ■ リスナーの配置
    listenPlayer();


    // ■ キャプションデータのロード
    // 実際のクローズドキャプショントラック（字幕データ）を非同期で取得します。
    // get(trackInfo)メソッドは
    // 指定した字幕トラック情報に基づいて字幕データを返します。
    CloudFunctions.callGetCaptions(videoId).then((captions) {

    // キャプションデータを Map<String, dynamic> にキャストする処理（アロー関数を使用せず）
    captionsEn = captions!.en.map((caption) {
      return Map<String, dynamic>.from(caption);
    }).toList();

    captionsJa = captions.ja.map((caption) {
      return Map<String, dynamic>.from(caption);
    }).toList();  


      // 各キャプションに対して処理を行う
      // for (var captionEn in captionsEn) {
        // print('キャプションの同期処理 1');
        // print('EN Caption Sample: ${captions.en[0]}');
        // print('JA Caption Sample: ${captions.ja[0]}');

        // var margin = const Duration(seconds: 3);
        // double startValueEn = double.parse(captionEn['start']); 
      

        // print('startValueEn == $startValueEn');
        // print('startValueJa == $startValueJa');
        // print('startValueEn の型 == ${startValueEn.runtimeType}');
        // print('startValueJa の型 == ${startValueJa.runtimeType}');


        // 対応する日本語キャプションを見つける
        // var correspondingJaCaption = captionsJa.firstWhere(
        //   (captionJa) {
        //     double startValueJa = double.parse(captionJa['start']);  
            
            // print('■ startValueEn == $startValueEn');
            // print('■ startValueJa == $startValueJa');
            // print('■ captionsJaの格納値: $captionJa');
            // print('■ 条件式 1.0 == ${startValueJa.compareTo(startValueEn - margin.inSeconds.toDouble())}');
            // print('■ 条件式 1.1 == ${startValueJa}');
            // print('■ 条件式 1.2 == ${(startValueEn - margin.inSeconds.toDouble())}');
            // print('■ 条件式 2.0 == ${startValueJa.compareTo(startValueEn + margin.inSeconds.toDouble())}');
            // print('■ 条件式 2.1 == ${startValueJa}');
            // print('■ 条件式 2.2 == ${(startValueEn + margin.inSeconds.toDouble())}');

            // 英語キャプションの開始時刻(end)から
            // margine(２秒)を引いたカウントよりも
            // 日本語キャプションの終了時刻が、後に(compareTo が >= 0)に位置し、
            // かつ
            // 英語キャプションの開始時刻(end)から
            // margine(２秒)を足したカウントよりも
            // 日本語キャプションの終了時刻が、前に(compareTo が <= 0)に位置する場合
            // 補足: .inSecondsでint型に変換し、さらにdouble型に変換して型一致させる    
          //   bool startsWithinMargin = 
          //     startValueJa
          //       .compareTo(startValueEn - margin.inSeconds.toDouble()) >= 0
          //   && startValueJa
          //       .compareTo(startValueEn + margin.inSeconds.toDouble()) <= 0;       

          //   // print('StartsWithinMargin: $startsWithinMargin');

          //   return startsWithinMargin;
          // },

          // // 一致するキャプションが見つからなかった場合は
          // // 空オブジェクトを返しておく
          // // (読み上げ時に、処理が発生しないようにする)
          // orElse: () {
          //   print('条件に合致しない、orElse実行');
          //   return {"start": '', "dur": '', "text": ''};
          // },
        // );
        
        // print('キャプションの同期処理 3 correspondingJaCaption == ${correspondingJaCaption}');      

          // 英語キャプションとそれに紐づく日本語キャプションをペアで管理
          // pairCaption = PairCaption(
          //                 en: captionEn,
          //                 ja: captionJa,
          //               );
        // print('キャプションの同期処理 4 pairCaption == ${pairCaption}');
          // ペアで管理したオブジェクトをリストで管理
          // pairCaptions!.add(pairCaption);   
        // print('キャプションの同期処理 5');
      // }  
    }).then((_) {
      // ロード完了を確認して
      // 初回の再生をトリガー
      // print('playVideo()で再生をトリガー');
    });
  }



  /// 各キャプションにおける自動処理の内容を記述
  void listenPlayer() {
    print('listenerの配置完了');
    iFrameController.listen((event) async{
    
      // 動画が読み込まれ、まだ再生されていない場合の処理
      if (iFrameController.value.playerState == PlayerState.unStarted) {
        if (isUnStarted == false) {
          print('動画の読み込み完了しましたが、まだ再生が開始されていません。');
          isUnStarted = true;

          // 動画の再読み込みが発生した場合に
          // 再生ポジションを現キャプションの開始時刻に移動し
          // その後に再生
          double seekTime = captionsJa[currentCaptionIndex]['start'];

         await iFrameController.seekTo(
            seconds: seekTime,
            allowSeekAhead: false
          );

         await iFrameController.playVideo();
        }
      }
    
      // 動画が再生中の場合の処理
      if (iFrameController.value.playerState == PlayerState.playing) {
        if (isPlayingTriggered == false) {
          isUnStarted = false;          
          isPlayingTriggered = true;
          print('動画が再生中です。');

          // ① map型captionオブジェクトからdurキーの値を取得して
          double durationTime = captionsJa[currentCaptionIndex]['dur'];

          // ② そのカウント後に停止メソッドが実行されるようにスケジュール
          await Future.delayed(
            // 第1引数
            Duration(milliseconds: (durationTime * 1000).toInt()),
            // 第2引数
            () {iFrameController.pauseVideo();}
            
          );
        }
      }
    
      // 動画が一時停止された場合の処理
      if (iFrameController.value.playerState == PlayerState.paused) {
        isPlayingTriggered = false;
        print('動画が一時停止された状態');

        // TTSでキャプションの読み上げ
        await tts.speak(
          captionsJa[currentCaptionIndex]['text'],
        );

        // 再生ポジションを次のIndexのstartの時刻に変更
        await iFrameController.seekTo(
          seconds: captionsJa[currentCaptionIndex! + 1]['start'],
          allowSeekAhead: false
        );
        // 再生をトリガー
         await iFrameController.playVideo();
      }
    
      // // 動画が一停止された場合の処理
      // if (iFrameController.value.playerState == PlayerState.ended) {  
      //   print('動画が終了した状態');
      //   isPlayingTriggered = false;
      // }
    });
  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.7),
        surfaceTintColor: Colors.transparent,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(15),
            child: Divider(
              color: Colors.white,
              height: 0,
            )),
        actions: <Widget>[


          // ■ リクエスト通知ボタン
          OverlayPortal(
            /// controller: 表示と非表示を制御するコンポーネント
            /// overlayChildBuilder: OverlayPortal内の表示ウィジェットを構築する応答関数です。
            controller: _overlayController1st,
            overlayChildBuilder: (BuildContext context) {
            
            /// 画面サイズ情報を取得
            final Size screenSize = MediaQuery.of(context).size;
            

              return Stack(
                children: [

                  /// 範囲外をタップしたときにOverlayを非表示する処理
                  /// Stack()最下層の全領域がスコープの範囲
                  GestureDetector(
                    onTap: () {
                      _overlayController1st.toggle();
                    },
                    child: Container(color: Colors.transparent),
                  ),

                  /// ポップアップの表示位置, 表示内容
                  Positioned(
                    top: screenSize.height * 0.15, // 画面高さの15%の位置から開始
                    left: screenSize.width * 0.05, // 画面幅の5%の位置から開始
                    height: screenSize.height * 0.3, // 画面高さの30%の高さ
                    width: screenSize.width * 0.9, // 画面幅の90%の幅
                    child: Card(
                      elevation: 20,
                      color: Colors.white,
                      child: Column(
                          children: [
                            Container(
                                  height: 30,
                                  width: double.infinity,
                                  color: const Color.fromARGB(255, 94, 94, 94),
                                  child: Center(
                                    child: Text(
                                      'Text',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  )
                                ),
                            Padding(
                              padding: const EdgeInsets.all(50),
                              child: Center(child: 
                                Text('Text',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 91, 91, 91),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                                )),
                            ),
                          ],
                        )

                      ),
                    ),
                  ],
                );
              },
            child: IconButton(
                onPressed: () {_overlayController1st.toggle();},
                icon: const Icon(Icons.person_add_outlined,
                    color: Color.fromARGB(255, 176, 176, 176)),
                iconSize: 35,
                tooltip: 'Text',
              )
          ),



          // ■ DMの通知ボタン
          OverlayPortal(
            /// controller: 表示と非表示を制御するコンポーネント
            /// overlayChildBuilder: OverlayPortal内の表示ウィジェットを構築する応答関数です。
            controller: _overlayController2nd,
            overlayChildBuilder: (BuildContext context) {
            
            /// 画面サイズ情報を取得
            final Size screenSize = MediaQuery.of(context).size;
            

              return Stack(
                children: [

                  /// 範囲外をタップしたときにOverlayを非表示する処理
                  /// Stack()最下層の全領域がスコープの範囲
                  GestureDetector(
                    onTap: () {
                      _overlayController2nd.toggle();
                    },
                    child: Container(color: Colors.transparent),
                  ),

                  /// ポップアップの表示位置, 表示内容
                  Positioned(
                    top: screenSize.height * 0.15, // 画面高さの15%の位置から開始
                    left: screenSize.width * 0.05, // 画面幅の5%の位置から開始
                    height: screenSize.height * 0.3, // 画面高さの30%の高さ
                    width: screenSize.width * 0.9, // 画面幅の90%の幅.
                    child: Card(
                      elevation: 20,
                      color: Colors.white,
                      child:  Column(
                          children: [
                            Container(
                                  height: 30,
                                  width: double.infinity,
                                  color: const Color.fromARGB(255, 94, 94, 94),
                                  child: Center(
                                    child: Text(
                                      'Text',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  )
                                ),
                            Padding(
                              padding: const EdgeInsets.all(50),
                              child: Center(child: 
                                Text('Text',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 91, 91, 91),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                                )),
                            ),
                          ],
                        )
                      ),
                    ),
                  ],
                );
              },
            child: IconButton(
                onPressed: () {_overlayController2nd.toggle();},
                icon: const Icon(Icons.notifications_none_outlined,
                    color: Color.fromARGB(255, 176, 176, 176)),
                iconSize: 35,
                tooltip: 'Text',
              )
          ),


          // ■ マッチングヒストリーの表示ボタン
          // Builderウィジェットで祖先のScaffoldを包括したcontextを取得
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: const Icon(Icons.contacts_outlined,
                  color: Color.fromARGB(255, 176, 176, 176)),
              iconSize: 27,
              tooltip: 'Text',
              // .of(context)は記述したそのウィジェット以外のスコープでscaffoldを探す
              // AppBar は Scaffold の内部にあるので、AppBar の context では scaffold が見つけられない
              // Builderウィジェット は Scaffold から独立してるので、その context においては scaffold が見つけられる,
            );
          })
        ],
      ),

      
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              //ListView が無限の長さを持つので直接 column でラップすると不具合
              //Expanded で長さを限界値に指定.
              child: ListView(
                children: [
                  SizedBox(
                    height: 380,
                    child: DrawerHeader(
                        child: Column(
                          children: [

                          //   // ■ プロフィール画面選択
                          //   Material(
                          //   color: Colors.transparent,
                          //   child: Ink(
                          //     decoration: BoxDecoration(
                          //         shape: BoxShape.circle,
                          //         image: DecorationImage(
                          //             image: NetworkImage(meUser!.userImageUrl!),
                          //             fit: BoxFit.cover)),
                          //     // BoxFith は画像の表示方法の制御
                          //     // cover は満遍なく埋める
                          //     child: InkWell(
                          //       splashColor: Colors.black.withOpacity(0.1),
                          //       radius: 100,
                          //       customBorder: const CircleBorder(),
                          //       onTap: () {},
                          //       child: const SizedBox(width: 110, height: 110),
                          //       // InkWellの有効範囲はchildのWidgetの範囲に相当するので
                          //       // タップの有効領域確保のために、空のSizedBoxを設定
                          //     ),
                          //   ),
                          // ),

                            // ■ 名前の選択
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text('Text'),
                                    subtitle: Text('TEXT',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 153, 153, 153)
                                      ),),
                                  )),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    // ボタンの最小サイズを設定
                                    minimumSize: MaterialStateProperty.all(const Size(0, 30))),
                                  onPressed:() {},
                                  child: Text('Text') 
                                ), 
                            ]),

                            // ■ プロフィールコメントの選択
                            Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text('Text'),
                                    // subtitle: Text('${meUser!.statement}',
                                    //   style: const TextStyle(
                                    //     color: Color.fromARGB(255, 153, 153, 153)
                                    //   ),),
                                  )),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    // ボタンの最小サイズを設定
                                    minimumSize: MaterialStateProperty.all(const Size(0, 30))),
                                  onPressed:() {},
                                  child: Text('Text') 
                                ), 
                            ]),

                            // ■ プロフィールコメント表示欄
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Container(
                                    color: Colors.white,
                                    height: 100,
                                    width: 225,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 153, 153, 153)
                                      ),),
                                    ),
                                  ),
                                ),
                              ],
                            )
                      ],
                    )),
                  ),
              ]),
            ),

            const Center(
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text('Comming soon!')),
              ),
            ),
            
            // ■ Display Language
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Text'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('Text'),
                  ),
                ],
              ),
            ),

            // ■ Target Language
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
                ),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Text'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('Text'),
                  ),
                ],
              ),
            ),

            // ■ サブスクリプション
            Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [

                  Expanded(
                    child: ListTile(
                      title: Text('Text'),
                    ),
                  ),

                  // ■ プラン選択 
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        // ボタンの最小サイズを設定
                        minimumSize: MaterialStateProperty.all(const Size(0, 30))),
                      onPressed: () {
                        
                      },
                      child: Text('Text',
                        style: const TextStyle(
                          fontSize: 15
                        ),
                        ),
                    )
                  ),
                ]
              )
            ),

            // ■ 最下部の環境設定部分
            Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                            icon: const Icon(Icons.settings),
                            iconSize: 25,
                            tooltip: 'comming soon',
                            color: const Color.fromARGB(255, 130, 130, 130),
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                          ),
                ])
            ),               
          ],
        ),
      ),


      endDrawer: Drawer(
          child: Column(children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Color.fromARGB(255, 199, 199, 199),
              width: 1.0,
            ))),
            height: 50,
            width: 280,
            child: Center(
                child: Text(
              'Text',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold),
            ))),
      ])),




      body: Stack(
        children: <Widget>[

          Column(
            children: [
              SizedBox(
                child: YoutubePlayer(
                controller: iFrameController,
                aspectRatio: 16 / 9,
                ),
              )
            ],
          )

        ],
      ),
    );
  }

}


