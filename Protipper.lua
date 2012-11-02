local p = Protipper;

Protipper.ICON_SIZE = 50;
Protipper.LABEL_HEIGHT = 12;
Protipper.PADDING = 8;
Protipper.FRAME = nil;
Protipper.SPELL = nil;
Protipper.INTERVAL = 0.1;
Protipper.COOLDOWN_DELTA = 0.75;
Protipper.SPEC = "None";
Protipper.TRAVELING_SPELLS = {};
Protipper.CASTING_SPELLS = {};
Protipper.TRIVIAL_HEALTH = 45000;

Protipper.OnLoad = function() 
	Protipper.CreateFrame();
	if Protipper.SPEC_LIST == nil then
	   Protipper.SPEC_LIST = {};
	end
end

local total = 0;

Protipper.UpdatePlayer = function()
	local currentSpec = GetSpecialization();
	local currentSpecName = currentSpec and
		select(2, GetSpecializationInfo(currentSpec)) or "None"
	p.SPEC = currentSpecName;
	p.PLAYER_NAME = GetUnitName("player");
end

Protipper.OnEvent = function(self, event, ...)
	if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local timestamp, eventtype, hideCaster, srcGUID, srcName, srcFlags,
		srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags = ...;

		if srcName == p.PLAYER_NAME then
			if eventtype == "SPELL_CAST_START" then
				local spell = UnitCastingInfo("player");
				if not (spell == nil) then
					p.CASTING_SPELLS[spell] = true;
				end
			end
			if eventtype == "SPELL_CAST_FAILED" then
				p.CASTING_SPELLS = {};
			end
			if eventtype == "SPELL_DAMAGE" or eventtype == "SPELL_MISSED" then
				local spell = select(13, ...);
				p.TRAVELING_SPELLS[spell] = nil;
			end
		end
	end
	if event == "PLAYER_TALENT_UPDATE" or
		event == "PLAYER_ENTERING_WORLD" then
		p.UpdatePlayer();

		local talents = {};
		Protipper.TALENTS = talents;
		for i = 1, GetNumTalents() do
			local tName, _, _, _, tStatus = GetTalentInfo(i);
		  	talents[tName] = tStatus;
		end
	end
	if event == "UNIT_SPELLCAST_SUCCEEDED" then
		local unit, name, rank, lineId, id = ...;
		if not (name == nil) then
			if (unit == "player") then
				p.TRAVELING_SPELLS[name] = true;
			end
		end
	end
	p.UpdatePriorities(p.SPEC);
end

Protipper.ActivePet = function()
	return UnitExists("pet");
end

Protipper.HasTalent = function(talentName)
	return p.TALENTS[talentName] == true;
end

Protipper.TargetSoonDead = function()
	local health = UnitHealth("target");
	local max = UnitHealthMax("target");
	return (health <= p.TRIVIAL_HEALTH and health/max < 0.05);
end

Protipper.IsCasting = function(spellName)
	local spell = UnitCastingInfo("player");
	return (not (spell == nil)) and (spell == spellName);
end

Protipper.IsTraveling = function(spellName)
	return not (p.TRAVELING_SPELLS[spellName] == nil);
end

Protipper.SelfBuffStack = function(spellName, minStack, maxStack)
	local name, rank, icon, count, dispelType, duration, expires, caster,
		isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
		value1, value2, value3 = UnitAura("player", spellName);

	if (name == nil or count == nil) then
		return (minStack == 0);
	end

	return (count >= minStack) and (count <= maxStack);
end

Protipper.DebuffStack = function(spellName, minStack, maxStack)
	local name, rank, icon, count, dispelType, duration, expires, caster,
		isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
		value1, value2, value3 = UnitAura("target", spellName);

	if (name == nil or count == nil) then
		return (minStack == 0);
	end

	return (count >= minStack) and (count <= maxStack);
end

