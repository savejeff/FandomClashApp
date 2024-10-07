import 'package:fandom_clash/mechanics.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'dev_base.dart';

import '../../util.dart';
import 'package:fandom_clash/models.dart';
import 'package:fandom_clash/global.dart';
import 'package:fandom_clash/defines.dart';

import 'package:fandom_clash/helper_creators.dart';


import '../../widgets/value_modifier_widget.dart';




// *****************************************************



import 'dart:math';

List<Character> generateCharacterVariations({
  required String namePrefix,
  required String player,
  List<int>? P_values,
  List<int>? A_values,
  List<int>? W_values,
  List<String>? size_values,
  List<String>? fandom_values,
  List<String>? role_values,
  List<Ability>? abilities,
  String? fixedSize,
  String? fixedFandom,
  String? fixedRole,
  int totalStatPoints = 15,
  int minStat = 3,
  int maxStat = 7,
}) {
  // If specific values are not provided, use defaults
  P_values ??= [for (int i = minStat; i <= maxStat; i++) i];
  A_values ??= [for (int i = minStat; i <= maxStat; i++) i];
  W_values ??= [for (int i = minStat; i <= maxStat; i++) i];
  size_values ??= fixedSize != null ? [fixedSize] : [FIGURE_SIZE_SMALL, FIGURE_SIZE_MEDIUM, FIGURE_SIZE_LARGE];
  fandom_values ??= fixedFandom != null ? [fixedFandom] : [TRAIT_ANIME, TRAIT_SUPERHERO, TRAIT_FANTASY_CREATURE, TRAIT_ROBOT_MECH];
  role_values ??= fixedRole != null ? [fixedRole] : [ROLE_WARRIOR, ROLE_RANGER, ROLE_SCOUT, ROLE_SUPPORT];
  abilities ??= [];

  List<Character> characterList = [];
  int counter = 1;

  for (var P in P_values) {
    for (var A in A_values) {
      for (var W in W_values) {
        // Ensure total stat points do not exceed the limit
        if (P + A + W != totalStatPoints) continue;
        for (var size in size_values) {
          for (var fandom in fandom_values) {
            for (var role in role_values) {
              // Create the character using the createCharacter function
              Character character = createCharacter(
                name: '$namePrefix$counter',
                player: player,
                P: P,
                A: A,
                W: W,
                size: size,
                fandom: fandom,
                role: role,
                abilities: abilities,
              );
              characterList.add(character);
              counter++;
            }
          }
        }
      }
    }
  }

  return characterList;
}



// *****************************************************


class DevPage extends StatefulWidget {
  @override
  _DevPageState createState() => _DevPageState();
}

class _DevPageState extends DevPageBaseState<DevPage> {

  bool updateRunning = false;

  /*******************************************************/

  String debugTxtStatus = "";

  /************************ state variables *******************************/

  late List<Character> AllCharacters;

  /*******************************************************/

