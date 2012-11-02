if not (UnitClass("player") == "Shaman") then
    return
end

Protipper.SPEC_LIST["Elemental"] = {
    {   "Elemental Mastery",
        "p.AbilityReady('Elemental Mastery')" },

    {   "Fire Elemental Totem",
        [[p.AbilityReady('Fire Elemental Totem') and
          (not (p.ActiveTotem('Fire Elemental Totem') or
                p.ActiveTotem('Earth Elemental Totem')))]] },

    {   "Earth Elemental Totem",
        [[p.AbilityReady('Earth Elemental Totem') and
          (not (p.ActiveTotem('Fire Elemental Totem') or
                p.ActiveTotem('Earth Elemental Totem')))]] },

    {   "Flame Shock",
        [[p.AbilityReady('Flame Shock') and
          p.DebuffRefresh('Flame Shock')]] },

    {   "Searing Totem",
        [[(not (p.ActiveTotem('Fire Elemental Totem') or
                p.ActiveTotem('Earth Elemental Totem') or
                p.ActiveTotem('Searing Totem')))]] },

    {   "Lava Burst",
        "p.AbilityReady('Lava Burst')" },

    {   "Earth Shock",
        [[p.AbilityReady('Earth Shock') and
          p.BuffStack('Lightning Shield', 6, 100, 'player')]] },

    {   "Lightning Bolt",
        "true" }
};

Protipper.SPEC_LIST["Enhancement"] = {
    {   "Auto Attack",
        "true" }
        
};

Protipper.SPEC_LIST["Restoration"] = {
    {   "Auto Attack",
        "true" }
}