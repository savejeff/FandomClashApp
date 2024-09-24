import 'package:flutter/material.dart';
import 'dart:async';

import '../../util.dart';
import 'dev_base.dart';



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

  //**************************************************************


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

  //************************** button callbacks*********************************


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

  //******************************* body ***************************************


  Widget _buildDevElements() {
    return
    //************************* dev element here ***************************
      Text("Example Element")
    //**********************************************************************
    ;
  }

  Widget _buildStatus() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 130.0, // Replace with your desired minimum height
      ),
      child: SingleChildScrollView(
        child: Text(
          'Status:\n$debugTxtStatus',
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
    );
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
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildLeftSide(),
            ),
          ),
          VerticalDivider(), // Divider between columns

          // Right side: Buttons
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildRightSideButtons(),
            ),
          ),
        ],
      ),
    );
  }


  // Left Side: Status and Output
  Widget _buildLeftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 250.0, // Replace with your desired minimum height
            ),
            child: SingleChildScrollView(
              child: _buildDevElements(),
            )),
        //**********************************************************************
        Divider(),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: Text(
              'Output:\n$debugTxtOut',
              style: TextStyle(fontFamily: 'RobotoMono'),
            ),
          ),
        ),
      ],
    );
  }

  // Right Side: Buttons
  Widget _buildRightSideButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatus(),
        Divider(),
        for (int i = 0; i < 5; i++)
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
    );
  }



}
