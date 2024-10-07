import 'models.dart';
import 'defines.dart';




//***************** Trait Abilities **************************

Ability ability_spirit_surge = Ability(
    name: "Spirit Surge",
    cost: 0,
    uses: 1,
    description: "Once per game, double the effect of an ability."
);

Ability ability_heroic_feat = Ability(
    name: "Heroic Feat",
    cost: 0,
    uses: 1,
    description: "Perform an extra action on your turn once per game."
);

Ability ability_elemental_affinity = Ability(
    name: "Wild Charge",
    cost: 0,
    uses: USES_ALWAYS,
    description: "Double the damage of an attack once per game"
);

Ability ability_mechanical_resilience = Ability(
    name: "Elemental Affinity",
    cost: 0,
    uses: 1,
    description: "Ignore one instance of damage per game."
);

//************************** role ability *******************************************

Ability ability_battle_aura = Ability(
    name: "Battle Aura",
    cost: 0,
    uses: USES_ALWAYS,
    description: "Allies within 3 units gain +1 P (always active)"
);

Ability ability_sharpshooter = Ability(
    name: "Sharpshooter",
    cost: 2,
    uses: USES_ALWAYS,
    description: "Ignore cover penalties for ranged attacks. (always active)"
);

Ability ability_quick_reflexes = Ability(
    name: "Quick Reflexes",
    cost: 2,
    uses: 3,
    description: "3 times per Game, reroll one die during a movement or defense "
);

Ability ability_healing_touch = Ability(
    name: "Healing Touch",
    cost: 2,
    uses: USES_UNLIMITED,
    description: "Spend 2 AP to restore 3 HP to an ally within 3 units.",
    effect: Effect(
    modifier_target_hp: 3
)
);

//*********************************************************************

Effect effect_healing_2hp = Effect(
  modifier_user_hp: 2
);


Ability ability_small_heal = Ability(
    name: "Small Heal",
    cost: 1,
    uses: USES_UNLIMITED,
    description: "Heals the Users HP by a small amount (+2HP)",
    effect: effect_healing_2hp
);