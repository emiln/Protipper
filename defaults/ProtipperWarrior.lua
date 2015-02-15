if not (UnitClass("player") == "Warrior") then
  return
end

Protipper.SPEC_LIST["Arms"] = {
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

Protipper.SPEC_LIST["Fury"] = {
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

Protipper.SPEC_LIST["Protection"] = {
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
