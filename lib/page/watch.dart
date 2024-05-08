// import 'dart:ffi';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
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
  String? zeroTime;
  // late ClosedCaptionManifest trackManifest;
  late PairCaption pairCaption;
  List<PairCaption>? pairCaptions = [];
  bool? isUnStarted = false;
  bool? isPlaying = false;
  bool? isPaused = false;
  bool? isLoading = true;
  bool? isFullscreen = false;
  bool? isManuallyPaused = false;
  int? flagNumber;
  int? currentPageIndex;
  int? currentCaptionIndex = 0;
  int? captionTrackLength;
  int pointerID = 0;
  dynamic captionsEn;
  dynamic captionsJa;
  double seekTime = 0.0;
  double durationTime = 100.0;
  double? currentSliderValue = 0.0;
  double? totalDuration = 0.0;
  Offset? firstTapPosition;
  StreamSubscription? iFrameSubscription;
  StreamSubscription? playTimeSubscription;


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
        print('内容 == ${captions.ja[1]}');
      }
    }).then((value) {
      // キャプションデータのロード処理を確実に待機してかつ
      // データの取得が成功していたらリスナーを配置
      if (captionsJa != null) {
        listenPlayer();
        listenPlayTime();
        setState(() {
          isLoading = false;  
        });
        print('リスナーの配置完了');
      }
    });

  }

  /// 各キャプションにおける自動処理の内容を記述
  void listenPlayer() {
      iFrameSubscription = iFrameController.listen((event) async{
        print(' ★ 1 リスナーイベントの取得確認 == ${iFrameController.value.playerState}');
    
      // // ■ 動画が読み込まれ、まだ再生されていない場合の処理
      if (iFrameController.value.playerState == PlayerState.unStarted
       && isManuallyPaused == false) {

        if (isUnStarted == false) {
          isUnStarted = true;
          isManuallyPaused = false;

          // ■ 全体の動画の長さの取得
          final loadedTotalDuration = await iFrameController.duration;
          setState(() {
            totalDuration = loadedTotalDuration;       
          });
  
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

      // ■ システムによる再生処理のコールバック
      if (iFrameController.value.playerState == PlayerState.playing) {
        if (isPlaying == false) {
          isPlaying = true;
          isUnStarted = false;
          isPaused = false;
          isManuallyPaused = false;
          print('▲ 0 currentCaptionIndex == $currentCaptionIndex');     
          print('▲ 1 動画が再生中です。');
          // print('▲ 2 該当キャプションの オブジェクトの確認: ${(captionsJa[currentCaptionIndex])}');
          // print('▲ 3 該当キャプションの dur値の確認: ${(captionsJa[currentCaptionIndex]['dur'])}');
          // 'dur'の値が文字列で数字表記になっているので
          // 型のキャスト String → double
          durationTime = double.parse(captionsJa[currentCaptionIndex]['dur']);
          // print('▲ 4 durationTimeの代入後の値: ${(captionsJa[currentCaptionIndex]['dur'])}');
          print('playbackRate == ${iFrameController.value.playbackRate}');
          // ② そのカウント後に停止メソッドが実行されるようにスケジュール
          await Future.delayed(
            // 第1引数
            Duration(milliseconds: (durationTime * 1000 * (1 / iFrameController.value.playbackRate)).toInt()),
            // 第2引数
            () {iFrameController.pauseVideo();}
          );
          print('▲ 2 一時停止の予約完了 ');
          print('▲ 3 currentCaptionIndex == $currentCaptionIndex');     
        }
      }
    

      // ■ システムによる一時停止処理のコールバック
      if (iFrameController.value.playerState == PlayerState.paused
       && isManuallyPaused == false) {

        if (isPaused == false) {
          isPaused = true;
          isPlaying = false;
          isManuallyPaused = false;
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

      // ■ ユーザーによる一時停止処理のコールバック
      if (iFrameController.value.playerState == PlayerState.paused
       && isManuallyPaused == true) {
          isUnStarted = false;
          isPlaying = false;
          isPaused = false;
          print('ユーザーよる一時停止処理のコールバック');
      }



    });
  }

  /// YouTubePlayerの再生位置を取得します
  void listenPlayTime() {
    playTimeSubscription = iFrameController.
    stream.listen((event) async{
      double? loadedPlayTime = await iFrameController.currentTime;
       // 最新の再生位置を取得してUIに変更を反映
       setState(() {
         currentSliderValue = loadedPlayTime;  
       });
    });
  }

  /// TTSの環境設定とコールバック設定
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

  /// double を「分:秒」形式の文字列に変換する関数
  String formatDuration(double? totalDuration) {
    final duration = Duration(seconds: totalDuration!.toInt());
    // duration.inMinutes: オブジェクトの総 "分数" を整数で返します。
    // duration.inSeconds: オブジェクトの総 "秒数" を整数で返します。
    // 割り切れない秒数は切り捨てられます。
    // remainder(): 割り算の余りを取得するメソッド 
    final minutes = NumberFormat('00').format(duration.inMinutes.remainder(60));
    final seconds = NumberFormat('00').format(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
  
  /// 二分探索を用いてシークポイントの値に最も近い 'start' 値を持つcaptionのindexを返す関数
  int searchClosestCaption(double targetValue, List<Map<String, dynamic>> captions) {
    int lowestIndex = 0;
    int highestIndex = captions.length - 1;


    while (lowestIndex <= highestIndex) {
      int midIndex =  (lowestIndex + highestIndex) ~/ 2;
      double midStartValue = double.parse(captions[midIndex]['start']);

        // ターゲット値がmidと一致する場合はmidを返す
        if (targetValue == midStartValue) {
          return midIndex;

        // ターゲット値がmidとより小さい領域場合は、high側(mid含む)を削除する
        } else if (targetValue < midStartValue) {
          highestIndex = midIndex - 1;
          
        // ターゲット値がmidとより大きい領域場合は、low側(mid含む)を削除する
        } else {
          lowestIndex = midIndex + 1;
        }
    }
    return lowestIndex;
  }

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
      ),

      body: isLoading == true
        ? const Center(child: CircularProgressIndicator()) // ローディング中はインジケーターを表示
        : Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                  
                      const SizedBox(height: 30),

                      SizedBox(
                        height: 300, 
                        width: 800,
                          child: YoutubePlayer(
                          controller: iFrameController,
                          ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 140,
                        width: 400,
                        child: Card(
                          elevation: 8,
                          color: Colors.lightGreen,
                          child: Column(
                            children: [

                              Expanded(
                                // 再生位置のシークバー
                                child: Slider(
                                  value: currentSliderValue!,
                                  min: 0,
                                  max: totalDuration!,
                                  onChanged: (value) async {
                                    // スライダーの値を直接変更する
                                    setState(() {
                                      currentSliderValue = value;
                                    });
                                  },
                                  onChangeEnd: (value) async{
                                    print('1 onChangeEnd実行');
                                    // 手動のスライダーの移動が完了したら
                                    // 変数をリフレッシュして 
                                    // シークを実行
                                    isUnStarted = false;
                                    isPlaying = false;
                                    isPaused = false;
                                    print('2 onChangeEnd実行');
                                    await iFrameController.seekTo(seconds: value.toDouble());
                                    // print('3 onChangeEnd実行 currentCaptionIndex == $currentCaptionIndex');
                                    currentCaptionIndex = searchClosestCaption(value.toDouble(), captionsJa);
                                    // print('4 onChangeEnd実行 currentCaptionIndex == $currentCaptionIndex');
                                  },
                                  activeColor: Colors.blue,
                                  inactiveColor: Colors.white,
                                ),
                              ),
                              
                              Text('${formatDuration(currentSliderValue)} / ${formatDuration(totalDuration)}'), 

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              
                                  // ■ 再生ボタン
                                  ElevatedButton(
                                    onPressed: () async{
                                      isManuallyPaused = false;
                                      await iFrameController.playVideo();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero, // 四角形にするため、角を丸めない
                                      ),
                                    backgroundColor: Colors.white, 
                                    foregroundColor: Colors.blue, 
                                    ),
                                    child: const Text('再生',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ),
                              
                                  const SizedBox(width: 15,),
                              
                                  // ■ 停止ボタン                            
                                  ElevatedButton(
                                    onPressed: () async{
                                      isManuallyPaused = true;
                                      await iFrameController.pauseVideo();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero, // 四角形にするため、角を丸めない
                                      ),
                                    backgroundColor: Colors.white, 
                                    foregroundColor: Colors.blue, 
                                    ),
                                    child: const Text('停止',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // ■ 戻るボタン                  
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
                        child: const Text('動画一覧に戻る',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                  

                      // ■ 注意書き
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
                                '・「再生」「停止」「再生位置の調整」は、緑色枠内の専用プレイヤーで操作してください。\n\n・表示字幕の設定は、YouTubeのいつも通りの操作と同じです（動画右下の歯車マーク）\n\n・倍速再生にも対応しています。\n\n・動画が終了すると自動でループします。',
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
