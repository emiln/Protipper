if not (UnitClass("player") == "Warlock") then
  return
end

Protipper.COOLDOWN_FREE_SPELL["Affliction"] = "Malefic Grasp"

Protipper.SPEC_LIST["Affliction"] = {
  preparation = {
    {
      "Summon Terrorguard",
      function(api)
        return (not api.Pet().isActive) and
          api.Talent("Demonic Servitude").isActive and
          api.Talent("Grimoire of Supremacy").isActive
      end
    },
    {
      "Summon Doomguard",
      function(api)
        return (not api.Pet().isActive) and
          api.Talent("Demonic Servitude").isActive
      end
    },
    {
      "Summon Felhunter",
      function(api)
        return (not api.Pet().isActive) and
          api.Talent("Grimoire of Supremacy").isActive
      end
    },
    {
      "Summon Felhunter",
      function(api)
        return (not api.Pet().isActive)
      end
    },
    {
      "Dark Intent",
      function(api)
        return not api.Effect("Dark Intent", "player").isActive
      end
    }
  },
  default = {
    {
      "Dark Soul: Misery",
      function(api)
        local darkSoul = api.Spell("Dark Soul: Misery")
        return darkSoul.isReady
      end
    },
    {
      "Life Tap",
      function(api)
        local player = api.Status("player")
        local darkSoul = api.Effect("Dark Soul: Misery", "player")

        return ((player.currentPower / player.maxPower) < 0.4) and
               (not darkSoul.isActive)
      end
    },
    {
      "Soul Swap",
      function(api)
        local soulburn = api.Effect("Soulburn", "player")
        local shards = api.AlternativePower("Soul Shards", "player")
        local agony = api.Effect("Agony", "target")
        local corruption = api.Effect("Corruption", "target")
        local unstable = api.Effect("Unstable Affliction", "target")

        return soulburn.isActive and shards.current >= 1 and
          agony.remainingDuration < 7.2 and
          corruption.remainingDuration < 5.4 and
          unstable.remainingDuration < 4.2
      end
    },
    {
      "Soulburn",
      function(api)
        local soulburn = api.Effect("Soulburn", "player")
        local shards = api.AlternativePower("Soul Shards", "player")
        local agony = api.Effect("Agony", "target")
        local corruption = api.Effect("Corruption", "target")
        local unstable = api.Effect("Unstable Affliction", "target")

        return (not soulburn.isActive) and shards.current >= 2 and
          agony.remainingDuration < 7.2 and
          corruption.remainingDuration < 5.4 and
          unstable.remainingDuration < 4.2
      end
    },
    {
      "Agony",
      function(api)
        return api.Effect("Agony", "target").remainingDuration < 7.2
      end
    },
    {
      "Corruption",
      function(api)
        return api.Effect("Corruption", "target").remainingDuration < 5.4
      end
    },
    {
      "Unstable Affliction",
      function(api)
        local dot = api.Effect("Unstable Affliction", "target")
        local spell = api.Spell("Unstable Affliction")
        return dot.remainingDuration < 4.2 and
          (not spell.isCasting) and
          (not spell.isTraveling)
      end
    },
    {
      "Soulburn",
      function(api)
        local soulburn = api.Effect("Soulburn", "player")
        local spirits = api.Effect("Haunting Spirits", "player")
        local shards = api.AlternativePower("Soul Shards", "player")
        local darkSoul = api.Spell("Dark Soul: Misery")

        if (shards.current < 4 and darkSoul.remainingCooldown < 30) then
          return false
        end

        return (not soulburn.isActive) and
          (shards.current > 1) and
          ((not spirits.isActive) or
           (shards.current >= 4) or
           (spirits.remainingDuration < 5))
      end
    },
    {
      "Haunt",
      function(api)
        local talent = api.Talent("Soulburn: Haunt")
        local soulburn = api.Effect("Soulburn", "player")
        local spirits = api.Effect("Haunting Spirits", "player")
        local haunt = api.Spell("Haunt")
        local darkSoul = api.Spell("Dark Soul: Misery")
        local shards = api.AlternativePower("Soul Shards", "player")

        if (shards.current < 4 and darkSoul.remainingCooldown < 30) then
          return false
        end

        return talent.isActive and
          (not haunt.isCasting) and
          (not haunt.isTraveling) and
          (soulburn.remainingDuration > haunt.castTime) or
          ((spirits.remainingDuration > 5) and
           (shards.current >= 4))
      end
    },
    {
      "Haunt",
      function(api)
        local debuff = api.Effect("Haunt", "target")
        local darkSoul = api.Effect("Dark Soul: Misery", "player")
        local player = api.Status("player")
        local shards = api.AlternativePower("Soul Shards", "player").current
        local boss = api.Status("target")
        local cast = api.Spell("Haunt")

        if (api.Talent("Soulburn: Haunt").isActive) then
          return false
        end

        if (shards.current < 4 and darkSoul.remainingCooldown < 30) then
          return false
        end

        local cond1 = debuff.remainingDuration == 0 or
                      shards == 4
        local cond2 = darkSoul.remainingDuration > cast.castTime or
                      boss.currentHealth/boss.maxHealth < 0.05 or
                      shards >= 3
        return cond1 and cond2 and (not (cast.isCasting or cast.isTraveling))
      end
    },
    {
      "Drain Soul",
      function(api)
        channel = api.Effect("Drain Soul", "target")
        return channel.remainingDuration < (channel.totalDuration / 4)
      end
    },
    {
      "Auto Attack",
      function(api)
        return true
      end
    }
  }
}

Protipper.COOLDOWN_FREE_SPELL["Demonology"] = "Shadow Bolt"

Protipper.SPEC_LIST["Demonology"] = {
    preparation = {},
    default = {
      {
        "Shadow Bolt",
        function(api)
          return true
        end
      }
    }
}

Protipper.COOLDOWN_FREE_SPELL["Destruction"] = "Incinerate"

Protipper.SPEC_LIST["Destruction"] = {
    preparation = {},
    default = {
      {
        "Incinerate",
        function(api)
          return true
        end
      },
    }
}
