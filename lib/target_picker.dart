// target_picker.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'global.dart'; // Import GameManager

// Function to show the target picker dialog
Future<Character?> showTargetPickerDialog(
    BuildContext context, Character attacker) async {
  // Get the list of characters from CharacterManager
  List<Character> characters = Global().characterManager.getCharacters();

  return showDialog<Character>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Target'),
        content: SingleChildScrollView(
          child: ListBody(
            children: characters
                .where((character) => character != attacker && character.isAlive)
                .map((Character character) {
              return ListTile(
                title: Text(character.name),
                subtitle: Text('HP: ${character.HP}/${character.maxHP}'),
                onTap: () {
                  Navigator.of(context).pop(character);
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(null);
            },
          ),
        ],
      );
    },
  );
}
