-- -------------------------------------------------------------------------- --
-- EnhancedTradeSkillUI by kunda                                              --
-- -------------------------------------------------------------------------- --
--                                                                            --
-- This a small simple addon to show more recipies in the profession window.  --
--                                                                            --
-- Four simple features:                                                      --
--  - Independent Frame, Move, Scale and Resize.                              --
--                                                                            --
-- Left-Click: (on Portrait TradeSkill Texture)                               --
--  - Move TradeSkill Frame.                                                  --
-- Right-Click: (on Portrait TradeSkill Texture)                              --
--  - Options (Resize and Scale)                                              --
--                                                                            --
-- -------------------------------------------------------------------------- --

EnhancedTradeSkillUI = CreateFrame("Frame") -- container
EnhancedTradeSkillUI_Options = {}           -- SavedVariable options table

local L = EnhancedTradeSkillUI_Locales      -- localization table
local maxTradeSkills = 50                   -- maximum number of shown TradeSkills
local minScale       = 0.5                  -- minimum value for TradeSkillFrame scale
local maxScale       = 1.5                  -- maximum value for TradeSkillFrame scale
local IsTradeSkillUI = false                -- check value for Blizzard_TradeSkillUI

-- ---------------------------------------------------------------------------------------------------------------------
local function SlashHandler()
	InterfaceOptionsFrame_OpenToCategory("EnhancedTradeSkillUI")
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function EnhancedTradeSkillUI:InitOptions()
	SlashCmdList["ENHANCEDTRADESKILLUI"] = SlashHandler
	SLASH_ENHANCEDTRADESKILLUI1 = "/etsui"
	SLASH_ENHANCEDTRADESKILLUI2 = "/tradeskillui"
	SLASH_ENHANCEDTRADESKILLUI3 = "/enhancedtradeskillui"

	if EnhancedTradeSkillUI_Options.ShownSkills == nil then EnhancedTradeSkillUI_Options.ShownSkills = 8 end
	if EnhancedTradeSkillUI_Options.scale       == nil then EnhancedTradeSkillUI_Options.scale       = 1 end
	if EnhancedTradeSkillUI_Options.lock        == nil then EnhancedTradeSkillUI_Options.lock        = false end
	if EnhancedTradeSkillUI_Options.tooltip     == nil then EnhancedTradeSkillUI_Options.tooltip     = true end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function EnhancedTradeSkillUI:Init()
	--EnhancedTradeSkillUI:SetUIPanel(TradeSkillFrame, nil) --目的是保持上次开启位置，但是还是去掉交给系统吧
	--table.insert(UISpecialFrames,"TradeSkillFrame")

	TradeSkillFrame:SetClampedToScreen(true)

	local button = CreateFrame("Button", "EnhancedTradeSkillUI_Mover", TradeSkillFrame)
	button:ClearAllPoints()
	button:SetPoint("CENTER", "TradeSkillFramePortrait", "CENTER", 0, 0)
	button:SetFrameLevel(TradeSkillFrame:GetFrameLevel()+1)
	button:SetWidth(55)
	button:SetHeight(55)
	button:RegisterForClicks("LeftButtonDown", "RightButtonUp")
	-- button:SetScript("OnEnter", function(self, button)
	-- 	if EnhancedTradeSkillUI_Options.tooltip then
	-- 		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 0, 50)
	-- 		if EnhancedTradeSkillUI_Options.lock then
	-- 			GameTooltip:SetText(L["Right-Click: Options"], nil, nil, nil, nil, 1)
	-- 		else
	-- 			GameTooltip:SetText(L["Left-Click: Move"].."\n"..L["Right-Click: Options"], nil, nil, nil, nil, 1)
	-- 		end
	-- 	end
	-- end)
	-- button:SetScript("OnLeave", function(self, button)
	-- 	GameTooltip:Hide()
	-- end)
	button:SetScript("OnMouseDown", function(self, button)
		GameTooltip:Hide()
		-- if button == "RightButton" then
		-- 	InterfaceOptionsFrame_OpenToCategory("EnhancedTradeSkillUI")
		-- else
			if not EnhancedTradeSkillUI_Options.lock then
				TradeSkillFrame:StartMoving()
			end
		-- end
	end)
	button:SetScript("OnMouseUp", function(self, button)
		--if button == "RightButton" then return end
		if not EnhancedTradeSkillUI_Options.lock then
			TradeSkillFrame:StopMovingOrSizing()
			EnhancedTradeSkillUI:SaveFramePos()
		end
	end)
	button:SetScript("OnDragStop", function(self, button)
		if button == "RightButton" then return end
		if not EnhancedTradeSkillUI_Options.lock then
			TradeSkillFrame:StopMovingOrSizing()
		end
	end)

	if EnhancedTradeSkillUI_Options.posX then
		TradeSkillFrame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", EnhancedTradeSkillUI_Options.posX, EnhancedTradeSkillUI_Options.posY)
	end
