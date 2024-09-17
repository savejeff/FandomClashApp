// mechanics.dart
import 'models.dart';
import 'util.dart';
import 'dart:math';

/// Function to handle character movement
String moveCharacter(Character character, Point<double> newPosition) {
  double x1 = 0; //character.position.x;
  double y1 = 0; //character.position.y;
  double x2 = newPosition.x;
  double y2 = newPosition.y;

  double distance = sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  double unitsMoved = distance;

  if (unitsMoved <= character.MR) {
    character.position = newPosition;
    return "${character.name} moves to position (${character.position.x}, ${character.position.y}).";
  } else {
    return "${character.name} cannot move that far. Maximum movement range is ${character.MR} units.";
  }
}

/// Function to handle attacks
String attack(
    Character attacker,
    Character defender, {
      String attackType = 'melee',
      String? defenderReaction,
    }) {
  // Determine attack and defense stats
  int attackStat;
  int baseDamage;

  if (attackType == 'melee') {
    attackStat = attacker.P + attacker.tempP;
    baseDamage = attacker.P + attacker.tempP;
  } else if (attackType == 'ranged') {
    attackStat = attacker.W + attacker.tempW;
    baseDamage = attacker.W + attacker.tempW;
  } else {
    return "Invalid attack type.";
  }

  // Attacker's roll
  int attackRoll = averageRoll2D6() + attackStat;

  // Defender's roll and reaction
  int defenseStat = defender.A + defender.tempA;
  int defenseRoll;

  if (defenderReaction == 'dodge' && defender.AP >= 1) {
    defender.AP -= 1;
    defenseRoll = averageRollWithAdvantage() + defenseStat;
  } else if (defenderReaction == 'block' && defender.AP >= 1) {
    defender.AP -= 1;
    defenseRoll = averageRoll2D6() + defender.P + defender.tempP;
  } else {
    defenseRoll = averageRoll2D6() + defenseStat;
  }

  // Determine if the attack hits
  if (attackRoll > defenseRoll) {
    int damage = baseDamage + (attackRoll - defenseRoll);
    defender.HP -= damage;
    if (defender.HP < 0) {
      defender.HP = 0;
    }
    return "${attacker.name} hits ${defender.name} for $damage damage. ${defender.name} has ${defender.HP} HP left.";
  } else {
    return "${attacker.name}'s attack misses ${defender.name}.";
  }
}

/// Function to use an ability
String useAbility(
    Character user,
    Ability ability, {
      Character? target,
    }) {
  if (user.AP >= ability.cost) {
    user.AP -= ability.cost;
    // Apply the ability's effect
    if (ability.effect != null) {
      return ability.effect!(user, target);
    } else {
      return "${user.name} uses ${ability.name}.";
    }
  } else {
    return "${user.name} does not have enough AP to use ${ability.name}.";
  }
}

/// Example ability effect functions
String healAbility(Character user, Character? target) {
  if (target == null) {
    return "No target specified for healing.";
  }
  int healAmount = 3; // Example heal amount
  target.HP += healAmount;
  if (target.HP > target.maxHP) {
    target.HP = target.maxHP;
  }
  return "${user.name} heals ${target.name} for $healAmount HP.";
}

String fireballAbility(Character user, List<Character> targets) {
  int damage = user.W + 2; // Damage as per the ability
  List<String> results = [];
  for (Character target in targets) {
    target.HP -= damage;
    if (target.HP < 0) {
      target.HP = 0;
    }
    results.add(
        "${target.name} takes $damage fire damage and has ${target.HP} HP left.");
  }
  return results.join(' ');
}

/// Function to pick up an item
String pickUpItem(Character character, Item item) {
  character.items.add(item);
  return "${character.name} picks up ${item.name}.";
}

/// Function to use an item
String useItem(Character character, Item item) {
  if (character.items.contains(item)) {
    if (item.effect != null) {
      String result = item.effect!(character);
      character.items.remove(item); // Remove consumable items after use
      return result;
    } else {
      return "${character.name} uses ${item.name}.";
    }
  } else {
    return "${character.name} does not have ${item.name}.";
  }
}

/// Example item effect function
String healingPotionEffect(Character character) {
  int healAmount = 2;
  character.HP += healAmount;
  if (character.HP > character.maxHP) {
    character.HP = character.maxHP;
  }
  return "${character.name} consumes a Healing Potion and restores $healAmount HP.";
}
