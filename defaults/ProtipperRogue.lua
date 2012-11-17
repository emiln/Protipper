if not (UnitClass("player") == "Rogue") then
   return
end

Protipper.SPEC_LIST["Assassination"] = {
   preparation = {
      { "Deadly Poison",
        "not p.BuffActive('Deadly Poison', 'player')" }
   },
   default = {
      { "Ambush",
        "p.AbilityReady('Ambush') and IsStealthed()" },

      { "Garotte",
        "p.AbilityReady('Garotte') and IsStealthed()" },

      { "Slice and Dice",
        [[(not p.BuffActive('Slice and Dice', 'player')) and
          p.ComboPoints(1, 5)]] },

      { "Envenom",
        [[(not p.BuffActive('Envenom', 'player')) and
          p.ComboPoints(4, 5)]] },

      { "Rupture",
        [[(not p.DebuffActive('Rupture', 'target')) and
          p.ComboPoints(4, 5)]] },

      { "Vendetta",
        "p.AbilityReady('Vendetta')" },

      { "Shadow Blades",
        "p.AbilityReady('Shadow Blades')" },

      { "Dispatch",
        "p.AbilityReady('Dispatch')" },

      { "Mutilate",
        "p.AbilityReady('Mutilate')" },

      { "Auto Attack",
        "true" }
   }
};

Protipper.SPEC_LIST["Combat"] = {
   preparation = {
      { "Deadly Poison",
	"not p.BuffActive('Deadly Poison', 'player')" }
   },
   default = {
      
      { "Ambush",
        "p.AbilityReady('Ambush') and IsStealthed()" },

      { "Slice and Dice",
        [[(not p.BuffActive('Slice and Dice', 'player')) and
          p.ComboPoints(1, 5)]] },

      { "Killing Spree",
        "p.AbilityReady('Killing Spree')" },

      { "Adrenaline Rush",
        [[p.AbilityReady('Adrenaline Rush') and
          (not (p.BuffActive('Heroism', 'player') or
                p.BuffActive('Time Warp', 'player') or
                p.BuffActive('Bloodlust', 'player')))]] },

      { "Shadow Blades",
        "p.AbilityReady('Shadow Blades') and p.BuffActive('Adrenaline Rush')" },

      { "Revealing Strike",
        "not p.DebuffActive('Revealing Strike', 'target')" },

      { "Eviscerate",
        [[p.AbilityReady('Eviscerate') and
          p.ComboPoints(5, 5)]] },

      { "Sinister Strike",
        "p.AbilityReady('Sinister Strike')" },

      { "Auto Attack",
        "true" } 
   }   
};

Protipper.SPEC_LIST["Subtlety"] = {
   preparation = {},
   default = {
      { "Auto Attack",
        "true" }
   }
};