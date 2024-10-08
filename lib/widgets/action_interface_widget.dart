import 'package:fandom_clash/defines.dart';
import 'package:flutter/material.dart';
import '../models.dart';
import '../mechanics.dart';

import '../global.dart';


import '../target_picker.dart';

import 'attack_dialog.dart';

// ActionInterface Widget
class ActionInterface extends StatelessWidget {
  String get TAG => runtimeType.toString();

  final Character character;
  final VoidCallback onUpdate;

  const ActionInterface({
    Key? key,
    required this.character,
    required this.onUpdate,
  }) : super(key: key);

  //*********************************************************************************


  void _onClick_Attack(BuildContext context, String type) async {
    if(!character.isAlive) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dead Characters can't Attack")),
      );
      return;
    }

    // Show the target picker dialog
    Character? target = await showTargetPickerDialog(
        context,
        character, // The attacker
        Global().GameMan.characters, // Targets
        Global().GameMan.currentPlayer()
    );

    if (target != null) {
      // Show the AttackDialog
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AttackDialog(
            attacker: character,
            defender: target,
            attackTypeInit: type,
            onAttackComplete: () {
              // Update the UI after the attack
              onUpdate();
              //setState(() {});
            },
          );
        },
      );
    } else {
      // Attack was canceled
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Attack canceled')),
      );
    }

  }

  void _onClick_ApplyModifier(BuildContext context) async {
    // Mockup: Apply modifier
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Modifier applied to ${character.name}!')),
    );
  }

  void _onClick_UseAbility(BuildContext context, Ability ability, Character user, Character? target) async {
    if(!character.isAlive) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dead Characters can't use Abilities")),
      );
      return;
    }


    String result_str = useAbility(user, ability);
    onUpdate(); // Update the UI

    // Mockup: Activate ability
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              '${character.name} uses ${ability.name}! $result_str')
      ),
    );
  }

  //*********************************************************************************

  @override
  Widget build(BuildContext context) {
    // Actions
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Actions',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            // Add padding between the Text and the Row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // Center the buttons within the row
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // Add horizontal padding between buttons
                  child: ElevatedButton(
                    onPressed: () async {
                      _onClick_Attack(context, ATTACK_TYPE_MELEE);
                    },
                    child: const Text('Attack Melee'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // Add horizontal padding between buttons
                  child: ElevatedButton(
                    onPressed: () async {
                      _onClick_Attack(context, ATTACK_TYPE_RANGED);
                    },
                    child: const Text('Attack Ranged'),
                  ),
                ),
                /*
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  // Add horizontal padding between buttons
                  child: ElevatedButton(
                    onPressed: () {
                      _onClick_ApplyModifier(context);
                    },
                    child: const Text('Apply Modifier'),
                  ),
                ),
                 */
              ],
            ),
          ),
          // Display character's abilities (if any)
          if (character.abilities.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Abilities:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...character.abilities.map((ability) => ListTile(
                      title: Text(ability.name),
                      subtitle: Text(ability.description),
                      trailing: Text('Cost: ${ability.cost} AP'),
                      onTap: () {
                        _onClick_UseAbility(context, ability, character, null);
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
                ...character.items.map((item) => ListTile(
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
