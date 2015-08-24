if not (UnitClass("player") == "Druid") then
  return
end

Protipper.SPEC_LIST["Balance"] = {
   preparation = {
     -- You need no preparation, your body should always be ready.
     },
   default = {
     {
       "Auto Attack",
       function(api)
         return true
       end
     }
   }
}

Protipper.SPEC_LIST["Feral"] = {
  preparation = {
    -- You need no preparation, your body should always be ready.
    {
     "Mark of the Wild",
     function(api)
       return not api.Effect("Mark of the Wild", "player").isActive
     end
    },

    {
     "Cat Form",
     function(api)
       return not api.Effect("Cat Form", "player").isActive
     end
    }
  },
  default = {
    {
      "Tiger's Fury",
      function(api)
        local ready = api.Spell("Tiger's Fury").isReady
        local energy = api.Status("player").currentPower

        return ready and energy <= 35
      end
    },
    {
      "Incarnation: King of the Jungle",
      function(api)
        return api.Spell("Incarnation: King of the Jungle").isReady
      end
    },
    {
      "Berserk",
      function(api)
        return api.Spell("Berserk").isReady
      end
    },
    {
     "Savage Roar",
     function(api)
       return api.Effect("Savage Roar", "player").remainingDuration < 1
          and api.Status("player").comboPoints > 0
     end
    },
    {
     "Rip",
     function(api)
       if (api.Effect("Predatory Swiftness", "player").isActive) then
         return false
       end
       local combo = api.Status("player").comboPoints
       local rip = api.Effect("Rip", "target").remainingDuration

       return combo == 5 and rip < 3
     end
    },
    {
     "Rake",
     function(api)
       local rake = api.Effect("Rake", "target").remainingDuration
       local blood = api.Effect("Bloodtalons", "player").isActive
       local combo = api.Status("player").comboPoints
       return blood and (rake <= 10) and (combo < 5)
     end
    },
    {
     "Ferocious Bite",
     function(api)
       if (api.Effect("Predatory Swiftness", "player").isActive) then
         return false
       end
       local target = api.Status("target")
       local fraction = target.currentHealth / target.maxHealth
       local combo = target.comboPoints

       return combo == 5 and fraction < 0.25
     end
    },
    {
     "Ferocious Bite",
     function(api)
       if (api.Effect("Predatory Swiftness", "player").isActive) then
         return false
       end
       local energy = api.Status("player").currentPower
       local combo = api.Status("target").comboPoints
       local blood = api.Effect("Bloodtalons", "player").isActive

       return energy >= 50 and (combo == 5 or (blood and combo >= 3))
     end
    },
    {
      "Healing Touch",
      function(api)
        local combo = api.Status("player").comboPoints
        local pred = api.Effect("Predatory Swiftness", "player")
        local duration = pred.remainingDuration
        local active = pred.isActive

        return (combo >= 4 and duration >= 0.5) or
        (duration < 2 and active)
      end
    },
    {
     "Rake",
     function(api)
       local rake = api.Effect("Rake", "target").remainingDuration
       return rake < 1
     end
    },
    {
     "Moonfire",
     function(api)
       local lunar = api.Talent("Lunar Inspiration").isActive
       local moonfire = api.Effect("Moonfire", "target").remainingDuration
       return lunar and (moonfire < 1)
     end
    },
    {
     "Shred",
     function(api)
       return (not api.Effect("Bloodtalons", "player").isActive)
           or api.Status("player").comboPoints <= 2
     end
    }
  }
}

Protipper.SPEC_LIST["Guardian"] = {
   preparation = {
     -- You need no preparation, your body should always be ready.
     },
   default = {
     {
       "Auto Attack",
       function(api)
         return true
       end
     }
   }
}

Protipper.SPEC_LIST["Restoration"] = {
   preparation = {
     -- You need no preparation, your body should always be ready.
     },
   default = {
     {
       "Auto Attack",
       function(api)
         return true
       end
     }
   }
}
