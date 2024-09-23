// character_manager.dart
import '../models.dart';
import 'package:flutter/material.dart';

class CharacterManager {
  // Use ValueNotifier to notify listeners when the list changes
  ValueNotifier<List<Character>> characters = ValueNotifier<List<Character>>([]);

  // Add a character
  void addCharacter(Character character) {
    characters.value = [...characters.value, character];
  }

  // Remove a character
  void removeCharacter(Character character) {
    characters.value = characters.value.where((c) => c != character).toList();
  }

  // Get the list of characters
  List<Character> getCharacters() {
    return characters.value;
  }
}
