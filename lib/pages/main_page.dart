import 'package:flutter/material.dart';
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
  void _onClick_FAB() {
    if (true) {
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


  /****************************************************************************/

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

          // Left Side
          Expanded(
            flex: 1,
            child:
            CharacterListWidget(
                characters: Global().characterManager.characters,
                onSelected: (character) {
                  setState(() {
                    selectedCharacter = character;
                  });
                }
            ),
          ),


          // Right Side: CharacterInteractionInterfaceWidget
          Expanded(
            flex: 1,
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClick_FAB,
        tooltip: 'Add Character',
        child: const Icon(Icons.add),
      ), // FloatingActionButton kept for later use
    );
  }
}
