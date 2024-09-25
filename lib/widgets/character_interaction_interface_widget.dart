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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _updateHP(int newValue) {
    setState(() {
      widget.character.HP = newValue;
    });
    widget.onUpdate();
  }

  void _updateAP(int newValue) {
    setState(() {
      widget.character.AP = newValue;
    });
    widget.onUpdate();
  }

  void _updateMP(int newValue) {
    setState(() {
      widget.character.MR = newValue;
    });
    widget.onUpdate();
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
            // HP Modifier (pass current value and callback)
            IntegerModifierWidget(
              value: widget.character.HP, // Pass current HP
              onValueChanged: _updateHP, // Callback to update HP
              label: 'HP',
            ),
            // AP Modifier
            IntegerModifierWidget(
              value: widget.character.AP, // Pass current AP
              onValueChanged: _updateAP, // Callback to update AP
              label: 'AP',
            ),
            // MP Modifier
            IntegerModifierWidget(
              value: widget.character.MR, // Pass current MP
              onValueChanged: _updateMP, // Callback to update MP
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
