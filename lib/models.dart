import 'dart:ffi';
import 'dart:math';

import 'defines.dart';
import 'util.dart';


class Effect {

  // TODO
  int? user_modifier_hp;

  Effect({
    this.user_modifier_hp,
  });


}

class Ability {
  String name;
  int cost; // AP cost
  String description;
  Effect? effect; // Function to apply the ability effect

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
  Effect? effect; // Function to apply the item's effect
  int uses; // how many times this item can be used. -1 for infinite

  Item({
    required this.name,
    required this.itemType,
    required this.description,
    required this.uses,
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
    this.size = FIGURE_SIZE_MEDIUM,
    Point? position,
    this.fandomTrait,
    this.role,
    this.tempHP = 0,
    this.tempA = 0,
    this.tempP = 0,
    this.tempW = 0,
  }) : position = position ?? Point(0, 0);

  bool get isAlive => HP > 0;

  int get totalP => this.P + tempP;
  int get totalA => this.A + tempA;
  int get totalW => this.W + tempW;


  //****************************************

  modifyHP(int hp_delta) {

  }

}

