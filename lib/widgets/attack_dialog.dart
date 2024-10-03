// attack_dialog.dart
import 'dart:async';
import 'dart:math';

import 'package:fandom_clash/defines.dart';
import 'package:fandom_clash/util_game.dart';
import 'package:flutter/material.dart';

import 'package:fandom_clash/models.dart';
import 'package:fandom_clash/mechanics.dart';

import 'package:fandom_clash/settings.dart';

import 'dice_roll_widget.dart'; // Import the DiceRollWidget


class AttackDialog extends StatefulWidget {
  final Character attacker;
  final Character defender;
  final String attackTypeInit;
  final VoidCallback onAttackComplete;

  const AttackDialog({
    Key? key,
    required this.attacker,
    required this.defender,
    required this.onAttackComplete,
    this.attackTypeInit = ATTACK_TYPE_MELEE,
  }) : super(key: key);

  @override
  _AttackDialogState createState() => _AttackDialogState();
}

class _AttackDialogState extends State<AttackDialog> {
  // Dice rolling states
  bool attackerRolling = false;
  bool defenderRolling = false;

  // Flags to control UI state
  bool attackExecuted = false;

  // Selected attack and defense types
  String selectedAttackType = ATTACK_TYPE_MELEE;
  String selectedDefenseType = DEFENCE_TYPE_NONE;

  // Selected roll types
  String selectedAttackRollType = "";
  String selectedDefenseRollType = "";

  // Attack result
  AttackResult? attackResult;

  @override
  void initState() {
    super.initState();

    selectedAttackType = widget.attackTypeInit;
  }

  // Function to execute the attack
  void _executeAttack() {
    if (attackExecuted) return;

    setState(() {
      attackExecuted = false;
      attackResult = null;
      attackerRolling = true;
      defenderRolling = true;
    });

    // Simulate rolling animations
    Future.delayed(const Duration(seconds: 2), () {
      // Perform the attack
      AttackResult result = attack(
        widget.attacker,
        widget.defender,
        attackType: selectedAttackType,
        defenderReaction: selectedDefenseType,
        attackRollOverride: selectedAttackRollType != "" ? selectedAttackRollType : null,
        defenseRollOverride: selectedDefenseRollType != "" ? selectedDefenseRollType : null,
        dry_run: true
      );

      setState(() {
        attackerRolling = false;
        defenderRolling = false;
        attackExecuted = true;
        attackResult = result;
      });

      // Callback to notify that the attack is complete
      widget.onAttackComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Attack Action',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Attack Type Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Attack Type Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Attack Type:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: selectedAttackType,
                            items: [
                              DropdownMenuItem(
                                value: ATTACK_TYPE_MELEE,
                                child: const Text('Melee'),
                              ),
                              DropdownMenuItem(
                                value: ATTACK_TYPE_RANGED,
                                child: const Text('Ranged'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedAttackType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      // Defender Reaction Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Defender Reaction:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: selectedDefenseType,
                            items: [
                              DropdownMenuItem(
                                value: DEFENCE_TYPE_NONE,
                                child: const Text('None'),
                              ),
                              DropdownMenuItem(
                                value: DEFENCE_TYPE_DODGE,
                                child: const Text('Dodge (-1 AP)'),
                              ),
                              DropdownMenuItem(
                                value: DEFENCE_TYPE_BLOCK,
                                child: const Text('Block (-1 AP)'),
                              ),
                              DropdownMenuItem(
                                value: DEFENCE_TYPE_COVERED,
                                child: const Text('Covered'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedDefenseType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Roll Type Selectors
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Attacker Roll Type Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Attacker Roll Type:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: selectedAttackRollType,
                            items: [
                              DropdownMenuItem(
                                value: "",
                                child: const Text('Regular Roll'),
                              ),
                              DropdownMenuItem(
                                value: ROLL_TYPE_MAX_2D6,
                                child: const Text('with Advantage'),
                              ),
                              DropdownMenuItem(
                                value: ROLL_TYPE_MIN_2D6,
                                child: const Text('with Disadvantage'),
                              ),
                              DropdownMenuItem(
                                value: ROLL_TYPE_1D6,
                                child: const Text('1d6'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedAttackRollType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      // Defender Roll Type Dropdown
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Defender Roll Type:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<String>(
                            value: selectedDefenseRollType,
                            items: [
                              DropdownMenuItem(
                                value: "",
                                child: const Text('Regular Roll'),
                              ),
                              DropdownMenuItem(
                                value: ROLL_TYPE_MAX_2D6,
                                child: const Text('with Advantage'),
                              ),
                              DropdownMenuItem(
                                value: ROLL_TYPE_MIN_2D6,
                                child: const Text('with Disadvantage'),
                              ),
                              DropdownMenuItem(
                                value: ROLL_TYPE_1D6,
                                child: const Text('1d6'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedDefenseRollType = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Attack and Defense Stats and Dice Results
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Attacker Section
                      Column(
                        children: [
                          Text(
                            widget.attacker.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Attack Stat: ${_getAttackerStat()}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildStatBox(_getAttackerStat().toString()),
                              const SizedBox(width: 8),
                              const Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Dice visualization using DiceRollWidget
                              DiceRollWidget(
                                finalValue: attackResult?.attacker_roll ?? -1,
                                rolling: attackerRolling,
                              ),
                            ],
                          ),
                        ],
                      ),

                      // VS Text
                      const Text(
                        'VS',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),

                      // Defender Section
                      Column(
                        children: [
                          Text(
                            widget.defender.name,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Defense Stat: ${_getDefenderStat()}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildStatBox(_getDefenderStat().toString()),
                              const SizedBox(width: 8),
                              const Text(
                                "+",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Dice visualization using DiceRollWidget
                              DiceRollWidget(
                                finalValue: attackResult?.defender_roll ?? -1,
                                rolling: defenderRolling,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Attack Result Display
                  if (attackExecuted && attackResult != null)
                    Column(
                      children: [
                        Divider(),
                        const SizedBox(height: 16),
                        Text(
                          attackResult!.hit ? "Hit!" : "Miss!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                            attackResult!.hit ? Colors.green : Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          attackResult!.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Execute Attack Button
                      ElevatedButton(
                        onPressed: attackExecuted ? null : _executeAttack,
                        child: const Text('Execute Attack'),
                      ),
                      const SizedBox(width: 8),
                      // Close Button
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Helper function to get the attacker's stat based on the selected attack type
  int _getAttackerStat() {
    if (selectedAttackType == ATTACK_TYPE_MELEE) {
      return widget.attacker.P + widget.attacker.tempP;
    } else if (selectedAttackType == ATTACK_TYPE_RANGED) {
      return widget.attacker.W + widget.attacker.tempW;
    }
    return 0;
  }

  // Helper function to get the defender's stat based on the selected defense type
  int _getDefenderStat() {
    if (selectedDefenseType == DEFENCE_TYPE_BLOCK) {
      return widget.defender.P + widget.defender.tempP;
    } else if (selectedDefenseType == DEFENCE_TYPE_COVERED) {
      return widget.defender.P + widget.defender.tempP + 2;
    } else {
      return widget.defender.A + widget.defender.tempA;
    }
  }

  // Helper widget to build the stat box
  Widget _buildStatBox(String statValue) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          statValue,
          style: const TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}