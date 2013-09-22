if not (UnitClass("player") == "Warlock") then
   return
end

Protipper.COOLDOWN_FREE_SPELL["Affliction"] = "Malefic Grasp";

Protipper.SPEC_LIST["Affliction"] = {
   preparation = {
      { "Dark Intent",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

      { "Summon Observer",
	[[p.TalentActive('Grimoire of Supremacy') and 
          (not p.PetActive) and 
          p.AbilityReady('Summon Observer')]] },

      { "Summon Felhunter",
	[[(not p.TalentActive('Grimoire of Supremacy')) and 
          (not p.PetActive()) and 
          (not p.BuffActive('Grimoire of Sacrifice', 'player')) and
          p.AbilityReady('Summon Felhunter')]] },

      { "Grimoire of Sacrifice",
	[[p.TalentActive('Grimoire of Sacrifice') and
          p.PetActive() and
          (not p.BuffActive('Grimoire of Sacrifice', 'player'))]] }
   },
   default = {
      { "Curse of the Elements",
        [[not (p.DebuffActive('Curse of the Elements', 'target') or 
               p.DebuffActive('Lightning Breath', 'target') or
               p.DebuffActive('Master Poisoner', 'target'))]] },

      { "Dark Soul",
        "p.AbilityReady('Dark Soul')" },

      { "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

      { "Soul Swap",
        "p.BuffActive('Soulburn', 'player')" },

      { "Haunt",
        [[p.DebuffRefresh('Haunt') and p.AbilityReady('Haunt') and
          (not p.IsTraveling('Haunt')) and (not p.IsCasting('Haunt'))]] },

      { "Soulburn",
        [[p.AbilityReady('Soulburn') and
          (p.DotRefresh('Agony') or
           p.DotRefresh('Corruption') or
           p.DotRefresh('Unstable Affliction'))]] },

      { "Agony",
        "p.DotRefresh('Agony')" },

      { "Corruption",
        "p.DotRefresh('Corruption')" },

      { "Unstable Affliction",
        "p.DotRefresh('Unstable Affliction')" },

      { "Drain Soul",
        "p.LowOnHealth(0.2, 'target')" },

      { "Life Tap",
        "p.LowOnMana(0.35, 'player')" },

      { "Malefic Grasp",
        "true" }
   }
};

Protipper.COOLDOWN_FREE_SPELL["Demonology"] = "Shadow Bolt";

Protipper.SPEC_LIST["Demonology"] = {
   preparation = {
      { "Dark Intent",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Dalaran Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },

      { "Summon Wrathguard",
	[[p.TalentActive('Grimoire of Supremacy') and 
          (not p.PetActive) and 
          p.AbilityReady('Summon Wrathguard')]] },

      { "Summon Felguard",
	[[(not p.TalentActive('Grimoire of Supremacy')) and 
          (not p.PetActive()) and 
          (not p.BuffActive('Grimoire of Sacrifice', 'player')) and
          p.AbilityReady('Summon Felguard')]] },

      { "Grimoire of Sacrifice",
	[[p.TalentActive('Grimoire of Sacrifice') and
          p.PetActive()
	  (not p.BuffActive('Grimoire of Sacrifice', 'player'))]] }
   },
   default = {
      { "Curse of the Elements",
	[[not (p.DebuffActive('Curse of the Elements', 'target') or 
               p.DebuffActive('Lightning Breath', 'target') or
               p.DebuffActive('Master Poisoner', 'target'))]] },
      
      { "Dark Soul",
	"p.AbilityReady('Dark Soul')" },

      { "Felstorm",
        [[p.PetActive and 
	  p.PetAbilityReady('Felstorm')]] },

      { "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

      { "Corruption",
        "p.DotRefresh('Corruption')" },

      { "Doom",
        "p.DotRefresh('Doom')" },

      { "Metamorphosis",
        "p.AbilityReady('Metamorphosis')" },

      { "Soul Fire",
        "p.BuffActive('Molten Core', 'player')" },

      { "Touch of Chaos",
        "p.AbilityReady('Touch of Chaos')" },

      { "Life Tap",
        "p.LowOnMana(0.35, 'player')" },

      { "Shadow Bolt",
        "true" }
   }
};

Protipper.COOLDOWN_FREE_SPELL["Destruction"] = "Incinerate";

Protipper.SPEC_LIST["Destruction"] = {
   preparation = {
      { "Dark Intent",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },
      
      { "Summon Fel Imp",
	[[p.TalentActive('Grimoire of Supremacy') and 
	  (not p.PetActive()) and 
	  p.AbilityReady('Summon Fel Imp')]] },

      { "Summon Imp",
	[[(not p.TalentActive('Grimoire of Supremacy')) and 
          (not p.PetActive()) and 
          (not p.BuffActive('Grimoire of Sacrifice', 'player')) and
          p.AbilityReady('Summon Imp')]] },

      { "Grimoire of Sacrifice",
	[[p.TalentActive('Grimoire of Sacrifice') and
          p.PetActive() and
	  (not p.BuffActive('Grimoire of Sacrifice', 'player'))]] }
   },
   default = {
      { "Curse of the Elements",
        [[not (p.DebuffActive('Curse of the Elements', 'target') or 
               p.DebuffActive('Lightning Breath', 'target') or
               p.DebuffActive('Master Poisoner', 'target'))]] },

      { "Dark Soul",
        "p.AbilityReady('Dark Soul')" },

      { "Summon Doomguard",
        "p.AbilityReady('Summon Doomguard')" },

      { "Shadowburn",
        "p.LowOnHealth(0.2, 'target') and p.AbilityReady('Shadowburn')" },

      { "Immolate",
        "p.DotRefresh('Immolate') and (not p.IsCasting('Immolate'))" },

      { "Chaos Bolt",
        [[p.AbilityReady('Chaos Bolt') and
          p.BuffStack('Backdraft', 0, 2, 'player')]] },

      { "Conflagrate",
        "p.AbilityReady('Conflagrate')" },

      { "Incinerate",
        "true" }
   }
};