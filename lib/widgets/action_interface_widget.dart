import 'package:flutter/material.dart';
import '../models.dart';
import '../mechanics.dart';

import '../target_picker.dart';

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
