
import 'dart:math';


class Ability {
  String name;
  int cost; // AP cost
  String description;
  Function? effect; // Function to apply the ability effect

  Ability({
    required this.name,
    required this.cost,
    required this.description,
    this.effect,
  });
}


class Item {
  String name;
  String itemType; // e.g., 'weapon', 'shield', 'consumable'
  String description;
  Function? effect; // Function to apply the item's effect

  Item({
    required this.name,
    required this.itemType,
    required this.description,
    this.effect,
  });
}



class Character {
  String name;
  String player;
  int P; // Power
  int A; // Agility
  int W; // Wisdom
  int maxHP;
  int HP;
  int AP;
  int MR; // Movement Range (in units of 5 cm)
  List<Ability> abilities;
  List<Item> items;
  String size; // 'Small', 'Medium', or 'Large'
  Point position; // (x, y) coordinates in grid units
  String? fandomTrait; // e.g., 'Anime', 'Superhero'
  String? role; // e.g., 'Warrior', 'Ranger'

  // Temporary modifiers (e.g., from abilities or items)
  int tempHP;
  int tempA;
  int tempP;
  int tempW;

  Character({
    required this.name,
    required this.player,
    required this.P,
    required this.A,
    required this.W,
    required this.maxHP,
    required this.HP,
    required this.AP,
    required this.MR,
    this.abilities = const [],
    this.items = const [],
    this.size = 'Medium',
    Point? position,
    this.fandomTrait,
    this.role,
    this.tempHP = 0,
    this.tempA = 0,
    this.tempP = 0,
    this.tempW = 0,
  }) : position = position ?? Point(0, 0);

  bool get isAlive => HP > 0;

  // Method to apply temporary modifiers
  void applyTempModifiers() {
    HP += tempHP;
    A += tempA;
    P += tempP;
    W += tempW;
    // Reset temporary modifiers after applying
    tempHP = 0;
    tempA = 0;
    tempP = 0;
    tempW = 0;
  }
}

class GameState {
  List<Character> characters;
  int currentTurn;
  List<String> players;
  Map<String, dynamic> terrain; // For environmental interactions

  GameState({
    required this.characters,
    this.currentTurn = 0,
    this.players = const [],
    this.terrain = const {},
  });

  // Method to advance the turn
  void nextTurn() {
    currentTurn += 1;
    // Additional logic for turn management can be added here
  }

  // Method to get characters belonging to a player
  List<Character> getCharactersByPlayer(String playerName) {
    return characters.where((char) => char.player == playerName).toList();
  }
}
