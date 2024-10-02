import 'package:fandom_clash/global.dart';
import 'package:fandom_clash/util.dart';


void Log(String tag, String sformat, [List<Object>? args]) {
  Global().Log(tag, sformat, args);
}


void LogTurn(String tag, String sformat, [List<Object>? args]) {
  Global().Log(tag, sformat, args);
  Global().GameMan.LogTurn(tag, format(sformat, args));
}




