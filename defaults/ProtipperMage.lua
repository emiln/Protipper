if not (UnitClass("player") == "Mage") then
    return
end

Protipper.SPEC_LIST["Arcane"] = {
    {   "Arcane Brilliance",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

    {   "Mage Armor",
        "not p.BuffActive('Mage Armor', 'player')" },

    { "Arcane Blast",
      "true" }
};

Protipper.SPEC_LIST["Fire"] = {
    {   "Arcane Brilliance",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

    {   "Molten Armor",
        "not p.BuffActive('Molten Armor', 'player')" },

    {   "Fireball",
        "true" }
};

Protipper.SPEC_LIST["Frost"] = {
    {   "Arcane Brilliance",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

    {   "Frost Armor",
        "not p.BuffActive('Frost Armor', 'player')" },

    {   "Summon Water Elemental",
        [[not p.PetActive() and 
          p.AbilityReady('Summon Water Elemental')]] },
    
    {   "Mirror Image",
        "p.AbilityReady('Mirror Image')"},

    {   "Icy Veins",
        "p.AbilityReady('Icy Veins')" },

    {   "Frost Bomb",
        "p.AbilityReady('Frost Bomb')" },

    {   "Frozen Orb",
        "p.AbilityReady('Frozen Orb')" },

    {   "Frostbolt",
        "p.DebuffRefresh('Frostbolt')" },

    {   "Freeze",
        [[not p.BuffStack('Fingers of Frost', 2, 2, 'player') and
          p.PetActive() and 
          p.PetAbilityReady('Freeze')]] },

    {   "Frostfire Bolt",
        [[p.BuffActive('Brain Freeze', 'player') and
          p.AbilityReady('Frostfire Bolt')]] },

    {   "Ice Lance",
        [[p.BuffActive('Fingers of Frost', 'player') and
          p.AbilityReady('Ice Lance')]] },
  
    {   "Frostbolt",
        "true" }
}