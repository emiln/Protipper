if not (UnitClass("player") == "Mage") then
   return
end

Protipper.COOLDOWN_FREE_SPELL["Arcane"] = "Arcane Blast";

Protipper.SPEC_LIST["Arcane"] = {
   preparation = {
      { "Arcane Brilliance",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Dalaran Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },
      
      { "Mage Armor",
        "not p.BuffActive('Mage Armor', 'player')" }
   },
   default = {
      { "Arcane Blast",
        "true" }
   }
};

Protipper.COOLDOWN_FREE_SPELL["Fire"] = "Fireball";

Protipper.SPEC_LIST["Fire"] = {

   preparation = {
      { "Arcane Brilliance",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Dalaran Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },
      
      { "Molten Armor",
        "not p.BuffActive('Molten Armor', 'player')" }
   },

   default = {      
      { "Mirror Image",
        "p.AbilityReady('Mirror Image')" },

-- Level 75 talents
      { "Nether Tempest",
        [[p.TalentActive('Nether Tempest') and 
          p.DebuffRefresh('Nether Tempest') and
          p.AbilityReady('Nether Tempest')]]},
      
      { "Frost Bomb",
        [[p.TalentActive('Frost Bomb') and 
          p.DebuffRefresh('Frost Bomb') and
          p.AbilityReady('Frost Bomb')]]},
      
      { "Living Bomb",
        [[p.TalentActive('Living Bomb') and 
          p.DebuffRefresh('Living Bomb') and
          p.AbilityReady('Living Bomb')]]},

-- Level 90 talents
      { "Evocation",
        [[p.TalentActive('Invocation') and
          p.AbilityReady('Evocation') and
          not p.BuffActive('Invoker\'s Energy', 'player')]]
      },

      { "Rune of Power",
        [[p.TalentActive('Rune of Power') and
          p.AbilityReady('Rune of Power') and
          not p.BuffACtive('Rune of Power', 'player')]]},

      { "Incanter's Ward"
        [[p.TalentActive('Incanter\'s Ward') and
          p.AbilityReady('Incanter\'s Ward')]]  },

      { "Presence of Mind",
        [[p.TalentActive('Presence of Mind') and
          p.AbilityReady('Presence of Mind') and
          not p.BuffActive('Presence of Mind', 'player') and
          p.BuffActive('Pyroblast!', 'player') and
          p.BuffActive('Heating Up', 'player') and
          p.AbilityReady('Combustion')]] },

      { "Alter Time",
        [[p.AbilityReady('Alter Time') and
          not p.BuffActive('Alter Time', 'player') and
          p.BuffActive('Pyroblast!', 'player') and
          p.BuffActive('Heating Up', 'player') and
          p.AbilityReady('Combustion')]] },
      
      { "Pyroblast",
        [[(p.BuffActive('Pyroblast!', 'player') and 
           p.BuffActive('Heating Up', 'player') and
           p.IsCasting('Fireball')) or 
          p.BuffActive('Presence of Mind', 'player') or
          (p.BuffActive('Pyroblast!', 'player') and 
           (p.RemainingBuffDuration('Pyroblast!', 'player') < p.CastTime('Fireball')))]] },

      { "Combustion", 
        [[p.DebuffActive('Ignite', 'target') and 
          p.DebuffActive('Pyroblast', 'target') and
          p.AbilityReady('Combustion')]] },

      { "Inferno Blast",
        [[p.BuffActive('Heating Up', 'player') and
          p.AbilityReady('Inferno Blast')]] },

      { "Alter Time",
        [[p.AbilityReady('Alter Time') and
        p.BuffActive('Alter Time', 'player')]] },
      
      { "Fireball",
        "true" }
   }
};

Protipper.COOLDOWN_FREE_SPELL["Frost"] = "Frostbolt";

Protipper.SPEC_LIST["Frost"] = {

   preparation = {
      { "Arcane Brilliance",
        [[not (p.BuffActive('Dark Intent', 'player') or
               p.BuffActive('Arcane Brilliance', 'player') or
               p.BuffActive('Dalaran Brilliance', 'player') or
               p.BuffActive('Burning Wrath', 'player') or
               p.BuffActive('Still Water', 'player'))]] },
      
      { "Frost Armor",
        "not p.BuffActive('Frost Armor', 'player')" },
      
      { "Summon Water Elemental",
        [[not p.PetActive() and 
          p.AbilityReady('Summon Water Elemental')]] }
   },

   default = {
      { "Mirror Image",
        "p.AbilityReady('Mirror Image')"},
      
      { "Icy Veins",
        "p.AbilityReady('Icy Veins')" },
      
      { "Nether Tempest",
        [[p.TalentActive('Nether Tempest') and 
          p.DebuffRefresh('Nether Tempest') and
          p.AbilityReady('Nether Tempest')]]},
      
      { "Frost Bomb",
        [[p.TalentActive('Frost Bomb') and 
          p.DebuffRefresh('Frost Bomb') and
          p.AbilityReady('Frost Bomb')]]},
      
      { "Living Bomb",
        [[p.TalentActive('Living Bomb') and 
          p.DebuffRefresh('Living Bomb') and
          p.AbilityReady('Living Bomb')]]},
      
      { "Frozen Orb",
        "p.AbilityReady('Frozen Orb')" },
      
      { "Frostbolt",
        "p.DebuffRefresh('Frostbolt')" },
      
      { "Freeze",
        [[not p.BuffStack('Fingers of Frost', 2, 2, 'player') and
          p.PetActive() and 
          p.PetAbilityReady('Freeze')]] },
      
      { "Frostfire Bolt",
        [[p.BuffActive('Brain Freeze', 'player') and
          p.AbilityReady('Frostfire Bolt')]] },
      
      { "Ice Lance",
        [[p.BuffActive('Fingers of Frost', 'player') and
          p.AbilityReady('Ice Lance')]] },
      
      { "Frostbolt",
        "true" }
   }
};
