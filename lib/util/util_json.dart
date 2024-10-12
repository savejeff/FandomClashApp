import 'dart:convert';


String json_to_string(Map<String, dynamic> json_dict) {
  return jsonEncode(json_dict);
}

String json_obj_to_string(Object? json_obj) {
  return jsonEncode(json_obj);
}

Map<String, dynamic> string_to_json(String json_string) {
  return jsonDecode(json_string);
}


/*


// Convert to JSON string
final jsonString = jsonEncode(effect_healing_2hp.toJson());


final jsonString = Global().GameMan.State_Backup();
Log("Main", 'Encoded JSON: $jsonString');

final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
final GameState game_state_new = GameState.fromJson(jsonMap);
Log("Main", "New State Character Count: %d",
    [game_state_new.characters.length]);


 */