# Protipper

A helping hand in keeping track of your DPS rotation.

## Features

Protipper is built on one simple idea and provides one simple feature:

* Displays the ability (by icon, name, and keybinding) you should use.

That's it. You, in turn, try to keep up with Protipper's suggestions, while it keeps track of the game state for you and updates its suggestions in real-time.

## FAQ

> ### How does Protipper know what to suggest?

It's a wizard.

No, in all seriousness Protipper relies on priority lists which can be expressed as:

1. When `condition1` is true: display `ability1`.
2. When `condition2` is true: display `ability2`.
3. ...

Protipper then traverses this list until it finds an ability with a true condition. Having found and displayed one, it starts all over again. While this may seem very simplistic and limiting, it makes for pretty good rotations if the conditions and ordering are chosen sensibly. Keeping priority lists for all specs up to date is hard work, and you should check the state of the spec you're intending to play to ensure we can actually help you, specifically. It is not currently possible for the two of us to keep all specs for all classes updated, but if we find people who can help out with the classes we do not master, it is definitely a future goal.

> ### Doesn't this ruin the joy of the game by making it too easy?

Why don't you find out? I personally really enjoy it, and "really enjoy" is quite far from "ruin the joy" by most standards. It only helps with your basic rotation (which doesn't include when to use raid-wide cooldowns), and you still have the arduous task of not standing in the fire. It's like having a seasoned player looking over your shoulder, whispering suggestions in your ear. You'll frequently have to disobey them, but having a fallback when the fights are stressful can be very helpful.

![Protipper in action](http://i.imgur.com/fLXmMXl.png)


## API functions

The API contains the following functions that are accessible when specifying the priority lists.

### `AlternativePower(type, unit)`

Gets the alternative power of a specified type for a specified unit. (Alternative Power is stuff like Soul Shards and Eclipse, etc.)

**Parameters**:

Parameter | Description
:-- | :--
`type` | The type of alternative power you wish to query.
`unit` | The unit you want to know the amount of alternative power for.

**Returns** (table containing the following keys):

Key | Value
:-- | :--
`current` | The current amount of alternative power for unit.
`max` | The maximum amount of alternative power for unit.

**Example**:

```lua
function(api)
  local shards = api.AlternativePower("Soul Shards", "player")
  return shards.current > 3
end
```

*****

### `Effect(spellName, unit)`

Gets the buff or debuff effect from the specified unit.

**Parameters**:

Parameter | Description
:-- | :--
`spellName` | The name of the buff or debuff effect you wish to query.
`unit` | The unit you want to search for the effect.

**Returns** (table containing the following keys):

Key | Value
:-- | :--
`isActive` | A boolean value representing if the effect is active on the unit.
`remainingDuration` | The remaining duration of the effect on the unit in seconds. `-1` if the effect is not found.
`stacks` | The number of stacks of the effect applied to the unit. `-1` if the effect is not found, and `0` if the effect is found but does not stack.

**Example**:

```lua
function(api)
  local corruption = api.Effect("Corruption", "target")
  return corruption.remainingDuration < 7.2
end
```

*****

### `Pet()`

Gets information about the currently active pet.

**Returns**:

Key | Value
:-- | :--
`currentPet` | The type of pet that is currently active. `nil` if no active pet is found.
`isActive` | A boolean value representing if a pet is currently summoned.

**Example**:

```lua
function(api)
  local pet = api.Pet()
  return pet.currentPet == "Felhunter" or pet.currentPet == "Observer"
end
```

### `Spell(spellName)`

Gets information about the specified spell.

**Parameters**:

Parameter | Description
:-- | :--
`spellName` | The name of the spell you wish to query.

**Returns** (table containing the following keys):

Key | Value
:-- | :--
`castTime` | The cast time of the spell in seconds.
`charges` | The current number of charges of the spell ready for use. `nil` if the spell does not use charges.
`isReady` | A boolean value representing if the spell is ready for use.
`isCasting` | A boolean value representing if the spell is currently being cast.
`isTraveling` | A boolean value representing if a cast of the spell is currently traveling towards a target.
`maxCharges` | The maximum number of charges of the spell. `nil` if the spell does not use charges.
`remainingCooldown` | The remaining cooldown before the spell can be used in seconds, or if the spell uses charges, before another charge is generated in seconds.

**Example**:

```lua
function(api)
  local spell = api.Spell("Chaos Bolt")
  return (not spell.isCasting) and (not spell.isTraveling) and spell.isReady
end
```

### `Status(unit)`

Gets the status (health amounts, power amounts and combo points) of the specificed unit.

**Parameters**:

Parameter | Description
:-- | :--
`unit` | The unit you wish to query.

**Returns** (table containing the following keys):

Key | Value
:-- | :--
`comboPoints` | The current amount of combo points available to the unit
`currentHealth` | The current health of the unit.
`currentPower` | The current power of the unit.
`maxHealth` | The maximum health of the unit.
`maxPower` | The maximum power of the unit.

**Example**:

```lua
function(api)
  local target = api.Status("target")
  local player = api.Status("player")
  return
    (target.currentHealth / target.maxHealth) < 0.25 and
    player.comboPoints == 5
end
```

### `Talent(talentName)`

Gets the current status of a specific talent.

**Parameters**:

Parameter | Description
:-- | :--
`talentName` | The name of the talent you wish to query.

**Returns** (table containing the following keys):

Key | Value
:-- | :--
`isActive` | A boolean representing if the specified talent is selected.

**Example**:

```lua
function(api)
  return api.Talent("Soulburn: Haunt").isActive
end
```

### `Totem(totemName)`

Gets information about a specific totem.

**Parameters**:

Parameter | Description
:-- | :--
`totemName` | The name of the totem you wish to query.

**Returns** (table containing the following keys):

Key | Value
:-- | :--
`isActive` | A boolean representing if a totem with the specified name is currently summoned.
`remainingDuration` | The remaining duration of the totem in seconds. `-1` if the totem is not summoned.

**Example**:

```lua
function(api)
  local totem = api.Totem("Searing Totem")
  return totem.remainingDuration > 5
end
```