  @override
  void initState() {
    super.initState();
    InitUI();
    UpdateUI();

    AllCharacters = Global().GameMan.characters;

    LogX("Init is done at %d", [millis()]);
  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  void Period() {

    /********************* regular logic here ******************/

    //LogX(">>> Update Period");

    /************************************************************/
  }

  void Update() {
    super.Update();
    UpdateUI();
  }

  //**************************************************************


  void InitUI() {
    // Define button actions and texts
  }

  Future<void> UpdateUI() async {
    if (!updateRunning) {
      setState(() {
        updateRunning = true;
      });

      final StringBuffer txtStatus = StringBuffer();
      final StringBuffer txtOut = StringBuffer();

      await Future.delayed(Duration(milliseconds: 1), () {
        //**************************** build status txt ************************

        // Example: Add status and output texts
        txtStatus.write("Dev: 1\n");
        txtStatus.write("Characters: ${AllCharacters.length}");

        //**********************************************************************


        setState(() {
          debugTxtStatus = txtStatus.toString();
        });

        updateRunning = false;
      });
    }
  }

  //************************** button callbacks *********************************


  List<String> button_texts = [
    /* Button 0 */ "All x All",
    /* Button 1 */ "Generate Characters",
    /* Button 2 */ "Select Current Characters",
    /* Button 3 */ "...",
    /* Button 4 */ "..."
  ];


  void onButton0_Click() {
    LogX('Button 0 Pressed');

    int ITERATIONS = 25;

    LogClear();

    List<String> summary_log = [];


    Map<String, int> lookup_was_best = {};
    Map<String, int> lookup_was_worst = {};


    LogX("______ Characters __________");
    for (Character char0 in AllCharacters) {
      String line = "${char0.name}: P=${char0.P}, A=${char0.A}, W=${char0.W}, Size=${char0.size}, Role=${char0.role}, Fandom=${char0.fandomTrait}";
      LogX(line);
      summary_log.add(line);

      lookup_was_best[char0.name] = 0;
      lookup_was_worst[char0.name] = 0;
    }

    LogX("_________ VS until Death _________________");

    double total_avg_turns = 0;
    double total_max_turns = 0;
    double total_min_turns = 99;


    for (Character char_attack in AllCharacters) {
      char_attack.HP = char_attack.maxHP; // reset character health

      int total_matches = 0; // count actual finished matches
      double avg_turns = 0; // avg turns taken to kill
      int max_turns = 0; // highest amount of turns for kill from ether ranged or melee
      int min_turns = 99; // lowest amount of turns for kill


      Character best_opponent = char_attack; // opponent with the lowest turns to kill
      double best_opponent_turns = 99;
      Character worst_opponent = char_attack; // opponent with the highest turns to kill
      double worst_opponent_turns = 0;


      for (Character char_defend in AllCharacters) {
        if (char_attack == char_defend) {
          continue;
        }

        double avg_turns_melee = 0;
        double avg_turns_ranged = 0;

        // do multiple repeats for 1:1 matchup
        for(int i = 0; i < ITERATIONS; i++) {
          total_matches += 1;


          char_defend.HP = char_defend.maxHP; // reset character health

          int turns_melee = 0;
          while (char_defend.isAlive) {
            attack(char_attack, char_defend, attackType: ATTACK_TYPE_MELEE,
                attackRollOverride: ROLL_TYPE_1D6, defenseRollOverride: ROLL_TYPE_1D6);
            turns_melee += 1;
            if(turns_melee >= 99)
              break;
          }

          char_defend.HP = char_defend.maxHP; // reset character health

          int turns_ranged = 0;
          while (char_defend.isAlive) {
            attack(char_attack, char_defend, attackType: ATTACK_TYPE_RANGED,
                attackRollOverride: ROLL_TYPE_1D6, defenseRollOverride: ROLL_TYPE_1D6);
            turns_ranged += 1;
            if(turns_ranged >= 99)
              break;

          }

          //if(max_turns < MIN([turns_ranged, turns_melee]))
          // worst_opponent = char_defend;
          //if(min_turns > MIN([turns_ranged, turns_melee]))
          // best_opponent = char_defend;

          avg_turns_melee += turns_melee;
          avg_turns_ranged += turns_ranged;

          avg_turns += MIN([turns_ranged, turns_melee]);
          max_turns = MAX([max_turns, MIN([turns_ranged, turns_melee])]);
          min_turns = MIN([min_turns, MIN([turns_ranged, turns_melee])]);
        }

        avg_turns_melee /= ITERATIONS;
        avg_turns_ranged /= ITERATIONS;


        if(worst_opponent_turns < MIN([avg_turns_ranged, avg_turns_melee])) {
          worst_opponent = char_defend;
          worst_opponent_turns = MIN([avg_turns_ranged, avg_turns_melee]);
        }
        if(best_opponent_turns > MIN([avg_turns_ranged, avg_turns_melee])) {
          best_opponent = char_defend;
          best_opponent_turns = MIN([avg_turns_ranged, avg_turns_melee]);
        }



        LogX("${char_attack.name}->${char_defend.name}: melee_turns=$avg_turns_melee, turns_ranged=$avg_turns_ranged");
      }

      avg_turns /= total_matches;

      total_avg_turns += avg_turns;
      total_max_turns += max_turns;
      total_min_turns = MIN([total_min_turns, 1.0 * min_turns]);

      //String line = "${char_attack.name}: avg_turns=${avg_turns}, max_turns=${max_turns}, best=${best_opponent.name}, worst=${worst_opponent.name}";
      String line = format(
          "%s: avg_turns=%.1f, min_turns=%d, max_turns=%d, best=%s, worst=%s",
          [char_attack.name, avg_turns, min_turns, max_turns, best_opponent.name, worst_opponent.name]
      );

      lookup_was_best[best_opponent.name] = lookup_was_best[best_opponent.name]! + 1;
      lookup_was_worst[worst_opponent.name] = lookup_was_worst[worst_opponent.name]! + 1;

      LogX(" >>> $line");
      LogX("");

      summary_log.add(line);
    }

    total_avg_turns /= AllCharacters.length;
    total_max_turns /= AllCharacters.length;

    LogX("");

    for(String line in summary_log)
      LogX(line);

    LogX("");

    LogX("Was weakest opponent: ");
    lookup_was_best.forEach((key, value) {
      LogX('${key}: $value');
    });
    LogX("");
    LogX("Was strongest opponent: ");
    lookup_was_worst.forEach((key, value) {
      LogX('${key}: $value');
    });
    LogX("");

    LogX(" >>> Total: avg_turns=${total_avg_turns}, avg max_turns=${total_max_turns}, min_turns=${total_min_turns}");


  }

  void onButton1_Click() {
    LogX('Button 1 Pressed');

    AllCharacters = generateCharacterVariations(
        namePrefix: "Chr",
        player: PLAYER_DEV_1,
        fixedFandom: TRAIT_ANIME,
        fixedSize: FIGURE_SIZE_MEDIUM,
    );

    //AllCharacters.shuffle(Random());

    for(int i = 0; i < AllCharacters.length; i++) {
      AllCharacters[i].name = AllCharacters[i].name + format("_P%dA%dW%d", [AllCharacters[i].P, AllCharacters[i].A, AllCharacters[i].W] );
    }

    LogX("Count: ${AllCharacters.length}");
  }

  void onButton2_Click() {
    LogX('Button 2 Pressed');

    AllCharacters = Global().GameMan.characters;
  }

  void onButton3_Click() {
    LogX('Button 3 Pressed');
  }

  void onButton4_Click() {
    LogX('Button 4 Pressed');
  }

  void onButton5_Click() {
    LogX('Button 5 Pressed');
  }

  void onButtonPressed(int index) {
    switch (index) {
      case 0:
        onButton0_Click();
        break;
      case 1:
        onButton1_Click();
        break;
      case 2:
        onButton2_Click();
        break;
      case 3:
        onButton3_Click();
        break;
      case 4:
        onButton4_Click();
        break;
    }
    UpdateUI();
  }

  //******************************* body ***************************************


  Widget _buildDevElements() {
    return
      //************************* dev element here ***************************

      Text("")

    //**********************************************************************
        ;
  }

  Widget _buildStatus() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 130.0, // Replace with your desired minimum height
      ),
      child: SingleChildScrollView(
        child: Text(
          'Status:\n$debugTxtStatus',
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dev Page'),
      ),
      body: Row(
        children: [
          // Left side: Status and Log
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildLeftSide(),
            ),
          ),
          VerticalDivider(), // Divider between columns

          // Right side: Buttons
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildRightSideButtons(),
            ),
          ),
        ],
      ),
    );
  }


  // Left Side: Status and Output
  Widget _buildLeftSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 250.0, // Replace with your desired minimum height
            ),
            child: SingleChildScrollView(
              child: _buildDevElements(),
            )),
        //**********************************************************************
        Divider(),
        Text("Log: "),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: SelectableText(
              debugTxtOut,
              style: TextStyle(fontFamily: 'RobotoMono'),
            ),
          ),
        ),
      ],
    );
  }

  // Right Side: Buttons
  Widget _buildRightSideButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatus(),
        Divider(),
        for (int i = 0; i < button_texts.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: ElevatedButton(
              onPressed: () => onButtonPressed(i),
              child: Text('#$i ${button_texts[i]}'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
              ),
            ),
          ),
      ],
    );
  }


}
