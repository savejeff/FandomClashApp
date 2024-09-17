import 'package:flutter/material.dart';
import 'dart:math';
import 'models.dart'; // Import your models

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

  const CharacterStatsWidget({Key? key, required this.character})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // Use a Card widget for better UI
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Name: ${character.name}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text('Player: ${character.player}'),
            Text('HP: ${character.HP}/${character.maxHP}'),
            Text('AP: ${character.AP}'),
            Text('P: ${character.P}'),
            Text('A: ${character.A}'),
            Text('W: ${character.W}'),
            Text('Role: ${character.role ?? 'N/A'}'),
            Text('Fandom: ${character.fandomTrait ?? 'N/A'}'),
            // Add more stats as needed
          ],
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // Define three characters
  late Character character1;
  late Character character2;
  late Character character3;

  @override
  void initState() {
    super.initState();

    // Initialize the characters
    character1 = Character(
      name: 'Warrior',
      player: 'Player 1',
      P: 7,
      A: 4,
      W: 4,
      maxHP: 17, // 10 + P (7) = 17
      HP: 17,
      AP: 9, // 5 + W (4) = 9
      MR: 3, // 1 + (A ÷ 2) = 1 + (4 ÷ 2) = 3
      abilities: [],
      items: [],
      size: 'Large',
      fandomTrait: 'Superhero',
      role: 'Warrior',
    );

    character2 = Character(
      name: 'Ranger',
      player: 'Player 1',
      P: 4,
      A: 5,
      W: 6,
      maxHP: 14, // 10 + P (4) = 14
      HP: 14,
      AP: 11, // 5 + W (6) = 11
      MR: 3, // 1 + (5 ÷ 2) = 3
      abilities: [],
      items: [],
      size: 'Medium',
      fandomTrait: 'Anime',
      role: 'Ranger',
    );

    character3 = Character(
      name: 'Scout',
      player: 'Player 1',
      P: 3,
      A: 7,
      W: 5,
      maxHP: 13, // 10 + P (3) = 13
      HP: 13,
      AP: 10, // 5 + W (5) = 10
      MR: 4, // 1 + (7 ÷ 2) = 4
      abilities: [],
      items: [],
      size: 'Small',
      fandomTrait: 'Fantasy Creature',
      role: 'Scout',
    );
  }

  // FloatingActionButton callback (to be implemented later)
  void _onButtonAddCharacter() {
    setState(() {
      // Logic to create new units will go here
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          // Enable horizontal scrolling if needed
          scrollDirection: Axis.horizontal,
          child: Row(
            // Align widgets horizontally
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CharacterStatsWidget(character: character1),
              CharacterStatsWidget(character: character2),
              CharacterStatsWidget(character: character3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onButtonAddCharacter,
        tooltip: 'Add Character',
        child: const Icon(Icons.add),
      ), // FloatingActionButton kept for later use
    );
  }
}
