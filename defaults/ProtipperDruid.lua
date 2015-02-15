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
