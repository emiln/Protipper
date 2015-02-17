# Protipper

A helping hand in keeping track of your DPS rotation.

## Features

Protipper is built on one simple idea and provides one simple feature:

* Displays the ability (by icon, name, and keybinding) you should use.

That's it. You, in turn, try to keep up with Protipper's suggestions, while it keeps track of the game state for you and updates its suggestions in real-time.

## FAQ

> How does Protipper know what to suggest?

Protipper relies on priority lists which can be expressed as:

1. When `condition1` is true: display `ability1`.
2. When `condition2` is true: display `ability2`.
3. ...

Protipper then traverses this list until it finds an ability with a true condition. Having found and displayed one, it starts all over again. While this may seem very simplistic and limiting, it makes for pretty good rotations if the conditions and ordering are chosen sensibly. Keeping priority lists for all specs up to date is hard work, and you should check the state of the spec you're intending to play to ensure we can actually help you, specifically. It is not currently possible for the two of us to keep all specs for all classes updated, but if we find people who can help out with the classes we do not master, it is definitely a future goal.

> Doesn't this ruin the joy of the game by making it too easy?

Why don't you find out? I personally really enjoy it, and "really enjoy" is quite far from "ruin the joy" by most standards. It only helps with your basic rotation (which doesn't include when to use raid-wide cooldowns), and you still have the arduous task of not standing in the fire. It's like having a seasoned player looking over your shoulder, whispering suggestions in your ear. You'll frequently have to disobey them, but having a fallback when the fights are stressful can be very helpful.

![Protipper in action](http://i.imgur.com/fLXmMXl.png)
