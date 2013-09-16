local ONE_GUID --just need one valid guid
WB_MAX_SKILL_LEVEL = PROFESSION_RANKS[#PROFESSION_RANKS][1];

local skills = {
    51311, --珠宝加工
    74258, --附魔
    45363, --铭文
    76666, --锻造
    51304, --炼金术
    51309, --裁缝
    51306, --工程学
    51302, --制皮
    51296, --烹饪
    10846, --急救
}

SLASH_WARBABY_TRADE_LINK1 = "/tradelink";
SLASH_WARBABY_TRADE_LINK2 = "/tl";
SlashCmdList["WARBABY_TRADE_LINK"] = function (cmd) 
    local dump, link = (' '):split(cmd, 2)
    if(dump == 'dump') then 
        print(link, string.len(cmd:match':([^:^|]+)|h'))
    elseif(dump == 'menu') then
        ToggleDropDownMenu(1, nil, WarbabyTradeLinkDropdown, GameMenuFrame, 0, 0)
    else
        local color = "|cff7F7Fff";
        if(cmd=="CLEAR") then
            WBTradeLink_RefreshAll(true)
            DEFAULT_CHAT_FRAME:AddMessage(color..WarbabyTL_CLEARED.."|r");
            return;
        end
        DEFAULT_CHAT_FRAME:AddMessage(color..WarbabyTL_TITLE);
        local curr = tonumber(cmd) or WB_MAX_SKILL_LEVEL;
        DEFAULT_CHAT_FRAME:AddMessage(WBTradeLink_GetAll(curr));
    end
end

function WBTradeLink_GetAll(skillLevel)
	local all = "";
    for i=1, #skills do
        all = all..WBTradeLink_GenerateLink(skills[i], skillLevel)
    end
    return all;
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self)
    if ONE_GUID then return end

    local _, unit = self:GetUnit();
    if not unit then return end

    local name, realm = UnitName(unit); if realm=="" then realm=nil end
    if name~=UnitName("player") and UnitIsPlayer(unit) and UnitIsFriend("player", unit) and not realm then
        ONE_GUID = UnitGUID(unit);
    end
end)

