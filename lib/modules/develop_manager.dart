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

    // Create dummy characters and add them to CharacterManager
    Global().characterManager.addCharacter(
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

    Global().characterManager.addCharacter(
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

    Global().characterManager.addCharacter(
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
}
