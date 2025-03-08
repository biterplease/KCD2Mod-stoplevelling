# KCD2: Stop levelling

Block the player's xp at desired levels.

## Motivation

1. Henry is OP, and in the realistic setting that KCD2 pretends to be, there is no room for an unstoppable slayer like Henry can become in the vanilla game. This mod aims to correct that.

2. At higher levels, a lot of RPG elements are lost because Henry is simply too powerful, and the system does not allow stats to go higher than 30, no matter what.
    - This also means that perks that add to your skills, permanently or conditionally, like Leshy I & II or Deft Hands, are completely lost after a certain point.
    - By having a lower limit for Stats and Skills, buffs from perks and potions will matter more.

E.g. if you wanted a knight, warrior monk, or assasin builds, you would setup stats like:

```
class      knight    monk    assasin
------------------------------------
strength       22      12         13
agility        14       9         22
vitality       20      18         12
speech         16      20          9
```

The mod creates a stat-skill dependency that governs the "build" of the character. This means that Skills that depend on a specific Stat, would never go higher than the governing Stat.
- e.g. `drinking,horse_riding,weapon_unarmed` all depend on `vitality` (default values), this means that, for the `assasin` class defined above, neither of these skills would ever go past `12`.

The skill dependencies are all configurable, as well as optional. Below are the deault values, which can be changed either in-game or through the `mod.cnf`.

You can also choose to turn these off and set individual limits for each skill with `STOPLEVELLING-SET-skills_limits_inherit_stats false`.

```
strength: craftsmanship,heavy_weapons,survival,weapon_large,fencing
agility: marksmanship,stealth,thievery,weapon_sword
vitality: drinking,horse_riding,weapon_unarmed
speech: alchemy,houndmaster,scholarship
```


## How it works

In its current state, it's rather difficult to get specific with XP blocking.

This mod adds a number of perks that would block XP when the limit is reached, but they can only affect the `buff_params` defined by Warhorse. As of KCD2 version `1.1.2`, the only available values are:

```
xpm     All XP
xst     Strength
xag     Agility
xvi     Vitality
xsw     Swords
xcr     Craftsmanship
xsu     Survival
xhw     Heavy Weapons
xma     Marksmanship
xsc     Scholarship
```

These can be blocked completely. Those that are not on this list, are have their XP reduced every 30 seconds by a script, only if:
- Their current XP progress is >= 20%
- The current skill or stat is >= the limit set in config.

There are caveats around this approach, mainly that XP isn't really stopped, only controlled. A quest reward or skill book might shoot you past the desired limit, and there is no way to go back a level.

## Config

Set these in `mod.cnf`.

Each of these is added as a console function: you can configure these values in-game.

### Time in milliseconds to check XP levels and reduce it.
```
STOPLEVELLING-SET-xp_trim_timer_period 30000
```

### Stat limits for your build.
```
STOPLEVELLING-SET-limit_strength 20
STOPLEVELLING-SET-limit_agility 20
STOPLEVELLING-SET-limit_vitality 15
STOPLEVELLING-SET-limit_speech 15
```
Forces Skill max level to the Stat max level.
```
STOPLEVELLING-SET-skills_limits_inherit_stats true
```


### Skill Tree configuration

Here you set stat to skill dependencies.
Only works if `STOPLEVELLING-SET-skills_limits_inherit_stats` is `true`

- `weapon_large` == polearms
- `fencing` == warfare
```
STOPLEVELLING-SET-skills_strength craftsmanship,heavy_weapons,survival,weapon_large,fencing
STOPLEVELLING-SET-skills_agility marksmanship,stealth,thievery,weapon_sword
STOPLEVELLING-SET-skills_vitality drinking,horse_riding,weapon_unarmed
STOPLEVELLING-SET-skills_speech alchemy,houndmaster,scholarship
```

 
### Individual skill limits

Only works if `STOPLEVELLING-SET-skills_limits_inherit_stats` is `false`.

Reminder that
- weapon_large == polearms
- fencing == warfare
```
STOPLEVELLING-SET-limit_craftsmanship 20
STOPLEVELLING-SET-limit_heavy_weapons 20
STOPLEVELLING-SET-limit_survival 20
STOPLEVELLING-SET-limit_weapon_large 20
STOPLEVELLING-SET-limit_fencing 20
STOPLEVELLING-SET-limit_marksmanship 20
STOPLEVELLING-SET-limit_stealth 20
STOPLEVELLING-SET-limit_thievery 20
STOPLEVELLING-SET-limit_weapon_sword 20
STOPLEVELLING-SET-limit_alchemy 20
STOPLEVELLING-SET-limit_houndmaster 20
STOPLEVELLING-SET-limit_scholarship 20
STOPLEVELLING-SET-limit_drinking 20
STOPLEVELLING-SET-limit_horse_riding 20
STOPLEVELLING-SET-limit_weapon_unarmed 20
```

## Testing

1. Install `make`
2. Run `make test`