function WBTradeLink_GenerateLink(spellid, level)
    local guid = ONE_GUID or UnitGUID("player")
    local _, link = GetSpellLink(spellid)
    if link then
        local color, trade, id, uid, list, name = string.match(link, "%|c(%x+)%|H(trade):(%d-):%d-:%d-:(%x-):([^|:]+)%|h%[([^%]]-)%]%|h%|r");
        local pure = string.format("trade:%d:%d:%d:%s:%s", spellid, level or WB_MAX_SKILL_LEVEL, WB_MAX_SKILL_LEVEL, guid:sub(4), strrep("/", #list))
        local full = string.format("|c%s|H%s|h[%s]|h|r", color, pure, name)
        return full, pure
    end
end

local function dropdownOnClick(line, spellid)
    local text, link = WBTradeLink_GenerateLink(spellid)
    if IsModifiedClick("CHATLINK") then
        local editBox = ChatEdit_ChooseBoxForSend();
        if editBox:HasFocus() then
            editBox:Insert(text);
        else
            ChatEdit_ActivateChat(editBox);
            editBox:SetText(text);
        end
    else
        SetItemRef(link, text, "LeftButton", DEFAULT_CHAT_FRAME)
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("VARIABLES_LOADED")
frame:SetScript("OnEvent", function(self, event)
    if event=="VARIABLES_LOADED" then

        ---copied from Professions Database
        local dd = CreateFrame("Frame", "WarbabyTradeLinkDropdown", UIParent, "UIDropDownMenuTemplate")
        UIDropDownMenu_Initialize(dd, function()
            UIDropDownMenu_AddButton({isTitle=1, notCheckable=1, text=WarbabyTL_TOOLTIPTITLE})
            for _, spellid in ipairs(skills) do
                local info = UIDropDownMenu_CreateInfo()
                local name, _, icon = GetSpellInfo(spellid)
                if name then
                    info.notCheckable = 1
                    info.text = name
                    info.icon = icon
                    info.arg1 = spellid
                    info.func = dropdownOnClick
                    UIDropDownMenu_AddButton(info)
                end
            end
        end, "MENU")

        if LibStub and LibStub("LibDataBroker-1.1", true) then
            local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("WarbabyTradeLink", {
                icon = "Interface\\Icons\\Achievement_Level_50",
                label = WarbabyTL_TOOLTIPTITLE,
                type = "launcher",
                text  = WarbabyTL_TOOLTIPTITLE,
                OnClick = function(self, button)
                    GameTooltip:Hide()
                    ToggleDropDownMenu(1, nil, WarbabyTradeLinkDropdown, self, 0, 0)
                end,
                OnTooltipShow = function(tt)
                    tt:SetText(WarbabyTL_TOOLTIPTITLE)
                    tt:AddLine(WarbabyTL_TOOLTIPTEXT, nil, nil, nil, true)
                end,
            })
        end
    end
end)

--[[------------------------------------------------------------
交易窗口界面增强
---------------------------------------------------------------]]

local function SetOrHookScript(frame, scriptName, func)
    if( frame:GetScript(scriptName) ) then
        frame:HookScript(scriptName, func);
    else
        frame:SetScript(scriptName, func);
    end
end

local hooked = false;

local function hookTradeSkillFrame()
    if(hooked) then return end
    hooked = true;
    for i=1,100 do
        local btn = getglobal("TradeSkillSkill"..i);
        if btn then
            SetOrHookScript(btn, "OnEnter", function (self)
                local id = self:GetID();
                if not id then return end
                local skillName, skillType, numAvailable, isExpanded, altVerb = GetTradeSkillInfo(id);
                if(skillType=="header") then
                    GameTooltip:Hide();
                    CursorUpdate(self);
                else
                    GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
                    pcall(GameTooltip.SetTradeSkillItem, GameTooltip, id);
                    --GameTooltip:Hide();
                    CursorUpdate(self);

                    local numReagents = GetTradeSkillNumReagents(id);
                    if(numReagents > 0) then
                        GameTooltip:AddLine("------------------");
                        local i;
                        for i=1, numReagents, 1 do
                            local reagentName, reagentTexture, reagentCount, playerReagentCount = GetTradeSkillReagentInfo(id, i);
                            if(reagentName) then
                                GameTooltip:AddLine(reagentName.."("..playerReagentCount.."/"..reagentCount..")");
                            end
                        end
                        GameTooltip:AddLine(" ");
                        GameTooltip:AddLine("Shift+右键点击可以获取数据库网址", 0, 0.82, 0);
                        GameTooltip:AddLine("此功能由网易有爱专业技能链接提供", 0, 0.82, 0);
                        GameTooltip:Show();
                    end
                end;

            end)

            SetOrHookScript(btn, "OnLeave", function (self)
                GameTooltip:Hide();
            end)

            btn:RegisterForClicks("LeftButtonUp","RightButtonUp");

            SetOrHookScript(btn, "OnClick", function (self, button)
                if ( IsModifiedClick() and button=="RightButton") then
                    local link = GetTradeSkillRecipeLink(self:GetID())
                    if link then
                        local _, _, id = string.find(link, "%|c%x+%|Henchant:(%d-)%|h%[[^%]]-%]%|h%|r");
                        id = "http://db.w.163.com/spell-"..id..".html";
                        local editbox = ChatEdit_ChooseBoxForSend()
                        ChatEdit_ActivateChat(editbox);
                        editbox:SetText(id);
                        editbox:HighlightText(0, -1);
                    end
                end
            end)
        end
    end

    local function GetMaskChar(b) --0-25(A-Z) 26-51(a-z) (52-61)0-9 62(+) 63(/)
        return strchar( b<26 and b+65 or b<52 and b-26+97 or b<62 and b-52+48 or b==62 and 43 or 47)
    end

    local function GetMaskByte(b)
        return b==43 and 62 or b==47 and 63 or b<=57 and b-48+52 or b<=90 and b-65 or b<=122 and b-97+26
    end

    TradeSkillLinkButton:RegisterForClicks("LeftButtonUp","RightButtonUp");
    SetOrHookScript(TradeSkillLinkButton, "OnClick", function(self, button)
        if(button=="RightButton") then
            local link=GetTradeSkillListLink();
            if link then
                --local start, finish, color, trade, uid, id, list, name = string.find(link, "%|c(%x+)%|H(trade):(%x-):%d-:%d-:(%d-):([^|:]+)%|h%[([^%]]-)%]%|h%|r");
                --[[local l2 = ""
                local i
                for i=1, #list do
                    local b = GetMaskByte(strbyte(list, i));
                    if i==1 then
                        b = bit.bxor(b, 31)
                    else
                        b = bit.bxor(b, 63)
                    end
                    l2 = l2..GetMaskChar(b);
                end
                link = "|c"..color.."|Htrade:"..uid..":".."0"..":450:"..id..":"..l2.."|h["..name.."]|h|r";]]

                local editbox = ChatEdit_ChooseBoxForSend()
                if(editbox:IsVisible()) then editbox:Hide() end;
                DEFAULT_CHAT_FRAME:AddMessage(string.format(WarbabyTL_SUBTRACT, name)..link);
                DEFAULT_CHAT_FRAME:AddMessage(WarbabyTL_WOWHEAD);
            end
        end
    end)
end

CoreDependCall("Blizzard_TradeSkillUI", function()
    TradeSkillFrame:HookScript("OnShow", hookTradeSkillFrame);
    TradeSkillLinkButton:HookScript("OnEnter", function() GameTooltip:AddLine("右键点击可以获取所有缺少的配方", 0, 0.82, 0) GameTooltip:Show(); end)
    local btn = CreateFrame("Button", "$parentTitleButton", TradeSkillFrame)
    btn:SetAllPoints(TradeSkillFrameTitleText)
    btn:RegisterForClicks("AnyUp")
    btn:SetScript("OnClick", function(self, button) if button == "RightButton" then ToggleDropDownMenu(1, nil, WarbabyTradeLinkDropdown, self, 0, 0) end end)
    if BM_SetMoveHandler then BM_SetMoveHandler(TradeSkillFrame, btn) end
end)