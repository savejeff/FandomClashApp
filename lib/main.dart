import 'package:flutter/material.dart';
import 'models.dart'; // Import your models
import 'target_picker.dart'; // Import the target picker dialog
import 'mechanics.dart'; // Import the mechanics
import 'game_manager.dart';       // Import GameManager
import 'character_manager.dart';  // Import CharacterManager



void main() {
  runApp(const MyApp());
}

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

// CharacterStatsWidget definition
class CharacterStatsWidget extends StatelessWidget {
  final Character character;
  final bool isSelected;
  final VoidCallback onTap;

  const CharacterStatsWidget({
    Key? key,
    required this.character,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.lightBlueAccent : Colors.white,
        // Highlight the card if selected
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Name: ${character.name}',
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text('Player: ${character.player}'),
              Text('Role: ${character.role ?? 'N/A'}'),
              Text('Fandom: ${character.fandomTrait ?? 'N/A'}'),
              Text(''),
              Text('P: ${character.P} A: ${character.A} W: ${character.W}',
              style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text('HP: ${character.HP}/${character.maxHP}'),
              Text('AP: ${character.AP}'),
              Text(''),
              // Add more stats as needed
            ],
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // Remove the characters list from the state
  // late List<Character> characters;

  // Currently selected character
  Character? selectedCharacter;

  @override
  void initState() {
    super.initState();

    // Initialize the GameManager
    GameManager().init();

    // Begin processes like loading game state or creating dummy content
    GameManager().begin();


  }

  // FloatingActionButton callback (to be implemented later)
  void _incrementCounter() {
    setState(() {
      // Logic to create new units will go here
    });
  }

  // Function to handle character selection
  void _selectCharacter(Character character) {
    setState(() {
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
              valueListenable: GameManager().characterManager.characters,
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
            child: selectedCharacter != null
                ? ActionInterface(
              character: selectedCharacter!,
              //characters: characters, // Pass the characters list
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

// ActionInterface Widget
class ActionInterface extends StatelessWidget {
  final Character character;
  final VoidCallback onUpdate;

  const ActionInterface({
    Key? key,
    required this.character,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Actions
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Actions for ${character.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              // Show the target picker dialog
              Character? target = await showTargetPickerDialog(
                context,
                character, // The attacker
              );

              if (target != null) {
                // Proceed with the attack logic
                String result = attack(character, target);
                onUpdate(); // Update the UI
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
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


          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Mockup: Use ability
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${character.name} uses an ability!')),
              );
            },
            child: const Text('Use Ability'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              // Mockup: Apply modifier
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Modifier applied to ${character.name}!')),
              );
            },
            child: const Text('Apply Modifier'),
          ),
          const SizedBox(height: 16),
          // Display character's abilities (if any)
          if (character.abilities.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Abilities:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...character.abilities.map((ability) =>
                    ListTile(
                      title: Text(ability.name),
                      subtitle: Text(ability.description),
                      trailing: Text('Cost: ${ability.cost} AP'),
                      onTap: () {
                        // Mockup: Activate ability
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  '${character.name} uses ${ability.name}!')),
                        );
                      },
                    )),
              ],
            ),
          // Display character's items (if any)
          if (character.items.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Items:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...character.items.map((item) =>
                    ListTile(
                      title: Text(item.name),
                      subtitle: Text(item.description),
                      onTap: () {
                        // Mockup: Use item
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                              Text('${character.name} uses ${item.name}!')),
                        );
                      },
                    )),
              ],
            ),
        ],
      ),
    );
  }
}
