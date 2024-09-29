// mechanics.dart
import 'dart:ffi';

import 'models.dart';
import 'util.dart';
import 'util_game.dart';



import 'defines.dart';
import "global.dart";
import "settings.dart";


/// Function to handle attacks
String attack(
  Character attacker,
  Character defender, {
  String attack_type = ATTACK_TYPE_MELEE,
  String defender_reaction = DEFENCE_TYPE_NONE,
}) {

  // Determine attack and defense stats
  int attack_stat;
  int base_damage;

  if (attack_type == ATTACK_TYPE_MELEE) {
    attack_stat = attacker.P + attacker.tempP;
    base_damage = attacker.P + attacker.tempP;
  } else if (attack_type == ATTACK_TYPE_RANGED) {
    attack_stat = attacker.W + attacker.tempW;
    base_damage = attacker.W + attacker.tempW;
  } else {
    return "Invalid attack type.";
  }

  // Attacker's roll
  int attack_roll = average_roll_2d6() + attack_stat;

  // Defender's roll and reaction
  int defense_stat = defender.A + defender.tempA;
  int defense_roll;

  if (defender_reaction == DEFENCE_TYPE_DODGE && defender.AP >= 1) {
    defender.AP -= 1;
    defense_roll = roll_with_advantage() + defense_stat;
  } else if (defender_reaction == DEFENCE_TYPE_BLOCK && defender.AP >= 1) {
    defender.AP -= 1;
    defense_roll = average_roll_2d6() + defender.P + defender.tempP;
  } else {
    defense_roll = average_roll_2d6() + defense_stat;
  }

  // Determine if the attack hits
  if (attack_roll + ATTACK_ADVANTAGE_MODIFIER > defense_roll) {
    int damage = base_damage + (attack_roll - defense_roll);
    defender.HP -= damage;
    if (defender.HP < 0) {
      defender.HP = 0;
    }

    return "${attacker.name} hits ${defender.name} for $damage damage. ${defender.name} has ${defender.HP} HP left.";
  } else {
    return "${attacker.name}'s attack misses ${defender.name}.";
  }
}

/// Applies a Effect and returns description modification / effect applied as string
String applyEffect(Effect effect, Character user, Character? target) {
  String effect_str = "";
  if (effect.modifier_user_hp != null) {
    user.HP = LIMIT(0, user.HP + effect.modifier_user_hp!, user.maxHP);
    effect_str += "User added ${effect.modifier_user_hp} HP";
  }

  return effect_str;
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
      return applyEffect(ability.effect!, user, target);
    } else {
      return "${user.name} uses ${ability.name}.";
    }
  } else {
    return "${user.name} does not have enough AP to use ${ability.name}.";
  }
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
      String result = applyEffect(item.effect!, character, null);
      if (item.uses > 0) {
        item.uses -= 1;

        if (item.uses == 0)
          character.items.remove(item); // Remove consumable items after use
      }

      return result;
    } else {
      return "${character.name} uses ${item.name}.";
    }
  } else {
    return "${character.name} does not have ${item.name}.";
  }
}





//*********************** deprecated *******************

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

/// Example item effect function
String healingPotionEffect(Character character) {
  int healAmount = 2;
  character.HP += healAmount;
  if (character.HP > character.maxHP) {
    character.HP = character.maxHP;
  }
  return "${character.name} consumes a Healing Potion and restores $healAmount HP.";
}
