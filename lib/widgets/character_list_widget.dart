import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'character_stats_widget.dart';

import '../models.dart';
import '../global.dart';



class CharacterListWidget extends StatefulWidget {
  final ValueListenable<List<Character>> characters;
  final void Function(Character)? onSelected; // New callback for selection

  const CharacterListWidget({
    Key? key,
    required this.characters,
    this.onSelected, // Accepting the callback in the constructor
  }) : super(key: key);

  @override
  _CharacterListWidgetState createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
  Character? selectedCharacter;

  @override
  void initState() {
    super.initState();
    selectedCharacter = null;
  }

  // Function to handle character selection
  void _onClick_CharacterCard(Character character) {
    setState(() {
      selectedCharacter = character;
      Global().GameMan.character_selected = character;
    });
    // Trigger the callback if it's provided
    if (widget.onSelected != null) {
      widget.onSelected!(character);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<Character>>(
        valueListenable: widget.characters,
        builder: (context, characters, _) {
          return ListView.builder(
            itemCount: characters.length,
            itemBuilder: (context, index) {
              Character character = characters[index];
              return CharacterStatsWidget(
                character: character,
                isSelected: selectedCharacter == character,
                onTap: () => _onClick_CharacterCard(character),
              );
            },
          );
        },

    );
  }
}
