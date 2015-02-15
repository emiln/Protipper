if not (UnitClass("player") == "Hunter") then
  return
end

Protipper.SPEC_LIST["Beast Mastery"] = {
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

Protipper.SPEC_LIST["Marksmanship"] = {
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

Protipper.SPEC_LIST["Survival"] = {
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
