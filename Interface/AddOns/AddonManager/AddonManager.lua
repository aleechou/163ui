--Addon Manager

local version = "10"

-- Localization
local L = AddonManagerLocale

SLASH_AM1 = L["/am"]
SLASH_AM2 = L["/addonmanager"]

-- Blizzard Addons
-- These addons are only accessable by name
local blizzard_addons = {
"Blizzard_AchievementUI",
"Blizzard_ArchaeologyUI",
"Blizzard_ArenaUI",
"Blizzard_AuctionUI",
"Blizzard_BarbershopUI",
"Blizzard_BattlefieldMinimap",
"Blizzard_BindingUI",
"Blizzard_Calendar",
"Blizzard_ClientSavedVariables",
"Blizzard_CombatLog",
"Blizzard_CombatText",
"Blizzard_CompactRaidFrames",
"Blizzard_CUFProfiles",
"Blizzard_DebugTools",
"Blizzard_EncounterJournal",
"Blizzard_GlyphUI",
"Blizzard_GMChatUI",
"Blizzard_GMSurveyUI",
"Blizzard_GuildBankUI",
"Blizzard_GuildControlUI",
"Blizzard_GuildUI",
"Blizzard_InspectUI",
"Blizzard_ItemAlterationUI",
"Blizzard_ItemSocketingUI",
"Blizzard_LookingForGuildUI",
"Blizzard_MacroUI",
"Blizzard_MovePad",
"Blizzard_RaidUI",
"Blizzard_ReforgingUI",
"Blizzard_TalentUI",
"Blizzard_TimeManager",
"Blizzard_TokenUI",
"Blizzard_TradeSkillUI",
"Blizzard_TrainerUI",
"Blizzard_VoidStorageUI"
}

local blizzard_color = {.2,.2,.6}
local memory_color = {.6,.2,.2}
local cpu_color = {.5,.5,.1}
local blizzard_color_hl = {.4,.4,.8}
local memory_color_hl = {.8,.4,.4}
local cpu_color_hl = {.7,.7,.3}

local yspacing = 20
local yoffset = -6
local firstrowy = yoffset - yspacing * 0
local secondrowy = yoffset - yspacing * 1
local thirdrowy = yoffset - yspacing * 2
local addonrowy = yoffset - yspacing * 3

local anchor_leftx = 6

local addonsvisible = 15

local garbagecollectiontime = 0
local cpuUsed = 0
local memoryUsed = 0
local cpuStartTime = GetTime()

local addon_data = {}
local blizzard_addon_data = {}

local mainframe = CreateFrame("Frame","AddonManager", UIParent)
mainframe:SetHeight(yoffset*2 + 20*20+110)
mainframe:SetWidth(560+140)
mainframe:SetPoint("CENTER",UIParent,"CENTER")
mainframe:EnableMouse(true)
mainframe:SetToplevel(true)
mainframe:EnableMouseWheel(true)
mainframe:SetBackdrop({bgFile = "Interface\\ChatFrame\\ChatFrameBackground"})
mainframe:SetBackdropColor(0,0,0)

mainframe:SetClampedToScreen(true)
mainframe:RegisterForDrag("LeftButton")
mainframe:SetMovable(true)
mainframe:SetScript("OnDragStart",function(self)
	self:StartMoving()
end)
mainframe:SetScript("OnDragStop",function(self)
	self:StopMovingOrSizing()
end)


-- CPU Profiling Reminder

if GetCVar("scriptProfile") == "1" then
	mainframe.cpuprofilingwarning = CreateFrame("Frame",nil,UIParent)
	mainframe.cpuprofilingwarning:SetWidth(10)
	mainframe.cpuprofilingwarning:SetHeight(10)
	mainframe.cpuprofilingwarning:SetAlpha(0)
	mainframe.cpuprofilingwarning:SetPoint("CENTER",UIParent,"CENTER")
	mainframe.cpuprofilingwarning.clock = 0

	mainframe.cpuprofilingwarning.texture = mainframe.cpuprofilingwarning:CreateFontString(nil, "ARTWORK")
	mainframe.cpuprofilingwarning.texture:SetFont("Fonts\\ZYKai_T.TTF",32)
	mainframe.cpuprofilingwarning.texture:SetText(L["*  CPU Profiling Enabled  *"])
	mainframe.cpuprofilingwarning.texture:SetTextColor(1,0,0)
	mainframe.cpuprofilingwarning.texture:SetPoint("CENTER",mainframe.cpuprofilingwarning,"CENTER")

	local WaitToDisplay
	local function FadeOut(self, lapse)
		self.clock = self.clock + lapse
		self:SetAlpha((3-self.clock)/3)
		if self.clock > 3 then
			self.clock = 0
			self:SetScript("OnUpdate",WaitToDisplay)
		end
	end
	local function FadeIn(self, lapse)
		self.clock = self.clock + lapse
		self:SetAlpha(self.clock/3)
		if self.clock > 3 then
			self.clock = 0
			self:SetScript("OnUpdate",FadeOut)
		end
	end
	WaitToDisplay = function(self, lapse)
		self.clock = self.clock + lapse
		if self.clock > 60 then
			self.clock = 0
			self:SetScript("OnUpdate",FadeIn)
		end
	end

	mainframe.cpuprofilingwarning:SetScript("OnUpdate",WaitToDisplay)
