import 'package:flutter/material.dart';

import '../models.dart';
import '../global.dart';

import '../widgets/character_list_widget.dart';

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
    // Set the turn_active to true or whatever your game logic requires
    Global().GameMan.startTurn();
    setState(() {}); // Trigger a UI update to reflect the new state
  }

  void _finishTurn() {
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  Global().GameMan.Reset();
                });
              },
              child: const Text('Reset'),
            ),
            SizedBox(width: 10),

            if (!Global().GameMan.turn_active && Global().GameMan.turn > 0) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Global().GameMan.restoreTurn(Global().GameMan.turn - 1);
                  });
                },
                child: const Text('Revert Turn'),
              ),
            ],
            SizedBox(width: 10), // add some padding between buttons
            Text("Turn ${Global().GameMan.turn}"),
            if (Global().GameMan.turn_active) ...[
              Text(" (Player: ${Global().GameMan.currentPlayer()})"),
            ],
            SizedBox(width: 10), // add some padding between buttons
            if (!Global().GameMan.turn_active &&
                Global().GameMan.turn < Global().GameMan.BackUpCount()) ...[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    Global().GameMan.restoreTurn(Global().GameMan.turn + 1);
                  });
                },
                child: const Text('Redo Turn'),
              ),
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
            flex: 4,
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
            flex: 5,
            child: Global().GameMan.character_selected != null &&
                    Global().GameMan.turn_active
                ? CharacterInteractionInterfaceWidget(
                    character: Global().GameMan.character_selected!,
                    onUpdate: () {
                      setState(() {
                        // Update UI when the character interaction changes
                      });
                    },
                  )
                : Center(
                    child: Text(
                        Global().GameMan.turn_active
                            ? 'Player ${Global().GameMan.currentPlayer()}: Select a Character'
                            : 'Start next Turn',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28)),
                  ),
          ),

          if (BuildConfig.ENABLE_DEVELOP) ...[
            // Right Side: CharacterInteractionInterfaceWidget
            Divider(), // Divider between columns
            Expanded(
                flex: 2,
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
        tooltip: Global().GameMan.turn_active
            ? 'Finish Turn ${Global().GameMan.turn}'
            : 'Start Turn ${Global().GameMan.turn + 1}',
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
