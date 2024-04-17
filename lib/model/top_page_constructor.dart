
class PageTransitionConstructor {
  // -2: 特に必要なコールバックがない場合
  // -1: WatchPageからの遷移で、字幕の取得に失敗した場合
  // 0: main.dartからの遷移
  
  int? flagNumber;


  PageTransitionConstructor({
    required this.flagNumber,
  });
}