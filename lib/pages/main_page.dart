import 'dart:convert';

import 'package:fandom_clash/content_builtin.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';


import '../models.dart';
import '../target_picker.dart';
import '../mechanics.dart';
import '../global.dart';

import '../widgets/character_list_widget.dart';

import 'develop/dev_page.dart';

//import 'develop/dev_page_basics_stateful_widget.dart';
//import 'develop/dev_page_fragment.dart';
//import 'develop/dev_page_widget_state_inheritance.dart';

import '../widgets/character_interaction_interface_widget.dart';

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
  Character? selectedCharacter;

  @override
  void initState() {
    super.initState();

    // Initialize the Global
    Global().init();

    // Begin processes like loading game state or creating dummy content
    Global().begin();
  }

  /****************************************************************************/

  // FloatingActionButton callback
  void _onClick_Develop() {
    if (true) {
      // Convert to JSON string
      final jsonString = jsonEncode(effect_healing_2hp.toJson());
      Log("Main", 'Encoded JSON: $jsonString');
      setState(() {});
    }

    if (false) {
      setState(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DevPage()));
      });
    }

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

      setState(() {
        Global().characterManager.addCharacter(char_new);
      });
    }
  }

  void _startTurn() {
    if (Global().GameMan.turn_active) {
      return;
    }
    // Logic to start the turn
    print("Starting turn...");
    // Set the turn_active to true or whatever your game logic requires
    Global().GameMan.startTurn();
    setState(() {}); // Trigger a UI update to reflect the new state
  }

  void _finishTurn() {
    // Logic to finish the turn
    print("Finishing turn...");
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
            Text("Turn ${Global().GameMan.turn} "),
            if (BuildConfig.ENABLE_DEVELOP) ...[
              ElevatedButton(
                onPressed: () {
                  _onClick_Develop();
                },
                child: const Text('Develop'),
              ),
            ],
            Text("   ") // Some Padding
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
                characters: Global().characterManager.characters,
                onSelected: (character) {
                  setState(() {
                    selectedCharacter = character;
                  });
                }),
          ),

          // Right Side: CharacterInteractionInterfaceWidget
          Expanded(
            flex: 2,
            child: selectedCharacter != null
                ? CharacterInteractionInterfaceWidget(
                    character: selectedCharacter!,
                    onUpdate: () {
                      setState(() {
                        // Update UI when the character interaction changes
                      });
                    },
                  )
                : const Center(
                    child: Text('Select a character to view actions'),
                  ),
          ),

          // Right Side: CharacterInteractionInterfaceWidget
          Expanded(
            flex: 1,
            child: Text(Global().SysLog)
          ),
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
