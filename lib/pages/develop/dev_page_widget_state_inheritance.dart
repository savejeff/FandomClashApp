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

//******************************************************************

class DevPage extends StatefulWidget {
  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends DevPageBaseState<DevPage> {

  bool updateRunning = false;


  /*******************************************************/

  String debugTxtStatus = "";

  /************************ state variables *******************************/

  // Initial incrementStep for the Counter widget
  int incrementStep = 1;

  /*******************************************************/

  @override
  void initState() {
    super.initState();
    InitUI();
    UpdateUI();

    LogX("Init is done at %d", [millis()]);
  }

  @override
  void dispose() {

    super.dispose();
  }


  @override
  void Period() {

    /********************* regular logic here ******************/

    //LogX(">>> Update Period");

    /************************************************************/
  }

  void Update() {
    super.Update();
    UpdateUI();
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

        //**************************** build status txt ************************

        // Example: Add status and output texts
        txtStatus.write("Dev: 1\n");
        txtStatus.write(format("Millis: %d\n", [millis()]));

        //**********************************************************************

        setState(() {
         debugTxtStatus = txtStatus.toString();
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
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Status:\n$debugTxtStatus',
                        style: TextStyle(fontFamily: 'RobotoMono'),
                      ),
                    ),
                  ),
                  Divider(),
                  //************************* dev element here ***************************

                  Text("Hallo"),

                  //**********************************************************************
                  Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        'Output:\n$debugTxtOut',
                        style: TextStyle(fontFamily: 'RobotoMono'),
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
        LogX('Button 0 Pressed');
        break;
      case 1:
        LogX('Button 1 Pressed');
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
