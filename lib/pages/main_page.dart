import 'package:flutter/material.dart';

import 'package:fandom_clash/content_builtin.dart';
import 'package:fandom_clash/modules/game_state.dart';

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../models.dart';
import '../target_picker.dart';
import '../mechanics.dart';
import '../global.dart';

import '../widgets/character_list_widget.dart';

//import 'develop/dev_page_basics_stateful_widget.dart';
//import 'develop/dev_page_fragment.dart';
//import 'develop/dev_page_widget_state_inheritance.dart';

import '../widgets/character_interaction_interface_widget.dart';
import '../widgets/develop_overview.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fandom Clash: Homefront Edition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const MainPage(title: 'Fandom Clash: Homefront Edition'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Currently selected character
  //Character? selectedCharacter;

  @override
  void initState() {
    super.initState();

    // Initialize the Global
    Global().init();

    // Begin processes like loading game state or creating dummy content
    Global().begin();
  }

  /****************************************************************************/

  void _startTurn() {
    if (Global().GameMan.turn_active) {
      return;
    }
    // Logic to start the turn
    Log("Main", "Starting turn...");
    // Set the turn_active to true or whatever your game logic requires
    Global().GameMan.startTurn();
    setState(() {}); // Trigger a UI update to reflect the new state
  }

  void _finishTurn() {
    // Logic to finish the turn
    Log("Main", "Finishing turn...");
    // Set the turn_active to false or whatever your game logic requires
    Global().GameMan.finishTurn();
    setState(() {}); // Trigger a UI update to reflect the new state
  }

  /****************************************************************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title),
            Expanded(flex: 1, child: Text("")),
            if (!Global().GameMan.turn_active && Global().GameMan.turn > 0) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Global().GameMan.RestoreTurn(Global().GameMan.turn - 1);
                  });
                },
                child: const Text('Revert Turn'),
              ),
            ],
            SizedBox(width: 10), // add some padding between buttons
            Text("Turn ${Global().GameMan.turn} "),
            SizedBox(width: 10), // add some padding between buttons
            if (!Global().GameMan.turn_active && Global().GameMan.turn < Global().GameMan.BackUpCount()) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Global().GameMan.RestoreTurn(Global().GameMan.turn + 1);
                  });
                },
                child: const Text('Redo Turn'),
              ),
            ],
            if (BuildConfig.ENABLE_DEVELOP) ...[
              /*
              ElevatedButton(
                onPressed: () {
                  //_onClick_Develop();
                },
                child: const Text('Develop'),
              ),*/
            ],
            SizedBox(width: 25), // add some padding between buttons
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Row(
        children: [
          // Left Side
          Expanded(
            flex: 2,
            child: CharacterListWidget(
                characters: Global().GameMan.characters,
                selectedCharacter: Global().GameMan.character_selected,
                onSelected: (character) {
                  setState(() {
                    Global().GameMan.character_selected = character;
                  });
                }),
          ),

          // Right Side: CharacterInteractionInterfaceWidget
          Expanded(
            flex: 2,
            child: Global().GameMan.character_selected != null && Global().GameMan.turn_active
                ? CharacterInteractionInterfaceWidget(
                    character: Global().GameMan.character_selected!,
                    onUpdate: () {
                      setState(() {
                        // Update UI when the character interaction changes
                      });
                    },
                  )
                : Center(
                    child: Global().GameMan.turn_active ? Text('Select a character to view actions') : Text('Start your Turn'),
                  ),
          ),

          if (BuildConfig.ENABLE_DEVELOP) ...[
            // Right Side: CharacterInteractionInterfaceWidget
            Expanded(
                flex: 1,
                child: DevelopOverview(
                  onValueChanged: (dummy) {
                    setState(() {});
                  },
                )),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Global().GameMan.turn_active) {
            _finishTurn(); // Call the method to finish the turn
          } else {
            _startTurn(); // Call the method to start the turn
          }
        },
        tooltip: Global().GameMan.turn_active ? 'Finish Turn' : 'Start Turn',
        // Update tooltip
        child: Icon(
          Global().GameMan.turn_active
              ? Icons.stop
              : Icons.play_arrow, // Update icon dynamically
        ),
      ),
    );
  }
}
