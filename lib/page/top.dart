import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repea_ted/model/top_page_constructor.dart';
import 'package:repea_ted/model/watch_%20page_constructor.dart';
import 'package:repea_ted/page/watch.dart';
import 'package:repea_ted/riverpod/provider/recommend_list_provider.dart';
import 'package:repea_ted/service/global_overlay_portal.dart';
import 'package:repea_ted/service/load_%20thumbnail.dart';
import 'package:repea_ted/service/utility.dart';
import 'package:repea_ted/service/video.dart';

class TopPage extends ConsumerStatefulWidget {
  final PageTransitionConstructor? topConstructor;
  const TopPage(this.topConstructor, {super.key});

  @override
  ConsumerState<TopPage> createState() => _LoungePageState();
}

class _LoungePageState extends ConsumerState<TopPage> {
  bool isInputEmpty = true;
  String? url;
  String? videoId;
  List<Video?>? recommendList = [];
  Future<List<Video?>?>? futureRecommendList;
  int? mobileItemCount = 30;
  int? desktopItemCount = 33;
  // final GlobalKey<State<StatefulWidget>> customOverlayKey_1 = GlobalKey();
  final _overlayController1st = OverlayPortalController();
  // final _overlayController2nd = OverlayPortalController();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController showDialogNameController = TextEditingController();
  // final TextEditingController statementController = TextEditingController();
  final TextEditingController urlTextController = TextEditingController();



  @override
  void initState() {
    super.initState();

      // main.dartからの画面遷移の場合(0)のみ
      // おすすめ動画リストの初期化処理を実行
      if (widget.topConstructor!.flagNumber == 0) {
        futureRecommendList = Video.loadTedTalk().then((result) {
          if (result != null) {
            result.shuffle();
            // シャッフルしたリストの先頭の100要素を取得
            var shuffledResult = result.take(100).toList();
            // プロバイダーを更新
            ref.read(recommendListProvider.notifier)
             .setShuffledRecommendList(shuffledResult);
          }
       });
      }
     // 日本語スクリプトのない動画URLでWatchPageから戻ってきた場合
     if (widget.topConstructor!.flagNumber == -1) {
       WidgetsBinding.instance.addPostFrameCallback((_) {
         ScaffoldMessenger.of(context).showSnackBar(customSnackBar()); 
       });
     } 
  }


