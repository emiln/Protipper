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

    {   "Frostbolt",
        "true" }
}