// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameState _$GameStateFromJson(Map<String, dynamic> json) => GameState(
      turn: (json['turn'] as num).toInt(),
      turn_active: json['turn_active'] as bool,
      players:
          (json['players'] as List<dynamic>).map((e) => e as String).toList(),
      character_selected: json['character_selected'] == null
          ? null
          : Character.fromJson(
              json['character_selected'] as Map<String, dynamic>),
      characters: (json['characters'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..eventlog = json['eventlog'] as String;

Map<String, dynamic> _$GameStateToJson(GameState instance) => <String, dynamic>{
      'turn': instance.turn,
      'turn_active': instance.turn_active,
      'players': instance.players,
      'character_selected': instance.character_selected,
      'characters': instance.characters,
      'eventlog': instance.eventlog,
    };
