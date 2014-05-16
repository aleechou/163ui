------------------------------------------------------------
-- OptionFrame.lua
--
-- Abin
-- 2011/2/20
------------------------------------------------------------

local ipairs = ipairs
local pairs = pairs
local CreateFrame = CreateFrame
local GameTooltip = GameTooltip

local _, addon = ...
local L = addon.L

BINDING_HEADER_EASYMOUNT_TITLE = "EasyMount"
BINDING_NAME_EASYMOUNT_HOTKEY1 = L["mount"]
BINDING_NAME_EASYMOUNT_HOTKEY2 = L["force ground mount"]
BINDING_NAME_EASYMOUNT_HOTKEY3 = L["vendors mount"]

local frame = UICreateInterfaceOptionPage("EasyMountOptionFrame", "EasyMount", L["desc"])
addon.optionFrame = frame

local tabFrame = UICreateTabFrame(frame:GetName().."TabFrame", frame)
frame.tabFrame = tabFrame
tabFrame:SetSize(480, 320)
frame:AnchorToTopLeft(tabFrame, 0, -24)

tabFrame:AddTab(L["ground"], "ground")
tabFrame:AddTab(L["fly"], "fly")
tabFrame:AddTab(L["vendors"], "vendors")
tabFrame:AddTab(L["swim"], "swim")
tabFrame:AddTab(L["taq"], "taq")
tabFrame:SelectTab(1)

local list = UICreateVirtualScrollList(tabFrame:GetName().."ListFrame", tabFrame, 15)
frame.listFrame = list
list:SetPoint("TOPLEFT", 5, -12)
list:SetPoint("BOTTOMRIGHT", -7, 7)
list.key = "ground"

local function List_Update(self)
	self:Clear()
	local mounts = addon.mountList[self.key]
	if not mounts then
		return
	end

	local data
	for _, data in ipairs(mounts) do
		self:InsertData(data)
	end
end

list:HookScript("OnShow", List_Update)

function tabFrame:OnTabSelected(id, key)
	list.key = key
	List_Update(list)
end

local function Check_OnClick(self)
	local blacklist = addon.db[list.key]
	if blacklist then
		if self:GetChecked() then
			blacklist[self.id] = nil
		else
			blacklist[self.id] = 1
		end
	end
	addon:UpdateActions()
end

function list:OnButtonCreated(button)
	local check = CreateFrame("CheckButton", button:GetName().."Check", button, "InterfaceOptionsCheckButtonTemplate")
	check:SetHitRectInsets(0, 0, 0, 0)
	check:SetPoint("LEFT", 4, 0)
	check:SetScript("OnClick", Check_OnClick)
	button.check = check

	local icon = button:CreateTexture(button:GetName().."Icon", "ARTWORK")
	icon:SetSize(16, 16)
	icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	icon:SetPoint("LEFT", check, "RIGHT", 4, 0)
	button.icon = icon

	local text = button:CreateFontString(button:GetName().."Text", "ARTWORK", "GameFontHighlightLeft")
	text:SetPoint("LEFT", icon, "RIGHT", 8, 0)
	text:SetTextColor(0x71 / 0xff, 0xd5 / 0xff, 1)
	button.text = text
end

function list:OnButtonUpdate(button, data)
	button.check.id = data.id
	local blacklist = addon.db[list.key]
	if blacklist then
		button.check:SetChecked(not blacklist[data.id])
	end
	button.icon:SetTexture(data.icon)
	button.text:SetText(data.name)
end

function list:OnButtonTooltip(button, data)
	pcall(GameTooltip.SetHyperlink, GameTooltip, "Hspell:"..data.id)
end

local btnClearAll = frame:CreatePressButton(L["clear all"])
btnClearAll:SetSize(130, 24)
btnClearAll:SetPoint("TOP", tabFrame, "BOTTOM", 0, -8)

btnClearAll:SetScript("OnClick", function(self)
	local mounts = addon.mountList[list.key]
	if not mounts then
		return
	end

	local blacklist = addon.db[list.key]
	if not blacklist then
		return
	end

	local data
	for _, data in ipairs(mounts) do
		blacklist[data.id] = 1
	end
	List_Update(list)
end)

local btnSelectAll = frame:CreatePressButton(L["select all"])
btnSelectAll:SetSize(130, 24)
btnSelectAll:SetPoint("RIGHT", btnClearAll, "LEFT")

btnSelectAll:SetScript("OnClick", function(self)
	local blacklist = addon.db[list.key]
	if blacklist then
		wipe(blacklist)
		List_Update(list)
	end
end)

local btnInvertSelect = frame:CreatePressButton(L["invert select"])
btnInvertSelect:SetSize(130, 24)
btnInvertSelect:SetPoint("LEFT", btnClearAll, "RIGHT")

btnInvertSelect:SetScript("OnClick", function(self)
	local mounts = addon.mountList[list.key]
	if not mounts then
		return
	end

	local blacklist = addon.db[list.key]
	if not blacklist then
		return
	end

	local temp = {}
	local k
	for k in pairs(blacklist) do
		temp[k] = 1
	end
	wipe(blacklist)

	local data
	for _, data in ipairs(mounts) do
		if not temp[data.id] then
			blacklist[data.id] = 1
		end
	end

	List_Update(list)
end)

SLASH_EASYMOUNT1 = "/easymount"
SLASH_EASYMOUNT2 = "/ezm"
SlashCmdList["EASYMOUNT"] = function()
	frame:Open()
end