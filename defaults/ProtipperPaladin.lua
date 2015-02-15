if not (UnitClass("player") == "Paladin") then
  return
end

Protipper.SPEC_LIST["Holy"] = {
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

Protipper.SPEC_LIST["Retribution"] = {
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
