import 'dart:math';

import 'package:fandom_clash/defines.dart';
import 'util_sys.dart';


// Random number generator
final Random _random = Random();


// Dice rolling functions
int roll_d6() {
  return _random.nextInt(6) + 1; // Returns a number between 1 and 6
}

int roll_2d6() {
  return roll_d6() + roll_d6();
}

int average_roll_2d6() {
  return (roll_2d6()) ~/ 2; // Integer division
}

int roll_with_advantage() {
  int roll1 = roll_d6();
  int roll2 = roll_d6();
  return max(roll1, roll2);
}

int roll_with_disadvantage() {
  int roll1 = roll_d6();
  int roll2 = roll_d6();
  return min(roll1, roll2);
}

int roll_by_type(String roll_type) {
  if(roll_type == ROLL_TYPE_1D6) {
    return roll_d6();
  } else if(roll_type == ROLL_TYPE_AVG_2D6) {
    return average_roll_2d6();
  } else if(roll_type == ROLL_TYPE_MAX_2D6) {
    return roll_with_advantage();
  } else if(roll_type == ROLL_TYPE_MIN_2D6) {
    return roll_with_disadvantage();
  }
  Log("util_game", "Unknown roll type $roll_type");
  return 0;
}
