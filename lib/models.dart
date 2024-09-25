import 'package:json_annotation/json_annotation.dart';

import 'dart:ffi';
import 'dart:math';

import 'defines.dart';
import 'util.dart';

part 'models.g.dart';


@JsonSerializable()
class Effect {

  // TODO
  int? user_modifier_hp;

  Effect({
    this.user_modifier_hp,
  });



  // Factory method for creating a new Character instance from a map.
  factory Effect.fromJson(Map<String, dynamic> json) =>
      _$EffectFromJson(json);

  // Method to convert Character instance into a map.
  Map<String, dynamic> toJson() => _$EffectToJson(this);

}


@JsonSerializable()
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


  // Factory method for creating a new Character instance from a map.
  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  // Method to convert Character instance into a map.
  Map<String, dynamic> toJson() => _$AbilityToJson(this);

}


@JsonSerializable()
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


  // Factory method for creating a new Character instance from a map.
  factory Item.fromJson(Map<String, dynamic> json) =>
      _$ItemFromJson(json);

  // Method to convert Character instance into a map.
  Map<String, dynamic> toJson() => _$ItemToJson(this);

}




@JsonSerializable()
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
  });

  bool get isAlive => HP > 0;

  int get totalP => this.P + tempP;
  int get totalA => this.A + tempA;
  int get totalW => this.W + tempW;


  //****************************************

  modifyHP(int hp_delta) {

  }


  // Factory method for creating a new Character instance from a map.
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  // Method to convert Character instance into a map.
  Map<String, dynamic> toJson() => _$CharacterToJson(this);


}