Protipper.SelfBuffUp = function(spellName)
	local name, rank, icon, count, dispelType, duration, expires, caster,
		isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
		value1, value2, value3 = UnitAura("player", spellName);

	return not (name == nil);
end

Protipper.SelfBuffDown = function(spellName)
	return not p.SelfBuffUp(spellName);
end

Protipper.DebuffUp = function(spellName)
	local name, rank, icon, count, dispelType, duration, expires, caster,
		isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
		value1, value2, value3 = UnitDebuff("target", spellName);

	return not (name == nil);
end

Protipper.DebuffDown = function(spellName)
	return not p.DebuffUp(spellName);
end

Protipper.AbilityReady = function(spellName)
	local start, duration, enable = GetSpellCooldown(spellName);

	local name, rank, icon, powerCost, isFunnel, powerType, castingTime,
		minRange, maxRange = GetSpellInfo(spellName);

	local currentPower = UnitPower("player", powerType);

	return (start + duration - GetTime() <
		p.COOLDOWN_DELTA and powerCost <= currentPower);
end

Protipper.PetAbilityReady = function(spellName)
	-- HARDCODED, PLS 2 FIX.
        local spellIndex = 4;

	local start, duration, enable = GetPetActionCooldown(spellIndex);

	local name, rank, icon, powerCost, isFunnel, powerType, castingTime,
		minRange, maxRange = GetSpellInfo(spellName);

	local currentPower = UnitPower("pet", powerType);

	return (start + duration - GetTime() < p.COOLDOWN_DELTA and 
	       powerCost <= currentPower);	
end

Protipper.DebuffRefresh = function(spellName)
	local name, rank, icon, powerCost, isFunnel, powerType, castingTime,
		minRange, maxRange = GetSpellInfo(spellName);

	local currentPower = UnitPower("player", powerType);

	local _, _, _, count, _, dotDuration, expires, _,
		_, _, spellID, _, _,
		value1, value2, value3 = UnitDebuff("target", spellName);

	if (expires == nil) then
		return true;
	end

	return
		(expires - GetTime() <= p.COOLDOWN_DELTA + castingTime/1000 and
		powerCost <= currentPower);
end

Protipper.DotRefresh = function(spellName)
	local start, duration, enable = GetSpellCooldown(spellName);

	local name, rank, icon, powerCost, isFunnel, powerType, castingTime,
		minRange, maxRange = GetSpellInfo(spellName);

	local currentPower = UnitPower("player", powerType);

	local _, _, _, count, _, dotDuration, expires, _,
		_, _, spellID, _, _,
		value1, value2, value3 = UnitDebuff("target", spellName);

	if dotDuration == nil then
		return true;
	end
	if not (p.AbilityReady('Pandemic')) then
		dotDuration = 0;
	end

	return
		(expires - GetTime() <
			p.COOLDOWN_DELTA + dotDuration*0.5 and
		powerCost <= currentPower);
end

Protipper.TargetLowOnHealth = function()
	local health = UnitHealth("target");
	local max = UnitHealthMax("target");
	return (health/max < 0.2);
end

Protipper.LowOnMana = function()
	local mana = UnitMana("player");
	local max = UnitManaMax("player");
	return (mana/max < 0.35);
end

Protipper.GetNextSpell = function(spec)
	local queue = p.SPEC_LIST[spec];
	if queue == nil then
		return "Auto Attack";
	end
	for i,v in ipairs(queue) do
		local spell = v[1];
		local cond = "local p = Protipper; return (" .. v[2] .. ");";
		local p, eor = loadstring(cond);
		if p() then
			return spell;
		end
	end
end

Protipper.UpdatePriorities = function(spec)
	local enemy = UnitCanAttack("player", "target");
	if (enemy == nil) then
		p.SetTexture("Interface\\ICONS\\INV_Misc_QuestionMark");
		p.SetNextSpellName(p.L["ACQUIRE_TARGET"]);
	else
		spell = p.GetNextSpell(spec);
		p.SetNextSpellName(spell);
		p.SetNextSpell(spell, p.FRAME);
	end
