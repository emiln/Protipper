if not (UnitClass("player") == "Death Knight") then
  return
end

Protipper.SPEC_LIST["Blood"] = {
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

Protipper.SPEC_LIST["Frost"] = {
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

Protipper.SPEC_LIST["Unholy"] = {
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
