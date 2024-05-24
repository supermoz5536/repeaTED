import 'package:flutter/material.dart';
import 'package:repea_ted/const/const_text.dart';

class GlobalHowToUse extends StatelessWidget {
  const GlobalHowToUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 146, 146, 146),
                          offset: Offset(0, 4.5), // 上方向への影
                          blurRadius: 7, // ぼかしの量
                        )
                      ]),
                  child: Theme(
                    data: ThemeData().copyWith(
                      iconTheme: IconThemeData(
                        size: MediaQuery.of(context).size.width < 600
                          ? 35
                          : 45, // アイコンのサイズを変更
                      ),
                    ),
                    child: ExpansionTile(
                      // shapeプロパティを設定するとデフォルトの境界線UIの描画を避けることができる
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      backgroundColor: Colors.blueAccent, // ボディ部分の背景色
                      collapsedBackgroundColor: Colors.blueAccent, // ヘッダー部分の背景色
                      iconColor: Colors.white, // 展開時のアイコンの色
                      collapsedIconColor: Colors.white, // 閉じている時のアイコンの色
                      title: Padding(
                        padding: MediaQuery.of(context).size.width < 600
                          ? const EdgeInsets.only(left: 40)
                          : const EdgeInsets.only(left: 50),
                        child: const Center(
                          child: Text(
                            '- 使い方 -',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30
                              ),
                            ),
                        )
                      ),
                      children: <Widget>[
                        Divider(
                          color: Colors.white.withOpacity(0.4),
                          height: 0,
                          thickness: 0.1,
                          indent: 70,
                          endIndent: MediaQuery.of(context).size.width < 600
                            ? 85
                            : 70,
                        ),
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
                                ]),
                            child: const Center(
                              child: Text(
                                ConstText.supportedLang,
                                style: TextStyle(
                                  color: Colors.white,
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                              ),
                            ),
                          ),
                      ),
                    ]),
                  ),
                );
  }
}