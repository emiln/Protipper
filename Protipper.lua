--[[Protipper: A World of Warcraft Addon for the DPS-engrossed damage dealer.
    Copyright © 2013 Emil Nauerby

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.]]

local p = Protipper

Protipper.COOLDOWN_FREE_SPELL = {}
Protipper.GCD = 1.5
Protipper.ICON_SIZE = 50
Protipper.LABEL_HEIGHT = 12
Protipper.PADDING = 2
Protipper.MARGIN = 1
Protipper.FRAME = nil
Protipper.SPELL = nil
Protipper.INTERVAL = 0.1
Protipper.COOLDOWN_DELTA = 0.75
Protipper.SPEC = "None"
Protipper.TRAVELING_SPELLS = {}
Protipper.CASTING_SPELLS = {}
Protipper.DRAG_ALPHA = 0.5
Protipper.MASTER_ALPHA = 1
Protipper.TRIVIAL_HEALTH = 45000
Protipper.TOTEM_MAP = {}
Protipper.POWER_MAP = {}
Protipper.API = {}
local api = Protipper.API

--  When loaded, create the fanciful frame.
Protipper.OnLoad = function()
    Protipper.CreateFrame()
    if Protipper.SPEC_LIST == nil then
        Protipper.SPEC_LIST = {}
    end
    Protipper.CreateTotemMap()
    Protipper.CreatePowerMap()
end

--[[Set up a mapping for totems. This makes determining whether a given totem
    is active much easier.]]
Protipper.CreateTotemMap = function()
    p.TOTEM_MAP["Flametongue Totem"] = 1
    p.TOTEM_MAP["Fire Elemental Totem"] = 1
    p.TOTEM_MAP["Magma Totem"] = 1
    p.TOTEM_MAP["Searing Totem"] = 1

    p.TOTEM_MAP["Earth Elemental Totem"] = 2
    p.TOTEM_MAP["Earthbind Totem"] = 2
    p.TOTEM_MAP["Stoneclaw Totem"] = 2
    p.TOTEM_MAP["Stoneskin Totem"] = 2
    p.TOTEM_MAP["Strength of Earth Totem"] = 2
    p.TOTEM_MAP["Tremor Totem"] = 2

    p.TOTEM_MAP["Cleansing Totem"] = 3
    p.TOTEM_MAP["Fire Resistance Totem"] = 3
    p.TOTEM_MAP["Healing Stream Totem"] = 3
    p.TOTEM_MAP["Mana Spring Totem"] = 3
    p.TOTEM_MAP["Mana Tide Totem"] = 3

    p.TOTEM_MAP["Grounding Totem"] = 4
    p.TOTEM_MAP["Nature Resistance Totem"] = 4
    p.TOTEM_MAP["Sentry Totem"] = 4
    p.TOTEM_MAP["Windfury Totem"] = 4
    p.TOTEM_MAP["Wrath of Air Totem"] = 4
end

Protipper.CreatePowerMap = function()
    p.POWER_MAP["Mana"] = 0
    p.POWER_MAP["Rage"] = 1
    p.POWER_MAP["Focus"] = 2
    p.POWER_MAP["Energy"] = 3
    p.POWER_MAP["Happiness"] = 4
    p.POWER_MAP["Runes"] = 5
    p.POWER_MAP["Runic Power"] = 6
    p.POWER_MAP["Soul Shards"] = 7
    p.POWER_MAP["Eclipse"] = 8
    p.POWER_MAP["Holy Power"] = 9
    p.POWER_MAP["Alternate Power"] = 10
    p.POWER_MAP["Dark Force"] = 11
    p.POWER_MAP["Light Force"] = 12
    p.POWER_MAP["Shadow Orbs"] = 13
    p.POWER_MAP["Burning Embers"] = 14
    p.POWER_MAP["Demonic Fury"] = 15
end

