// NetworkImage, ImageInfo, ImageConfiguration などのウィジェット/クラスのため
import 'package:flutter/material.dart'; 
// Completer および Future のため
import 'dart:async'; 


class LoadThumbnail {

  /// この関数は、与えられたURLから画像をロードし、
  /// ImageProviderオブジェクトを返します。
  static Future<ImageProvider> loadThumbnail(String url) async {
    
    // NetworkImageオブジェクトをインスタンス化して、
    // 引数で受け取ったurlを使用しています。
    // 与えられた URL から画像データを取得する役割を担います。
    final image = NetworkImage(url);

    // Completer<ImageProvider>のインスタンスを作成します。
    // これにより、非同期的に画像を取得するプロセスの結果を
    // 後からFutureにセットできるようになります。

    // 非同期処理の結果を外部に公開するためのオブジェクトです。
    // 通常、非同期操作がいつ終了するか正確には分からない状況で有効です。
    // Completerを使用すると、操作が完了した時点で結果をFutureに通知し、
    // それを待っている他の部分に結果を渡すことができます。

    // ImageProviderは、
    // 画像を取得するためのメソッドやプロパティを持つFlutterの抽象クラスです。
    final completer = Completer<ImageProvider>();

    // ImageStreamListenerオブジェクトは
    // 画像のロード状況を監視するためのリスナーです。
    // 特定のイベント（画像のロード完了やエラー）が
    // 発生したときにコールバックを呼び出します。
    final listener = ImageStreamListener((ImageInfo info, bool _) {

      // listener が completer を操作することで、
      // 画像ロードの結果（成功または失敗）が 
      // completer.future を通じて公開されます。

      // 成功時: completer.complete(image) は、
      // 画像が正常にロードされたことを示し、ロードされた画像を Future に渡します。
      completer.complete(image);

    },
      onError: (exception, stackTrace) {
      // エラー時: completer.completeError(exception) は、
      // ロード中に何らかの問題が発生したことを示し、エラー情報を Future に渡します。
      completer.completeError(exception);
    });
  
    // この行の役割は、
    // ダウンロード時の環境設定とリスナーの監視を設定した上で、
    // ダウンロードをトリガーすることです。

    // image.resolve(...): 画像をダウンロードを開始するためのメソッドです
    // ImageProvider（この場合は image としてインスタンス化された NetworkImage）が
    // 提供する画像データを取得しようとします。
    // 具体的には、画像の実際のロードプロセスを開始します。
    // これは、画像を表示する前に必要な処理で、
    // 画像のデータをメモリにロードして描画可能な状態にします。

    // ImageConfiguration オブジェクトは、画像をダウンロードする際の環境設定を提供します
    // デバイスのピクセル比、サイズ、テキストの方向、プラットフォームなどの情報が含まれます。
    // const ImageConfiguration() としているのは、
    // 特に設定を変更せずにデフォルトの設定を使用しており
    // 特別な設定が必要ない場合の標準的な使用法です
    
    // addListener(listener)で、
    // 作成したリスナーオブジェクトを利用して
    // ダウンロード状況を監視をします。

    image.resolve(const ImageConfiguration()).addListener(listener);

    // リスナーが変更をリスンしてすると
    // コールバックで設定した image の変更（完了の通知）を
    // completer.future を通じて取得できます。
    // 呼び出し元はこのfutureを使用して、
    // 画像がロードされるのを待ったり、
    // ロードが完了した後の処理を行ったりできます。
    return completer.future;
  }

}