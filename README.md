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
Assuming this is up to date (which is totally happening), the available functions are:

* `AbilityReady(spellName)`: returns true if `spellName` is *not* on cooldown,
  and you have the required resources to use it.
* `ActivePet()`: returns true if you have an active pet.
* `CenterFrame()`: returns the frame to the center of the screen if you happen
  to misplace it.
* `DebuffRefresh(spellName)`: returns true if `spellName` is expired on target
  or will within your cast time.
* `DebuffStack(spellName, minStack, maxStack)`: returns true if your target is
  currently affected by `spellName`, and `minStack <= stackCount <= maxStack`.
* `HasTalent(talentName)`: returns true if you currently have `talentName`.
* `IsCasting(spellName)`: returns true if you are currently casting `spellName`.
* `IsTraveling(spellName)`: returns true if you have successfully cast
  `spellName`, but it has not hit (or missed) yet.
* `LowOnMana()`: returns true if your mana is below `35%`.
* `SelfBuffDown(spellName)`: returns true if you are currently *not* affected
  by `spellName`.
* `SelfBuffStack(spellName, minStack, maxStack)`: returns true if you are
  currently affected by `spellName`, and `minStack <= stackCount <= maxStack`.
* `SelfBuffUp(spellName)`: returns true if you are currently affected by
  `spellName`.
* `TargetLowOnHealth()`: returns true if target's health is below `20%`.
* `TargetSoonDead()`: returns true if target's health is below any of
  `TRIVIAL_HEALTH` and `5%`.