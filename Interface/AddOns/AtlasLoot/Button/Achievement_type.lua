local AtlasLoot = _G.AtlasLoot
local AC = AtlasLoot.Button:AddType("Achievement", "ac")
local AL = AtlasLoot.Locales
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

-- lua

-- WoW
local GetAchievementInfo = GetAchievementInfo

local Tooltip = AtlasLoot.Tooltip
local AcClickHandler = nil

local AC_COLOR = "|cffffff00"
local GUILD_AC_IMAGE = "Interface\\AchievementFrame\\UI-Achievement-Guild"
local NORMAL_AC_IMAGE = "Interface\\AchievementFrame\\UI-Achievement-IconFrame"

function AC.OnSet(button, second)
	if not AcClickHandler then
		AcClickHandler = AtlasLoot.ClickHandler:Add(
		"Achievement",
		{
			ChatLink = { "LeftButton", "Shift" },
			GoTo = { "LeftButton", "None" },
			types = {
				ChatLink = true,
				GoTo = true,
			},
		},
		AtlasLoot.db.profile.Button.Achievement.ClickHandler, 
		{
			{ "ChatLink", 	AL["Chat Link"], 	AL["Add achievement link into chat"] },
			{ "GoTo",		"Go to ac",			"Jep thats it ;)" },
		})
	end
	if not button then return end
	if second and button.__atlaslootinfo.secType then
		button.secButton.AcID = button.__atlaslootinfo.secType[2]
		AC.Refresh(button.secButton)
	else
		button.AcID = button.__atlaslootinfo.type[2]
		AC.Refresh(button)
	end
end

function AC.OnClear(button)
	button.AcID = nil
	button.secButton.AcID = nil
	
	button.secButton.icon:SetDesaturated(false)
	button.secButton.overlay:SetHeight(button.icon:GetWidth())
	button.secButton.overlay:SetWidth(button.icon:GetWidth())
	button.secButton.overlay:SetTexCoord(1, 1, 1, 1)
	button.secButton.overlay:SetDesaturated(false)
	button.secButton.overlay:Hide() 
	
	button.icon:SetDesaturated(false)
	button.overlay:SetHeight(button.icon:GetWidth())
	button.overlay:SetWidth(button.icon:GetWidth())
	button.overlay:SetTexCoord(1, 1, 1, 1)
	button.overlay:SetDesaturated(false)
	button.overlay:Hide()
end

function AC.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = AcClickHandler:Get(mouseButton)
	if mouseButton == "ChatLink" then
		AtlasLoot.Button:AddChatLink(GetAchievementLink(button.AcID) or "achievement:"..button.AcID)
	elseif mouseButton == "GoTo" then
		if not IsAddOnLoaded("Blizzard_AchievementUI") then
			LoadAddOn("Blizzard_AchievementUI")
		end
		ShowUIPanel(AchievementFrame)
		AchievementFrame_SelectAchievement(button.AcID)
	end
end

function AC.OnEnter(button)
	local tooltip = GetAlTooltip() 
	tooltip:ClearLines()
	tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 24)
	tooltip:SetHyperlink(GetAchievementLink(button.AcID))
	tooltip:Show()
end

function AC.OnLeave(button)
	GetAlTooltip():Hide()
end

function AC.Refresh(button)
	local _, name, _, completed, _, _, _, _, _, image, rewardText, isGuild = GetAchievementInfo(button.AcID)
	
	if button.type == "secButton" then
		--button.mini:SetTexture()
		--button.mini:Show()
	else
		button.name:SetText(AC_COLOR..name)
		button.extra:SetText(rewardText)
	end
	
	button.icon:SetTexture(image)
	if isGuild then
		button.overlay:SetTexture(GUILD_AC_IMAGE)
		button.overlay:SetTexCoord(0.25976563, 0.40820313, 0.50000000, 0.64453125)
	else
		button.overlay:SetTexture(NORMAL_AC_IMAGE)
		button.overlay:SetTexCoord(0, 0.5625, 0, 0.5625)
	end
	button.overlay:SetHeight(button.icon:GetHeight()*1.2)
	button.overlay:SetWidth(button.icon:GetWidth()*1.2)
	button.overlay:Show()
	if not completed then
		button.icon:SetDesaturated(true)
		button.overlay:SetDesaturated(true)
	end
end