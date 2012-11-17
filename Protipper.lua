--[[
   Protipper: A World of Warcraft Addon for the DPS-engrossed damage dealer.
   Copyright (C) 2012 Emil Nauerby

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>.
   ]]

   local p = Protipper;

   Protipper.COOLDOWN_FREE_SPELL = {};
   Protipper.HP_COLOR_LOW = {235,26,26};
   Protipper.GCD = 1.5;
   Protipper.HP_COLOR_HIGH = {61,235,26};
   Protipper.BAR_WIDTH = 10;
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
   Protipper.HP_BAR_ALPHA = 0.6;
   Protipper.PLAYER_HP_BAR = nil;
   Protipper.TARGET_HP_BAR = nil;
   Protipper.TRIVIAL_HEALTH = 45000;
   Protipper.TOTEM_MAP = {};

   Protipper.OnLoad = function() 
      Protipper.CreateFrame();
      if Protipper.SPEC_LIST == nil then
	 Protipper.SPEC_LIST = {};
      end
      Protipper.CreateTotemMap();
   end

   Protipper.CreateTotemMap = function()
      p.TOTEM_MAP["Flametongue Totem"] = 1;
      p.TOTEM_MAP["Fire Elemental Totem"] = 1;
      p.TOTEM_MAP["Magma Totem"] = 1;
      p.TOTEM_MAP["Searing Totem"] = 1;

      p.TOTEM_MAP["Earth Elemental Totem"] = 2;
      p.TOTEM_MAP["Earthbind Totem"] = 2;
      p.TOTEM_MAP["Stoneclaw Totem"] = 2;
      p.TOTEM_MAP["Stoneskin Totem"] = 2;
      p.TOTEM_MAP["Strength of Earth Totem"] = 2;
      p.TOTEM_MAP["Tremor Totem"] = 2;

      p.TOTEM_MAP["Cleansing Totem"] = 3;
      p.TOTEM_MAP["Fire Resistance Totem"] = 3;
      p.TOTEM_MAP["Healing Stream Totem"] = 3;
      p.TOTEM_MAP["Mana Spring Totem"] = 3;
      p.TOTEM_MAP["Mana Tide Totem"] = 3;

      p.TOTEM_MAP["Grounding Totem"] = 4;
      p.TOTEM_MAP["Nature Resistance Totem"] = 4;
      p.TOTEM_MAP["Sentry Totem"] = 4;
      p.TOTEM_MAP["Windfury Totem"] = 4;
      p.TOTEM_MAP["Wrath of Air Totem"] = 4;
   end

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

	 if srcName == p.PLAYER_NAME or srcName == GetUnitName("pet") then
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
	    p.UpdatePriorities(p.SPEC);
	 end
      end
      if event == "PLAYER_TALENT_UPDATE" or
	 event == "PLAYER_ENTERING_WORLD" then
	 p.UpdatePlayer();
	 p.UpdatePlayerHealth();
	 p.UpdateTargetHealth();

	 local talents = {};
	 Protipper.TALENTS = talents;
	 for i = 1, GetNumTalents() do
	    local tName, _, _, _, tStatus = GetTalentInfo(i);
	    talents[tName] = tStatus;
	 end
	 p.UpdatePriorities(p.SPEC);
      end
      if event == "UNIT_SPELLCAST_SUCCEEDED" then
	 local unit, name, rank, lineId, id = ...;
	 if not (name == nil) then
	    if (unit == "player") then
	       p.TRAVELING_SPELLS[name] = true;
	    end
	 end
	 p.UpdatePriorities(p.SPEC);
      end

      if event == "SPELL_UPDATE_COOLDOWN" then
	 p.UpdatePriorities(p.SPEC);
      end

      if event == "PLAYER_TARGET_CHANGED" then
	 p.UpdatePriorities(p.SPEC);
	 p.UpdateTargetHealth();
      end

      if event == "UNIT_HEALTH" then
	 local unit = ...;
	 if unit == "player" then
	    p.UpdatePlayerHealth();
	    p.UpdatePriorities(p.SPEC);
	 elseif unit == "target" then
	    p.UpdateTargetHealth();
	 end
      end

      if event == "ADDON_LOADED" then
	 if (... == "Protipper") then
	    if (ProtipperOptions == nil) then
	       ProtipperOptions = {};
	       ProtipperOptions.x = 0;
	       ProtipperOptions.y = 0;
	    end
	    local x = ProtipperOptions.x;
	    local y = ProtipperOptions.y;
	    if (x and y) then
	       p.FRAME:SetPoint("CENTER", x, y);
	    end
	 end
      end
   end

   Protipper.PetActive = function()
      return UnitExists("pet");
   end

   Protipper.TalentActive = function(talentName)
      return p.TALENTS[talentName] == true;
   end

   Protipper.IsCasting = function(spellName)
      local spell = UnitCastingInfo("player");
      return (not (spell == nil)) and (spell == spellName);
   end

   Protipper.IsTraveling = function(spellName)
      return not (p.TRAVELING_SPELLS[spellName] == nil);
   end

   Protipper.BuffStack = function(spellName, minStack, maxStack, unit)
      local name, rank, icon, count, dispelType, duration, expires, caster,
      isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
      value1, value2, value3 = UnitAura(unit, spellName);

      if (name == nil or count == nil) then
	 return (minStack == 0);
      end

      return (count >= minStack) and (count <= maxStack);
   end

   Protipper.DebuffStack = function(spellName, minStack, maxStack, unit)
      local name, rank, icon, count, debuffType, duration, expirationTime, 
      unitCaster, isStealable, shouldConsolidate, spellId  = 
	 UnitDebuff(unit, spellName);

      if (name == nil or count == nil) then
	 return (minStack == 0);
      end

      return (count >= minStack) and (count <= maxStack);
   end

   Protipper.BuffActive = function(spellName, unit)
      local name, rank, icon, count, dispelType, duration, expires, caster,
      isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
      value1, value2, value3 = UnitAura(unit, spellName);

      return not (name == nil);
   end

   Protipper.DebuffActive = function(spellName, unit)
      local name, rank, icon, count, dispelType, duration, expires, caster,
      isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
      value1, value2, value3 = UnitDebuff(unit, spellName);

      return not (name == nil);
   end

   Protipper.TotemActive = function(totemName)
      local totemSlot = p.TOTEM_MAP[totemName];
      local haveTotem, activeTotem, startTime, duration = GetTotemInfo(totemSlot);

      return (activeTotem == totemName) and
	 (GetTime() - startTime + duration) >= p.COOLDOWN_DELTA;
   end

   Protipper.GCDActive = function()
      local spell = p.COOLDOWN_FREE_SPELL[p.SPEC];
      local start, duration, enable = GetSpellCooldown(spell);
      local remainingCooldown = start + duration - GetTime();
      return remainingCooldown > 0;
   end

   Protipper.AbilityReady = function(spellName)
      local start, duration, enable = GetSpellCooldown(spellName);

      local name, rank, icon, powerCost, isFunnel, powerType, castingTime,
      minRange, maxRange = GetSpellInfo(spellName);

      if (name == nil) then return false end

      local currentPower = UnitPower("player", powerType);

      -- Information about current spell being cast.
      local spell, rank, displayName, icon, startTime, endTime, 
      isTradeSkill, castID, interrupt = UnitCastingInfo("player");
      
      local remainingCooldown = start + duration - GetTime();

      -- Deal with GCD. We'll consider a spell prevented only by the GCD "ready".
      if p.GCDActive() and remainingCooldown < p.GCD then
	 return (powerCost <= currentPower and not (name == displayName));
      end

      local remainingCastTime = 0;
      if spell then
	 remainingCastTime = endTime/1000 - GetTime();
      end
      
      return ((remainingCooldown < p.COOLDOWN_DELTA or 
	       remainingCooldown < remainingCastTime) and 
	      powerCost <= currentPower) and not (name == displayName);
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

   Protipper.ComboPoints = function(minPoints, maxPoints)
      local points = GetComboPoints("player", "target");
      return (points >= minPoints and points <= maxPoints);
   end

   Protipper.LowOnHealth = function(healthFraction, unit)
      local health = UnitHealth(unit);
      local max = UnitHealthMax(unit);
      return (health/max < healthFraction);
   end

   Protipper.LowOnMana = function(manaFraction, unit)
      local mana = UnitMana(unit);
      local max = UnitManaMax(unit);
      return (mana/max < manaFraction);
   end

   local function GetNextSpell (queue)
      if queue == nil then
	 return nil;
      end
      for i,v in ipairs(queue) do
	 local spell = v[1];
	 local cond = "local p = Protipper; return (" .. v[2] .. ");";
	 local p, eor = loadstring(cond);
	 if p() then
	    return spell;
	 end
      end
      return nil;
   end

   Protipper.UpdatePriorities = function(spec)
      local enemy = UnitCanAttack("player", "target");
      if (enemy == nil) then
	 spell = GetNextSpell(Protipper.SPEC_LIST[spec].preparation);
	 print(spell)
	 if (spell == nil) then
	    p.SetTexture("Interface\\ICONS\\INV_Misc_QuestionMark");
	    p.SetNextSpellName(p.L["ACQUIRE_TARGET"]);
	 else 
	    p.SetNextSpellName(spell);
	    p.SetNextSpell(spell, p.FRAME);
	 end
      else
	 spell = GetNextSpell(Protipper.SPEC_LIST[spec].default);
	 if (spell == nil) then
	    spell = "Auto Attack";
	 end
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
      point, relTo, relPoint, x, y = p.FRAME:GetPoint(1);
      ProtipperOptions.x = x;
      ProtipperOptions.y = y;
   end

   Protipper.SetNextSpellName = function(spellName)
      p.DESCRIPTION.Text:SetText(spellName);
      p.DESCRIPTION:SetWidth(p.DESCRIPTION.Text:GetStringWidth() + 2*p.PADDING);
   end

   Protipper.CenterFrame = function()
      p.FRAME:ClearAllPoints();
      p.FRAME:SetPoint("CENTER", 0, 0);
   end

   Protipper.UpdatePlayerHealth = function()
      local health = UnitHealth("player");
      local max = UnitHealthMax("player");
      if (health > 0) then
	 local frac = health/max;
	 p.PLAYER_HP_BAR:SetHeight(frac*(p.ICON_SIZE - 4));
	 local l = p.HP_COLOR_LOW;
	 local h = p.HP_COLOR_HIGH;
	 local r = (h[1]-l[1])*frac+l[1];
	 local g = (h[2]-l[2])*frac+l[2];
	 local b = (h[3]-l[3])*frac+l[3];
	 p.PLAYER_HP_BAR.Texture:SetTexture(r/255, g/255, b/255,
					    p.HP_BAR_ALPHA);
      else
	 p.PLAYER_HP_BAR:SetHeight(p.ICON_SIZE - 4);
	 p.PLAYER_HP_BAR.Texture:SetTexture(0.2, 0.2, 0.2, p.HP_BAR_ALPHA);
      end
   end

   Protipper.UpdateTargetHealth = function()
      local health = UnitHealth("target");
      local max = UnitHealthMax("target");
      if (health > 0) then
	 local frac = health/max;
	 p.TARGET_HP_BAR:SetHeight(frac*(p.ICON_SIZE - 4));
	 local l = p.HP_COLOR_LOW;
	 local h = p.HP_COLOR_HIGH;
	 local r = (h[1]-l[1])*frac+l[1];
	 local g = (h[2]-l[2])*frac+l[2];
	 local b = (h[3]-l[3])*frac+l[3];
	 p.TARGET_HP_BAR.Texture:SetTexture(r/255, g/255, b/255,
					    p.HP_BAR_ALPHA);
      else
	 p.TARGET_HP_BAR:SetHeight(p.ICON_SIZE - 4);
	 p.TARGET_HP_BAR.Texture:SetTexture(0.2, 0.2, 0.2, p.HP_BAR_ALPHA);
      end
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

      local backdropSmall = {
	 bgFile = "Interface\\Tooltips\\ChatBubble-Background",
	 edgeFile = "Interface\\Tooltips\\ChatBubble-Backdrop",
	 tile = true,
	 tileSize = 8,
	 edgeSize = 8,
	 insets = {
	    left = 1,
	    right = 1,
	    top = 1,
	    bottom = 1
	 }
      };

      local playerBar = CreateFrame("Frame", nil, p.SPELL);
      local playerBarInner = CreateFrame("Frame", nil, playerBar);
      local targetBar = CreateFrame("Frame", nil, p.SPELL);
      local targetBarInner = CreateFrame("Frame", nil, targetBar);

      playerBar:SetPoint("LEFT", -10, 0);
      playerBar:SetBackdrop(backdropSmall);
      playerBar:SetWidth(p.BAR_WIDTH);
      playerBar:SetHeight(p.ICON_SIZE);

      targetBar:SetPoint("RIGHT", 10, 0);
      targetBar:SetBackdrop(backdropSmall);
      targetBar:SetWidth(p.BAR_WIDTH);
      targetBar:SetHeight(p.ICON_SIZE);

      playerBarInner:SetPoint("BOTTOM", playerBar, "BOTTOM", 0, 2);
      playerBarInner.Texture = playerBarInner:CreateTexture();
      playerBarInner.Texture:SetAllPoints(playerBarInner);
      playerBarInner:SetWidth(p.BAR_WIDTH - 4);
      playerBarInner:SetHeight(p.ICON_SIZE - 4);

      p.PLAYER_HP_BAR = playerBarInner;
      p.TARGET_HP_BAR = targetBarInner;

      targetBarInner:SetPoint("BOTTOM", targetBar, "BOTTOM", 0, 2);
      targetBarInner.Texture = targetBarInner:CreateTexture();
      targetBarInner.Texture:SetAllPoints(targetBarInner);
      targetBarInner:SetWidth(p.BAR_WIDTH - 4);
      targetBarInner:SetHeight(p.ICON_SIZE - 4);

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

	 pt:RegisterEvent("ADDON_LOADED");

	 -- Update health bars.
	 pt:RegisterEvent("UNIT_HEALTH");	

	 pt:SetScript("OnEvent", p.OnEvent);
   end