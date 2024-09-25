// global.dart
import 'package:fandom_clash/modules/game_manager.dart';

import 'util.dart';

import 'modules/character_manager.dart';
import 'modules/develop_manager.dart';
import 'modules/game_manager.dart';


class BuildConfig {
  static const bool ENABLE_DEVELOP = false;
}


// Global Singleton
class Global {
  // Private constructor
  Global._privateConstructor();

  // Single instance
  static final Global _instance = Global._privateConstructor();

  // Factory constructor to return the same instance
  factory Global() {
    return _instance;
  }

  // Manager classes
  final CharacterManager characterManager = CharacterManager();
  final GameManager GameMan = GameManager();
  final DevelopManager developManager = DevelopManager();


  // init() method to initialize all components
  void init() {
    millis();
    // Initialize components if needed
    // For now, there may be nothing specific to initialize
  }

  // begin() method to start processes like loading game state
  void begin() {
    // For development, create dummy content
    developManager.createDummyContent();
  }
}
