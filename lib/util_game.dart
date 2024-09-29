import 'dart:math';


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
