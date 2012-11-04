if not (UnitClass("player") == "Rogue") then
    return
end

Protipper.SPEC_LIST["Assassination"] = {
    {   "Auto Attack",
        "true" }
};

Protipper.SPEC_LIST["Combat"] = {
    {   "Deadly Poison",
        "not p.BuffActive('Deadly Poison', 'player')" },

    {   "Killing Spree",
        "p.AbilityReady('Killing Spree')" },

    {   "Adrenaline Rush",
        "p.AbilityReady('Adrenaline Rush')" },

    {   "Shadow Blades",
        "p.AbilityReady('Shadow Blades')" },

    {   "Ambush",
        "p.AbilityReady('Ambush')" },

    {   "Slice and Dice",
        [[(not p.BuffActive('Slice and Dice', 'player')) and
          p.ComboPoints(1, 5)]] },

    {   "Revealing Strike",
        "not p.DebuffActive('Revealing Strike', 'target')" },

    {   "Eviscerate",
        [[p.AbilityReady('Eviscerate') and
          p.ComboPoints(5, 5)]] },

    {   "Sinister Strike",
        "p.AbilityReady('Sinister Strike')" },

    {   "Auto Attack",
        "true" }
        
};

Protipper.SPEC_LIST["Subtlety"] = {
    {   "Auto Attack",
        "true" }
}