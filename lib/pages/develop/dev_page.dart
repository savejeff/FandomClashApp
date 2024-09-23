import 'package:flutter/material.dart';
import 'dart:async';

import '../../util.dart';


class DevPage extends StatefulWidget {
  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {

  bool updateRunning = false;
  ExecuterEvery EXECUTE_EVERY_STATUS = ExecuterEvery(1000);

  Timer? _timer; // Store the Timer reference

  /*******************************************************/

  String debugTxtOut = "";
  String debugTxtStatus = "";
  bool _log_direction = false;
  int _time_last_log = 0;


  void LogClear() {
    setState(() {
      debugTxtOut = "";
      _time_last_log = millis();
    });
  }


  void LogX(String sformat, [List<Object>? args]) {
    String msg = format(sformat, args);

    if (_time_last_log == 0) {
      _time_last_log = millis();
    }

    String newLogEntry = "[+${millis() - _time_last_log}] $msg";
    if (_log_direction) {
      setState(() {
        debugTxtOut = "$newLogEntry\n$debugTxtOut";
      });
    } else {
      setState(() {
        debugTxtOut += "\n$newLogEntry";
      });
    }

    print(newLogEntry); // Equivalent to Log.d(TAG, msg) in Android

    _time_last_log = millis();
  }


  /*******************************************************/

  @override
  void initState() {
    super.initState();
    InitUI();
    UpdateUI();

    /*
    Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      Update();
    });*/

    // Start the timer when the page is created
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      Update();
    });

    LogX("Init is done at %d", [millis()]);
  }


  @override
  void dispose() {

    // Cancel the timer when the page is destroyed
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    super.dispose();
  }



  void Update() {

    if(EXECUTE_EVERY_STATUS.itsTime()) {

      /********************* regular logic here ******************/

      //LogX(">>> Update Period");

      /************************************************************/

    }
  }



  void InitUI() {
    // Define button actions and texts
  }

  Future<void> UpdateUI() async {
    if (!updateRunning) {
      setState(() {
        updateRunning = true;
      });

      final StringBuffer txtStatus = StringBuffer();
      final StringBuffer txtOut = StringBuffer();

      await Future.delayed(Duration(milliseconds: 1), () {
        // Example asynchronous operation

        // Example: Add status and output texts
        txtStatus.write("Dev: 1\n");

        if (debugTxtStatus.isNotEmpty) {
          txtStatus.write("\n$debugTxtStatus");
        }

        if (debugTxtOut.isNotEmpty) {
          txtOut.write("\n$debugTxtOut");
        }

        setState(() {
          debugTxtStatus = txtStatus.toString();
          debugTxtOut = txtOut.toString();
        });

        updateRunning = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dev Page'),
      ),
      body: Row(
        children: [
          // Left side: Status and Log
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Status:\n$debugTxtStatus',
                        style: TextStyle(fontFamily: 'monospace', height: 1.5),
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Output:\n$debugTxtOut',
                        style: TextStyle(fontFamily: 'monospace', height: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          VerticalDivider(), // Divider between columns

          // Right side: Buttons
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  for (int i = 0; i < 8; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        onPressed: () => onButtonPressed(i),
                        child: Text('Button $i'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 60),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onButtonPressed(int index) {
    switch (index) {
      case 0:
        LogX('Button 0 Pressed: Rebuild Time Segments');
        break;
      case 1:
        LogX('Button 1 Pressed: Clear Time Segments');
        LogClear();
        break;
    // Add more cases for other buttons
      default:
        LogX('Button $index Pressed');
        break;
    }
    UpdateUI();
  }


}
