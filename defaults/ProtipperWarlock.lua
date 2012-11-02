if not (UnitClass("player") == "Warlock") then
    return
end

Protipper.SPEC_LIST["Affliction"] = {
    {   "Dark Intent",
        [[p.SelfBuffDown('Dark Intent') and 
          p.SelfBuffDown('Arcane Brilliance') and
          p.SelfBuffDown('Burning Wrath') and
          p.SelfBuffDown('Still Water')]] },

    {   "Summon Felhunter",
        [[(not p.SelfBuffUp('Grimoire of Sacrifice')) and
          (not p.ActivePet())]] },

    {   "Grimoire of Sacrifice",
        [[p.HasTalent('Grimoire of Sacrifice') and
          p.ActivePet() and p.SelfBuffDown('Grimoire of Sacrifice')]] },

    {   "Curse of the Elements",
        [[p.DebuffDown('Curse of the Elements') and 
          p.DebuffDown('Lightning Breath') and 
          p.DebuffDown('Master Poisoner')]] },

    {   "Dark Soul",
        "p.AbilityReady('Dark Soul')" },

    {   "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard') and (GetNumGroupMembers() > 0)" },

    {   "Soul Swap",
        "p.SelfBuffUp('Soulburn')" },

    {   "Haunt",
        [[p.DebuffRefresh('Haunt') and p.AbilityReady('Haunt') and
          (not p.IsTraveling('Haunt')) and (not p.IsCasting('Haunt')) and
          (not p.TargetSoonDead())]] },

    {   "Soulburn",
        [[p.AbilityReady('Soulburn') and
          (not p.TargetSoonDead()) and
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
        "p.TargetLowOnHealth()" },

    {   "Life Tap",
        "p.LowOnMana()" },

    {   "Malefic Grasp",
        "true" }
};

Protipper.SPEC_LIST["Demonology"] = {
    {   "Dark Intent",
        [[p.SelfBuffDown('Dark Intent') and
          p.SelfBuffDown('Arcane Brilliance') and
          p.SelfBuffDown('Burning Wrath') and
          p.SelfBuffDown('Still Water')]] },

    {   "Curse of the Elements",
        [[p.DebuffDown('Curse of the Elements') and
          p.DebuffDown('Lightning Breath') and
          p.DebuffDown('Master Poisoner')]] },

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
        "p.SelfBuffUp('Molten Core')" },

    {   "Touch of Chaos",
        "p.AbilityReady('Touch of Chaos')" },

    {   "Life Tap",
        "p.LowOnMana()" },

    {   "Shadow Bolt",
        "true" }
};

Protipper.SPEC_LIST["Destruction"] = {
    {   "Dark Intent",
        [[p.SelfBuffDown('Dark Intent') and
          p.SelfBuffDown('Arcane Brilliance') and
          p.SelfBuffDown('Burning Wrath') and
          p.SelfBuffDown('Still Water')]] },

    {   "Curse of the Elements",
        [[p.DebuffDown('Curse of the Elements') and
          p.DebuffDown('Lightning Breath') and
          p.DebuffDown('Master Poisoner')]] },

    {   "Dark Soul",
        "p.AbilityReady('Dark Soul')" },

    {   "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

    {   "Shadowburn",
        "p.TargetLowOnHealth()" },

    {   "Immolate",
        "p.DotRefresh('Immolate')" },

    {   "Chaos Bolt",
        [[p.AbilityReady('Chaos Bolt') and
         p.SelfBuffStack('Backdraft', 0, 2)]] },

    {   "Conflagrate",
        "p.AbilityReady('Conflagrate')" },

    {   "Incinerate",
        "true" }
}