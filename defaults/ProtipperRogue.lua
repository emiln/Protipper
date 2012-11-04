if not (UnitClass("player") == "Rogue") then
    return
end

Protipper.SPEC_LIST["Assassination"] = {
    {   "Auto Attack",
        "true" }
};

Protipper.SPEC_LIST["Combat"] = {
    {   "Ambush",
        "p.AbilityReady('Ambush')" },

    {   "Revealing Strike",
        "not p.DebuffActive('Revealing Strike', 'target')" },

    {   "Slice and Dice",
        [[(not p.BuffActive('Slice and Dice', 'player')) and
          p.ComboPoints(1, 5)]] },

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