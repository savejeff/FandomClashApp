// game_manager.dart
import 'character_manager.dart';

class GameManager {
  // Private constructor
  GameManager._privateConstructor();

  // Single instance
  static final GameManager _instance = GameManager._privateConstructor();

  // Factory constructor to return the same instance
  factory GameManager() {
    return _instance;
  }

  // Manager classes
  final CharacterManager characterManager = CharacterManager();

  // You can add other managers here (e.g., ItemManager, AbilityManager)
}
