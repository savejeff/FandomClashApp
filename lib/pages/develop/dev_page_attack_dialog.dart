import 'package:fandom_clash/util_game.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'dev_base.dart';

import 'package:fandom_clash/util.dart';
import 'package:fandom_clash/models.dart';
import 'package:fandom_clash/global.dart';
import 'package:fandom_clash/defines.dart';

import 'package:fandom_clash/widgets/value_modifier_widget.dart';

import 'package:fandom_clash/widgets/attack_dialog.dart';
import 'package:fandom_clash/widgets/dice_roll_widget.dart';

import 'dart:math';

class DevPage extends StatefulWidget {
  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends DevPageBaseState<DevPage> {
  bool updateRunning = false;

  /*******************************************************/

  String debugTxtStatus = "";

  /************************ state variables *******************************/
  int finalValue = 1; // Final value for the dice
  bool isRolling = false;

  void _startRoll() {
    if (isRolling) return;
    setState(() {
      finalValue =
          Random().nextInt(6) + 1; // Random final value between 1 and 6
      isRolling = true;
    });

    // Simulate rolling for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isRolling = false;
      });
    });
  }

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

        //**********************************************************************

        setState(() {
          debugTxtStatus = txtStatus.toString();
        });

        updateRunning = false;
      });
    }
  }

  //************************** button callbacks *********************************

  void onButton0_Click() {
    LogX('Button 0 Pressed');
  }

  void onButton1_Click() {
    LogX('Button 1 Pressed');
  }

  void onButton2_Click() {
    LogX('Button 2 Pressed');
  }

  void onButton3_Click() {
    LogX('Button 3 Pressed');
  }

  void onButton4_Click() {
    LogX('Button 4 Pressed');
  }

  void onButton5_Click() {
    LogX('Button 5 Pressed');
  }

  void onButtonPressed(int index) {
    switch (index) {
      case 0:
        onButton0_Click();
        break;
      case 1:
        onButton1_Click();
        break;
      case 2:
        onButton2_Click();
        break;
      case 3:
        onButton3_Click();
        break;
      case 4:
        onButton4_Click();
        break;
    }
    UpdateUI();
  }

  //******************************* body ***************************************

  Widget _buildDevElements() {
    return
        //************************* dev element here ***************************
        Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DiceRollWidget(
          finalValue: finalValue,
          rolling: isRolling,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isRolling ? null : _startRoll,
          child: const Text('Roll Dice'),
        ),
        ElevatedButton(
          onPressed: () async {
            // Show the target picker dialog
            Character? character = Global().GameMan.characters[0];
            Character? target = Global().GameMan.characters[3];

            if (target != null) {
              // Show the AttackDialog
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AttackDialog(
                    attacker: character,
                    defender: target,
                    onAttackComplete: () {
                      // Update the UI after the attack
                      //onUpdate();
                      setState(() {});
                    },
                  );
                },
              );
            } else {
              // Attack was canceled
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Attack canceled')),
              );
            }
          },
          child: const Text('Attack'),
        ),
      ],
    )

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
