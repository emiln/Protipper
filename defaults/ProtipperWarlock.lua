if not (UnitClass("player") == "Warlock") then
  return
end

Protipper.COOLDOWN_FREE_SPELL["Affliction"] = "Malefic Grasp"

Protipper.SPEC_LIST["Affliction"] = {
    preparation = {},
    default = {
      {
        "Malefic Grasp",
        function(api)
          return true
        end
      }
    }
}

Protipper.COOLDOWN_FREE_SPELL["Demonology"] = "Shadow Bolt"

Protipper.SPEC_LIST["Demonology"] = {
    preparation = {},
    default = {
      {
        "Shadow Bolt",
        function(api)
          return true
        end
      }
    }
}

Protipper.COOLDOWN_FREE_SPELL["Destruction"] = "Incinerate"

Protipper.SPEC_LIST["Destruction"] = {
    preparation = {},
    default = {
      {
        "Incinerate",
        function(api)
          return true
        end
      },
    }
}