  @override
  void dispose() {
    // showDialogNameController.removeListener(() {setState((){});});
    // showDialogNameController.dispose();
    // nameController.dispose();
    // statementController.dispose();
    urlTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  List<Video?>? recommendList= ref.watch(recommendListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CustomOverlayPortal(
          customController:  _overlayController1st,
          flagNumber: 1
        ),
        title: const Text('repeaTED（リピーテッド）BETA版',
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




      body: Stack(
        children: <Widget>[
          ListView(
            children: [
          
              const SizedBox(height: 30),
          
              Row(
                children: [
                  
                // ■ 入力フィールド
                Expanded(
                  child: Padding(
                  // 入力フィールドの枠の大きさ    
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 30,
                      right: 0,
                      bottom: 30), 
                    child: TextField(
                      controller: urlTextController, 
                      onChanged: (value) {
                        // TextFiledのテキスト変更をリスンして
                        // 空白かどうかを確認して再描画
                        setState(() {
                          isInputEmpty = value.isEmpty;
                        });
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 244, 241, 241),
                        contentPadding: EdgeInsets.only(left: 10),
                        border: InputBorder.none,
                        hintText: 'Youtube動画のURLをココに入力'
                      ),
                      // [Enterキー]のコールバックを指定するプロパティ
                      onSubmitted: (_) async{
                        if (isInputEmpty != true ) {
                          url = urlTextController.text;
                          videoId = Utility.extractVideoId(url);
                          if (videoId != null && context.mounted ) {
                            WatchPageConstructor watchConstructor = 
                              WatchPageConstructor(videoId: videoId);
                            /// 画面遷移に必要なコンストラクタ
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context)
                                => WatchPage(watchConstructor)),
                              (_) => false);
                          }
                        }
                      },
                    ),
                  )),
          
                // ■ 送信アイコン
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 30
                  ),
                  child: IconButton(
                      onPressed: urlTextController.text.isEmpty
                      ? null
                      : () async {
                        if (isInputEmpty != true ) {
                          url = urlTextController.text;
                          videoId = Utility.extractVideoId(url);
                          if (videoId != null && context.mounted ) {
                            WatchPageConstructor watchConstructor = 
                              WatchPageConstructor(videoId: videoId);
                            /// 画面遷移に必要なコンストラクタ
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context)
                                => WatchPage(watchConstructor)),
                              (_) => false);
                          }
                        }
                      },
                      icon: Icon(
                        Icons.open_in_new_outlined,
                        color: isInputEmpty ? Colors.grey : Colors.blue,
                      )),
                ),
                ],
              ),
          

              // ■ 利用について
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  left: 30,
                  right: 30,
                  bottom: 20,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 146, 146, 146),
                          offset: Offset(0, 4.5), // 上方向への影
                          blurRadius: 7, // ぼかしの量
                        )
                      ]),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                      '・英語のYoutube動画を同時通訳者のように自動で日本語に読み上げるアプリです。\n\n・作業中などに流しっぱにして、英語の音に意識を向けながら繰り返し聞いてると、リスニング力が上がります。\n\n・ユーザー作成の日本語字幕のあるYoutube動画なら、上の検索バーから動画URLを入力して直接利用できます。',
                        style: TextStyle(
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          

              // ■ ギャラリーヘッダー
              Padding(
                padding: const EdgeInsets.only(
                  top:30,
                  left: 30,
                  right: 30,
                  bottom: 30,
                ),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 146, 146, 146),
                          offset: Offset(0, 4.5), // 上方向への影
                          blurRadius: 7, // ぼかしの量
                        )
                      ]),
                  // color: Colors.white,
                  height: 70, // フッター領域の縦幅
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        '本日おすすめの人気TED',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ■ ギャラリー
                FutureBuilder(
                  future: futureRecommendList,
                  builder: (BuildContext context, futureSnapshot) {
                    if (futureSnapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    } else if (futureSnapshot.hasError) {
                      return const SizedBox.shrink();
                    } else {            
                      return SizedBox(
                        height: MediaQuery.of(context).size.width < 600
                            // 「各動画の高さ」 x 「動画数」 + 「上部の静的な領域の高さ」
                            ? 225 * mobileItemCount!.toDouble()
                            // MediaQuery.of(context).size.width / 400 で横が何列か算出します
                            // desktopItemCountを横の列数で割って、縦１列あたりの動画数を算出します
                            // 算出した縦１列あたりの動画数に、1つあたり動画の高さをかけて、全体の高さを算出します。,
                            : ((desktopItemCount!.toDouble() / 3) + 4) * 257,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: MediaQuery.of(context).size.width < 600
                            ? mobileItemCount
                            : desktopItemCount,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: MediaQuery.of(context).size.width < 600
                            ? 1
                            : 3, 
                            childAspectRatio: 16 / 9, // アスペクト比
                          ),
                          itemBuilder: (BuildContext context, int index)  {
                            String? exractedTitle = Utility.extractTitle(recommendList![index]);
                            String? extractedSpeakerName = Utility.extractSpeakerName(recommendList[index]);
                            
                            
                      
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GridTile(
                                footer: GridTileBar(
                                  backgroundColor: Colors.black45,
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 4,),
                                      Flexible(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            exractedTitle ?? '',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                            ),),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Center(
                                          child: Text(
                                            extractedSpeakerName ?? '',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold
                                            ),),
                                        ),
                                      ),
                                      const SizedBox(height: 4,)
                                    ],
                                  ),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Ink(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage('https://img.youtube.com/vi/${recommendList[index]!.videoId}/0.jpg'),
                                                  fit: BoxFit.cover
                                              )
                                          ),
                                        child: InkWell(
                                          hoverColor: Colors.white.withOpacity(0.3),
                                          splashColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                                          onTap: () {
                                            WatchPageConstructor watchConstructor = 
                                              WatchPageConstructor(videoId: recommendList[index]!.videoId);
                                            /// 画面遷移に必要なコンストラクタ
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(builder: (context)
                                                => WatchPage(watchConstructor)),
                                              (_) => false);
                                          },
                                          child: const SizedBox(width: 400, height: 225),
                                          // InkWellの有効範囲はchildのWidgetの範囲に相当するので
                                          // タップの有効領域確保のために、空のSizedBoxを設定
                                        ),
                                      )
                                ),
                              ),
                            );
                          }),
                      );
                  }
              }),
            ],
          )
        ],
      ),
    );
  }


  SnackBar customSnackBar() {
    return SnackBar(
      duration: const Duration(milliseconds: 3500),
      behavior: SnackBarBehavior.floating,
      margin: MediaQuery.of(context).size.width < 600
        ? const EdgeInsets.all(30)
        : const EdgeInsets.only(
            top: 30,
            left: 300,
            right: 300,
            bottom: 30
          ),
      content: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 5, right: 20),
                child: Center(
                  child: Icon(
                    Icons.error_outline_outlined,
                    color: Colors.white,),
                ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Center(
                  child: Text(
                    '日本語字幕のない動画です。',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width < 600
                        ? 15
                        : 25,
                      color: Colors.white,
                    ),),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor:const Color.fromARGB(255, 44, 44, 44),
    );
  }

}

