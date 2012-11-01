local specs = {};
Protipper.SPEC_LIST = specs;

specs["Affliction"] = {
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
        "p.AbilityReady('Summon Doomguard') and (GetNumGroupMembers() > 0)" },

    {   "Soul Swap",
        "p.SelfBuffUp('Soulburn')" },

    {   "Haunt",
        [[p.DebuffRefresh('Haunt') and p.AbilityReady('Haunt') and
          (not p.IsTraveling('Haunt'))]] },

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
        "p.TargetLowOnHealth()" },

    {   "Life Tap",
        "p.LowOnMana()" },

    {   "Malefic Grasp",
        "true" }
};

specs["Demonology"] = {
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

specs["Destruction"] = {
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