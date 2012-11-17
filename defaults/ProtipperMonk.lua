if not (UnitClass("player") == "Monk") then
   return
end

Protipper.COOLDOWN_FREE_SPELL["Brewmaster"] = "Jab";

Protipper.SPEC_LIST["Brewmaster"] = {
   preparation = {},
   default = {
      { "Auto Attack",
        "true" }
   }
};

Protipper.COOLDOWN_FREE_SPELL["Mistweaver"] = "Jab";

Protipper.SPEC_LIST["Mistweaver"] = {
   preparation = {},
   default = {
      { "Auto Attack",
        "true" }
   }
};

Protipper.COOLDOWN_FREE_SPELL["Windwalker"] = "Jab";

Protipper.SPEC_LIST["Windwalker"] = {
   preparation = {
      {	"Legacy of the Emperor",
    	[[not (p.BuffActive('Legacy of the Emperor', 'player') or
	      p.BuffActive('Blessing of Kings', 'player') or
	      p.BuffActive('Mark of the Wild', 'player') or
	      p.BuffActive('Embrace of the Shale Spider', 'player'))]] },

      {	"Legacy of the White Tiger",
    	[[not (p.BuffActive('Legacy of the White Tiger', 'player') or
	      p.BuffActive('Fearless Roar', 'player') or
	      p.BuffActive('Furious Howl', 'player') or
	      p.BuffActive('Dalaran Brilliance', 'player') or
	      p.BuffActive('Still Water', 'player') or
	      p.BuffActive('Arcane Brilliance', 'player') or
	      p.BuffActive('Leader of the Pack', 'player') or
	      p.BuffActive('Terrifying Roar', 'player'))]] }
   },
   default = {
      {	"Tigereye Brew",
    	[[p.BuffStack('Tigereye Brew', 10, 10, 'player') and
	p.AbilityReady('Tigereye Brew')]] },

      {	"Invoke Xuen, the White Tiger",
    	[[p.TalentActive('Invoke Xuen, the White Tiger') and
	p.AbilityReady('Invoke Xuen, the White Tiger')]] },

      {	"Chi Brew",
    	[[p.TalentActive('Chi Brew') and
	p.AbilityReady('Chi Brew')]] },

      { "Rising Sun Kick",
	"p.AbilityReady('Rising Sun Kick')" }, 

      { "Tiger Palm",
	[[not p.BuffStack('Tiger Power', 3, 3, 'player') and
	p.AbilityReady('Tiger Palm')]] },

      {	"Fists of Fury",
	"p.AbilityReady('Fists of Fury')" },

      {	"Tiger Palm",
    	[[p.BuffActive('Combo Breaker: Tiger Palm', 'player') and 
	p.AbilityReady('Tiger Palm')]] },

      {	"Blackout Kick",
    	"p.AbilityReady('Blackout Kick')" },

      {	"Expel Harm",
    	"p.AbilityReady('Expel Harm')" },

      {	"Jab",
    	"true"}
   }
}