end

--   TOP ROW

mainframe.addontext = mainframe:CreateFontString(nil, "ARTWORK")
mainframe.addontext:SetFontObject(GameFontNormalSmall)
mainframe.addontext:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx,firstrowy)
mainframe.addontext:SetText(string.format(L["Addon Manager v%s"],version))

mainframe.addonbox = CreateFrame("CheckButton",nil, mainframe)
mainframe.addonbox:SetHeight(16)
mainframe.addonbox:SetWidth(100)
mainframe.addonbox:EnableMouse(true)
mainframe.addonbox:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx,firstrowy)
mainframe.addonbox:SetScript("OnEnter",function(self)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(self,"ANCHOR_LEFT")
	GameTooltip:AddLine(string.format(L["Addon Manager v%s"],version),1,1,1)
	GameTooltip:AddLine(L["Written by Crepusculu of Stormrage-US"],1,1,1)
	GameTooltip:AddLine(L["Find my addons listed at WoWInterface.com"],1,1,1)
	GameTooltip:Show()
end)
mainframe.addonbox:SetScript("OnLeave",function()
	GameTooltip:Hide()
end)



mainframe.pollingtext = mainframe:CreateFontString(nil, "ARTWORK")
mainframe.pollingtext:SetFontObject(GameFontNormalSmall)
mainframe.pollingtext:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx+190,firstrowy)
mainframe.pollingtext:SetText(L["Periodical Polling"])
mainframe.pollingtext:SetTextColor(1,0,0)

mainframe.pollingbox = CreateFrame("CheckButton",nil, mainframe)
mainframe.pollingbox:SetHeight(16)
mainframe.pollingbox:SetWidth(16)
mainframe.pollingbox:SetChecked(true)
mainframe.pollingbox:SetCheckedTexture("Interface\\AddOns\\AddonManager\\images\\checkmark.tga")
mainframe.pollingbox:GetCheckedTexture():SetBlendMode("BLEND")
mainframe.pollingbox:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\checkbox.tga")
mainframe.pollingbox:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx+170,firstrowy)
mainframe.pollingbox:SetScript("OnClick",function(self)
	if AddonManagerSaved.poll then
		self:GetParent().pollingtext:SetTextColor(1,0,0)
		AddonManagerSaved.poll = false
	else
		self:GetParent().pollingtext:SetTextColor(0,1,0)
		AddonManagerSaved.poll = true
	end
	mainframe.pollingSet(AddonManagerSaved.poll)
end)

local pollingUpdater = CreateFrame("Frame")
pollingUpdater.nextpoll = 0

mainframe.pollingSet = function(state)
	if state then
		pollingUpdater.nextpoll = GetTime() + 1
		pollingUpdater:SetScript("OnUpdate",function(self, elapsed)
			if GetTime() >= self.nextpoll then
				self.nextpoll = self.nextpoll + 1
				mainframe.updateAddonUsage()
			end
		end)
	else
		pollingUpdater:SetScript("OnUpdate",nil)
		pollingUpdater.nextpoll = 0
	end
end

mainframe.updatebutton = CreateFrame("Button",nil, mainframe)
mainframe.updatebutton:SetHeight(16)
mainframe.updatebutton:SetWidth(120)
mainframe.updatebutton.texture = mainframe.updatebutton:CreateTexture(nil,"OVERLAY")
mainframe.updatebutton.texture:SetHeight(20)
mainframe.updatebutton.texture:SetWidth(20)
mainframe.updatebutton.texture:SetTexture("Interface\\AddOns\\AddonManager\\images\\update.tga")
mainframe.updatebutton.texture:SetPoint("LEFT",mainframe.updatebutton,"LEFT",-4,0)
mainframe.updatebutton.text = mainframe.updatebutton:CreateFontString()
mainframe.updatebutton.text:SetAllPoints(mainframe.updatebutton)
mainframe.updatebutton.text:SetFont("Fonts\\ZYKai_T.TTF",16,"OUTLINE")
mainframe.updatebutton.text:SetText(L["Update"])
mainframe.updatebutton.text:SetTextColor(1,1,.4)
mainframe.updatebutton:SetPoint("TOPRIGHT",mainframe,"TOPRIGHT",-anchor_leftx-190,firstrowy)

