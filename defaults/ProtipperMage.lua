if not (UnitClass("player") == "Mage") then
    return
end

Protipper.SPEC_LIST["Arcane"] = {
    {   "Arcane Brilliance",
        [[p.SelfBuffDown('Dark Intent') and 
          p.SelfBuffDown('Arcane Brilliance') and
          p.SelfBuffDown('Burning Wrath') and
          p.SelfBuffDown('Still Water')]] },

    {   "Mage Armor",
    	"p.SelfBuffDown('Mage Armor')" },

    {	"Arcane Blast",
    	"true" }
};

Protipper.SPEC_LIST["Fire"] = {
    {   "Arcane Brilliance",
        [[p.SelfBuffDown('Dark Intent') and 
          p.SelfBuffDown('Arcane Brilliance') and
          p.SelfBuffDown('Burning Wrath') and
          p.SelfBuffDown('Still Water')]] },

    {   "Molten Armor",
    	"p.SelfBuffDown('Molten Armor')" },

    {   "Fireball",
        "true" }
};

Protipper.SPEC_LIST["Frost"] = {
    {   "Arcane Brilliance",
        [[p.SelfBuffDown('Dark Intent') and 
          p.SelfBuffDown('Arcane Brilliance') and
          p.SelfBuffDown('Burning Wrath') and
          p.SelfBuffDown('Still Water')]] },

    {   "Frost Armor",
    	"p.SelfBuffDown('Frost Armor')" },

    {	"Summon Water Elemental",
    	[[not p.ActivePet() and 
	p.AbilityReady('Summon Water Elemental')]] },
    
    {	"Mirror Image",
    	"p.AbilityReady('Mirror Image')"},

    {	"Icy Veins",
    	"p.AbilityReady('Icy Veins')" },

    {	"Frost Bomb",
    	"p.AbilityReady('Frost Bomb')" },

    {	"Frozen Orb",
	"p.AbilityReady('Frozen Orb')" },

    { 	"Frostbolt",
    	"p.DebuffRefresh('Frostbolt')" },

    {	"Freeze",
    	[[not p.SelfBuffStack('Fingers of Frost', 2, 2) and
	p.ActivePet() and 
	p.PetAbilityReady('Freeze')]] },

    {	"Frostfire Bolt",
    	[[p.SelfBuffUp('Brain Freeze') and
	p.AbilityReady('Frostfire Bolt')]] },

    {	"Ice Lance",
	[[p.SelfBuffUp('Fingers of Frost') and
	p.AbilityReady('Ice Lance')]] },
	
    {   "Frostbolt",
        "true" }
}