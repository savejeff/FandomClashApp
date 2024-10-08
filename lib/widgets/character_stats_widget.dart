import 'package:fandom_clash/global.dart';
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


  String printModifier(int mod_v) {
    if(mod_v < 0)
      return "$mod_v";
    if(mod_v > 0)
      return "+$mod_v";
    return "  ";
  }

  @override
  Widget build(BuildContext context) {

    Color bg_color = Global().GameMan.turn_active && Global().GameMan.currentPlayer() == character.player ? Colors.white : Colors.grey;
    if(isSelected) {
      bg_color = Colors.lightBlueAccent;
    }
    //Color bg_color = Colors.white;
    if(!character.isAlive) {
      bg_color = Colors.redAccent;
    }

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bg_color,
        // Highlight the card if selected
        margin: const EdgeInsets.all(4.0),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(children: [
                  Text(
                    '${character.name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('Player: ${character.player}'),
                  Text('Role: ${character.role ?? 'N/A'}'),
                  Text('Fandom: ${character.fandomTrait ?? 'N/A'}'),
                ]),
              ),
              Expanded(
                flex: 2,
                child: Column(children: [
                  /*Text(
                'P: ${character.P} A: ${character.A} W: ${character.W}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),*/
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'P: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${character.P}${printModifier(character.tempP)}  ',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: 'A: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${character.A}${printModifier(character.tempA)}  ',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: 'W: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${character.W}${printModifier(character.tempW)}  ',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    style: TextStyle(fontSize: 16),
                  ),

                  Text(''),
                  //Text('HP: ${character.HP}/${character.maxHP} | AP: ${character.AP} | MR: ${character.MR}'),

                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'HP: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${character.HP}/${character.maxHP} | ',
                        ),
                        TextSpan(
                          text: 'AP: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${character.AP} | ',
                        ),
                        TextSpan(
                          text: 'MR: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: '${character.MR}',
                        ),
                      ],
                    ),
                  ),
                  Text(""),
                  // Add more stats as needed
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
