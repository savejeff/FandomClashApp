// game_manager.dart
import '../models.dart';
import 'package:flutter/material.dart';
import '../defines.dart';

import 'game_state.dart';

class GameManager extends ChangeNotifier {
  GameState game_state = GameState(
      turn: 0,
      turn_active: false,
      characters: [],
      players: [],
      character_selected: null);

  //****************************** State Backup ********************************

  String State_Backup() {
    return game_state.Stringify();
  }

  void State_Restore(String game_state_str) {
    game_state = GameState.fromJsonString(game_state_str);
  }

  Map<int, String> _history_game_state = {};

  // Add a new backup to the map
  void BackupState() {
    _history_game_state[game_state.turn] = game_state.Stringify();
  }

  bool RestoreTurn(int turn) {
    if (_history_game_state.containsKey(turn)) {
      String game_state_str = _history_game_state[turn]!;
      game_state = GameState.fromJsonString(game_state_str);
      notifyListeners(); // Notify UI to update
      return true;
    }
    return false;
  }

  int BackUpCount() {
    return _history_game_state.length;
  }

  void Reset() {
    // TODO implement
  }

  //********************************* getter/setter ****************************

  // Getters and Setters to notify listeners on changes
  int get turn => game_state.turn;

  set turn(int value) {
    game_state.turn = value;
    notifyListeners(); // Notify UI to update
  }

  bool get turn_active => game_state.turn_active;

  set turn_active(bool value) {
    game_state.turn_active = value;
    notifyListeners();
  }

  List<String> get players => game_state.players;

  set players(List<String> value) {
    game_state.players = value;
    notifyListeners();
  }

  Character? get character_selected => game_state.character_selected;

  set character_selected(Character? value) {
    game_state.character_selected = value;
    notifyListeners();
  }

  List<Character> get characters => game_state.characters;

  set characters(List<Character> value) {
    game_state.characters = value;
    notifyListeners(); // Notify when the list changes
  }

  //********************************* Characters *******************************

  // Add a character
  void addCharacter(Character character) {
    game_state.characters.add(character);
  }

  //************************** selected Character ***********************

  // Select a Character to be focused
  void selectCharacter(Character character) {
    character_selected = character;
  }

  //**************************** Turn ****************************

  bool startTurn() {
    if (turn_active) {
      return false;
    }
    turn += 1;
    turn_active = true;

    return true;
  }

  bool finishTurn() {
    if (!turn_active) {
      return false;
    }

    // finish turn
    turn_active = false;

    // backup for history
    BackupState();

    return true;
  }
}
