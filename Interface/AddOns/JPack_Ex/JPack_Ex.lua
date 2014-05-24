--[[
	JPack_Ex: A button on you bag frame!
	orig: zyleon@sohu.com
	maintenance: yaroot@gmail.com
]]

local L = _G.JPackLocale

local addon = CreateFrame'frame'
addon:SetScript('OnEvent', function(self, event, ...) self[event](self, event, ...) end)

local function OnClick(self, button)
	local access, order
	if ( button == 'LeftButton' ) then
		if IsShiftKeyDown() then
			access = 1
		elseif IsControlKeyDown() then
			access = 2
		elseif IsAltKeyDown() then
			access = 3
		end
	elseif ( button == 'RightButton' ) then
		if IsShiftKeyDown() then
			order = 1
		elseif IsControlKeyDown() then
			order = 2
		end
	end
	JPack:Pack(access, order)
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
	if addon ~= 'Blizzard_GuildBankUI' then return end
	BuildButton(GuildBankFrame, 45, 20, 'TOPRIGHT', -25, -15)
	self:UnregisterEvent('ADDON_LOADED')
	self.ADDON_LOADED = nil
end

function addon:PLAYER_LOGIN()
	addon:UnregisterEvent('PLAYER_LOGIN')
	if IsAddOnLoaded('ArkInventory') then
		local i = 1
		while i do
			local arkframe = _G['ARKINV_Frame'..i]
			if not arkframe then break end
			BuildButton(arkframe, 50, 25, 'TOPRIGHT', -135, -15)
			i = i + 1
		end
		return
		
	elseif IsAddOnLoaded('Baggins') then
		BuildButton(BagginsBag1, 45, 20, 'TOPRIGHT', -30, -6)
		BuildButton(BagginsBag12, 45, 20, 'TOPRIGHT', -30, -6)
		
	-- you should look into DataBroker display on Bagnon
	--[[elseif IsAddOnLoaded('Bagnon') then
		local id = 1
		hooksecurefunc(Bagnon.Frame, 'New', function(self, name)
			local f = getglobal('BagnonFrame'..id)
			if not f then return end
			BuildButton(f, 45, 20, 'TOPRIGHT', -50, -8):SetFrameStrata('FULLSCREEN')
			id = id + 1
		end)]]
	elseif IsAddOnLoaded('BaudBag') then
		BuildButton(BBCont1_1, 45, 20, 'TOPRIGHT', -40, 20)
		BuildButton(BBCont2_1, 45, 20, 'TOPRIGHT', -40, 20)
		
	elseif IsAddOnLoaded('Combuctor') then
		CombuctorFrame1Search:SetPoint('TOPRIGHT',-166,-44)
		CombuctorFrame2Search:SetPoint('TOPRIGHT',-166,-44)
		BuildButton(CombuctorFrame1, 60, 30, 'TOPRIGHT', -23, -28)
		BuildButton(CombuctorFrame2, 60, 30, 'TOPRIGHT', -23, -28)
		
	elseif IsAddOnLoaded('MyInventory') then
		BuildButton(MyInventoryFrame, 45, 20, 'TOPRIGHT', -15, -35)
		BuildButton(MyBankFrame, 45, 20, 'TOPRIGHT', -15, -35)
		
	elseif IsAddOnLoaded('OneBag3') or IsAddOnLoaded('OneBank3') then
		if IsAddOnLoaded('OneBag3') then
			BuildButton(OneBagFrame, 60, 20, 'TOPRIGHT', -105, -10)
		end
		if IsAddOnLoaded('OneBank3') then
			BuildButton(OneBankFrame, 60, 20, 'TOPRIGHT', -105, -10)
		end
		
	else
		BuildButton(ContainerFrame1, 45, 20, 'TOPRIGHT', -10, -28)
		BuildButton(BankFrame, 45, 20, 'TOPRIGHT', -50, -15)
	end
	
	if JPack.DEV_MOD then addon:RegisterEvent('ADDON_LOADED') end
end

addon:RegisterEvent('PLAYER_LOGIN')
