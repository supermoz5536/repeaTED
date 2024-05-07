// import 'dart:ffi';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repea_ted/cloud_functions/functions.dart';
import 'package:repea_ted/model/caption_tracks.dart';
import 'package:repea_ted/model/pair_captions.dart';
import 'package:repea_ted/model/page_transition_constructor.dart';
import 'package:repea_ted/model/watch_%20page_constructor.dart';
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
import 'package:repea_ted/service/utility.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class WatchPage extends ConsumerStatefulWidget {
  final WatchPageConstructor? watchConstructor;
  const WatchPage(this.watchConstructor, {super.key});

  @override
  ConsumerState<WatchPage> createState() => _LoungePageState();
}

class _LoungePageState extends ConsumerState<WatchPage> {
  // final _overlayController1st = OverlayPortalController();
  // final _overlayController2nd = OverlayPortalController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController showDialogNameController = TextEditingController();
  // final TextEditingController statementController = TextEditingController();
  late final YoutubePlayerController iFrameController;
  final FlutterTts tts = FlutterTts();
  // var yt = YoutubeExplode();
  String? videoId;
  // late ClosedCaptionManifest trackManifest;
  late PairCaption pairCaption;
  List<PairCaption>? pairCaptions = [];
  bool? isUnStarted = false;
  bool? isPlaying = false;
  bool? isPaused = false;
  bool? isLoading = true;
  bool? isFullscreen = false;
  bool? isTapped = false;
  int? flagNumber;
  int? currentPageIndex;
  int? currentCaptionIndex = 0;
  int? captionTrackLength;
  dynamic captionsEn;
  dynamic captionsJa;
  double seekTime = 0.0;
  double durationTime = 100.0;
  StreamSubscription? iFrameSubscription;


