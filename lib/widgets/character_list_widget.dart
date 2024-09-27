import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'character_stats_widget.dart';

import '../models.dart';
import '../global.dart';

class CharacterListWidget extends StatelessWidget {
	final List<Character> characters;
	final Character? selectedCharacter;
	final void Function(Character)? onSelected; // Callback for selection

	const CharacterListWidget({
		Key? key,
		required this.characters,
		this.selectedCharacter, // The selected character is passed in via constructor
		this.onSelected, // Callback for selection passed in via constructor
	}) : super(key: key);

	// Function to handle character selection
	void _onClick_CharacterCard(Character character) {
		// Trigger the callback if it's provided
		if (onSelected != null) {
			onSelected!(character);
		}
		// Set the selected character at the higher level where state is managed
		Global().GameMan.character_selected = character;
	}

	@override
	Widget build(BuildContext context) {
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
	}
}