if not (UnitClass("player") == "Shaman") then
  return
end

Protipper.SPEC_LIST["Elemental"] = {
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

Protipper.SPEC_LIST["Enhancement"] = {
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

Protipper.SPEC_LIST["Restoration"] = {
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