end

Protipper.SetTexture = function(texturePath)
	p.CreateButton();
	p.SPELL:SetNormalTexture(texturePath);
end

Protipper.SetNextSpell = function(spellName, parent)
	if ((spellName == nil) and (not p.SPELL == nil)) then
		p.SPELL:Hide();
		return;
	end
	p.CreateButton();
	local b = p.SPELL;
	name, rank, icon, powerCost, isFunnel, powerType,
	castingTime, minRange, maxRange = GetSpellInfo(spellName);
	b:SetNormalTexture(icon);
end

Protipper.CreateButton = function()
	if (p.SPELL == nil) then
		p.SPELL = CreateFrame("Button", nil, p.FRAME);
		p.SPELL:SetPoint("TOPLEFT", p.FRAME, "TOPLEFT", 0, 0);
		p.SPELL:SetWidth(Protipper.ICON_SIZE);
		p.SPELL:SetHeight(Protipper.ICON_SIZE);
		p.SPELL:RegisterForDrag("LeftButton");
		p.SPELL:SetScript("OnDragStart", p.StartDragFrame);
		p.SPELL:SetScript("OnDragStop", p.StopDragFrame);
	end
end

Protipper.StartDragFrame = function()
	p.FRAME:SetMovable(true);
	p.FRAME:StartMoving();
end

Protipper.StopDragFrame = function()
	p.FRAME:SetMovable(false);
	p.FRAME:StopMovingOrSizing();
end

Protipper.SetNextSpellName = function(spellName)
	p.DESCRIPTION.Text:SetText(spellName);
	p.DESCRIPTION:SetWidth(p.DESCRIPTION.Text:GetStringWidth() + 2*p.PADDING);
end

Protipper.CenterFrame = function()
	p.FRAME:ClearAllPoints();
	p.FRAME:SetPoint("CENTER", 0, 0);
end

Protipper.CreateFrame = function()
	local backdrop = {
		bgFile = "Interface\\Tooltips\\ChatBubble-Background",
		edgeFile = "Interface\\Tooltips\\ChatBubble-Backdrop",
		tile = true,
		tileSize = 32,
		edgeSize = 16,
		insets = {
			left = 3,
			right = 3,
			top = 3,
			bottom = 3
		}
	}
	local pt = CreateFrame("Frame", "ptFrame", UIParent);
	p.FRAME = pt;
	pt:SetBackdrop(nil);
	pt:SetPoint("CENTER", 0, 0);
	pt:SetWidth(p.ICON_SIZE);
	pt:SetHeight(p.ICON_SIZE);
	pt:SetMovable(true);

	p.CreateButton();

	local desc = CreateFrame("Frame", nil, pt);
	p.DESCRIPTION = desc;
	desc:SetBackdrop(backdrop);
	desc:SetPoint("BOTTOM", 0, -1*(p.LABEL_HEIGHT + 2*p.PADDING));
	desc:SetWidth(120);
	desc:SetHeight(p.LABEL_HEIGHT + 2*p.PADDING);
	desc.Text = desc:CreateFontString(nil, "STRATA", "GameFontNormal");
	desc.Text:SetPoint("TOP", 0, -1*p.PADDING);
	desc.Text:SetText(p.L["ACQUIRE_TARGET"]);

	pt:RegisterEvent("PLAYER_ENTERING_WORLD", pt);
	pt:RegisterEvent("PLAYER_TALENT_UPDATE", pt);
	pt:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", pt);

	--[[ Make sure it updates priorities whenever something spell-related
		 happens. ]]
	pt:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	pt:RegisterEvent("SPELL_UPDATE_USABLE");
	pt:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	pt:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	pt:RegisterEvent("UNIT_SPELLCAST_START");
	pt:RegisterEvent("UNIT_SPELLCAST_STOP");
	pt:RegisterEvent("PLAYER_TARGET_CHANGED");
	pt:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

	pt:SetScript("OnEvent", p.OnEvent);
end