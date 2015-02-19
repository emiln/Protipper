# Protipper

A helping hand in keeping track of your DPS rotation.

## Features

Protipper is built on one simple idea and provides one simple feature:

* Displays the ability (by icon, name, and keybinding) you should use.

That's it. You, in turn, try to keep up with Protipper's suggestions, while it keeps track of the game state for you and updates its suggestions in real-time.

## FAQ

> How does Protipper know what to suggest?

It's a wizard.

No, in all seriousness Protipper relies on priority lists which can be expressed as:

1. When `condition1` is true: display `ability1`.
2. When `condition2` is true: display `ability2`.
3. ...

Protipper then traverses this list until it finds an ability with a true condition. Having found and displayed one, it starts all over again. While this may seem very simplistic and limiting, it makes for pretty good rotations if the conditions and ordering are chosen sensibly. Keeping priority lists for all specs up to date is hard work, and you should check the state of the spec you're intending to play to ensure we can actually help you, specifically. It is not currently possible for the two of us to keep all specs for all classes updated, but if we find people who can help out with the classes we do not master, it is definitely a future goal.

> Doesn't this ruin the joy of the game by making it too easy?

Why don't you find out? I personally really enjoy it, and "really enjoy" is quite far from "ruin the joy" by most standards. It only helps with your basic rotation (which doesn't include when to use raid-wide cooldowns), and you still have the arduous task of not standing in the fire. It's like having a seasoned player looking over your shoulder, whispering suggestions in your ear. You'll frequently have to disobey them, but having a fallback when the fights are stressful can be very helpful.

![Protipper in action](http://i.imgur.com/fLXmMXl.png)


## API functions

The API contains the following functions that are accessible when specifying the priority lists.

* `AlternativePower(type, unit)`

  Gets the alternative power of a specified type for a specified unit. (Alternative Power is stuff like Soul Shards and Eclipse, etc.)

  Parameters:

    <dl>
      <dt>type</dt>
      <dd>The type of alternative power you wish to query.</dd>
      <dt>unit</dt>
      <dd>The unit you want to know the amount of alternative power for.</dd>
    </dl>

  Returns a table containing the following fields:
  <dl>
      <dt>current</dt>
      <dd>The current amount of alternative power for unit.</dd>
      <dt>max</dt>
      <dd>The maximum amount of alternative power for unit.</dd>  
    </dl>

* `Effect(spellName, unit)`

  Gets the buff or debuff effect from the specified unit.

  Parameters:
    <dl>
      <dt>spellName</dt>
      <dd>The name of the buff or debuff effect you wish to query.</dd>
      <dt>unit</dt>
      <dd>The unit you want to search for the effect.</dd>
    </dl>

    Returns a table containing the following:
    <dl>
      <dt>isActive</dt>
      <dd>A boolean value representing if the effect is active on the unit.</dd>
      <dt>remainingDuration</dt>
      <dd>The remaining duration of the effect on the unit in seconds. `-1` if the effect is not found.</dd>
      <dt>stacks</dt>
      <dd>The number of stacks of the effect applied to the unit. `-1` if the effect is not found, and `0` if the effect is found but does not stack.</dd>
    </dl>

* `Pet()`

  Gets information about the currently active pet.

  Returns a table containing the following:
  <dl>
    <dt>isActive</dt>
    <dd>A boolean value representing if a pet is currently summoned.</dd>
    <dt>currentPet</dt>
    <dd>The type of pet that is currently active. `nil` if no active pet is found</dd>
  </dl>


* `Spell(spellName)`

  Gets information about the specified spell.

  Parameters:
  <dl>
    <dt>spellName</dt>
    <dd>The name of the spell you wish to query.</dd>
  </dl>

  Returns a table containing the following:
  <dl>
    <dt>isReady</dt>
    <dd>A boolean value representing if the spell is ready for use.</dd>
    <dt>isCasting</dt>
    <dd>A boolean value representing if the spell is currently being cast.</dd>
    <dt>isTraveling</dt>
    <dd>A boolean value representing if a cast of the spell is currently traveling towards a target.</dd>
    <dt>charges</dt>
    <dd>The current number of charges of the spell ready for use. `nil` if the spell does not use charges.</dd>
    <dt>maxCharges</dt>
    <dd>The maximum number of charges of the spell. `nil` if the spell does not use charges.</dd>
    <dt>castTime</dt>
    <dd>The cast time of the spell in seconds.</dd>
    <dt>remainingCooldown</dt>
    <dd>The remaining cooldown before the spell can be used in seconds, or if the spell uses charges, before another charge is generated in seconds.</dd>
  </dl>

* `Status(unit)`

  Gets the status (health amounts, power amounts and combo points) of the specificed unit.

  Parameters:
  <dl>
    <dt>unit</dt>
    <dd>The unit you wish to query.</dd>
  </dl>

  Returns a table containing the following:
  <dl>
    <dt>currentHealth</dt>
    <dd>The current health of the unit.</dd>
    <dt>maxHealth</dt>
    <dd>The maximum health of the unit.</dd>
    <dt>currentPower</dt>
    <dd>The current power of the unit.</dd>
    <dt>maxPower</dt>
    <dd>The maximum power of the unit.</dd>
    <dt>comboPoints</dt>
    <dd>The current amount of combo points available to the unit</dd>
  </dl>

* `Talent(talentName)`

  Gets the current status of a specific talent.

  Parameters:
  <dl>
    <dt>talentName</dt>
    <dd>The name of the talent you wish to query.</dd>
  </dl>

  Returns a table containing the following:
  <dl>
    <dt>isActive</dt>
    <dd>A boolean representing if the specified talent is selected.</dd>
  </dl>

* `Totem(totemName)`

  Gets information about a specific totem.

  Parameters:
  <dl>
    <dt>totemName</dt>
    <dd>The name of the totem you wish to query.</dd>
  </dl>

  Returns a table containing the following:
  <dl>
    <dt>isActive</dt>
    <dd>A boolean representing if a totem with the specified name is currently summoned.</dd>
    <dt>remainingDuration</dt>
    <dd>The remaining duration of the totem in seconds. `-1` if the totem is not summoned.</dd>
  </dl>
