if not (UnitClass("player") == "Mage") then
  return
end

Protipper.COOLDOWN_FREE_SPELL["Arcane"] = "Arcane Blast"

Protipper.SPEC_LIST["Arcane"] = {
  preparation = {},
  default = {
    {
      "Arcane Power",
      function(api)
        return api.Spell("Evocation").remainingCooldown <= 30 and api.Spell("Arcane Power").isReady
      end
    },
    {
      "Evocation",
      function(api)
        return api.Helpers.PowerPercent("player") <= 50 and api.Spell("Evocation").isReady
      end
    },
    {
      "Arcane Missiles",
      function(api)
        return (api.Effect("Arcane Missiles!", "player").stacks >= 3 and api.Helpers.PowerPercent("player") > 70)
      end
    },
    {
      "Arcane Blast",
      function(api)
        return api.Helpers.PowerPercent("player") > 93
      end
    },
    {
      "Arcane Missiles",
      function(api)
        return api.Effect("Arcane Charge", "player").stacks >= 4 and api.Effect("Arcane Missiles!", "player").isActive and api.Helpers.PowerPercent("player") > 70
      end
    },
    {
      "Arcane Barrage",
      function(api)
        return api.Effect("Arcane Charge", "player").stacks >= 4 and api.Spell("Evocation", "player").remainingCooldown > 30
      end
    },
    {
      "Arcane Blast",
      function(api)
        return true
      end
    }
  }
}

Protipper.COOLDOWN_FREE_SPELL["Fire"] = "Fireball"

Protipper.SPEC_LIST["Fire"] = {
   preparation = {},
   default = {
      {
        "Fireball",
        function(api)
          return true
        end
      }
   }
}

Protipper.COOLDOWN_FREE_SPELL["Frost"] = "Frostbolt"

Protipper.SPEC_LIST["Frost"] = {
   preparation = {},
   default = {
      {
        "Frostbolt",
        function(api)
          return true
        end
      }
   }
}
