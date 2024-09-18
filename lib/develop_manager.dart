// develop_manager.dart
import 'models.dart';
import 'game_manager.dart';

class DevelopManager {
  void createDummyContent() {
    // Create dummy characters and add them to CharacterManager
    GameManager().characterManager.addCharacter(
      Character(
        name: 'Warrior',
        player: 'Player 1',
        P: 7,
        A: 4,
        W: 4,
        maxHP: 17,
        HP: 17,
        AP: 9,
        MR: 3,
        abilities: [],
        items: [],
        size: 'Large',
        fandomTrait: 'Superhero',
        role: 'Warrior',
      ),
    );

    GameManager().characterManager.addCharacter(
      Character(
        name: 'Ranger',
        player: 'Player 1',
        P: 4,
        A: 5,
        W: 6,
        maxHP: 14,
        HP: 14,
        AP: 11,
        MR: 3,
        abilities: [],
        items: [],
        size: 'Medium',
        fandomTrait: 'Anime',
        role: 'Ranger',
      ),
    );

    GameManager().characterManager.addCharacter(
      Character(
        name: 'Scout',
        player: 'Player 1',
        P: 3,
        A: 7,
        W: 5,
        maxHP: 13,
        HP: 13,
        AP: 10,
        MR: 4,
        abilities: [],
        items: [],
        size: 'Small',
        fandomTrait: 'Fantasy Creature',
        role: 'Scout',
      ),
    );
  }
}
