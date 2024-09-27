// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Effect _$EffectFromJson(Map<String, dynamic> json) => Effect(
      modifier_user_hp: (json['modifier_user_hp'] as num?)?.toInt(),
      modifier_target_hp: (json['modifier_target_hp'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EffectToJson(Effect instance) => <String, dynamic>{
      'modifier_user_hp': instance.modifier_user_hp,
      'modifier_target_hp': instance.modifier_target_hp,
    };

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
      name: json['name'] as String,
      cost: (json['cost'] as num).toInt(),
      description: json['description'] as String,
      effect: json['effect'] == null
          ? null
          : Effect.fromJson(json['effect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
      'name': instance.name,
      'cost': instance.cost,
      'description': instance.description,
      'effect': instance.effect,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      name: json['name'] as String,
      itemType: json['itemType'] as String,
      description: json['description'] as String,
      uses: (json['uses'] as num).toInt(),
      effect: json['effect'] == null
          ? null
          : Effect.fromJson(json['effect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'name': instance.name,
      'itemType': instance.itemType,
      'description': instance.description,
      'effect': instance.effect,
      'uses': instance.uses,
    };

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
      name: json['name'] as String,
      player: json['player'] as String,
      P: (json['P'] as num).toInt(),
      A: (json['A'] as num).toInt(),
      W: (json['W'] as num).toInt(),
      maxHP: (json['maxHP'] as num).toInt(),
      HP: (json['HP'] as num).toInt(),
      AP: (json['AP'] as num).toInt(),
      MR: (json['MR'] as num).toInt(),
      abilities: (json['abilities'] as List<dynamic>?)
              ?.map((e) => Ability.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      size: json['size'] as String? ?? FIGURE_SIZE_MEDIUM,
      fandomTrait: json['fandomTrait'] as String?,
      role: json['role'] as String?,
      tempHP: (json['tempHP'] as num?)?.toInt() ?? 0,
      tempA: (json['tempA'] as num?)?.toInt() ?? 0,
      tempP: (json['tempP'] as num?)?.toInt() ?? 0,
      tempW: (json['tempW'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
      'name': instance.name,
      'player': instance.player,
      'P': instance.P,
      'A': instance.A,
      'W': instance.W,
      'maxHP': instance.maxHP,
      'HP': instance.HP,
      'AP': instance.AP,
      'MR': instance.MR,
      'abilities': instance.abilities,
      'items': instance.items,
      'size': instance.size,
      'fandomTrait': instance.fandomTrait,
      'role': instance.role,
      'tempHP': instance.tempHP,
      'tempA': instance.tempA,
      'tempP': instance.tempP,
      'tempW': instance.tempW,
    };