mainframe.reloaduibutton = CreateFrame("Button",nil, mainframe)
mainframe.reloaduibutton:SetHeight(16)
mainframe.reloaduibutton:SetWidth(120)
mainframe.reloaduibutton.texture = mainframe.reloaduibutton:CreateTexture(nil,"OVERLAY")
mainframe.reloaduibutton.texture:SetHeight(20)
mainframe.reloaduibutton.texture:SetWidth(20)
mainframe.reloaduibutton.texture:SetTexture("Interface\\AddOns\\AddonManager\\images\\reload.tga")
mainframe.reloaduibutton.texture:SetPoint("LEFT",mainframe.reloaduibutton,"LEFT",-4,0)
mainframe.reloaduibutton.text = mainframe.reloaduibutton:CreateFontString()
mainframe.reloaduibutton.text:SetAllPoints(mainframe.reloaduibutton)
mainframe.reloaduibutton.text:SetFont("Fonts\\ZYKai_T.TTF",16,"OUTLINE")
mainframe.reloaduibutton.text:SetText(L["Reload UI"])
mainframe.reloaduibutton.text:SetTextColor(.4,1,.4)
mainframe.reloaduibutton:SetPoint("TOPRIGHT",mainframe,"TOPRIGHT",-anchor_leftx-60,firstrowy)
mainframe.reloaduibutton:SetScript("OnClick",ReloadUI)

mainframe.exitbutton = CreateFrame("Button",nil, mainframe)
mainframe.exitbutton:SetHeight(16)
mainframe.exitbutton:SetWidth(58)
mainframe.exitbutton.texture = mainframe.exitbutton:CreateTexture(nil,"OVERLAY")
mainframe.exitbutton.texture:SetHeight(20)
mainframe.exitbutton.texture:SetWidth(20)
mainframe.exitbutton.texture:SetTexture("Interface\\AddOns\\AddonManager\\images\\close.tga")
mainframe.exitbutton.texture:SetPoint("RIGHT",mainframe.exitbutton,"RIGHT",4,0)
mainframe.exitbutton.text = mainframe.exitbutton:CreateFontString()
mainframe.exitbutton.text:SetAllPoints(mainframe.exitbutton)
mainframe.exitbutton.text:SetFont("Fonts\\ZYKai_T.TTF",16,"OUTLINE")
mainframe.exitbutton.text:SetText(L["Exit"])
mainframe.exitbutton.text:SetTextColor(1,.4,.4)
mainframe.exitbutton:SetPoint("TOPRIGHT",mainframe,"TOPRIGHT",-anchor_leftx,firstrowy)
mainframe.exitbutton:SetScript("OnClick",function(self)
	self:GetParent():Hide()
end)


-- Table creation and updating functions

local function createcheckbox(parent)
	local box = CreateFrame("Button",nil, parent)
	box:SetHeight(16)
	box:SetWidth(16)
	box.state = 0
	box:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\checkbox.tga")
	return box
end
local function updatecheckbox(parent,data)
	if data == 0 then
		parent:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\checkbox.tga")
	end
	if data == 1 then
		parent:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\checkmark.tga")
	end
	if data == 2 then
		parent:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\greenplus.tga")
	end
	if data == 3 then
		parent:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\redslash.tga")
	end
end
local function onclickcheckbox(parent,dataindex)
	addon_data[dataindex].enabled = math.fmod(addon_data[dataindex].enabled + 2,4)
	if addon_data[dataindex].enabled == 1 or addon_data[dataindex].enabled == 2 then
		EnableAddOn(addon_data[dataindex].addonref)
	else
		DisableAddOn(addon_data[dataindex].addonref)
	end
	updatecheckbox(parent,addon_data[dataindex].enabled)
end

local function createLOD(parent)
	local box = CreateFrame("Button",nil, parent)
	box.text = box:CreateFontString()
	box.text:SetAllPoints(box)
	box.text:SetFontObject(GameFontNormalSmall)
	return box
end
local function updateLOD(parent,data)
	parent.text:SetText(data)
end
local function loadedAddon(id)
	if IsAddOnLoaded(id) then
		for k,v in pairs(addon_data) do
			if v.name == id then
				v.status = L["Loaded"]
				return
			end
		end
		for k,v in pairs(blizzard_addon_data) do
			if v.name == id then
				v.status = L["Loaded"]
				return
			end
		end
	end
end
local function onclickBlizLOD(parent,dataindex)
	if IsAddOnLoadOnDemand(blizzard_addon_data[dataindex].addonref) then
		print("Loading Addon - "..blizzard_addon_data[dataindex].addonref)
		LoadAddOn(blizzard_addon_data[dataindex].addonref)
		updateLOD(parent,blizzard_addon_data[dataindex].status)
	end
end
local function onclickLOD(parent,dataindex)
	if IsAddOnLoadOnDemand(addon_data[dataindex].addonref) then
		print("Loading Addon - "..addon_data[dataindex].addonref)
		LoadAddOn(addon_data[dataindex].addonref)
		updateLOD(parent,addon_data[dataindex].status)
	end
end

