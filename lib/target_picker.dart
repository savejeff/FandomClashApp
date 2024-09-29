// target_picker.dart
import 'package:flutter/material.dart';
import 'models.dart';
import 'global.dart'; // Import GameManager

// Function to show the target picker dialog
Future<Character?> showTargetPickerDialog(BuildContext context,
    Character attacker, List<Character> characters, String player) async {
  return showDialog<Character>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select Target'),
        content: SingleChildScrollView(
          child: ListBody(
            children: characters
                .where(
                    (character) => character != attacker && character.isAlive)
                .map((Character character) {
              // Condition to determine if the item should have a colored background
              Color? bg_color = player == character.player
                  ? Colors.grey
                  : null; // Example condition

              return Container(
                color: bg_color,
                child: ListTile(
                  title: Text("${character.name} (${character.player})"),
                  subtitle: Text('HP: ${character.HP}/${character.maxHP}'),
                  onTap: () {
                    Navigator.of(context).pop(character);
                  },
                ),
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
