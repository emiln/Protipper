if not (UnitClass("player") == "Priest") then
  return
end

Protipper.SPEC_LIST["Discipline"] = {
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

Protipper.SPEC_LIST["Shadow"] = {
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
