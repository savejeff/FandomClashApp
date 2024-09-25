// game_manager.dart
import '../models.dart';
import 'package:flutter/material.dart';
import '../defines.dart';


class GameManager {

  List<String> players = [];

  // Use ValueNotifier to notify listeners when the list changes
  Character? character_selected;

  // Add a character
  void selectCharacter(Character character) {
    character_selected = character;

  }

}