local function addondependenciestooltipshow(parent,dataindex)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(parent,"ANCHOR_BOTTOMRIGHT")
	if #(addon_data[dataindex].deps) > 0 then
		GameTooltip:AddLine(L["Dependencies:"],1,1,0)
		for k,v in pairs(addon_data[dataindex].deps) do
			if IsAddOnLoaded(v) then
				GameTooltip:AddLine(v,0,1,0)
			else
				GameTooltip:AddLine(v,1,0,0)
			end
		end
	else
		GameTooltip:AddLine(L["No Dependencies"],1,1,0)
	end
	GameTooltip:Show()
end
local function hideaddontooltip(parent,dataindex)
	GameTooltip:Hide()
end
local function addondescriptiontooltipshow(parent,dataindex)
	GameTooltip:ClearLines()
	GameTooltip:SetOwner(parent,"ANCHOR_BOTTOMRIGHT")
	GameTooltip:AddLine(addon_data[dataindex].title,1,1,0)
	GameTooltip:AddLine(addon_data[dataindex].notes,1,1,1,true)
	GameTooltip:Show()
end

local function twopointprecision(parent,data)
	parent:SetFontObject(GameFontNormalSmall)
	parent:SetText(string.format("%.2f",data or 0))
end


mainframe.tabber = CTab:Create(mainframe)
mainframe.tabber:SetHeight(20)
mainframe.tabber:SetWidth(300)
mainframe.tabber:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx,secondrowy)


--  BLIZZARD TAB

mainframe.blizzardtab = CreateFrame("Frame",nil,mainframe)
mainframe.blizzardtab:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx,thirdrowy)
mainframe.blizzardtab:SetPoint("BOTTOMRIGHT",mainframe,"BOTTOMRIGHT",-anchor_leftx,-yoffset)
mainframe.blizzardtab:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8.blp",tile=false})
mainframe.blizzardtab:SetBackdropColor(blizzard_color[1],blizzard_color[2],blizzard_color[3])

local addontableheader3 = {}
addontableheader3[1] = CTableHeader:Create(L["Addon"], "name", 200, nil, nil, nil, nil, nil)
addontableheader3[2] = CTableHeader:Create(L["Status"], "status", 100, updateLOD, createLOD, onclickBlizLOD, nil, nil)
addontableheader3[3] = CTableHeader:Create(L["Notes"], "notes", 370, nil, nil, nil,nil,nil)

mainframe.blizzardtable = CTable:Create(mainframe.blizzardtab, addontableheader3, nil, blizzard_addon_data, blizzard_color)
mainframe.blizzardtable:SetPoint("TOPLEFT",mainframe.blizzardtab,"TOPLEFT",0,-yspacing)
mainframe.blizzardtable:UpdateView()

mainframe.tabber:AddTab("Blizzard",mainframe.blizzardtab, blizzard_color)



--  MEMORY TAB

mainframe.memorytab = CreateFrame("Frame",nil,mainframe)
mainframe.memorytab:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx,thirdrowy)
mainframe.memorytab:SetPoint("BOTTOMRIGHT",mainframe,"BOTTOMRIGHT",-anchor_leftx,-yoffset)
mainframe.memorytab:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8.blp",tile=false})
mainframe.memorytab:SetBackdropColor(memory_color[1],memory_color[2],memory_color[3])


mainframe.memorytext = mainframe.memorytab:CreateFontString(nil, "ARTWORK")
mainframe.memorytext:SetFontObject(GameFontNormalSmall)
mainframe.memorytext:SetPoint("TOPLEFT",mainframe.memorytab,"TOPLEFT",0,-4)
mainframe.memorytext:SetText(L["Addon Memory Consumption"])
mainframe.memorytext:SetTextColor(1,1,1)
mainframe.memorytext2 = mainframe.memorytab:CreateFontString(nil, "ARTWORK")
mainframe.memorytext2:SetFontObject(GameFontNormalSmall)
mainframe.memorytext2:SetPoint("LEFT",mainframe.memorytext,"RIGHT",4,0)
mainframe.memorytext2:SetText("")
mainframe.memorytext2:SetTextColor(1,1,1)

mainframe.lastcollectiontext = mainframe.memorytab:CreateFontString(nil, "ARTWORK")
mainframe.lastcollectiontext:SetFontObject(GameFontNormalSmall)
mainframe.lastcollectiontext:SetPoint("TOP",mainframe.memorytab,"TOP",4,-4)
mainframe.lastcollectiontext:SetText(L["Last Collection"])
mainframe.lastcollectiontext:SetTextColor(1,1,1)
mainframe.lastcollectiontext2 = mainframe.memorytab:CreateFontString(nil, "ARTWORK")
mainframe.lastcollectiontext2:SetFontObject(GameFontNormalSmall)
mainframe.lastcollectiontext2:SetPoint("LEFT",mainframe.lastcollectiontext,"RIGHT",4,0)
mainframe.lastcollectiontext2:SetText(L["-nil-"])
mainframe.lastcollectiontext2:SetTextColor(1,1,1)

