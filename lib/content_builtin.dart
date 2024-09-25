import 'models.dart';
import 'defines.dart';


Ability ability_spirit_surge = Ability(
    name: "Spirit Surge",
    cost: 2,
    description: "Once per game, double the effect of an ability."
);

Ability ability_battle_aura = Ability(
    name: "Battle Aura",
    cost: 2,
    description: "Allies within 3 units gain +1 P (always active)"
);

Effect effect_healing_2hp = Effect(
  user_modifier_hp: 2
);


Ability ability_small_heal = Ability(
    name: "Small Heal",
    cost: 1,
    description: "Heals the Users HP by a small amount",
    effect: effect_healing_2hp
);