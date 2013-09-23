Protipper
=========

A World of Warcraft Addon for the DPS-engrossed damage dealer.

What does this thing do?
----------------

The Addon will display the icon of the ability you should use next in order to
maximize your DPS. In order to decide which ability to show, it will use a
prioritized list of abilities, each having a condition that will be evaluated
to determine whether the ability in question should be shown or whether the
program should progress to the next element in the priority list.

Priority list? Conditions? I don't get it.
------------------------------------------

Perhaps an example will explain how it works. Consider the following priority
list:

* `'Dark Soul'` if `AbilityReady('Dark Soul')`
* `'Summon Doomguard'` if `AbilityReady('Summon Doomguard')`
* `'Agony'` if `DotRefresh('Agony')`
* ...
* `'Malefic Grasp'` if `true`

The decision about which spell to display would go as follows:

* Is `Dark Soul` ready to be cast? Yes: Show that icon; no: proceed down.
* Is `Summon Doomguard` ready to be cast? Yes: Show that icon; no: proceed
  down.
* Has `Agony` expired or does the currently ticking `Agony` need refreshing
  (when considering [Pandemic](http://www.wowhead.com/spell=131973))? Yes:
  show that icon; no: proceed down.
* ...
* If everything else fails its condition, show `Malefic Grasp`. This is why
  the condition is trivially `true`.

Do I have to write such lists on my own?
----------------------------------------

More or less sensible defaults are included and they should work well for
raiding. If your purpose is not raiding at level 90, then you may have to write
your own lists or modify the default lists. However, the goal is for the
default priority lists to express the very best ability to use in order to
maximize your DPS, and this should really be the ability you want to use in
most situations where DPS matter in the first place.

I would be surprised if the majority of people do not find the defaults useful.

Is there a list of all functions provided by Protipper?
-------------------------------------------------------
The API available to conditions is listed below. All occurences of the
parameter `unit` take on the following values: `{pet,player,target}`.

* `AbilityReady(abilityName)`: returns true if `abilityName` is *not* on
  cooldown, and you have the required resources to use it.

* `BuffActive(buffName, unit)`: returns true if `unit` is currently affected by
  a buff called `buffName`.

* `BuffStack(buffName, minStack, maxStack, unit)`: returns true if `unit` is
  currently affected by `buffName` at `stackCount` stacks, and
  `minStack <= stackCount <= maxStack`.

* `CenterFrame()`: returns the frame to the center of the screen if you happen
  to misplace it.

* `ChargesBetween(spellName, minCharges, maxCharges)`: Returns true if the
  player has a spell called `spellName` with a number of
  charges between `minCharges` and `maxCharges`, both inclusive.

* `DebuffActive(debuffName, unit)`: returns true if `unit` is currently
  affected by a debuff called `debuffName`.

* `DebuffRefresh(debuffName)`: returns true if `debuffName` is expired on target
  or will within your cast time.

* `DebuffStack(debuffName, minStack, maxStack, unit)`: returns true if `unit` is
  currently affected by `debuffName` at `stackCount` stacks, and
  `minStack <= stackCount <= maxStack`.

* `IsCasting(spellName)`: returns true if you are currently casting
  `spellName`.

* `IsTraveling(spellName)`: returns true if you have successfully cast
  `spellName`, but it has not hit (or missed) yet.

* `LowOnHealth(healthFraction, unit)`: returns true if `unit`'s health is
  below `healthFraction`, where `0 <= healthFraction <= 1`.

* `LowOnMana(manaFraction, unit)`: returns true if `unit`'s mana is below
  `manaFraction`, where `0 <= manaFraction <= 1`.

* `PetActive()`: returns true if you have an active pet.

* `PowerBetween(powerType, minPower, maxPower, unit)`: Returns true if `unit` has
  between `minPower` and `maxPower`of the power type of name `powerType`, both
  inclusive. Valid power types:

  * Alternate Power
  * Burning Embers
  * Dark Force
  * Demonic Fury
  * Eclipse
  * Energy
  * Focus
  * Happiness
  * Holy Power
  * Light Force
  * Mana
  * Rage
  * Runes
  * Runic Power
  * Shadow Orbs
  * Soul Shards

  Example: PowerBetween('Rage', 50, 60, 'player') is true, if the player has
  between 50 and 60 Rage.

* `TalentActive(talentName)`: returns true if you currently have `talentName`.