mainframe.cleargarbagebutton = CreateFrame("Button",nil, mainframe.memorytab)
mainframe.cleargarbagebutton:SetHeight(16)
mainframe.cleargarbagebutton:SetWidth(140)
mainframe.cleargarbagebutton.texture = mainframe.cleargarbagebutton:CreateTexture(nil,"BACKGROUND")
mainframe.cleargarbagebutton.texture:SetTexture("Interface/Buttons/WHITE8X8.blp")
mainframe.cleargarbagebutton.texture:SetGradientAlpha("HORIZONTAL",0,0,0,1,0,0,0,0)
mainframe.cleargarbagebutton.texture:SetAllPoints()
mainframe.cleargarbagebutton.texture2 = mainframe.cleargarbagebutton:CreateTexture(nil,"ARTWORK")
mainframe.cleargarbagebutton.texture2:SetHeight(20)
mainframe.cleargarbagebutton.texture2:SetWidth(20)
mainframe.cleargarbagebutton.texture2:SetTexture("Interface\\AddOns\\AddonManager\\images\\recycle.tga")
mainframe.cleargarbagebutton.texture2:SetPoint("LEFT",mainframe.cleargarbagebutton,"LEFT",-4,0)
mainframe.cleargarbagebutton.text = mainframe.cleargarbagebutton:CreateFontString(nil,"OVERLAY")
mainframe.cleargarbagebutton.text:SetAllPoints(mainframe.cleargarbagebutton)
mainframe.cleargarbagebutton.text:SetFont("Fonts\\ZYKai_T.TTF",16,"OUTLINE")
mainframe.cleargarbagebutton.text:SetText(L["Collect Garbage"])
mainframe.cleargarbagebutton.text:SetTextColor(.4,.4,1)
mainframe.cleargarbagebutton:SetPoint("TOPRIGHT",mainframe.memorytab,"TOPRIGHT",-anchor_leftx,-4)

local addontableheader = {}
addontableheader[1] = CTableHeader:Create("", "enabled", 20,  updatecheckbox, createcheckbox, onclickcheckbox,nil,nil)
addontableheader[2] = CTableHeader:Create(L["Addon"], "name", 150, updateLOD, createLOD, nil, addondescriptiontooltipshow, hideaddontooltip)
addontableheader[3] = CTableHeader:Create(L["Status"], "status", 125, updateLOD, createLOD, onclickLOD, addondependenciestooltipshow, hideaddontooltip)
addontableheader[4] = CTableHeader:Create(L["Active"], "activeMemory", 75, twopointprecision, nil, nil,nil,nil)
addontableheader[5] = CTableHeader:Create(L["Current"], "currentMemory", 100, twopointprecision, nil, nil,nil,nil)
addontableheader[6] = CTableHeader:Create(L["Max"], "maxMemory", 100, twopointprecision, nil, nil,nil,nil)
addontableheader[7] = CTableHeader:Create(L["Cummulative"], "totalMemory", 100, twopointprecision, nil, nil,nil,nil)

mainframe.memorytable = CTable:Create(mainframe.memorytab, addontableheader, nil, addon_data, memory_color)
mainframe.memorytable:SetPoint("TOPLEFT",mainframe.memorytab,"TOPLEFT",0,-yspacing)
mainframe.memorytable:UpdateView()

mainframe.tabber:AddTab("Memory",mainframe.memorytab, memory_color)


--  CPU TAB

mainframe.cputab = CreateFrame("Frame",nil,mainframe)
mainframe.cputab:SetPoint("TOPLEFT",mainframe,"TOPLEFT",anchor_leftx,thirdrowy)
mainframe.cputab:SetPoint("BOTTOMRIGHT",mainframe,"BOTTOMRIGHT",-anchor_leftx,-yoffset)
mainframe.cputab:SetBackdrop({bgFile="Interface/Buttons/WHITE8X8.blp",tile=false})
mainframe.cputab:SetBackdropColor(cpu_color[1],cpu_color[2],cpu_color[3])

mainframe.cpuprofilingbox = CreateFrame("CheckButton",nil, mainframe.cputab)
mainframe.cpuprofilingbox:SetHeight(16)
mainframe.cpuprofilingbox:SetWidth(16)
mainframe.cpuprofilingbox:SetChecked(true)
mainframe.cpuprofilingbox:SetCheckedTexture("Interface\\AddOns\\AddonManager\\images\\checkmark.tga")
mainframe.cpuprofilingbox:GetCheckedTexture():SetBlendMode("BLEND")
mainframe.cpuprofilingbox:SetNormalTexture("Interface\\AddOns\\AddonManager\\images\\checkbox.tga")
mainframe.cpuprofilingbox:SetPoint("TOPLEFT",mainframe.cputab,"TOPLEFT",anchor_leftx,-4)
mainframe.cpuprofilingbox:SetScript("OnClick",function()
	if GetCVar("scriptProfile") == "0" then
		SetCVar("scriptProfile", "1")
	else
		SetCVar("scriptProfile", "0")
	end
end)
mainframe.cpuprofilingtext = mainframe.cputab:CreateFontString(nil, "ARTWORK")
mainframe.cpuprofilingtext:SetFontObject(GameFontNormalSmall)
mainframe.cpuprofilingtext:SetPoint("LEFT",mainframe.cpuprofilingbox,"RIGHT",anchor_leftx,0)
mainframe.cpuprofilingtext:SetText(L["CPU Profiling"])
mainframe.cpuprofilingtext:SetTextColor(1,0,0)

