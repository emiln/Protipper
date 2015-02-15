if not (UnitClass("player") == "Mage") then
  return
end

Protipper.COOLDOWN_FREE_SPELL["Arcane"] = "Arcane Blast"

Protipper.SPEC_LIST["Arcane"] = {
   preparation = {},
   default = {
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
