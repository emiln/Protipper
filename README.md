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

* `'Dark Soul' if AbilityReady('Dark Soul')`
* `'Summon Doomguard' if AbilityReady('Summon Doomguard')`
* `'Agony' if DotRefresh('Agony')`
* ...
* `'Malefic Grasp' if true`

The decision about which spell to display would go as follows:

* Is `Dark Soul` ready to be cast? Yes: Show that icon; no: proceed down.
* Is `Summon Doomguard` ready to be cast? Yes: Show that icon; no: proceed
  down.
* Has `Agony` expired or does the currently ticking `Agony` need refreshing
  (when considering [Pandemic](http://www.wowhead.com/spell=131973))? Yes:
  show that icon; no: proceed down.
* ...
* If everything else fails its condition, show `Malefic Grasp`.