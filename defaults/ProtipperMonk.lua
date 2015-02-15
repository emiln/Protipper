if not (UnitClass("player") == "Monk") then
  return
end

Protipper.COOLDOWN_FREE_SPELL["Brewmaster"] = "Jab"

Protipper.SPEC_LIST["Brewmaster"] = {
   preparation = {},
   default = {
     {
       "Auto Attack",
       function(api)
         return true
       end
     }
   }
}

Protipper.COOLDOWN_FREE_SPELL["Mistweaver"] = "Jab"

Protipper.SPEC_LIST["Mistweaver"] = {
   preparation = {},
   default = {
     {
       "Auto Attack",
       function(api)
         return true
       end
     }
   }
}

Protipper.COOLDOWN_FREE_SPELL["Windwalker"] = "Jab"

Protipper.SPEC_LIST["Windwalker"] = {
   preparation = {},
   default = {
     {
       "Auto Attack",
       function(api)
         return true
       end
     }
   }
}
