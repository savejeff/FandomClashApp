import 'dart:math';


// Random number generator
final Random _random = Random();


// Dice rolling functions
int rollD6() {
  return _random.nextInt(6) + 1; // Returns a number between 1 and 6
}

int roll2D6() {
  return rollD6() + rollD6();
}

int averageRoll2D6() {
  return (roll2D6()) ~/ 2; // Integer division
}

int rollWithAdvantage() {
  int roll1 = rollD6();
  int roll2 = rollD6();
  return max(roll1, roll2);
}

int rollWithDisadvantage() {
  int roll1 = rollD6();
  int roll2 = rollD6();
  return min(roll1, roll2);
}

int averageRollWithAdvantage() {
  return (rollWithAdvantage()) ~/ 2;
}

int averageRollWithDisadvantage() {
  return (rollWithDisadvantage()) ~/ 2;
}
