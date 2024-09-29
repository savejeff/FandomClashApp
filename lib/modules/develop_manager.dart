// develop_manager.dart

import '../defines.dart';
import '../global.dart';
import '../models.dart';

import '../content_builtin.dart';


class DevelopManager {
  void createDummyContent() {
    Global().GameMan.players = [
      PLAYER_DEV_1,
      PLAYER_DEV_2
    ];

    if (false) {
      // Create dummy characters and add them to CharacterManager
      Global().GameMan.addCharacter(
        Character(
          name: 'Warrior',
          player: PLAYER_DEV_1,
          P: 7,
          A: 4,
          W: 4,
          maxHP: 17,
          HP: 17,
          AP: 9,
          MR: 3,
          abilities: [
            ability_battle_aura,
            ability_spirit_surge
          ],
          items: [],
          size: FIGURE_SIZE_LARGE,
          fandomTrait: TRAIT_SUPERHERO,
          role: ROLE_WARRIOR,
        ),
      );

      Global().GameMan.addCharacter(
        Character(
          name: 'Ranger',
          player: PLAYER_DEV_2,
          P: 4,
          A: 5,
          W: 6,
          maxHP: 14,
          HP: 14,
          AP: 11,
          MR: 3,
          abilities: [],
          items: [],
          size: FIGURE_SIZE_MEDIUM,
          fandomTrait: TRAIT_ANIME,
          role: ROLE_RANGER,
        ),
      );

      Global().GameMan.addCharacter(
        Character(
          name: 'Scout',
          player: PLAYER_DEV_2,
          P: 3,
          A: 7,
          W: 5,
          maxHP: 13,
          HP: 13,
          AP: 10,
          MR: 4,
          abilities: [
            ability_small_heal
          ],
          items: [],
          size: FIGURE_SIZE_SMALL,
          fandomTrait: TRAIT_FANTASY_CREATURE,
          role: ROLE_SCOUT,
        ),
      );
    }

    if (true) {

      const String PLAYER_1 = "Player 1";
      const String PLAYER_2 = "Player 2";

      // Create dummy characters and add them to CharacterManager
      Global().GameMan.addCharacter(
        Character(
          name: 'Ranger',
          player: PLAYER_1,
          P: 3,
          A: 5,
          W: 7,
          maxHP: 13,
          HP: 13,
          AP: 12,
          MR: 3,
          abilities: [
            ability_elemental_affinity,
            ability_sharpshooter
          ],
          items: [],
          size: FIGURE_SIZE_MEDIUM,
          fandomTrait: TRAIT_FANTASY_CREATURE,
          role: ROLE_RANGER,
        ),
      );

      Global().GameMan.addCharacter(
        Character(
          name: 'Scout',
          player: PLAYER_1,
          P: 6,
          A: 6,
          W: 3,
          maxHP: 16,
          HP: 16,
          AP: 8,
          MR: 4,
          abilities: [
            ability_spirit_surge,
            ability_quick_reflexes
          ],
          items: [],
          size: FIGURE_SIZE_MEDIUM,
          fandomTrait: TRAIT_ANIME,
          role: ROLE_SCOUT,
        ),
      );

      Global().GameMan.addCharacter(
        Character(
          name: 'Support',
          player: PLAYER_1,
          P: 5,
          A: 6,
          W: 4,
          maxHP: 15,
          HP: 15,
          AP: 9,
          MR: 4,
          abilities: [
            ability_heroic_feat,
            ability_healing_touch
          ],
          items: [],
          size: FIGURE_SIZE_MEDIUM,
          fandomTrait: TRAIT_SUPERHERO,
          role: ROLE_SUPPORT,
        ),
      );

      //************* Player 2 ***************

      // Create dummy characters and add them to CharacterManager
      Global().GameMan.addCharacter(
        Character(
          name: 'Scout',
          player: PLAYER_2,
          P: 6,
          A: 3,
          W: 6,
          maxHP: 16,
          HP: 16,
          AP: 11,
          MR: 3,
          abilities: [
            ability_spirit_surge,
            ability_quick_reflexes
          ],
          items: [],
          size: FIGURE_SIZE_SMALL,
          fandomTrait: TRAIT_ANIME,
          role: ROLE_SCOUT,
        ),
      );

      Global().GameMan.addCharacter(
        Character(
          name: 'Warrior',
          player: PLAYER_2,
          P: 7,
          A: 5,
          W: 3,
          maxHP: 17,
          HP: 17,
          AP: 8,
          MR: 3,
          abilities: [
            ability_heroic_feat,
            ability_battle_aura
          ],
          items: [],
          size: FIGURE_SIZE_LARGE,
          fandomTrait: TRAIT_SUPERHERO,
          role: ROLE_WARRIOR,
        ),
      );

      Global().GameMan.addCharacter(
        Character(
          name: 'Support',
          player: PLAYER_2,
          P: 6,
          A: 6,
          W: 3,
          maxHP: 16,
          HP: 16,
          AP: 8,
          MR: 4,
          abilities: [
            ability_mechanical_resilience,
            ability_healing_touch
          ],
          items: [],
          size: FIGURE_SIZE_MEDIUM,
          fandomTrait: TRAIT_ROBOT_MECH,
          role: ROLE_SUPPORT,
        ),
      );
    }
  }
}
