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
      
      { "Presence of Mind",
	[[p.TalentActive('Presence of Mind') and
       p.AbilityReady('Presence of Mind')]]},
      
      { "Pyroblast",
	[[p.BuffActive('Pyroblast!', 'player') or 
       p.BuffActive('Presence of Mind', 'player')]] },
      
      { "Inferno Blast",
	[[p.BuffActive('Heating Up', 'player') and
       p.AbilityReady('Inferno Blast')]] },
      
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
