import 'package:flutter/material.dart';
import '../models.dart';
import '../target_picker.dart';
import '../mechanics.dart';
import '../global.dart';

import 'develop/dev_page.dart';
//import 'develop/dev_page_basics_stateful_widget.dart';
//import 'develop/dev_page_fragment.dart';
//import 'develop/dev_page_widget_state_inheritance.dart';


import '../widgets/character_stats_widget.dart';
import '../widgets/action_interface_widget.dart';



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
      home: const MyHomePage(title: 'Fandom Clash: Homefront Edition'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  // Remove the characters list from the state
  // late List<Character> characters;

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

  // FloatingActionButton callback (to be implemented later)
  void _incrementCounter() {
    setState(() {
      // Logic to create new units will go here

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DevPage()),
      );

    });
  }

  // Function to handle character selection
  void _selectCharacter(Character character) {
    setState(() {
      Global().GameMan.character_selected = character;
      selectedCharacter = character;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: Row(
        children: [

          // Left Side: List of characters
          Expanded(
            flex: 1,
            child: ValueListenableBuilder<List<Character>>(
              valueListenable: Global().characterManager.characters,
              builder: (context, characters, _) {
                return ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    Character character = characters[index];
                    return CharacterStatsWidget(
                      character: character,
                      isSelected: selectedCharacter == character,
                      onTap: () => _selectCharacter(character),
                    );
                  },
                );
              },
            ),
          ),

          // Right Side: Action interface
          Expanded(
            flex: 1,
            //child: selectedCharacter != null
            child: Global().GameMan.character_selected != null
                ? ActionInterface(
              character: Global().GameMan.character_selected!,
              onUpdate: () {
                setState(() {
                  // Update UI when character changes
                });
              },
            )
                : const Center(
              child: Text('Select a character to view actions'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Add Character',
        child: const Icon(Icons.add),
      ), // FloatingActionButton kept for later use
    );
  }
}
