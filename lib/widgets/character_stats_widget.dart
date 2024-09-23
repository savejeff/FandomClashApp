import 'package:flutter/material.dart';
import '../models.dart';


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

