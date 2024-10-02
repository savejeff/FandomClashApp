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

// attack_result.dart
class AttackResult {
  int attacker_roll;
  int defender_roll;
  bool hit;
  int damage;
  int remainingHP;
  String message;

  AttackResult({
    required this.attacker_roll,
    required this.defender_roll,
    required this.hit,
    required this.damage,
    required this.remainingHP,
    required this.message,
  });
}

AttackResult attack(
  Character attacker,
  Character defender, {
  String attackType = ATTACK_TYPE_MELEE,
  String defenderReaction = DEFENCE_TYPE_NONE,
  String? attackRollOverride,
  String? defenseRollOverride,
  int? attackerDiceOverride,
  int? defenderDiceOverride,
}) {
  AttackResult result = AttackResult(
    attacker_roll: 0,
    defender_roll: 0,
    hit: false,
    damage: 0,
    remainingHP: defender.HP,
    message: "Invalid attack type.",
  );

  // Determine attack and roll
  int attackStat;
  String attackRoll = ROLL_TYPE_AVG_2D6;

  // Defender's roll and roll
  int defenseStat;
  String defenseRoll = ROLL_TYPE_AVG_2D6;

  // calculate attack stat
  if (attackType == ATTACK_TYPE_MELEE) {
    attackStat = attacker.P + attacker.tempP;
  } else if (attackType == ATTACK_TYPE_RANGED) {
    attackStat = attacker.W + attacker.tempW;
  } else {
    return result;
  }

  // - - calculate defense stat - -

  // defense dodge (add advantage to defense)
  if (defenderReaction == DEFENCE_TYPE_DODGE && defender.AP >= 1) {
    defender.AP -= 1;
    defenseStat = defender.A + defender.tempA;
    defenseRoll = ROLL_TYPE_MAX_2D6; // with advantage
  }
  // block (use P not A as defense stat
  else if (defenderReaction == DEFENCE_TYPE_BLOCK && defender.AP >= 1) {
    defender.AP -= 1;
    defenseStat = defender.P + defender.tempP;
    defenseRoll = ROLL_TYPE_AVG_2D6; // regular
  }
  // covered (adds +2 defense stat)
  else if (defenderReaction == DEFENCE_TYPE_COVERED) {
    // Assuming 'Covered' adds a static bonus, e.g., +2 to defense
    defenseStat = defender.A + defender.tempA + 2; // Adjust as per game rules
    defenseRoll = ROLL_TYPE_AVG_2D6; // regular
  }
  // regular defence ( A is defense stat with regular avg_2d6
  else {
    defenseStat = defender.A + defender.tempA;
    defenseRoll = ROLL_TYPE_AVG_2D6; // regular
  }

  // apply override
  if (attackRollOverride != null) {
    attackRoll = attackRollOverride;
  }
  if (defenseRollOverride != null) {
    defenseRoll = defenseRollOverride;
  }

  // actual roll
  result.defender_roll = (defenderDiceOverride ?? roll_by_type(attackRoll));
  result.attacker_roll = (attackerDiceOverride ?? roll_by_type(defenseRoll));

  // calculate total for attack and defense
  int attack_total = result.attacker_roll + attackStat;
  int defense_total = result.defender_roll + defenseStat;


  // Determine if the attack hits
  if (attack_total > defense_total) {

    // damage = attack stat + overflow from attack vs defense
    int damage = attackStat + (attack_total - defense_total);

    // apply damage
    defender.HP -= damage;
    if (defender.HP < 0) {
      defender.HP = 0;
    }

    result.hit = true;
    result.damage = damage;
    result.remainingHP = defender.HP;
    result.message =
        "${attacker.name} hits ${defender.name} for $damage damage. ${defender.name} has ${defender.HP} HP left.";
  } else {
    result.hit = false;
    result.damage = 0;
    result.remainingHP = defender.HP;
    result.message = "${attacker.name}'s attack misses ${defender.name}.";
  }

  return result;
}

class AttackDialog extends StatefulWidget {
  final Character attacker;
  final Character defender;
  final VoidCallback onAttackComplete;

  const AttackDialog({
    Key? key,
    required this.attacker,
    required this.defender,
    required this.onAttackComplete,
  }) : super(key: key);

  @override
  _AttackDialogState createState() => _AttackDialogState();
}

class _AttackDialogState extends State<AttackDialog> {
  // Dice roll results
  int attackerDiceResult = -1;
  int defenderDiceResult = -1;

  // Dice rolling states
  bool attackerRolling = false;
  bool defenderRolling = false;

  // Flags to control UI state
  bool diceRolled = false;
  bool attackExecuted = false;

  // Selected attack and defense types
  String selectedAttackType = ATTACK_TYPE_MELEE;
  String selectedDefenseType = DEFENCE_TYPE_NONE;

  // Attack result
  AttackResult? attackResult;

  @override
  void initState() {
    super.initState();
  }

  // Function to perform the dice rolls and update the UI
  void _rollDice() {
    setState(() {
      diceRolled = false;
      attackExecuted = false;
      attackResult = null;
      attackerRolling = true;
      defenderRolling = true;
      attackerDiceResult = average_roll_2d6(); // Use your dice roll function
      defenderDiceResult = average_roll_2d6();
    });

    // Simulate rolling for 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        attackerRolling = false;
        defenderRolling = false;
        diceRolled = true;
      });
    });
  }

  // Function to execute the attack
  void _executeAttack() {
    if (!diceRolled) return;

    // Use the attack function from mechanics.dart
    AttackResult result = attack(
      widget.attacker,
      widget.defender,
      attackType: selectedAttackType,
      defenderReaction: selectedDefenseType,
      attackerDiceOverride: attackerDiceResult,
      defenderDiceOverride: defenderDiceResult,
    );

    setState(() {
      attackExecuted = true;
      attackResult = result;
    });

    // Callback to notify that the attack is complete
    widget.onAttackComplete();
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
                                finalValue: attackerDiceResult,
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
                                finalValue: defenderDiceResult,
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
                      // Roll Dice Button
                      ElevatedButton(
                        onPressed: diceRolled ? null : _rollDice,
                        child: const Text('Roll Dice'),
                      ),
                      const SizedBox(width: 8),
                      // Execute Attack Button
                      ElevatedButton(
                        onPressed: diceRolled && !attackExecuted
                            ? _executeAttack
                            : null,
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
      return widget.attacker.P;
    } else if (selectedAttackType == ATTACK_TYPE_RANGED) {
      return widget.attacker.W;
    }
    return 0;
  }

  // Helper function to get the defender's stat based on the selected defense type
  int _getDefenderStat() {
    if (selectedDefenseType == DEFENCE_TYPE_BLOCK) {
      return widget.defender.P;
    } else {
      return widget.defender.A;
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
