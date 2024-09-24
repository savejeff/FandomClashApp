import 'package:flutter/material.dart';
import 'dart:async';

import '../../util.dart';


// Base state class that holds the shared logic (LogX, LogClear, etc.)
abstract class SmartState<T extends StatefulWidget> extends State<T> {

  Timer? _timer; // Store the Timer reference
  ExecuterEvery EXECUTE_EVERY_PERIOD = ExecuterEvery(1000);


  @override
  void initState() {
    super.initState();

    // Start the timer when the page is created
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      Update();
    });

  }

  @override
  void dispose() {

    // Cancel the timer when the page is destroyed
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    super.dispose();
  }

  void Period() {

  }

  void Update() {

    if(EXECUTE_EVERY_PERIOD.itsTime()) {
      Period();
    }

  }
}


// Base state class that holds the shared logic (LogX, LogClear, etc.)
abstract class DevPageBaseState<T extends StatefulWidget> extends SmartState<T> {


  String debugTxtOut = "";
  bool _log_direction = false;
  int _time_last_log = 0;

  // Clears the log
  void LogClear() {
    setState(() {
      debugTxtOut = "";
      _time_last_log = DateTime.now().millisecondsSinceEpoch;
    });
  }

  // Logs a formatted message into the log
  void LogX(String sformat, [List<Object>? args]) {
    String msg = args == null ? sformat : format(sformat, args);

    if (_time_last_log == 0) {
      _time_last_log = DateTime.now().millisecondsSinceEpoch;
    }

    String newLogEntry = "[+${DateTime.now().millisecondsSinceEpoch - _time_last_log}] $msg";
    if (_log_direction) {
      setState(() {
        debugTxtOut = "$newLogEntry\n$debugTxtOut";
      });
    } else {
      setState(() {
        debugTxtOut += "\n$newLogEntry";
      });
    }

    print(newLogEntry); // For debugging in the console

    _time_last_log = DateTime.now().millisecondsSinceEpoch;
  }

}
