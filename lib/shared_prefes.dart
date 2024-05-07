import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefes {                     
static SharedPreferences? _preferences; 

static Future<void> setPrefsInstance() async{
  // ignore: prefer_conditional_assignment
  if(_preferences == null) {
    _preferences = await SharedPreferences.getInstance();    //ここまでで_preferencesを定義してそこにSharedpreferrencesのインスタンスを代入するところまで完了
  }
}


static bool? getHasHistory() {       
  return _preferences!.getBool('hasHistory') ?? false; 
}

static setHasHistory() {       
  return _preferences!.setBool('hasHistory', true); 
}



}

