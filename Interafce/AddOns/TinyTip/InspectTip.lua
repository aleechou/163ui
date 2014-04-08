local InspectLess = LibStub("LibInspectLess-1.0")

local PREFIX_ILEVEL = "装等: "
local PREFIX_TALENT = SPECIALIZATION..": "
local INSPECTING = "正在观察...\n"
local PATTERN_ILEVEL = "^" .. PREFIX_ILEVEL .. "([^\n]*)"
local PATTERN_TALENT = "\n" .. PREFIX_TALENT .. "([^\n]*)"

local function isCurrentTipUnit(guid)
    --if not GameTooltip:IsVisible() then return end --OnTooltipSet的时候还没有显示出来
    local _, unit = GameTooltip:GetUnit()
    if unit and UnitGUID(unit) == guid then --and shouldInspect(unit) then 不需要在范围内
        return unit
    end
end

local function SetTooltipText(prefix, text)
    local found, tipline, _, ilevel, talent;
    for i = 2, GameTooltip:NumLines() do
        tipline = _G["GameTooltipTextLeft"..i]
        local text = tipline:GetText();
        if text then
            if text == INSPECTING then
               found = true
            else
                _, _, ilevel = text:find(PATTERN_ILEVEL)
                _, _, talent = text:find(PATTERN_TALENT)
                found = ilevel or talent
            end
            if found then break; end
        end
    end

    if prefix == INSPECTING then
        text = INSPECTING
    else
        if prefix == PREFIX_ILEVEL then ilevel = text else talent = text end
        text = format("%s%s\n%s%s", ilevel and PREFIX_ILEVEL or "", ilevel or "", talent and PREFIX_TALENT or "", talent or "");
    end

    if found then
        tipline:SetText(text)
    else
        GameTooltip:AddLine(text)
    end
    GameTooltip:Show()
end

local function SetGearScore(unit, guid)
    if not isCurrentTipUnit(guid) then return end

    local avgLevel, color, resilience, totalLevel, count, slotCount, itemLinks, pvppower = U1GetInventoryLevel(unit)
    if avgLevel and avgLevel > 0 then
        resilience = resilience > 0 and ("  |cffffffff/ 韧性 "..resilience.."|r") or "  |cffffffff无韧性|r"
        pvppower = pvppower > 0 and ("  |cffffffff/ 强度 "..pvppower.."|r") or "  |cffffffff无强度|r"
        avgLevel = (count~=slotCount and "|cffffd200*|r" or "").."|cff"..color..avgLevel.."|r"
        SetTooltipText(PREFIX_ILEVEL, avgLevel..resilience..pvppower);
    end
end

local function GetTalentString(isInspecting)
    local active, inact

    if(isInspecting)then
        local unit = "mouseover"
        if(unit)then
            active = GetInspectSpecialization(unit)
            if(active and active>0) then active = select(2, GetSpecializationInfoByID(active)) end
        end
    else
        active = GetActiveSpecGroup(isInspecting);
        inact = active and (3-active)
        active = GetSpecialization(isInspecting, false, active);
        inact = GetSpecialization(isInspecting, false, inact);
        active = active and select(2, GetSpecializationInfo(active))
        inact = inact and select(2, GetSpecializationInfo(inact))
    end

    if(active or inact)then
        local talentString = "";
        talentString=talentString..NORMAL_FONT_COLOR_CODE..(active or EMPTY)..FONT_COLOR_CODE_CLOSE
        if(inact)then
            talentString=talentString.." / "..GRAY_FONT_COLOR_CODE..inact..FONT_COLOR_CODE_CLOSE
        end
        return talentString
    else
        return ""
    end
end

local function SetTalent(unit, guid)
    if not isCurrentTipUnit(guid) then return end

    local inspecting = not UnitIsUnit("player", unit)

    SetTooltipText(PREFIX_TALENT, GetTalentString(inspecting))
end

local function shouldInspect(unit)
    return (UnitLevel(unit)>=80 or UnitInParty(unit) or UnitInRaid(unit)) and CanInspect(unit) and (not InspectFrame or not InspectFrame:IsShown()) and (not Examiner or not Examiner:IsShown())
end

local function InspectIfStayOnUnit(guid)
    local unit = isCurrentTipUnit(guid)
    if unit and InspectLess:IsNotBlocking() and shouldInspect(unit) then
        SetTooltipText(INSPECTING);
        NotifyInspect(unit);
        return 1
    end
end

local function TooltipSetUnitOnNextFrame(guid)
    local _, unit = GameTooltip:GetUnit();
    if not unit then return end
    if InspectLess:IsDone() then
        SetGearScore(unit, guid)
    end
    if InspectLess:IsReady() then
        SetTalent(unit, guid)
    end
end

CoreRawHook(GameTooltip, "OnTooltipSetUnit", function(self, unit)
    if TTVar and not TTVar.InspectTip then return end
    local _, unit = self:GetUnit();
    if not unit or not UnitIsPlayer(unit) then return end

    local guid = UnitGUID(unit)

    if UnitIsUnit(unit, "player") then
        SetGearScore("player", guid)
        SetTalent("player", guid)
        return
    end

    if InspectLess:GetGUID()==guid then
        RunOnNextFrame(TooltipSetUnitOnNextFrame, guid)
        if InspectLess:IsDone() and InspectLess:IsReady() then return end
    end

    --不用判断shouldInspect，只要鼠标提示不变就行了
    CoreScheduleBucket("TinyTipInspect", 0.2, InspectIfStayOnUnit, guid)
end, true)

local _, AddOn = ...
function AddOn:InspectLess_InspectItemReady(event, unit, guid)
    if TTVar and not TTVar.InspectTip then return end
    SetGearScore(unit, guid);
end
function AddOn:InspectLess_InspectReady(event, unit, guid)
    if TTVar and not TTVar.InspectTip then return end
    if unit then
        SetTalent(unit, guid);
    end
end

local InspextNextPass --是为了多个插件响应InspectLess_Next的时候，谁响应过了就放在后面，TODO: 只支持两个插件...
function AddOn:InspectLess_Next(event, bool)
    if TTVar and not TTVar.InspectTip then return end
    local _, unit = GameTooltip:GetUnit()
    if unit and not UnitIsUnit(unit, "player") then
        local guid = UnitGUID(unit)
        if guid~=InspectLess:GetGUID() then
            if InspextNextPass then
                RunOnNextFrame(InspectIfStayOnUnit, guid)
                InspextNextPass = nil
            else
                InspextNextPass = InspectIfStayOnUnit(guid)
            end
        end
    end
end

InspectLess.RegisterCallback(AddOn, "InspectLess_InspectItemReady")
InspectLess.RegisterCallback(AddOn, "InspectLess_InspectReady")
InspectLess.RegisterCallback(AddOn, "InspectLess_Next")
