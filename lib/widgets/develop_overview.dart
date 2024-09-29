import 'package:flutter/material.dart';

import 'dart:convert';

import '../global.dart';

import '../models.dart';
import '../target_picker.dart';
import '../mechanics.dart';
import '../modules/game_state.dart';

import '../pages/develop/dev_page.dart';

String reverseLines(String input) {
  // Split the input string by newline characters
  List<String> lines = input.split('\n');

  // Reverse the order of the lines
  List<String> reversedLines = lines.reversed.toList();

  // Join the reversed lines back into a single string
  return reversedLines.join('\n');
}

class DevelopOverview extends StatelessWidget {
  final void Function(int) onValueChanged;

  const DevelopOverview({
    Key? key,
    required this.onValueChanged, // Callback to modify value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _statusText = '' +
        'BackUpCount: ${Global().GameMan.BackUpCount()}\n' +
        "Current Turn: ${Global().GameMan.turn}\n" +
        "Turn Active: ${Global().GameMan.turn_active}\n";

    void _onClick_DevPage() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DevPage()));
    }

    void _onClick_Develop1() {
      if (true) {
        int turn = Global().GameMan.turn;
        turn -= 1;
        Global().GameMan.RestoreTurn(turn);
        onValueChanged(turn);
      }

      if (false) {}

      if (false) {
        Character char_new = Character(
          name: 'Warrior',
          player: 'Player 1',
          P: 7,
          A: 4,
          W: 4,
          maxHP: 17,
          HP: 17,
          AP: 9,
          MR: 3,
          abilities: [],
          items: [],
          size: 'Large',
          fandomTrait: 'Superhero',
          role: 'Warrior',
        );

        //setState(() {
        Global().GameMan.addCharacter(char_new);
        //});
      }
    }

    void _onClick_Develop2() {
      Log("Dev", "Hallo, World!");
    }

    void _onClick_Develop3() {}

    //*************** body *************************

    return SingleChildScrollView(
      child: Column(
        children: [
          Text("Develop:",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10), // add some padding between buttons

          ElevatedButton(
            onPressed: () {
              _onClick_DevPage();
            },
            child: const Text('Dev Page'),
          ),
          SizedBox(height: 10), // add some padding between buttons
          ElevatedButton(
            onPressed: () {
              _onClick_Develop1();
            },
            child: const Text('Dev #1'),
          ),
          SizedBox(height: 10), // add some padding between buttons
          ElevatedButton(
            onPressed: () {
              _onClick_Develop2();
            },
            child: const Text('Dev #2'),
          ),
          SizedBox(height: 10), // add some padding between buttons
          ElevatedButton(
            onPressed: () {
              _onClick_Develop3();
            },
            child: const Text('Dev #3'),
          ),
          SizedBox(height: 10), // add some padding between buttons

          Text("Status: ",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Align(
              alignment: Alignment.topLeft, // left-align the text
              child: Text(
                _statusText,
                style: TextStyle(fontFamily: 'RobotoMono', fontSize: 12),
              )),


          //SizedBox(height: 10), // add some padding between buttons

          Text("Log: ",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Align(
            alignment: Alignment.topLeft, // left-align the text
            child: Text(
              reverseLines(Global().SysLog),
              style: TextStyle(fontFamily: 'RobotoMono', fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