mainframe.cpustarttext = mainframe.cputab:CreateFontString(nil, "ARTWORK")
mainframe.cpustarttext:SetFontObject(GameFontNormalSmall)
mainframe.cpustarttext:SetPoint("TOP",mainframe.cputab,"TOP",0,-4)
mainframe.cpustarttext:SetText(L["CPU Start"])
mainframe.cpustarttext:SetTextColor(1,1,1)
mainframe.cpustarttext2 = mainframe.cputab:CreateFontString(nil, "ARTWORK")
mainframe.cpustarttext2:SetFontObject(GameFontNormalSmall)
mainframe.cpustarttext2:SetPoint("LEFT",mainframe.cpustarttext,"RIGHT",4,0)
mainframe.cpustarttext2:SetText(L["-nil-"])
mainframe.cpustarttext2:SetTextColor(1,1,1)

mainframe.resetcpubutton = CreateFrame("Button",nil, mainframe.cputab)
mainframe.resetcpubutton:SetHeight(16)
mainframe.resetcpubutton:SetWidth(120)
mainframe.resetcpubutton.texture = mainframe.resetcpubutton:CreateTexture(nil,"BACKGROUND")
mainframe.resetcpubutton.texture:SetTexture("Interface/Buttons/WHITE8X8.blp")
mainframe.resetcpubutton.texture:SetGradientAlpha("HORIZONTAL",0,0,0,1,0,0,0,0)
mainframe.resetcpubutton.texture:SetAllPoints()
mainframe.resetcpubutton.texture2 = mainframe.resetcpubutton:CreateTexture(nil,"ARTWORK")
mainframe.resetcpubutton.texture2:SetHeight(20)
mainframe.resetcpubutton.texture2:SetWidth(20)
mainframe.resetcpubutton.texture2:SetTexture("Interface\\AddOns\\AddonManager\\images\\reset.tga")
mainframe.resetcpubutton.texture2:SetPoint("LEFT",mainframe.resetcpubutton,"LEFT",-4,0)
mainframe.resetcpubutton.text = mainframe.resetcpubutton:CreateFontString(nil,"OVERLAY")
mainframe.resetcpubutton.text:SetAllPoints(mainframe.resetcpubutton)
mainframe.resetcpubutton.text:SetFont("Fonts\\ZYKai_T.TTF",16,"OUTLINE")
mainframe.resetcpubutton.text:SetText(L["Reset CPU"])
mainframe.resetcpubutton.text:SetTextColor(1,1,.4)
mainframe.resetcpubutton:SetPoint("TOPRIGHT",mainframe.cputab,"TOPRIGHT",-anchor_leftx,-4)

local addontableheader2 = {}
addontableheader2[1] = CTableHeader:Create("", "enabled", 20,  updatecheckbox, createcheckbox, onclickcheckbox,nil,nil)
addontableheader2[2] = CTableHeader:Create(L["Addon"], "name", 150, updateLOD, createLOD, nil, addondescriptiontooltipshow, hideaddontooltip)
addontableheader2[3] = CTableHeader:Create(L["Status"], "status", 125, updateLOD, createLOD, onclickLOD, addondependenciestooltipshow, hideaddontooltip)
addontableheader2[4] = CTableHeader:Create(L["Current"], "activeCPU", 75, twopointprecision, nil, nil,nil,nil)
addontableheader2[5] = CTableHeader:Create(L["Peak"], "spikeCPU", 100, twopointprecision, nil, nil,nil,nil)
addontableheader2[6] = CTableHeader:Create(L["Total"], "totalCPU", 100, twopointprecision, nil, nil,nil,nil)

mainframe.cputable = CTable:Create(mainframe.cputab, addontableheader2, nil, addon_data, cpu_color)
mainframe.cputable:SetPoint("TOPLEFT",mainframe.cputab,"TOPLEFT",0,-yspacing)
mainframe.cputable:UpdateView()

mainframe.tabber:AddTab("CPU",mainframe.cputab, cpu_color)

mainframe.tabber:ActivateTab(2)  -- Show memory tab by default



-- Nonfuntional resize
-- Need ability to resize visible table rows
-- optional horizontal scrolling
-- optional cell fractional positioning

local StartResizeUI = function(self)
	mainframe:StartSizing("TOPLEFT")
