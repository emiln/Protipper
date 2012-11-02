if not (UnitClass("player") == "Warlock") then
    return
end

Protipper.SPEC_LIST["Affliction"] = {
    {   "Dark Intent",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

    {   "Summon Felhunter",
        [[(not p.BuffActive('Grimoire of Sacrifice', 'player')) and
          (not p.PetActive())]] },

    {   "Grimoire of Sacrifice",
        [[p.TalentActive('Grimoire of Sacrifice') and
          p.PetActive() and
          (not p.BuffActive('Grimoire of Sacrifice', 'player'))]] },

    {   "Curse of the Elements",
        [[not (p.DebuffActive('Curse of the Elements', 'target') or 
               p.DebuffActive('Lightning Breath', 'target') or
               p.DebuffActive('Master Poisoner', 'target'))]] },

    {   "Dark Soul",
        "p.AbilityReady('Dark Soul')" },

    {   "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

    {   "Soul Swap",
        "p.BuffActive('Soulburn', 'player')" },

    {   "Haunt",
        [[p.DebuffRefresh('Haunt') and p.AbilityReady('Haunt') and
          (not p.IsTraveling('Haunt')) and (not p.IsCasting('Haunt'))]] },

    {   "Soulburn",
        [[p.AbilityReady('Soulburn') and
          (p.DotRefresh('Agony') or
           p.DotRefresh('Corruption') or
           p.DotRefresh('Unstable Affliction'))]] },

    {   "Agony",
        "p.DotRefresh('Agony')" },

    {   "Corruption",
        "p.DotRefresh('Corruption')" },

    {   "Unstable Affliction",
        "p.DotRefresh('Unstable Affliction')" },

    {   "Drain Soul",
        "p.LowOnHealth(0.2, 'target')" },

    {   "Life Tap",
        "p.LowOnMana(0.35, 'player')" },

    {   "Malefic Grasp",
        "true" }
};

Protipper.SPEC_LIST["Demonology"] = {
    {   "Dark Intent",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

    {   "Curse of the Elements",
        [[not (p.DebuffActive('Curse of the Elements', 'target') or 
               p.DebuffActive('Lightning Breath', 'target') or
               p.DebuffActive('Master Poisoner', 'target'))]] },

    {   "Dark Soul",
        "p.AbilityReady('Dark Soul')" },

    {   "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

    {   "Felstorm",
        "p.AbilityReady('Felstorm')" },

    {   "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

    {   "Corruption",
        "p.DotRefresh('Corruption')" },

    {   "Doom",
        "p.DotRefresh('Doom')" },

    {   "Metamorphosis",
        "p.AbilityReady('Metamorphosis')" },

    {   "Soul Fire",
        "p.BuffActive('Molten Core', 'player')" },

    {   "Touch of Chaos",
        "p.AbilityReady('Touch of Chaos')" },

    {   "Life Tap",
        "p.LowOnMana(0.35, 'player')" },

    {   "Shadow Bolt",
        "true" }
};

Protipper.SPEC_LIST["Destruction"] = {
    {   "Dark Intent",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

    {   "Curse of the Elements",
        [[not (p.DebuffActive('Curse of the Elements', 'target') or 
               p.DebuffActive('Lightning Breath', 'target') or
               p.DebuffActive('Master Poisoner', 'target'))]] },

    {   "Dark Soul",
        "p.AbilityReady('Dark Soul')" },

    {   "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

    {   "Shadowburn",
        "p.LowOnHealth(0.2, 'target')" },

    {   "Immolate",
        "p.DotRefresh('Immolate')" },

    {   "Chaos Bolt",
        [[p.AbilityReady('Chaos Bolt') and
          p.BuffStack('Backdraft', 0, 2, 'player')]] },

    {   "Conflagrate",
        "p.AbilityReady('Conflagrate')" },

    {   "Incinerate",
        "true" }
}