end

function EnhancedTradeSkillUI:SetUIPanel(frame, info)
	local function NOOP() end
	local name = frame:GetName()
	local visible = frame:IsShown()
	local script1 = frame:GetScript("OnShow")
	local script2 = frame:GetScript("OnHide")

	if visible then
		frame:HookScript("OnShow", NOOP)
		frame:HookScript("OnHide", NOOP)
		HideUIPanel(frame)
	end

	UIPanelWindows[name] = info

	if visible then
		ShowUIPanel(frame)
		frame:HookScript("OnShow", script1)
		frame:HookScript("OnHide", script2)
	end
end

function EnhancedTradeSkillUI:SaveFramePos()
	EnhancedTradeSkillUI_Options.posX = TradeSkillFrame:GetLeft()
	EnhancedTradeSkillUI_Options.posY = TradeSkillFrame:GetTop()
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function EnhancedTradeSkillUI:CreateNewTextButtons()
	for i=9, maxTradeSkills do
		local b = CreateFrame("Button", "TradeSkillSkill"..i, TradeSkillFrame, "TradeSkillSkillButtonTemplate")
		b:SetPoint("TOPLEFT", "TradeSkillSkill"..(i-1), "BOTTOMLEFT", 0, 0)
	end

	local scrollbarTexture = TradeSkillListScrollFrame:CreateTexture("EnhancedTradeSkillUI_ScrollbarTexture", "BACKGROUND")
	scrollbarTexture:ClearAllPoints()
	scrollbarTexture:SetPoint("TOPRIGHT", TradeSkillListScrollFrame, "TOPRIGHT", 29, -50)
	scrollbarTexture:SetWidth(32)
	scrollbarTexture:SetHeight(0)
	scrollbarTexture:SetTexture("Interface\\ClassTrainerFrame\\UI-ClassTrainer-ScrollBar")
	scrollbarTexture:SetTexCoord(0/64, 32/64, 25/128, 123/128)
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function EnhancedTradeSkillUI:Resize(newsize, scale)
	if not IsTradeSkillUI then return end

	TRADE_SKILLS_DISPLAYED = newsize

	TradeSkillFrame:SetHeight(296+newsize*16)

	TradeSkillListScrollFrame:SetHeight(2+newsize*16)
	TradeSkillListScrollFrameScrollChildFrame:SetHeight(16*newsize-60)

	if newsize > 14 then
		EnhancedTradeSkillUI_ScrollbarTexture:Show()
		EnhancedTradeSkillUI_ScrollbarTexture:SetHeight((16*newsize)-(16*8))
	else
		EnhancedTradeSkillUI_ScrollbarTexture:Hide()
		EnhancedTradeSkillUI_ScrollbarTexture:SetHeight(0)
	end

	TradeSkillFrame:SetClampRectInsets(0, 0, 0, 210+(newsize*16))

	TradeSkillHorizontalBarLeft:SetPoint("TOPLEFT", "TradeSkillFrame", "TOPLEFT", 0, -207-(newsize-8)*16)
	TradeSkillDetailScrollFrame:SetPoint("TOPLEFT", "TradeSkillFrame", "TOPLEFT", 6, -220-(newsize-8)*16)

	for i = newsize+1, maxTradeSkills do
		_G["TradeSkillSkill"..i]:Hide()
	end

	TradeSkillFrame:SetScale(scale)
	TradeSkillFrame_Update()
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function OnEvent(self, event, arg1)
	if event == "ADDON_LOADED" then
		if arg1 == "EnhancedTradeSkillUI" then
			EnhancedTradeSkillUI:InitOptions()
			--EnhancedTradeSkillUI:CreateInterfaceOptions()
		end
		if arg1 == "Blizzard_TradeSkillUI" or (arg1 == "EnhancedTradeSkillUI" and IsAddOnLoaded("Blizzard_TradeSkillUI")) then
			if IsTradeSkillUI then return end
			IsTradeSkillUI = true
			EnhancedTradeSkillUI:Init()
			EnhancedTradeSkillUI:CreateNewTextButtons()
			EnhancedTradeSkillUI:Resize(EnhancedTradeSkillUI_Options.ShownSkills, EnhancedTradeSkillUI_Options.scale)
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

EnhancedTradeSkillUI:RegisterEvent("ADDON_LOADED")
EnhancedTradeSkillUI:SetScript("OnEvent", OnEvent)