end
local StopResizeUI = function(self)
	mainframe:StopMovingOrSizing()
end
mainframe.resizer = CreateFrame("Frame",nil, mainframe)
mainframe.resizer:SetHeight(16)
mainframe.resizer:SetWidth(16)
mainframe.resizer:EnableMouse(true)
mainframe.resizer:SetPoint("BOTTOMRIGHT",mainframe,"BOTTOMRIGHT")
mainframe.resizer:SetScript("OnDragStart",StartResizeUI)
mainframe.resizer:SetScript("OnDragStop",StopResizeUI)
mainframe.resizer.texture = mainframe.resizer:CreateTexture(nil,"OVERLAY")
mainframe.resizer.texture:SetHeight(16)
mainframe.resizer.texture:SetWidth(16)
mainframe.resizer.texture:SetTexture("Interface\\AddOns\\AddonManager\\images\\resize.tga")
mainframe.resizer.texture:SetAllPoints(mainframe.resizer)


-- ResetCPUUsage Hook
local oldResetCPUUsage = ResetCPUUsage
ResetCPUUsage = function()
	oldResetCPUUsage()
	cpuStartTime = GetTime()

	-- reset spike data
	for i=1,GetNumAddOns() do
		if addon_data[i] then
			addon_data[i].spikeCPU = 0
		end
	end
end

local function LoadAddonHook(identifier)
	loadedAddon(identifier)
end
hooksecurefunc("LoadAddOn",LoadAddonHook)

-- collectgarbage Hook
local oldcollectgarbage = collectgarbage
collectgarbage = function(parameter)
	if parameter == "collect" then
		garbagecollectiontime = GetTime()
	end
	return oldcollectgarbage(parameter)
end

mainframe.AddAddon = function(reference)
	-- new addon, woo!
	local i = #addon_data + 1

	local addon = {}
	addon.addonref = reference
	addon.name,
	addon.title,
	addon.notes,
	addon.enabled,
	addon.loadable,
	addon.reason,
	addon.security = GetAddOnInfo(reference)
	addon.loaded = IsAddOnLoaded(reference)
	addon.loadDemand = IsAddOnLoadOnDemand(reference)
	addon.deps = {GetAddOnDependencies(reference)}

	if addon.enabled == nil then
		addon.enabled = 0
	end

	addon.totalCPU = GetAddOnCPUUsage(reference) or 0
	addon.activeCPU = addon.totalCPU
	addon.spikeCPU = 0

	addon.totalMemory = GetAddOnMemoryUsage(reference)
	addon.currentMemory = addon.totalMemory
	addon.activeMemory = 0
	addon.minMemory = addon.totalMemory
	addon.maxMemory = addon.totalMemory

	addon.loaded = IsAddOnLoaded(addon.addonref)
	if addon.loaded then
		addon.status = L["Loaded"]
	elseif addon.loadable and addon.loaded == nil then
		addon.status = L["Click to Load"]
	else
		addon.status = _G["ADDON_"..(addon.reason or "")]
		addon.status = string.gsub(addon.status or "", "endency", ".")
		addon.status = string.gsub(addon.status or "", "loadable on demand", "LOD")
	end

	addon_data[i] = addon

	cpuUsed = cpuUsed + addon_data[i].totalCPU
	memoryUsed = memoryUsed + addon_data[i].currentMemory
end

mainframe.AddBlizzardAddon = function(reference)
	local i = #blizzard_addon_data + 1

	local addon = {}
	addon.addonref = reference
	addon.name,
	addon.title,
	addon.notes,
	addon.enabled,
	addon.loadable,
	addon.reason,
	addon.security = GetAddOnInfo(reference)
	addon.loaded = IsAddOnLoaded(reference)
	addon.loadDemand = IsAddOnLoadOnDemand(reference)
	addon.deps = {GetAddOnDependencies(reference)}

	if addon.enabled == nil then
		addon.enabled = 0
	end

	addon.loaded = IsAddOnLoaded(addon.addonref)
	if addon.loaded then
		addon.status = L["Loaded"]
	elseif addon.loadable and addon.loaded == nil then
		addon.status = L["Click to Load"]
	else
		addon.status = _G["ADDON_"..(addon.reason or "")]
	end
	blizzard_addon_data[i] = addon
end

-- Initialize addon data table
mainframe.InitializeAddons = function()

	if not AddonManagerSaved then
		AddonManagerSaved = {}
		AddonManagerSaved.poll = false
	end
	if AddonManagerSaved.poll then
		mainframe.pollingbox:SetChecked(true)
		mainframe.pollingtext:SetTextColor(0,1,0)
	else
		mainframe.pollingbox:SetChecked(false)
		mainframe.pollingtext:SetTextColor(1,0,0)
	end
	mainframe.pollingSet(AddonManagerSaved.poll)

	ResetCPUUsage()
	UpdateAddOnCPUUsage()
	UpdateAddOnMemoryUsage()

	-- User addons
	for i=1,GetNumAddOns() do
		mainframe.AddAddon(i)
	end
	-- Blizzard addons
	for i=1,#blizzard_addons do
		mainframe.AddBlizzardAddon(blizzard_addons[i])
	end

	-- Update our table!
	mainframe.memorytable:UpdateView()
	mainframe.cputable:UpdateView()
	mainframe.blizzardtable:UpdateView()
