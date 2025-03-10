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

These can be blocked completely. Those that are not on this list, are have their XP reduced periodcally by script, only if:
- Their current XP progress is >= 50%
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
STOPLEVELLING-SET-limit_vitality 20
STOPLEVELLING-SET-limit_speech 20
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

### In-game

There's a number of commands added in-game that allow you to check out the mod at work.

I suggest that if you are doing this, you start with `stoplevelling_kill_timers`, to prevent unwanted actions.

```
Function                                   | Example usage                      | Remarks
-------------------------------------------|------------------------------------|--------------------------------------------------------------------
stoplevelling_limits                       | stoplevelling_limits               |
stoplevelling_skill_deps                   | stoplevelling_skill_deps           |
stoplevelling_add_all_perks                | stoplevelling_add_all_perks        |
stoplevelling_remove_all_perks             | stoplevelling_remove_all_perks     |  
stoplevelling_add_perk <stat_or_skill>     | stoplevelling_add_perk alchemy     |
stoplevelling_remove_perk <stat_or_skill>  | stoplevelling_remove_perk strength | Accepted arguments listed below.
stoplevelling_trim_xp                      | stoplevelling_trim_xp              | Core of the mod, checks Stat and Skill levels and blocks if needed.
stoplevelling_init_timers                  | stoplevelling_init_timers          | 
stoplevelling_kill_timers                  | stoplevelling_kill_timers          |
```

Arguments to `stoplevelling_add_perk` and `stoplevelling_remove_perk`:

```shell
strength
agility
vitality
speech
craftsmanship
heavy_weapons
survival
weapon_large   # polearms
fencing        # warfare
marksmanship
stealth
thievery
weapon_sword
alchemy
houndmaster
scholarship
drinking
horse_riding
weapon_unarmed
```

### Unit testing

1. Clone repository
2. Install `make`
3. Run `make test`

## Building locally

1. Clone repository
2. Install `make`
3. Run `make build`

The zipped version of the mod should be in `./zips`

## Contributing

### Localization

Open a PR adding your translations to `src/Data/Localization` under the filename `text_ui_soul__stoplevelling_<Language>.xml`

Note that `<Language>` needs to match the language definitions found in the gamefiles under `C:\Program Files (x86)\Steam\steamapps\common\KingdomComeDeliverance2\Localization` by default, e.g. `text_ui_soul__stoplevelling_Spanish.xml`, `text_ui_soul__stoplevelling_German.xml`, etc