--  Update the player, retrieving current spec and name.
Protipper.UpdatePlayer = function()
    local currentSpec = GetSpecialization()
    local currentSpecName = currentSpec and
        select(2, GetSpecializationInfo(currentSpec)) or "None"
    p.SPEC = currentSpecName
    p.PLAYER_NAME = GetUnitName("player")
end

--[[Huge event handler function. Takes care of updating priorities, health bars
    travelling spells, and player info.]]
Protipper.OnEvent = function(self, event, ...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local timestamp, eventtype, hideCaster, srcGUID, srcName, srcFlags,
            srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags = ...

        if srcName == p.PLAYER_NAME or srcName == GetUnitName("pet") then
            if eventtype == "SPELL_CAST_START" then
                local spell = UnitCastingInfo("player")
                if not (spell == nil) then
                    p.CASTING_SPELLS[spell] = true
                end
            end
            if eventtype == "SPELL_CAST_FAILED" then
                p.CASTING_SPELLS = {}
            end
            if eventtype == "SPELL_DAMAGE" or eventtype == "SPELL_MISSED" then
                local spell = select(13, ...)
                p.TRAVELING_SPELLS[spell] = nil
            end
            p.UpdatePriorities(p.SPEC)
        end
    end

    if event == "PLAYER_TALENT_UPDATE" or
        event == "PLAYER_ENTERING_WORLD" then
        p.UpdatePlayer()
        p.UpdatePriorities(p.SPEC)
    end

    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit, name, rank, lineId, id = ...
        if not (name == nil) then
            if (unit == "player") then
                p.TRAVELING_SPELLS[name] = true
            end
        end
        p.UpdatePriorities(p.SPEC)
    end

    if event == "SPELL_UPDATE_COOLDOWN" then
        p.UpdatePriorities(p.SPEC)
    end

    if event == "PLAYER_TARGET_CHANGED" then
        p.UpdatePriorities(p.SPEC)
    end

    if event == "UNIT_HEALTH" then
        local unit = ...
        if unit == "player" then
            p.UpdatePriorities(p.SPEC)
        end
    end

    if event == "ADDON_LOADED" then
        if (... == "Protipper") then
            if (ProtipperOptions == nil) then
                ProtipperOptions = {}
                ProtipperOptions.x = 0
                ProtipperOptions.y = 0
            end
            local x = ProtipperOptions.x
            local y = ProtipperOptions.y
            if (x and y) then
                p.FRAME:SetPoint("CENTER", x, y)
            end
        end
    end
end

--  Returns true if glocal cooldown is preventing you from using abilities.
Protipper.GCDActive = function()
    local spell = p.COOLDOWN_FREE_SPELL[p.SPEC]
    local start, duration, enable = GetSpellCooldown(spell)
    local remainingCooldown = start + duration - GetTime()
    return remainingCooldown > 0
end



--------------------------
--- New API functions ----
--------------------------

--[[Returns the following:
    current - A double representing the unit's current alternative power.
    max - A double representing the unit's maximum alternative power.]]
api.AlternativePower = function(type, unit)
  local current = UnitPower(unit, p.POWER_MAP[type])
  local max = UnitPowerMax(unit, p.POWER_MAP[type])
  return {current = current, max = max}
end

--[[Returns the following:
    isActive - A boolean representing if the effect is applied to the unit.
    remainingDuration - A double representing the remaining duration of the effect on the unit. -1 if the effect is not applied to the unit.
    stacks - A double representing the number of stacks of the effect applied to the unit. -1 if the effect is not applied to the unit. 0 if this effect does not stack.
    totalTime - A double reprenseting the total duration of the effect on the unit. -1 if the effect is not applied to the unit.]]
api.Effect = function(spellName, unit)
  local effect = {}
  effect.isActive, effect.remainingDuration, effect.stacks = false, -1, -1
  local name, rank, icon, count, dispelType, duration, expires, caster,
        isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff,
        value1, value2, value3 = UnitAura(unit, spellName)
  if name == nil then
    name, rank, icon, count, debuffType, duration, expires, caster,
    isStealable, shouldConsolidate, spellID = UnitDebuff(unit, spellName)
  end
  if name ~= nil then
    effect.isActive = true
    effect.remainingDuration = expires - GetTime()
    effect.stacks = count
    effect.totalTime = duration
  end
  return effect
end

--[[Returns the following:
    isActive - A boolean representing whether or not a pet is active.
    currentPet - A string representing which pet is active. nil if no pet is active.]]
api.Pet = function()
  local pet = {}
  pet.isActive, pet.currentPet = UnitExists("pet"), nil
  if (pet.isActive) then
    pet.currentPet = UnitCreatureFamily("pet")
  end
  return pet
end

--[[Returns the following:
    isReady - A boolean representing if the spell is ready for use.
    isCasting - A boolean representing if the spell is currently being cast.
    isTraveling - A boolean representing if the spell is currently traveling towards the target.
    charges - A double representing the number of charges of the spell that is ready to use. nil if the spell does not use charges.
    maxCharges - A double representing the maximum number of charges available for the spell. nil if the spell does not use charges.
    castTime - A double representing the cast time of the spell.
    remainingCooldown - A double representing the remaining cooldown before the spell can be used, or if the spell has charges, before another charge is generated.]]
api.Spell = function(spellName)
  local spell = {}
  spell.isReady, spell.isCasting, spell.isTraveling, spell.charges, spell.maxCharges, spell.castTime,
        spell.remainingCooldown = false, false, false, -1, -1, -1, -1
  if (spellName == nil) then
    return spell
  end
  -- Information about spell to cast.
  local name, rank, icon, castingTime,
      minRange, maxRange = GetSpellInfo(spellName)
  local spellCharges, spellMaxCharges, chargeStart, chargeDuration = GetSpellCharges(spellName)
  if castingTime == nil then
    castingTime = 0
  end

  -- Current cooldown status
  local start, duration, enable = GetSpellCooldown(spellName)

  -- Information about current spell being cast.
  local currentCastingSpell, rank, displayName, icon, startTime, endTime,
      isTradeSkill, castID, interrupt = UnitCastingInfo("player")

  local remainingCastTime = 0
  if currentCastingSpell then
    remainingCastTime = endTime/1000 - GetTime()
  end

  spell.isCasting = (currentCastingSpell == name)
  spell.isTraveling = not p.TRAVELING_SPELLS[spellName] == nil
  spell.charges = spellCharges
  spell.maxCharges = spellMaxCharges
  spell.castTime = castingTime / 1000
  --[[Need to check if the recharge started at 2^32/1000 minus the duration of the recharge,
      because this is a sensible default, and as such we write quality code to accommodate it.]]
  if (spellMaxCharges ~= nil and chargeStart < (2^32/1000 - chargeDuration))  then
    spell.remainingCooldown = chargeDuration - (GetTime() - chargeStart)
  else
    if start ~= nil and start > 0 then
      spell.remainingCooldown = duration - (GetTime() - start)
    else
      spell.remainingCooldown = 0
    end
  end

  spell.isReady = (spell.remainingCooldown < p.COOLDOWN_DELTA or spell.remainingCooldown < remainingCastTime) or
            (spell.charges ~= nil and spell.charges > 0) and
            not spell.isCasting

  return spell
end

--[[Returns a map containing the following:
    currentHealth - A double representing the units current health.
    maxHealth - A double representing the units maximum health.
    currentPower - A double representing the units current primary power.
    maxPower - A double representing the units maximum primary power.
    comboPoints - An integer representing the current number of combo points on the target.
    Perhaps alternate powers?]]
api.Status = function(unit)
  local status = {}
  status.currentHealth, status.maxHealth = UnitHealth(unit), UnitHealthMax(unit)
  status.currentPower, status.maxPower = UnitPower(unit), UnitPowerMax(unit)
  status.comboPoints = GetComboPoints("player")
  return status
end

--[[Returns a map containing the following:
    isActive - A boolean representing whether or not the talent is currently selected.]]
api.Talent = function(talentName)
  local talent = {}
  talent.isActive = false
  if talentName == nil then
    return talent
  end
  talent.isActive = IsTalentSpell(talentName)
  if talent.isActive == nil then
    talent.isActive = false
  end
  return talent
end

--[[Returns a map containing the following:
    isActive - A boolean representing if the totem is currently active
    remainingDuration - A double representing the remaining duration of the totem. -1 if totem is inactive.]]
api.Totem = function(totemName)
  local totem = {}
  totem.isActive = false
  totem.remainingDuration = -1
  if totemName == nil then
    return totem
  end
  local totemSlot = p.TOTEM_MAP[totemName]
  local haveTotem, activeTotem, startTime, duration = GetTotemInfo(totemSlot)

  totem.isActive = (activeTotem == totemName)
  totem.remainingDuration = (isActive) and (duration - (GetTime() - startTime)) or -1
  return totem
end

-------------------------
----- Miscellaneous -----
-------------------------

--  Returns the next spell to cast.
local function GetNextSpell (queue)
    if queue == nil then
        return nil
    end
    for i,v in ipairs(queue) do
        local spell = v[1]
        local condition = v[2]
        if condition(Protipper.API) then
          return spell
        end
    end
    return nil
end

--  Updates the icon on the Protipper frame, showing the spell to cast next.
Protipper.UpdatePriorities = function(spec)
    if (spec == "None") then
        p.SetNextSpellName("Auto Attack")
        p.SetNextSpell("Auto Attack", p.FRAME)
        p.SetNextSpellKeybinding(nil)
        return
    end
    local enemy = UnitCanAttack("player", "target")
    spell = GetNextSpell(Protipper.SPEC_LIST[spec].preparation)
    if (spell == nil and (not (enemy == nil))) then
        spell = GetNextSpell(Protipper.SPEC_LIST[spec].default)
        if (spell == nil) then
            spell = "Auto Attack"
        end
    end
    if (spell == nil) then
        p.SetTexture("Interface\\ICONS\\INV_Misc_QuestionMark")
        p.SetNextSpellName(p.L["ACQUIRE_TARGET"])
        p.SetNextSpellKeybinding(nil)
    else
        p.SetNextSpellName(spell)
        p.SetNextSpell(spell, p.FRAME)
        p.SetNextSpellKeybinding(spell)
    end
end

-- Set the texture of the next spell to cast, given a texturePath.
Protipper.SetTexture = function(texturePath)
    p.CreateButton()
    p.SPELL.TEXTURE:SetTexture(texturePath)
end

-- Returns a string representing the keybinding (if any) for the given spell.
Protipper.KeybindingForSpell = function(spellName)
    --[[Action buttons:
        ACTIONBUTTON[1-12] <- First page in regular action bar.
        ACTIONBUTTON[1-12] <- Second page in regular action bar.
        BONUSACTIONBUTTON[1-10] <- Pet bar.
        MULTIACTIONBAR1BUTTON[1-12] <- Right action bar.
        MULTIACTIONBAR2BUTTON[1-12] <- Right action bar 2.
        MULTIACTIONBAR3BUTTON[1-12] <- Lower right action bar.
        MULTIACTIONBAR4BUTTON[1-12] <- Lower left action bar.]]
    for idx = 1, 120 do
        atype, id, subType, spellId = GetActionInfo(idx)
        if (atype == "spell") then
            local name, rank, icon, powerCost, isFunnel, powerType,
                castingTime, minRange, maxRange = GetSpellInfo(id)
            if (name ~= nil) then
                if (name == spellName) then
                    -- Calculate the COMMAND string.
                    local page = math.floor(idx / 12)
                    local slot = idx % 12
                    local command = ""
                    if (page == 0) then
                        command = "ACTIONBUTTON"
                    elseif (page == 1) then
                        command = "ACTIONBUTTON"
                    elseif (page == 2) then
                        command = "MULTIACTIONBAR3BUTTON"
                    elseif (page == 3) then
                        command = "MULTIACTIONBAR4BUTTON"
                    elseif (page == 4) then
                        command = "MULTIACTIONBAR2BUTTON"
                    elseif (page == 5) then
                        command = "MULTIACTIONBAR1BUTTON"
                    end
                    command = command .. slot
                    return GetBindingKey(command)
                end
            end
        end
    end

    return nil
end

-- Set the next spell to cast, given the spell's name.
Protipper.SetNextSpell = function(spellName, parent)
    if ((spellName == nil) and (not p.SPELL == nil)) then
        p.SPELL:Hide()
        return
    end
    p.CreateButton()
    local b = p.SPELL
    local name, rank, icon, powerCost, isFunnel, powerType,
        castingTime, minRange, maxRange = GetSpellInfo(spellName)
    p.SetTexture(icon)
end

-- Set the next spell to cast's keybinding, given the spell's name.
Protipper.SetNextSpellKeybinding = function(spell)
    if (spell ~= p.SPELL.TEXT:GetText()) then
        local key = p.KeybindingForSpell(spell)
        if (spell == nil or key == nil) then
            p.SPELL.TEXT:Hide()
            p.SPELL.KEYBINDING:Hide()
        else
            key = string.gsub(key, "(%w)%w+(-.+)", "%1%2")
            p.SPELL.TEXT:Show()
            p.SPELL.KEYBINDING:Show()
            p.SPELL.TEXT:SetText(key)
            local width = p.SPELL.TEXT:GetStringWidth()
            p.SPELL.KEYBINDING:SetWidth(width)
        end
    end
end

Protipper.CreateButton = function()
    if (p.SPELL == nil) then
        local backdrop = {
            bgFile = "Interface\\Tooltips\\ChatBubble-Background",
            edgeFile = "Interface\\Tooltips\\ChatBubble-Backdrop",
            tile = false,
            tileSize = 1,
            edgeSize = 1,
            insets = {
                left = 0,
                right = 0,
                top = 0,
                bottom = 0
            }
        }

        p.SPELL = CreateFrame("Frame", nil, p.FRAME)
        p.SPELL:SetHeight(p.ICON_SIZE)
        p.SPELL:SetWidth(p.ICON_SIZE)
        p.SPELL:SetBackdrop(backdrop)
        p.SPELL:SetBackdropColor(0, 0, 0, 0.7)
        p.SPELL:SetBackdropBorderColor(0, 0, 0, 1)
        p.SPELL:SetPoint("TOPLEFT", p.FRAME, "TOPLEFT", 0, 0)
        p.SPELL:RegisterForDrag("LeftButton")
        p.SPELL:SetScript("OnDragStart", p.StartDragFrame)
        p.SPELL:SetScript("OnDragStop", p.StopDragFrame)
        p.SPELL:EnableMouse(true)

        p.SPELL.TEXTURE = p.SPELL:CreateTexture("ProtipperIconTexture")
        p.SPELL.TEXTURE:SetPoint("TOPLEFT", p.SPELL, "TOPLEFT", 1, -1)
        p.SPELL.TEXTURE:SetHeight(p.ICON_SIZE - 2)
        p.SPELL.TEXTURE:SetWidth(p.ICON_SIZE - 2)
        p.SPELL.TEXTURE:SetTexCoord(0.08, 0.92, 0.08, 0.92)

        p.SPELL.KEYBINDING = CreateFrame("Frame", nil, p.SPELL)
        p.SPELL.KEYBINDING:SetHeight(p.LABEL_HEIGHT + 2)
        p.SPELL.KEYBINDING:SetWidth(p.ICON_SIZE - 4)
        p.SPELL.KEYBINDING:SetBackdrop(backdrop)
        p.SPELL.KEYBINDING:SetBackdropColor(0, 0, 0, 0)
        p.SPELL.KEYBINDING:SetBackdropBorderColor(0, 0, 0, 0)
        p.SPELL.KEYBINDING:SetPoint("TOPRIGHT", p.SPELL.TEXTURE,
            "TOPRIGHT", 0, 0)
        p.SPELL.TEXT = p.SPELL.KEYBINDING:CreateFontString(nil,
            "STRATA", "GameFontHighlight")
        local filename, height, flags = p.SPELL.TEXT:GetFont()
        p.SPELL.TEXT:SetFont(filename, p.LABEL_HEIGHT, "OUTLINE")
        p.SPELL.TEXT:SetTextHeight(p.LABEL_HEIGHT)
        p.SPELL.TEXT:SetAllPoints()

    end
end

Protipper.StartDragFrame = function()
    p.FRAME:SetAlpha(p.DRAG_ALPHA)
    p.FRAME:SetMovable(true)
    p.FRAME:StartMoving()
end

Protipper.StopDragFrame = function()
    p.FRAME:SetAlpha(p.MASTER_ALPHA)
    p.FRAME:SetMovable(false)
    p.FRAME:StopMovingOrSizing()
    point, relTo, relPoint, x, y = p.FRAME:GetPoint(1)
    ProtipperOptions.x = x
    ProtipperOptions.y = y
end

Protipper.SetNextSpellName = function(spellName)
    p.DESCRIPTION.Text:SetText(spellName)
    p.DESCRIPTION:SetWidth(p.DESCRIPTION.Text:GetStringWidth() + 2*p.PADDING)
end

Protipper.CenterFrame = function()
    p.FRAME:ClearAllPoints()
    p.FRAME:SetPoint("CENTER", 0, 0)
end

Protipper.CreateFrame = function()
    local backdrop = {
        bgFile = "Interface\\Tooltips\\ChatBubble-Background",
        edgeFile = "Interface\\Tooltips\\ChatBubble-Backdrop",
        tile = false,
        tileSize = 1,
        edgeSize = 1,
        insets = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0
        }
    }

    local pt = CreateFrame("Frame", "ptFrame", UIParent)
    p.FRAME = pt
    pt:SetBackdrop(nil)
    pt:SetPoint("CENTER", 0, 0)
    pt:SetWidth(p.ICON_SIZE)
    pt:SetHeight(p.ICON_SIZE)
    pt:SetMovable(true)

    p.CreateButton()

    local desc = CreateFrame("Frame", nil, pt)
    p.DESCRIPTION = desc
    desc:SetBackdrop(backdrop)
    desc:SetBackdropBorderColor(0, 0, 0, 1)
    desc:SetBackdropColor(0, 0, 0, 0.7)
    desc:SetPoint("BOTTOM", 0,-p.MARGIN - 1*(p.LABEL_HEIGHT + 2*p.PADDING))
    desc:SetWidth(120)
    desc:SetHeight(p.LABEL_HEIGHT + 2*p.PADDING)
    desc.Text = desc:CreateFontString(nil, "STRATA", "GameFontNormal")
    desc.Text:SetTextColor(1, 1, 1, 1)
    desc.Text:SetPoint("TOP", 0, -1*p.PADDING)
    desc.Text:SetText(p.L["ACQUIRE_TARGET"])

    pt:RegisterEvent("PLAYER_ENTERING_WORLD", pt)
    pt:RegisterEvent("PLAYER_TALENT_UPDATE", pt)
    pt:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", pt)

    --[[ Make sure it updates priorities whenever something spell-related
    happens. ]]
    pt:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    pt:RegisterEvent("SPELL_UPDATE_USABLE")
    pt:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
    pt:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    pt:RegisterEvent("UNIT_SPELLCAST_START")
    pt:RegisterEvent("UNIT_SPELLCAST_STOP")
    pt:RegisterEvent("PLAYER_TARGET_CHANGED")
    pt:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

    pt:RegisterEvent("ADDON_LOADED")

    -- Update health bars.
    pt:RegisterEvent("UNIT_HEALTH")

    pt:SetScript("OnEvent", p.OnEvent)
end
