import 'package:flutter/material.dart';

import '../models.dart';

import 'value_modifier_widget.dart';
import 'action_interface_widget.dart';


class CharacterInteractionInterfaceWidget extends StatefulWidget {
  final Character character;
  final void Function() onUpdate;

  const CharacterInteractionInterfaceWidget({
    Key? key,
    required this.character,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _CharacterInteractionInterfaceWidgetState createState() => _CharacterInteractionInterfaceWidgetState();
}

class _CharacterInteractionInterfaceWidgetState extends State<CharacterInteractionInterfaceWidget> {
  int hp = 100;  // Initial values for HP, AP, and MP
  int ap = 50;
  int mp = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    hp = widget.character.HP;
    ap = widget.character.AP;
    mp = widget.character.MR;
  }

  void _updateHP(int newValue) {
    setState(() {
      hp = newValue;
      widget.character.HP = hp;
    });
  }

  void _updateAP(int newValue) {
    setState(() {
      ap = newValue;
      widget.character.AP = ap;
    });
  }

  void _updateMP(int newValue) {
    setState(() {
      mp = newValue;
      widget.character.MR = mp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Row with 3 IntegerModifierWidgets for HP, AP, MP
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // HP Modifier
            IntegerModifierWidget(
              initialValue: widget.character.HP,
              onValueChanged: _updateHP,
              label: 'HP',
            ),
            // AP Modifier
            IntegerModifierWidget(
              initialValue: ap,
              onValueChanged: _updateAP,
              label: 'AP',
            ),
            // MP Modifier
            IntegerModifierWidget(
              initialValue: mp,
              onValueChanged: _updateMP,
              label: 'MP',
            ),
          ],
        ),
        SizedBox(height: 20), // Space after the row of IntegerModifierWidgets

        // Action interface for the selected character
        ActionInterface(
          character: widget.character,
          onUpdate: widget.onUpdate,
        ),
      ],
    );
  }
}