  @override
  void initState() {
    super.initState();
    videoId = widget.watchConstructor!.videoId;
    flagNumber = widget.watchConstructor!.flagNumber;
    currentPageIndex = widget.watchConstructor!.currentPageIndex;

    // ■ YoutubePlayerControllerの初期化.
    iFrameController = YoutubePlayerController.fromVideoId(
      videoId: videoId!,
      params: const YoutubePlayerParams(
        mute: false,
        showControls: true,
        showFullscreenButton: true,
        enableCaption: true,
        captionLanguage: 'en',
      ),
    );

    // ■ TTSの初期化
    initTTS();

    // ■ キャプションデータのロード
    // 実際のクローズドキャプショントラック（字幕データ）を非同期で取得します。
    // get(trackInfo)メソッドは
    // 指定した字幕トラック情報に基づいて字幕データを返します。
    CloudFunctions.callGetCaptions(videoId).then((captions) {

      // キャプションの取得に失敗したらトップページへ画面遷移
      if (captions == null && context.mounted) {
        PageTransitionConstructor? constructor = PageTransitionConstructor(
                                                   flagNumber: -1,
                                                   currentPageIndex: 0
                                                 );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TopPage(constructor)),
          );

      } else {
        // キャプションデータを Map<String, dynamic> にキャストする処理（アロー関数を使用せず）
        captionsEn = captions!.en.map((caption) {
          return Map<String, dynamic>.from(caption);
        }).toList();

        captionsJa = captions.ja.map((caption) {
          return Map<String, dynamic>.from(caption);
        }).toList();  

        captionTrackLength = captions.ja.length;    
        print('captionTrackLength == ${captionsJa[1]}');
      }
    }).then((value) {
      // キャプションデータのロード処理を確実に待機してかつ
      // データの取得が成功していたらリスナーを配置
      if (captionsJa != null) listenPlayer();
      print('リスナーの配置完了');
      setState(() {
        isLoading = false;  
      });
    });

  }


  /// 各キャプションにおける自動処理の内容を記述
  void listenPlayer() {
      iFrameSubscription = iFrameController.listen((event) async{
        print(' ★ 1 リスナーイベントの取得確認 == ${iFrameController.value.playerState}');
    
      // // ■ 動画が読み込まれ、まだ再生されていない場合の処理
      if (iFrameController.value.playerState == PlayerState.unStarted) {
        if (isUnStarted == false) {
          isUnStarted = true;
          print('■ 1 PlayerState.unStarteのタスク開始');
          // print('■ 3 動画の読み込み完了しましたが、まだ再生が開始されていません。');
          // print('■ 4 JA Caption 取得確認: ${captionsJa[currentCaptionIndex]['start']}');
          // print('■ 5 JA Caption start の型確認: ${captionsJa[currentCaptionIndex]['start'].runtimeType}');
          // print('■ 6 JA Caption start の型確認: ${double.parse(captionsJa[currentCaptionIndex]['start']).runtimeType}');

          // 'start'の値が文字列で数字表記になっているので
          // 型のキャスト String → double
          seekTime = double.parse(captionsJa[currentCaptionIndex]['start']);
          // print('■ 7 seekTimeの値確認: $seekTime');

          // 再生ポジションを現キャプションの開始時刻に移動し
          await iFrameController.seekTo(
            seconds: seekTime,
            allowSeekAhead: true
          );

          // その後に再生
          // await iFrameController.playVideo();
        }
    }

      // ■ 動画が再生中の場合の処理
      if (iFrameController.value.playerState == PlayerState.playing) {
        if (isPlaying == false) {
          isPlaying = true;
          isUnStarted = false;
          isPaused = false;  
          print('▲ 0 currentCaptionIndex == $currentCaptionIndex');     
          print('▲ 1 動画が再生中です。');
          // print('▲ 2 該当キャプションの オブジェクトの確認: ${(captionsJa[currentCaptionIndex])}');
          // print('▲ 3 該当キャプションの dur値の確認: ${(captionsJa[currentCaptionIndex]['dur'])}');
          // 'dur'の値が文字列で数字表記になっているので
          // 型のキャスト String → double
          durationTime = double.parse(captionsJa[currentCaptionIndex]['dur']);
          // print('▲ 4 durationTimeの代入後の値: ${(captionsJa[currentCaptionIndex]['dur'])}');
          

          // ② そのカウント後に停止メソッドが実行されるようにスケジュール
          await Future.delayed(
            // 第1引数
            Duration(milliseconds: (durationTime * 1000).toInt()),
            // 第2引数
            () {iFrameController.pauseVideo();}
          );
          print('▲ 2 一時停止の予約完了 ');
          print('▲ 3 currentCaptionIndex == $currentCaptionIndex');     
        }
      }
    
      // ■ 動画が一時停止された場合の処理
      if (iFrameController.value.playerState == PlayerState.paused) {
        if (isPaused == false) {
          isPaused = true;
          isPlaying = false;
          print('● 0 currentCaptionIndex == $currentCaptionIndex');
          print('● 1 動画が一時停止された状態');


          // 英語の行のみ削除
          print('1 読み上げの englishText == ${captionsJa[currentCaptionIndex]['text']}');
          String? japaneseText = Utility.extractJapaneseText(captionsJa[currentCaptionIndex]['text']);
          print('2 読み上げの englishText == ${japaneseText}');

          await Future.delayed(const Duration(milliseconds: 750));

          // TTSでキャプションの読み上げ
          await tts.speak(
            japaneseText!,
            // captionsJa[currentCaptionIndex]['text'],
          );
        }
      }
    
      // ■ 動画が停止された場合の処理
      // if (event.playerState) {  
      //   print('動画が終了した状態');
      //   isUnStarted = false;
      //   isPlaying = false;
      //   isPaused = true;
      //   currentCaptionIndex = 0;
      //   seekTime = double.parse(captionsJa[currentCaptionIndex]['start']);

      //   // 再生ポジションを現キャプションの開始時刻に移動し
      //   await iFrameController.seekTo(
      //     seconds: seekTime,
      //     allowSeekAhead: true
      //   );

      //   // その後に再生
      //   await iFrameController.playVideo();
      // }
    });
  }




  Future<void> initTTS() async {
    // 音量を70%に設定
    await tts.setVolume(0.5); 
    await tts.setSpeechRate(0.775);


    // 読み上げ完了時のコールバック設定
    tts.setCompletionHandler(() async{
      print("読み上げ完了後のコールバックが完了しました。");

          currentCaptionIndex = currentCaptionIndex! + 1;

          if (currentCaptionIndex! < captionTrackLength!){
            seekTime = double.parse(captionsJa[currentCaptionIndex]['start']);
            print('● 3 キャスト完了');

            // 再生ポジションを次のIndexのstartの時刻に変更
            await iFrameController.seekTo(
              seconds: seekTime - 0.2,
              allowSeekAhead: true
            );
            print('● 4 再生ポジション移動');

            // 再生をトリガー
            await iFrameController.playVideo();
            print('● 5 再生のトリガー完了');
            print('● 6 currentCaptionIndex == $currentCaptionIndex');
          }

          else if (currentCaptionIndex == captionTrackLength) {
            print('動画が終了した状態');
            print('● 7 currentCaptionIndex == $currentCaptionIndex');
            isUnStarted = false;
            isPlaying = false;
            isPaused = true;
            currentCaptionIndex = 0;
            seekTime = double.parse(captionsJa[currentCaptionIndex]['start']);

            // 再生ポジションを現キャプションの開始時刻に移動し
            await iFrameController.seekTo(
              seconds: seekTime,
              allowSeekAhead: true
            );

            // その後に再生
            await iFrameController.playVideo();
          }
    });
  
  }

    // disposeメソッドをオーバーライド
  @override
  void dispose() {
    // showDialogNameController.removeListener(() {setState((){});});
    // showDialogNameController.dispose();
    // nameController.dispose();
    // statementController.dispose();
    if (iFrameSubscription != null) iFrameSubscription!.cancel();
    // iFrameController.close();  // iFrameの .disposeメソッドはwebだとバグが潜在してる可能性がある
    tts.stop();
    super.dispose();
    print('dispose完了');
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset('assets/pics/icon.png'),
        title: const Text('TraceSpeaker 英→日 BETA版',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.7),
        surfaceTintColor: Colors.transparent,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Divider(
              color: Colors.white,
              height: 0,
            )),
        actions: <Widget>[


          // // ■ リクエスト通知ボタン
          // OverlayPortal(
          //   /// controller: 表示と非表示を制御するコンポーネント
          //   /// overlayChildBuilder: OverlayPortal内の表示ウィジェットを構築する応答関数です。
          //   controller: _overlayController1st,
          //   overlayChildBuilder: (BuildContext context) {
            
          //   /// 画面サイズ情報を取得
          //   final Size screenSize = MediaQuery.of(context).size;
            

          //     return Stack(
          //       children: [

          //         /// 範囲外をタップしたときにOverlayを非表示する処理
          //         /// Stack()最下層の全領域がスコープの範囲
          //         GestureDetector(
          //           onTap: () {
          //             _overlayController1st.toggle();
          //           },
          //           child: Container(color: Colors.transparent),
          //         ),

          //         /// ポップアップの表示位置, 表示内容
          //         Positioned(
          //           top: screenSize.height * 0.15, // 画面高さの15%の位置から開始
          //           left: screenSize.width * 0.05, // 画面幅の5%の位置から開始
          //           height: screenSize.height * 0.3, // 画面高さの30%の高さ
          //           width: screenSize.width * 0.9, // 画面幅の90%の幅
          //           child: Card(
          //             elevation: 20,
          //             color: Colors.white,
          //             child: Column(
          //                 children: [
          //                   Container(
          //                         height: 30,
          //                         width: double.infinity,
          //                         color: const Color.fromARGB(255, 94, 94, 94),
          //                         child: Center(
          //                           child: Text(
          //                             'Text',
          //                             style: const TextStyle(
          //                               color: Colors.white,
          //                               fontSize: 20,
          //                               fontWeight: FontWeight.bold
          //                             )
          //                           ),
          //                         )
          //                       ),
          //                   Padding(
          //                     padding: const EdgeInsets.all(50),
          //                     child: Center(child: 
          //                       Text('Text',
          //                       style: const TextStyle(
          //                         color: Color.fromARGB(255, 91, 91, 91),
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.bold
          //                       ),
          //                       )),
          //                   ),
          //                 ],
          //               )

          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //   child: IconButton(
          //       onPressed: () {_overlayController1st.toggle();},
          //       icon: const Icon(Icons.person_add_outlined,
          //           color: Color.fromARGB(255, 176, 176, 176)),
          //       iconSize: 35,
          //       tooltip: 'Text',
          //     )
          // ),



          // // ■ DMの通知ボタン
          // OverlayPortal(
          //   /// controller: 表示と非表示を制御するコンポーネント
          //   /// overlayChildBuilder: OverlayPortal内の表示ウィジェットを構築する応答関数です。
          //   controller: _overlayController2nd,
          //   overlayChildBuilder: (BuildContext context) {
            
          //   /// 画面サイズ情報を取得
          //   final Size screenSize = MediaQuery.of(context).size;
            

          //     return Stack(
          //       children: [

          //         /// 範囲外をタップしたときにOverlayを非表示する処理
          //         /// Stack()最下層の全領域がスコープの範囲
          //         GestureDetector(
          //           onTap: () {
          //             _overlayController2nd.toggle();
          //           },
          //           child: Container(color: Colors.transparent),
          //         ),

          //         /// ポップアップの表示位置, 表示内容
          //         Positioned(
          //           top: screenSize.height * 0.15, // 画面高さの15%の位置から開始
          //           left: screenSize.width * 0.05, // 画面幅の5%の位置から開始
          //           height: screenSize.height * 0.3, // 画面高さの30%の高さ
          //           width: screenSize.width * 0.9, // 画面幅の90%の幅.
          //           child: Card(
          //             elevation: 20,
          //             color: Colors.white,
          //             child:  Column(
          //                 children: [
          //                   Container(
          //                         height: 30,
          //                         width: double.infinity,
          //                         color: const Color.fromARGB(255, 94, 94, 94),
          //                         child: Center(
          //                           child: Text(
          //                             'Text',
          //                             style: const TextStyle(
          //                               color: Colors.white,
          //                               fontSize: 20,
          //                               fontWeight: FontWeight.bold
          //                             )
          //                           ),
          //                         )
          //                       ),
          //                   Padding(
          //                     padding: const EdgeInsets.all(50),
          //                     child: Center(child: 
          //                       Text('Text',
          //                       style: const TextStyle(
          //                         color: Color.fromARGB(255, 91, 91, 91),
          //                         fontSize: 15,
          //                         fontWeight: FontWeight.bold
          //                       ),
          //                       )),
          //                   ),
          //                 ],
          //               )
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //   child: IconButton(
          //       onPressed: () {_overlayController2nd.toggle();},
          //       icon: const Icon(Icons.notifications_none_outlined,
          //           color: Color.fromARGB(255, 176, 176, 176)),
          //       iconSize: 35,
          //       tooltip: 'Text',
          //     )
          // ),


          // // ■ マッチングヒストリーの表示ボタン
          // // Builderウィジェットで祖先のScaffoldを包括したcontextを取得
          // Builder(builder: (context) {
          //   return IconButton(
          //     onPressed: () {
          //       Scaffold.of(context).openEndDrawer();
          //     },
          //     icon: const Icon(Icons.contacts_outlined,
          //         color: Color.fromARGB(255, 176, 176, 176)),
          //     iconSize: 27,
          //     tooltip: 'Text',
          //     // .of(context)は記述したそのウィジェット以外のスコープでscaffoldを探す
          //     // AppBar は Scaffold の内部にあるので、AppBar の context では scaffold が見つけられない
          //     // Builderウィジェット は Scaffold から独立してるので、その context においては scaffold が見つけられる,
          //   );
          // })
        ],
      ),

      
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       Expanded(
      //         //ListView が無限の長さを持つので直接 column でラップすると不具合
      //         //Expanded で長さを限界値に指定.
      //         child: ListView(
      //           children: [
      //             SizedBox(
      //               height: 380,
      //               child: DrawerHeader(
      //                   child: Column(
      //                     children: [

      //                     //   // ■ プロフィール画面選択
      //                     //   Material(
      //                     //   color: Colors.transparent,
      //                     //   child: Ink(
      //                     //     decoration: BoxDecoration(
      //                     //         shape: BoxShape.circle,
      //                     //         image: DecorationImage(
      //                     //             image: NetworkImage(meUser!.userImageUrl!),
      //                     //             fit: BoxFit.cover)),
      //                     //     // BoxFith は画像の表示方法の制御
      //                     //     // cover は満遍なく埋める
      //                     //     child: InkWell(
      //                     //       splashColor: Colors.black.withOpacity(0.1),
      //                     //       radius: 100,
      //                     //       customBorder: const CircleBorder(),
      //                     //       onTap: () {},
      //                     //       child: const SizedBox(width: 110, height: 110),
      //                     //       // InkWellの有効範囲はchildのWidgetの範囲に相当するので
      //                     //       // タップの有効領域確保のために、空のSizedBoxを設定
      //                     //     ),
      //                     //   ),
      //                     // ),

      //                       // ■ 名前の選択
      //                       Row(
      //                         children: [
      //                           Expanded(
      //                             child: ListTile(
      //                               title: Text('Text'),
      //                               subtitle: Text('TEXT',
      //                                 style: const TextStyle(
      //                                   color: Color.fromARGB(255, 153, 153, 153)
      //                                 ),),
      //                             )),
      //                           ElevatedButton(
      //                             style: ButtonStyle(
      //                               // ボタンの最小サイズを設定
      //                               minimumSize: MaterialStateProperty.all(const Size(0, 30))),
      //                             onPressed:() {},
      //                             child: Text('Text') 
      //                           ), 
      //                       ]),

      //                       // ■ プロフィールコメントの選択
      //                       Row(
      //                         children: [
      //                           Expanded(
      //                             child: ListTile(
      //                               title: Text('Text'),
      //                               // subtitle: Text('${meUser!.statement}',
      //                               //   style: const TextStyle(
      //                               //     color: Color.fromARGB(255, 153, 153, 153)
      //                               //   ),),
      //                             )),
      //                           ElevatedButton(
      //                             style: ButtonStyle(
      //                               // ボタンの最小サイズを設定
      //                               minimumSize: MaterialStateProperty.all(const Size(0, 30))),
      //                             onPressed:() {},
      //                             child: Text('Text') 
      //                           ), 
      //                       ]),

      //                       // ■ プロフィールコメント表示欄
      //                       Row(
      //                         children: [
      //                           Padding(
      //                             padding: const EdgeInsets.only(left: 15.0),
      //                             child: Container(
      //                               color: Colors.white,
      //                               height: 100,
      //                               width: 225,
      //                               child: Padding(
      //                                 padding: const EdgeInsets.all(8.0),
      //                                 child: Text('',
      //                                 style: const TextStyle(
      //                                   color: Color.fromARGB(255, 153, 153, 153)
      //                                 ),),
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       )
      //                 ],
      //               )),
      //             ),
      //         ]),
      //       ),

      //       const Center(
      //         child: SizedBox(
      //           height: 50,
      //           child: Center(
      //             child: Text('Comming soon!')),
      //         ),
      //       ),
            
      //       // ■ Display Language
      //       Container(
      //         decoration: const BoxDecoration(
      //           border: Border(
      //             top: BorderSide(
      //                 color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
      //           ),
      //         ),
      //         padding: const EdgeInsets.all(8),
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: ListTile(
      //                 title: Text('Text'),
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(right: 20),
      //               child: Text('Text'),
      //             ),
      //           ],
      //         ),
      //       ),

      //       // ■ Target Language
      //       Container(
      //         decoration: const BoxDecoration(
      //           border: Border(
      //             top: BorderSide(
      //                 color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
      //           ),
      //         ),
      //         padding: const EdgeInsets.all(8),
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: ListTile(
      //                 title: Text('Text'),
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.only(right: 20),
      //               child: Text('Text'),
      //             ),
      //           ],
      //         ),
      //       ),

      //       // ■ サブスクリプション
      //       Container(
      //           decoration: const BoxDecoration(
      //             border: Border(
      //               top: BorderSide(
      //                   color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
      //             ),
      //           ),
      //           padding: const EdgeInsets.all(8),
      //           child: Row(
      //             children: [

      //             Expanded(
      //               child: ListTile(
      //                 title: Text('Text'),
      //               ),
      //             ),

      //             // ■ プラン選択 
      //             Padding(
      //               padding: const EdgeInsets.only(right: 20),
      //               child: ElevatedButton(
      //                 style: ButtonStyle(
      //                   // ボタンの最小サイズを設定
      //                   minimumSize: MaterialStateProperty.all(const Size(0, 30))),
      //                 onPressed: () {
                        
      //                 },
      //                 child: Text('Text',
      //                   style: const TextStyle(
      //                     fontSize: 15
      //                   ),
      //                   ),
      //               )
      //             ),
      //           ]
      //         )
      //       ),

      //       // ■ 最下部の環境設定部分
      //       Container(
      //           decoration: const BoxDecoration(
      //             border: Border(
      //               top: BorderSide(
      //                   color: Color.fromARGB(255, 199, 199, 199), width: 1.0),
      //             ),
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               IconButton(
      //                       icon: const Icon(Icons.settings),
      //                       iconSize: 25,
      //                       tooltip: 'comming soon',
      //                       color: const Color.fromARGB(255, 130, 130, 130),
      //                       padding: EdgeInsets.zero,
      //                       onPressed: () {},
      //                     ),
      //           ])
      //       ),               
      //     ],
      //   ),
      // ),


      // endDrawer: Drawer(
      //     child: Column(children: <Widget>[
      //   Container(
      //       decoration: const BoxDecoration(
      //           border: Border(
      //               bottom: BorderSide(
      //         color: Color.fromARGB(255, 199, 199, 199),
      //         width: 1.0,
      //       ))),
      //       height: 50,
      //       width: 280,
      //       child: Center(
      //           child: Text(
      //         'Text',
      //         style: const TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold),
      //       ))),
      // ])),




      body: isLoading == true
        ? const Center(child: CircularProgressIndicator()) // ローディング中はインジケーターを表示
        : Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                  
                      const SizedBox(height: 30),

                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: SizedBox(
                      //     child: YoutubePlayer(
                      //     controller: iFrameController,
                      //     aspectRatio: 16 / 9,
                      //     ),
                      //   ),
                      // ),

                      Stack(
                        children: [
                  
                          // YouTubePlayer
                          AbsorbPointer(
                            absorbing: true,
                            child: SizedBox(
                              height: 300, // 通常モード時の高さ
                              width: 800,
                                child: YoutubePlayer(
                                controller: iFrameController,
                                ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              print('isTapped before == $isTapped');
                              isTapped = true;
                              print('isTapped affter == $isTapped');
                            },
                            // absorbing: false で設定でchildに伝版させる
                            child: PointerInterceptor(
                              intercepting: true,
                              child: Container(
                                height: 300, // 通常モード時の高さ
                                width: 800,
                                color: Colors.blue.withOpacity(0.5),
                              ),
                            ),
                          ),

                        ],
                      ),



                      const SizedBox(height: 15),
                  
                      ElevatedButton(
                        onPressed: () {                        
                          if (context.mounted) {
                              Widget nextPage;
                              print('flag == $flagNumber');

                              switch (flagNumber) {
                                case 1:
                                  nextPage = TopPage(PageTransitionConstructor(
                                    flagNumber: 1,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 2:
                                  nextPage = TedStageTalkPage(PageTransitionConstructor(
                                    flagNumber: 2,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 3:
                                  nextPage = TedEdPage(PageTransitionConstructor(
                                    flagNumber: 3,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 4:
                                  nextPage = TedTalkPage(PageTransitionConstructor(
                                    flagNumber: 4,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 5:
                                  nextPage = TedInstituteTalkPage(PageTransitionConstructor(
                                    flagNumber: 5,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 6:
                                  nextPage = TedSalonTalkPage(PageTransitionConstructor(
                                    flagNumber: 6,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 7:
                                  nextPage = OriginalContentPage(PageTransitionConstructor(
                                    flagNumber: 7,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 8:
                                  nextPage = TabiEatsPage(PageTransitionConstructor(
                                    flagNumber: 8,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 9:
                                  nextPage = RachelAndJunPage(PageTransitionConstructor(
                                    flagNumber: 9,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 10:
                                  nextPage = PaoloFromTokyoPage(PageTransitionConstructor(
                                    flagNumber: 10,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 11:
                                  nextPage = AbroadInJapanPage(PageTransitionConstructor(
                                    flagNumber: 11,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 12:
                                  nextPage = PinkfongPage(PageTransitionConstructor(
                                    flagNumber: 12,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 13:
                                  nextPage = CookingWithDogPage(PageTransitionConstructor(
                                    flagNumber: 13,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 14:
                                  nextPage = JunsKitchenPage(PageTransitionConstructor(
                                    flagNumber: 14,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 15:
                                  nextPage = WaoRyuOnlyInJapanPage(PageTransitionConstructor(
                                    flagNumber: 15,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 16:
                                  nextPage = LifeWhereImFromPage(PageTransitionConstructor(
                                    flagNumber: 16,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 17:
                                  nextPage = OliBarrettTravelPage(PageTransitionConstructor(
                                    flagNumber: 17,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 18:
                                  nextPage = SharmeleonPage(PageTransitionConstructor(
                                    flagNumber: 18,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 19:
                                  nextPage = UnrealEngineJpPage(PageTransitionConstructor(
                                    flagNumber: 19,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;                                


                                case 20:
                                  nextPage = CurrentlyHannahPage(PageTransitionConstructor(
                                    flagNumber: 20,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;    

                                case 21:
                                  nextPage = HereIsGoodPage(PageTransitionConstructor(
                                    flagNumber: 21,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 22:
                                  nextPage = SamuraiJunjiroChannelPage(PageTransitionConstructor(
                                    flagNumber: 22,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                case 23:
                                  nextPage = TalesFromOurPocketPage(PageTransitionConstructor(
                                    flagNumber: 23,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;

                                default:
                                  nextPage = TopPage(PageTransitionConstructor(
                                    flagNumber: 1,
                                    currentPageIndex: currentPageIndex
                                  ));
                                  break;
                              }

                              Navigator.pushReplacement(  
                                context,
                                MaterialPageRoute(builder: (context) => nextPage),
                              );

                          }
                        },
                        child: const Text('戻る',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                  
                      const SizedBox(
                        height: 275,
                        width: 800,
                        child: Card(
                          color:Colors.blueAccent,
                          margin: EdgeInsets.only(
                            top: 15,
                            left: 30,
                            right: 30,
                            bottom: 30,
                          ),
                          elevation: 10, // 影の離れ具合
                          shadowColor: Colors.grey, // 影の色
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Center(
                              child: Text(
                                '・表示する字幕の「言語選択」「ON/OFF」は動画右下の歯車マークで設定できます。\n\n・自動で動画の再生が始まります、始まらない時は再生ボタンをクリック。\n\n・再生位置をクリックで調整はできません（元の再生位置に自動で戻ります）\n\n・動画が終了すると自動でループします。',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  
                    ],
                  ),
                ),
              )
            ],
      ),
    );
  }
}


