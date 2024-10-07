import 'package:fandom_clash/models.dart';
import 'package:fandom_clash/defines.dart';
import 'package:fandom_clash/content_builtin.dart';

Character createCharacter({
  required String name,
  required String player,
  required int P,
  required int A,
  required int W,
  required String size,
  required String fandom,
  required String role,
  required List<Ability> abilities,
}) {
  // Apply role bonus to stats
  switch (role) {
    case ROLE_WARRIOR:
      P += 1;
      break;
    case ROLE_RANGER:
      W += 1;
      break;
    case ROLE_SCOUT:
      A += 1;
      break;
    case ROLE_SUPPORT:
      W += 1;
      break;
    default:
      // No bonus
      break;
  }

  // Compute derived stats
  int maxHP = 10 + (2 * P);
  int AP = 5 + W;

  // Compute Movement Range (MR) in units of 5 cm
  int MR = (1 + (A ~/ 2)) *
      2; // Multiply by 2 because 1 unit = 10 cm, but code uses 5 cm units

  // Apply size modifiers
  if (size == FIGURE_SIZE_LARGE) {
    maxHP += 2;
    MR -= 2;
  } else if (size == FIGURE_SIZE_MEDIUM) {
    maxHP += 1;
    // MR remains the same
  } else if (size == FIGURE_SIZE_SMALL) {
    MR += 2;
    maxHP -= 1;
  }

  // Initialize abilities list
  List<Ability> characterAbilities = [];

  // Add role abilities
  switch (role) {
    case ROLE_WARRIOR:
      characterAbilities.add(ability_battle_aura);
      break;
    case ROLE_RANGER:
      characterAbilities.add(ability_sharpshooter);
      break;
    case ROLE_SCOUT:
      characterAbilities.add(ability_quick_reflexes);
      break;
    case ROLE_SUPPORT:
      characterAbilities.add(ability_healing_touch);
      break;
    default:
      break;
  }

  // Add fandom trait abilities
  switch (fandom) {
    case TRAIT_ANIME:
      characterAbilities.add(ability_spirit_surge);
      break;
    case TRAIT_SUPERHERO:
      characterAbilities.add(ability_heroic_feat);
      break;
    case TRAIT_FANTASY_CREATURE:
      characterAbilities.add(ability_elemental_affinity);
      break;
    case TRAIT_ROBOT_MECH:
      characterAbilities.add(ability_mechanical_resilience);
      break;
    default:
      break;
  }

  // Add any custom abilities provided
  characterAbilities.addAll(abilities);

  // Create and return the Character instance
  return Character(
    name: name,
    player: player,
    P: P,
    A: A,
    W: W,
    maxHP: maxHP,
    HP: maxHP,
    // Characters start at full health
    AP: AP,
    MR: MR,
    abilities: characterAbilities,
    size: size,
    fandomTrait: fandom,
    role: role,
  );
}

void PrintCharacter(Character newCharacter) {
  print('Character Name: ${newCharacter.name}');
  print('Player: ${newCharacter.player}');
  print(
      'Stats - P: ${newCharacter.P}, A: ${newCharacter.A}, W: ${newCharacter.W}');
  print('Max HP: ${newCharacter.maxHP}');
  print('AP: ${newCharacter.AP}');
  print('MR (in 5 cm units): ${newCharacter.MR}');
  print('Abilities:');
  for (var ability in newCharacter.abilities) {
    print(' - ${ability.name}: ${ability.description}');
  }
}
