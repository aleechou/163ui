
local L = _G.JPackLocale

local addon = CreateFrame'frame'
addon:SetScript('OnEvent', function(self, event, ...) self[event](self, event, ...) end)
local ignoreBag = {} for i=0, NUM_BAG_SLOTS do ignoreBag[i] = 1 end

local LibDataBroker = LibStub'LibDataBroker-1.1'
local dataobj
local function OnClick(self, button)
    if(not dataobj) then
        dataobj = LibDataBroker:GetDataObjectByName'JPack'
    end
    if(not dataobj) then return end
    local access, order = dataobj.clickOption(button)
    JPACK_IGNORE_BAGS_NO_BANK = nil

    if self:GetParent() and self:GetParent().isBank then
        JPACK_IGNORE_BAGS_NO_BANK = ignoreBag
        JPack:Pack(access, order)
    else
        --access是nil的时候是整理背包，3是整理公会银行，普通版没这功能
        if access or not JPack.bankOpened then
            JPack:Pack(access, order)
        else
            dataobj.staticPopupData.access = access
            dataobj.staticPopupData.order = order
            StaticPopup_Show("JPACK_CONFIRM_BANK", nil, nil, dataobj.staticPopupData)
        end
    end
end


local function OnEnter(self)
    GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
    GameTooltip:AddDoubleLine(L['Click'], L['Pack'], 0, 1, 0, 0, 1, 0)
    if JPack.DEV_MOD then GameTooltip:AddDoubleLine(L['Alt + Left-Click'], L['Packup guildbank'], 0, 1, 0, 0, 1, 0) end
    GameTooltip:AddDoubleLine(L['Shift + Left-Click'], L['Save to the bank'], 0, 1, 0, 0, 1, 0)
    GameTooltip:AddDoubleLine(L['Ctrl + Left-Click'], L['Load from the bank'], 0, 1, 0, 0, 1, 0)
    GameTooltip:AddDoubleLine(L['Shift + Right-Click'], L['Set sequence to ascend'], 0, 1, 0, 0, 1, 0)
    GameTooltip:AddDoubleLine(L['Ctrl + Right-Click'], L['Set sequence to descend'], 0, 1, 0, 0, 1, 0)
    GameTooltip:Show()
end

local function OnLeave()
    GameTooltip:Hide()
end

function BuildButton(parent, width, height, point1, point2, point3)
    local f = CreateFrame('Button', nil, parent, 'UIPanelButtonTemplate')		

    f:SetWidth(width)
    f:SetHeight(height)
    f:SetPoint(point1, point2, point3)
    f:SetText(L['Pack'])
    f:SetScript('OnMouseUP', OnClick)

    f:SetScript('OnEnter', OnEnter)
    f:SetScript('OnLeave', OnLeave)

    return f
end

function addon:ADDON_LOADED(event,addon)
    self:PLAYER_LOGIN(event, addon);
    -- if addon ~= 'Blizzard_GuildBankUI' then return end
    -- BuildButton(GuildBankFrame, 45, 20, 'TOPRIGHT', -25, -15)
    --self:UnregisterEvent('ADDON_LOADED')
    --self.ADDON_LOADED = nil
end

--compatible for other addon later loading
local function shouldCheckAddOn(name, addonLoaded)
    if not addonLoaded then 
        return IsAddOnLoaded(name)
    else
        return name == addonLoaded
    end
end

function addon:PLAYER_LOGIN(event, addonLoaded)
    addon:UnregisterEvent('PLAYER_LOGIN')
    -- if shouldCheckAddOn('ArkInventory', addonLoaded) then
    --     local i = 1
    --     while i do
    --         local arkframe = _G['ARKINV_Frame'..i]
    --         if not arkframe then break end
    --         BuildButton(arkframe, 50, 25, 'TOPRIGHT', -135, -15)
    --         i = i + 1
    --     end
    --     return

--     elseif shouldCheckAddOn('Baggins', addonLoaded) then
--         BuildButton(BagginsBag1, 45, 20, 'TOPRIGHT', -30, -6)
--         BuildButton(BagginsBag12, 45, 20, 'TOPRIGHT', -30, -6)

        -- you should look into DataBroker display on Bagnon
        --[[elseif IsAddOnLoaded('Bagnon') then
        local id = 1
        hooksecurefunc(Bagnon.Frame, 'New', function(self, name)
        local f = getglobal('BagnonFrame'..id)
        if not f then return end
        BuildButton(f, 45, 20, 'TOPRIGHT', -50, -8):SetFrameStrata('FULLSCREEN')
        id = id + 1
        end)]]
    -- elseif shouldCheckAddOn('BaudBag', addonLoaded) then
    --     BuildButton(BBCont1_1, 45, 20, 'TOPRIGHT', -40, 20)
    --     BuildButton(BBCont2_1, 45, 20, 'TOPRIGHT', -40, 20)

--     elseif shouldCheckAddOn('Combuctor', addonLoaded) then
--         CoreScheduleTimer(false, 0.1, function()
--             CombuctorFrame1Search:SetPoint('TOPRIGHT',-166,-44)
--             CombuctorFrame2Search:SetPoint('TOPRIGHT',-166,-44)
--             BuildButton(CombuctorFrame1, 45, 25, 'TOPRIGHT', -50, -40)
--             BuildButton(CombuctorFrame2, 45, 20, 'TOPRIGHT', -50, -40)
--         end)

--     elseif shouldCheckAddOn('MyInventory', addonLoaded) then
--         BuildButton(MyInventoryFrame, 45, 20, 'TOPRIGHT', -15, -35)
--         BuildButton(MyBankFrame, 45, 20, 'TOPRIGHT', -15, -35)

--     elseif shouldCheckAddOn('OneBag3', addonLoaded) or shouldCheckAddOn('OneBank3', addonLoaded) then
--         if shouldCheckAddOn('OneBag3', addonLoaded) then
--             BuildButton(OneBagFrame, 60, 20, 'TOPRIGHT', -105, -10)
--         end
--         if shouldCheckAddOn('OneBank3', addonLoaded) then
--             BuildButton(OneBankFrame, 60, 20, 'TOPRIGHT', -105, -10)
--         end
--     end

    -- if not addonLoaded then
        BuildButton(ContainerFrame1, 40, 20, 'TOPRIGHT', -25, -6)
        BuildButton(BankFrame, 45, 20, 'TOPRIGHT', -50, -15)
    -- end

    --if JPack.DEV_MOD then addon:RegisterEvent('ADDON_LOADED') end
end

addon:RegisterEvent'PLAYER_LOGIN'
addon:RegisterEvent'ADDON_LOADED'
