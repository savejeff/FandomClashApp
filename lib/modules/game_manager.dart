// game_manager.dart
import '../models.dart';
import 'package:flutter/material.dart';
import '../defines.dart';


class GameManager {

  int turn = 0; // current turn
  bool turn_active = false;

  List<String> players = [];

  // Use ValueNotifier to notify listeners when the list changes
  Character? character_selected;

  // Add a character
  void selectCharacter(Character character) {
    character_selected = character;

  }

  bool startTurn() {
    if(turn_active) {
      return false;
    }
    turn += 1;
    turn_active = true;

    return true;
  }

  bool finishTurn() {
    if(!turn_active) {
      return false;
    }

    turn_active = false;

    return true;
  }

}