end

do
	-- temporary variable used in update function
	local cur_memory_usage, cpu_usage, k, cur_addon
	local GetAddOnMemoryUsage = GetAddOnMemoryUsage
	local GetAddOnCPUUsage = GetAddOnCPUUsage
	local UpdateAddOnCPUUsage = UpdateAddOnCPUUsage
	local UpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage
	mainframe.updateAddonUsage = function()
		UpdateAddOnCPUUsage()
		UpdateAddOnMemoryUsage()
		cpuUsed = 0
		memoryUsed = 0
		for i=1,GetNumAddOns() do

			cur_addon = addon_data[i]
			k = cur_addon.addonref
			cur_memory_usage = GetAddOnMemoryUsage(k)
			cpu_usage = GetAddOnCPUUsage(k)
			cur_addon.activeCPU = cpu_usage - cur_addon.totalCPU
			cur_addon.totalCPU = cpu_usage or 0
			cur_addon.spikeCPU = math.max(cur_addon.spikeCPU, cur_addon.activeCPU)
			cur_addon.activeMemory = cur_memory_usage - cur_addon.currentMemory
			if cur_addon.activeMemory > 0 then
				cur_addon.totalMemory = cur_addon.totalMemory + cur_addon.activeMemory
			end
			if cur_memory_usage > cur_addon.maxMemory then
				cur_addon.maxMemory = cur_memory_usage
			end
			if cur_memory_usage < cur_addon.minMemory then
				cur_addon.minMemory = cur_memory_usage
			end
			cur_addon.currentMemory = cur_memory_usage

			cpuUsed = cpuUsed + cur_addon.totalCPU
			memoryUsed = memoryUsed + cur_addon.currentMemory
		end
		if mainframe.memorytable:IsVisible() then  -- only update table when it is visible
			mainframe.memorytable:SortByColumn()
			mainframe.memorytable:UpdateView()
			mainframe.memorytext2:SetText(string.format(" %.1f MB",memoryUsed/1000))
			if garbagecollectiontime ~= 0 then
				mainframe.lastcollectiontext2:SetText(string.format("%.0f min ago",(GetTime() - garbagecollectiontime)/60))
			end
		end
		if mainframe.cputable:IsVisible() then  -- only update table when it is visible
			mainframe.cputable:SortByColumn() -- both memory and cpu sort the same table, probably need to move out of table class
			mainframe.cputable:UpdateView()
			if cpuUsed > 0 then
				mainframe.cpustarttext2:SetText(string.format("%.0f min ago",(GetTime() - cpuStartTime)/60))
			end
		end

		mainframe.tabber:UpdateTab(1,string.format(" %.1f MB",(collectgarbage("count")-memoryUsed)/1000))
		mainframe.tabber:UpdateTab(2,string.format(" %.1f MB",memoryUsed/1000))
		mainframe.tabber:UpdateTab(3,string.format(" %.0f",cpuUsed))
	end
end

mainframe:SetScript("OnShow",mainframe.updateAddonUsage)

local name, title, notes, enabled, loadable, reason, security, dependencies
mainframe:RegisterEvent("PLAYER_LOGIN")

mainframe:SetScript("OnEvent",function(self,event)
	if event == "PLAYER_LOGIN" then
		mainframe.InitializeAddons()
		self.cpuprofilingbox:SetChecked(true)
		self.cpuprofilingtext:SetTextColor(0,1,0)
		if GetCVar("scriptProfile") == "0" then
			self.cpuprofilingbox:SetChecked(false)
			self.cpuprofilingtext:SetTextColor(1,0,0)
		end
	end
end)

mainframe.cleargarbagebutton:SetScript("OnClick",function()
	collectgarbage("collect")
	mainframe.updateAddonUsage()
end)

mainframe.resetcpubutton:SetScript("OnClick",function()
	ResetCPUUsage()
	mainframe.updateAddonUsage()
end)

mainframe.updatebutton:SetScript("OnClick",function()
	mainframe.updateAddonUsage()
end)

mainframe:SetScript("OnMouseWheel",function(self,arg)
	if mainframe.memorytable:IsVisible() then
		mainframe.memorytable:ScrollByUnit(-arg)
	elseif mainframe.cputable:IsVisible() then
		mainframe.cputable:ScrollByUnit(-arg)
	elseif mainframe.blizzardtable:IsVisible() then
		mainframe.blizzardtable:ScrollByUnit(-arg)
	end
end)

mainframe:Hide()
SlashCmdList["AM"] = function()
	mainframe:Show()
end
