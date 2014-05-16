-- $Id: DefaultFrame.lua 4248 2013-09-10 09:29:27Z lag123 $
--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)
]]
local AtlasLoot = LibStub("AceAddon-3.0"):GetAddon("AtlasLoot")

local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

--local _ = nil
local MODULENAME = "DefaultFrame"
local DefaultFrame = AtlasLoot:NewModule(MODULENAME)

local frameName = "AtlasLootDefaultFrame"
local imagePath = AtlasLoot.imagePath.."AtlasImages\\"
local scrollNumLines, scrollCurLines, curInstance = 24, 0, {}
local curBoss = nil
local instances = {}

--[[
	1 = Atlas
	2 = AtlasLoot old
]]--
local DEFAULTFRAME_STYLE_NUM_DUMMY = 1

local db
local dbDefaults = {
	profile = {
		DefaultFrameLocked = false,
		module = "AtlasLootCataclysm",
		instance = "BlackrockCaverns",
		point = nil,
		NEWpoint = {"CENTER"}
	},
}

local getOptions
do
	local options
	function getOptions()
		if not options then
			options = {
				type = "group",
				name = MODULENAME,
				order = 600,
				childGroups = "tab",
				args = {
					toggle = {
						type = "toggle",
						name = AL["Enable"],
						get = function()
							return AtlasLoot:GetModuleEnabled(MODULENAME)
						end,
						set = function(info, v)
							AtlasLoot:SetModuleEnabled(MODULENAME, v)
						end,
						order = 10,
					},
					nllockb = {
						type = "description",
						name = "",
						order = 20,
					},

				},
			}
		
		end
		return options
	end
	
end
	

function DefaultFrame:OnInitialize()
	if not AtlasLoot.db then AtlasLoot:OnLoaderLoad() end
	self.db = AtlasLoot.db:RegisterNamespace(MODULENAME, dbDefaults)
	db = self.db.profile
	
	self:CreateDefaultFrame()
	--self:Helper()
	self:CreateInstanceTab()
	self.Frame:SetPoint(unpack(db.NEWpoint))
	tinsert(UISpecialFrames, frameName)
	--AtlasLoot:RegisterModuleOptions(MODULENAME, getOptions, MODULENAME)
	AtlasLoot:RegisterPFrame(frameName, { "TOPLEFT", frameName, "TOPLEFT", "18", "-84" })
	AtlasLoot:AddResetCommand(DefaultFrame.ResetCom, "DefaultFrame", "frames")
	--DefaultFrame:SetInstanceTable()
	-- Call this later or it conflict with blizzard raids frames?
	--DefaultFrame:DropDownRefresh()
	AtlasLoot.ShowFrame_MiniMap = DefaultFrame.MiniMap_OnClick_Replace
	AtlasLoot:DefaultFrame_RefreshScale()
end

function DefaultFrame:OnEnable()

end

function DefaultFrame:OnDisable()

end

function DefaultFrame:ResetCom()
	DefaultFrame.Frame:SetPoint("CENTER", UIParent, "CENTER")
end

-- FRAME
do

	local function onDragStart(self, arg1)
		if arg1 == "LeftButton" then
			if not db.DefaultFrameLocked then
				self:StartMoving()
			end
		end
	end
	
	local function onDragStop(self)
		self:StopMovingOrSizing()
		local a,b,c,d,e = self:GetPoint()
		db.NEWpoint = { a, nil, c, d, e }
	end
	
	local function setFrameLvl(self)
		self:SetFrameLevel( self:GetParent():GetFrameLevel() + 1 )
		--self:SetToplevel(true)
	end

	local function updateLock()
		if(db.DefaultFrameLocked) then
			DefaultFrame.Frame.LockButton.NormalTexture:SetTexture(imagePath.."LockButton-Locked-Up")
			DefaultFrame.Frame.LockButton.PushedTexture:SetTexture(imagePath.."LockButton-Locked-Down")
		else
			DefaultFrame.Frame.LockButton.NormalTexture:SetTexture(imagePath.."LockButton-Unlocked-Up")
			DefaultFrame.Frame.LockButton.PushedTexture:SetTexture(imagePath.."LockButton-Unlocked-Down")
		end
	end

	local function toggleLock()
		if(db.DefaultFrameLocked) then
			db.DefaultFrameLocked = false
			updateLock()
		else
			db.DefaultFrameLocked = true
			updateLock()
		end
	end

	local function scrollBarUpdate()
		local line, lineplusoffset
		FauxScrollFrame_Update(DefaultFrame.Frame.ScrollFrame, scrollCurLines, scrollNumLines, 15)
		for line=1,scrollNumLines do
			lineplusoffset = line + FauxScrollFrame_GetOffset(DefaultFrame.Frame.ScrollFrame)
			if ( lineplusoffset <= scrollCurLines ) then
				DefaultFrame.Frame.ScrollFrame.Buttons[line]:SetText(curInstance[lineplusoffset])
				DefaultFrame.Frame.ScrollFrame.Buttons[line]:Show()
			elseif DefaultFrame.Frame.ScrollFrame.Buttons[line] then
				DefaultFrame.Frame.ScrollFrame.Buttons[line]:Hide()
			end
		end
	end

	local function onVerticalScroll()
		FauxScrollFrame_OnVerticalScroll(self, offset, 15, scrollBarUpdate); 
	end
	
	local DropDownRefresh = false
	local function onShow()
		AtlasLoot.AtlasLootPanel:SetParent(_G[frameName])
		AtlasLoot.AtlasLootPanel:SetPoint("TOP", frameName, "BOTTOM", 0, 9)
		AtlasLoot.AtlasInfoFrame:SetParent(_G[frameName])
		AtlasLoot.AtlasInfoFrame:SetPoint("TOPLEFT", frameName, "TOPLEFT", 535, -37)
		DefaultFrame:AutoSelect()
		DefaultFrame:SetInstanceTable()
		
		if AtlasLoot.db.profile.HidePanel == true then
			AtlasLoot.AtlasLootPanel:Hide();
		else
			AtlasLoot.AtlasLootPanel:Show();
		end 
		
		AtlasLoot:DefaultFrame_RefreshScale()
		AtlasLoot:DefaultFrame_RefreshAlpha()
		
		if not DropDownRefresh then
			DefaultFrame:DropDownRefresh()
			DropDownRefresh = true
		end
		
		AtlasLoot.AtlasInfoFrame:Show()
		AtlasLootItemsFrame:Show()
	end
	
	local function onEnter()
		AtlasLoot:DefaultFrame_RefreshAlpha()
	end
	
	local function onLeave()
		AtlasLoot:DefaultFrame_RefreshAlpha(true)
	end
	
	local function onCompareFrameClick()
		if db.instance then
			if AtlasLoot.CompareFrame:IsShown() then AtlasLoot.CompareFrame:Hide() end
			AtlasLoot:CompareFrame_LoadInstance( db.instance ) 
		end 
	end

	function DefaultFrame:CreateDefaultFrame()
		if self.Frame then return end
		self.Frame = CreateFrame("Frame", frameName)
		
		local Frame = self.Frame
		Frame:ClearAllPoints()
		Frame:SetParent(UIParent)
		Frame:SetPoint(unpack(db.NEWpoint))
		--Frame:SetFrameStrata("HIGH")
		Frame:SetWidth(921)
		Frame:SetHeight(601)
		Frame:SetMovable(true)
		Frame:EnableMouse(true)
		Frame:RegisterForDrag("LeftButton")
		Frame:RegisterForDrag("LeftButton", "RightButton")
		Frame:SetScript("OnMouseDown", onDragStart)
		Frame:SetScript("OnMouseUp", onDragStop)
		Frame:SetScript("OnShow", onShow)
		--Frame:SetScript("OnEnter", onEnter)
		--Frame:SetScript("OnLeave", onLeave)
		Frame:SetToplevel(true)
		Frame:SetClampedToScreen(true)
		
		Frame.CloseButton = CreateFrame("Button", frameName.."_CloseButton", Frame, "UIPanelCloseButton")
		Frame.CloseButton:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", 5, -7)
		Frame.CloseButton:SetScript("OnShow", setFrameLvl)
		
		Frame.LockButton = CreateFrame("Button", frameName.."_LockButton",Frame,"OptionsButtonTemplate")
		Frame.LockButton:SetWidth(25)
		Frame.LockButton:SetHeight(25)
		Frame.LockButton:SetPoint("RIGHT", Frame.CloseButton, "LEFT", 5, 0)
		Frame.LockButton:SetScript("OnClick", toggleLock)
		
		Frame.LockButton.NormalTexture = Frame:CreateTexture(frameName.."_NormalTexture", "ARTWORK")
		Frame.LockButton.NormalTexture:SetPoint("TOPLEFT", Frame.LockButton, "TOPLEFT", -3, 3)	
		
		Frame.LockButton.PushedTexture = Frame:CreateTexture(frameName.."_PushedTexture", "ARTWORK")
		Frame.LockButton.PushedTexture:SetPoint("TOPLEFT", Frame.LockButton, "TOPLEFT", -3, 3)

		Frame.LockButton.HighlightTexture = Frame:CreateTexture(frameName.."_HighlightTexture", "ARTWORK")
		Frame.LockButton.HighlightTexture:SetPoint("TOPLEFT", Frame.LockButton, "TOPLEFT", -3, 3)
		Frame.LockButton.HighlightTexture:SetTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
		
		Frame.LockButton:SetNormalTexture(Frame.LockButton.NormalTexture)
		Frame.LockButton:SetPushedTexture(Frame.LockButton.PushedTexture)
		Frame.LockButton:SetHighlightTexture(Frame.LockButton.HighlightTexture, "ADD")

		updateLock()
		
		
		Frame.Layers = {}
		
		Frame.Layers[1] = Frame:CreateTexture(nil, "ARTWORK")
		Frame.Layers[1]:SetPoint("TOPLEFT", Frame, "TOPLEFT")	
		Frame.Layers[1]:SetWidth(512)
		Frame.Layers[1]:SetHeight(128)
		Frame.Layers[1]:SetTexture(imagePath.."AtlasFrame-Top")
		
		Frame.Layers[2] = Frame:CreateTexture(nil, "ARTWORK")
		Frame.Layers[2]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, -128)	
		Frame.Layers[2]:SetWidth(32)
		Frame.Layers[2]:SetHeight(256)
		Frame.Layers[2]:SetTexture(imagePath.."AtlasFrame-Left")
		
		Frame.Layers[3] = Frame:CreateTexture(nil, "ARTWORK")
		Frame.Layers[3]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 0, -384)	
		Frame.Layers[3]:SetWidth(512)
		Frame.Layers[3]:SetHeight(256)
		Frame.Layers[3]:SetTexture(imagePath.."AtlasFrame-Bottom")
		
		Frame.Layers[4] = Frame:CreateTexture(nil, "ARTWORK")
		Frame.Layers[4]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 512, -512)	
		Frame.Layers[4]:SetWidth(512)
		Frame.Layers[4]:SetHeight(128)
		Frame.Layers[4]:SetTexture(imagePath.."AtlasFrame-Bottom2")
		
		Frame.Layers[5] = Frame:CreateTexture(nil, "ARTWORK")
		Frame.Layers[5]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 512, 0)	
		Frame.Layers[5]:SetWidth(512)
		Frame.Layers[5]:SetHeight(512)
		Frame.Layers[5]:SetTexture(imagePath.."AtlasFrame-Right")
		
		Frame.Layers[6] = Frame:CreateTexture(nil, "ARTWORK")
		Frame.Layers[6]:SetPoint("TOPLEFT", Frame, "TOPLEFT", 18, -84)	
		Frame.Layers[6]:SetWidth(512)
		Frame.Layers[6]:SetHeight(512)
		Frame.Layers[6]:SetTexture(0.0, 0.0, 0.0, 1.0)
		
		Frame.Title = Frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
		Frame.Title:SetPoint("TOP", Frame, "TOP", 20, -17)
		Frame.Title:SetText(AL["AtlasLoot"])
		
		Frame.VersionNumber = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		Frame.VersionNumber:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -52, -18)
		Frame.VersionNumber:SetTextColor(0.4, 0.4, 0.4)
		Frame.VersionNumber:SetText(ATLASLOOT_VERSION_NUM.." ( FrameStyle by Atlas )")
		
		Frame.InstanceName = Frame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLarge")
		Frame.InstanceName:SetPoint("TOPLEFT", Frame, "TOPLEFT", 546, -97)
		Frame.InstanceName:SetJustifyH("LEFT")
		Frame.InstanceName:SetWidth(351)
		Frame.InstanceName:SetText("")
		
		Frame.ScrollFrame = CreateFrame("ScrollFrame", frameName.."_ScrollFrame", Frame, "FauxScrollFrameTemplate")
		Frame.ScrollFrame:SetPoint("TOPLEFT", Frame, "TOPLEFT", 530, -186)	
		Frame.ScrollFrame:SetWidth(351)
		Frame.ScrollFrame:SetHeight(367)
		Frame.ScrollFrame:SetScript("OnVerticalScroll", onVerticalScroll)
		Frame.ScrollFrame:SetScript("OnShow", scrollBarUpdate)
		
		Frame.ScrollFrame.Buttons = {}
		
		Frame.CompareFrame = CreateFrame("Button", frameName.."_CompareFrame", Frame, "UIPanelButtonTemplate")
		Frame.CompareFrame:SetWidth(200)
		Frame.CompareFrame:SetHeight(20)
		Frame.CompareFrame:SetPoint("TOPLEFT", Frame, "TOPLEFT", 545, -560)
		Frame.CompareFrame:SetText(AL["Show in Compare Frame"])
		Frame.CompareFrame:SetScript("OnClick", onCompareFrameClick)
		
		Frame.EncounterJournal = AtlasLoot:EncounterJournal_CreateButton(frameName.."_EncounterJournal", Frame)
		Frame.EncounterJournal:SetPoint("LEFT", Frame.CompareFrame, "RIGHT", 0, 0)
		Frame:Hide()
		
		Frame.ModuleSelect = CreateFrame("Frame", frameName.."_ModuleSelect", Frame, "UIDropDownMenuTemplate")
		Frame.ModuleSelect:SetPoint("TOPLEFT", Frame, "TOPLEFT", 60, -50)
		Frame.ModuleSelect.info = {}
		
		Frame.ModuleSelect.Text = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		Frame.ModuleSelect.Text:SetPoint("BOTTOMLEFT", Frame.ModuleSelect, "TOPLEFT", 21, 0)
		Frame.ModuleSelect.Text:SetText(AL["Select Module"])
		

		Frame.InstanceSelect = CreateFrame("Frame", frameName.."_InstanceSelect", Frame, "UIDropDownMenuTemplate")
		Frame.InstanceSelect:SetPoint("LEFT", Frame.ModuleSelect, "RIGHT", 0, 0)
		Frame.InstanceSelect.info = {}
		
		Frame.InstanceSelect.Text = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
		Frame.InstanceSelect.Text:SetPoint("BOTTOMLEFT", Frame.InstanceSelect, "TOPLEFT", 21, 0)
		Frame.InstanceSelect.Text:SetText(AL["Select Instance"])
		
		Frame:Hide()
	end

end

function DefaultFrame:DropDownRefresh()
	if type(db.module) == "table" then
		if UnitLevel("player") == 85 then
			db.module = db.module[2]
		else
			db.module = db.module[1]
		end
	end
	UIDropDownMenu_Initialize(_G[frameName.."_ModuleSelect"], DefaultFrame.ModuleSelect_Initialize)
	UIDropDownMenu_SetSelectedValue(_G[frameName.."_ModuleSelect"], db.module)
	UIDropDownMenu_SetWidth(_G[frameName.."_ModuleSelect"], 190)
	
	UIDropDownMenu_Initialize(_G[frameName.."_InstanceSelect"], DefaultFrame.InstanceSelect_Initialize)
	UIDropDownMenu_SetSelectedValue(_G[frameName.."_InstanceSelect"], db.instance)
	UIDropDownMenu_SetWidth(_G[frameName.."_InstanceSelect"], 190)
end

function DefaultFrame:ModuleSelect_Initialize()
	local info = self.info
	wipe(info)	
	
	for num,module in ipairs(AtlasLoot.Modules) do
		if module[1] ~= "AtlasLootCrafting" and module[1] ~= "AtlasLootWorldEvents" and type(AtlasLoot:CheckModule(module[1])) ~= "string" then
			info.text = module[5]
			info.value = module[1]
			info.func = DefaultFrame.ModuleSelect_OnClick
			info.checked = nil
			UIDropDownMenu_AddButton(info)
		end
	end
end

function DefaultFrame:ModuleSelect_OnClick()
	if not self.value then return end
    db.module = self.value
	db.instance = ""
	curBoss = nil
	DefaultFrame:DropDownRefresh()
	DefaultFrame:SetInstanceTable()
end

function DefaultFrame:InstanceSelect_Initialize(level)
	--if not level then return end
	local info = self.info
	local first = true
	wipe(info)
	if level == 1 or not level then
		if instances[db.module] then
			for k,v in ipairs(instances[db.module]) do
				if not v[2] then
					if first and db.instance == "" then
						db.instance = v[1]
						first = false
					end
					info.text = AtlasLoot_LootTableRegister["Instances"][v[1]]["Info"][1]
					info.value = v[1]
					info.func = DefaultFrame.InstanceSelect_OnClick
					if DEFAULTFRAME_STYLE_NUM_DUMMY == 2 then
						info.hasArrow = true
					end
					info.checked = nil
					UIDropDownMenu_AddButton(info, level)
				end
			end
			
			info.text = ""
			info.value = nil
			info.func = nil
			info.checked = nil
			info.notCheckable = true
			info.isTitle = true
			info.justifyH = "CENTER"
			UIDropDownMenu_AddButton(info, level)
			
			info.text = "--- "..tostring(RAIDS or "RAIDS").." ---"
			UIDropDownMenu_AddButton(info, level)
			
			info.notCheckable = false
			info.isTitle = false
			info.disabled = false
			info.justifyH = nil
			
			for k,v in ipairs(instances[db.module]) do
				if v[2] then
					info.text = AtlasLoot_LootTableRegister["Instances"][v[1]]["Info"][1]
					info.value = v[1]
					info.func = DefaultFrame.InstanceSelect_OnClick
					if DEFAULTFRAME_STYLE_NUM_DUMMY == 2 then
						info.hasArrow = true
					end
					info.checked = nil
					UIDropDownMenu_AddButton(info, level)
				end
			end
		end
	elseif level == 2 and DEFAULTFRAME_STYLE_NUM_DUMMY == 2 then
		if AtlasLoot_LootTableRegister["Instances"][UIDROPDOWNMENU_MENU_VALUE] then
			for bossNum, bossTab in ipairs(AtlasLoot_LootTableRegister["Instances"][UIDROPDOWNMENU_MENU_VALUE]["Bosses"]) do
				info.text = AtlasLoot:GetTableInfo(bossTab[1])
				info.value = bossTab[1]
				info.func = AtlasLoot.ShowLootPage
				info.checked = nil
				UIDropDownMenu_AddButton(info, level)
			end
		end
	end
end

function DefaultFrame:InstanceSelect_OnClick()
	if not self.value then return end
    db.instance = self.value
	curBoss = nil
	DefaultFrame:DropDownRefresh()
	DefaultFrame:SetInstanceTable()
end

function DefaultFrame:SetInstanceTable()
	--DefaultFrame:AutoSelect()
	curInstance = AtlasLoot:GetTableRegister(db.instance)
	if not curInstance then
		--print("ERROR: DefaultFrame:SetInstanceTable() <-->"..db.instance.." <--> "..db.module)
		curInstance = AtlasLoot:GetTableRegister("EmptyPage")
		db.instance = "EmptyPage"
		db.module = "EmptyPage"
		DefaultFrame:DropDownRefresh()
	end
	local iniName = curInstance["Info"][1]
	if curInstance["Info"] and curInstance["Info"].disableCompare then
		self.Frame.CompareFrame:Hide()
	else
		self.Frame.CompareFrame:Show()
	end
	if curInstance["Info"] and curInstance["Info"].EncounterJournalID then
		self.Frame.EncounterJournal.info = { curInstance["Info"].EncounterJournalID, nil }
		AtlasLoot:EncounterJournal_ButtonsRefresh()	
	else
		self.Frame.EncounterJournal.info = nil
		AtlasLoot:EncounterJournal_ButtonsRefresh()	
	end
	curInstance = curInstance["Bosses"]
	if not curInstance then return end
	scrollCurLines = #curInstance

	if DEFAULTFRAME_STYLE_NUM_DUMMY == 1 then
		DefaultFrame.Frame.InstanceName:SetText(iniName)
		
		for i = 1,scrollCurLines do
			if not DefaultFrame.Frame.ScrollFrame.Buttons[i] then
				if i==1 then
					DefaultFrame.Frame.ScrollFrame.Buttons[i] = AtlasLoot:CreateSelectBossLineButton(DefaultFrame.Frame, {"TOPLEFT", frameName.."_ScrollFrame", "TOPLEFT", 16, -3}, frameName.."_ScrollLine"..i)
				else
					DefaultFrame.Frame.ScrollFrame.Buttons[i] = AtlasLoot:CreateSelectBossLineButton(DefaultFrame.Frame, {"TOPLEFT", frameName.."_ScrollLine"..(i-1), "BOTTOMLEFT"}, frameName.."_ScrollLine"..i)
				end
				DefaultFrame.Frame.ScrollFrame.Buttons[i]:SetScript("OnClick", DefaultFrame.Boss_OnClick)
			end
		end
	
		for i in ipairs(DefaultFrame.Frame.ScrollFrame.Buttons) do
			if DefaultFrame.Frame.ScrollFrame.Buttons[i] then
				DefaultFrame.Frame.ScrollFrame.Buttons[i]:Hide()
				DefaultFrame.Frame.ScrollFrame.Buttons[i].Loot:Hide()
				DefaultFrame.Frame.ScrollFrame.Buttons[i].Selected:Hide()
				DefaultFrame.Frame.ScrollFrame.Buttons[i].boss = nil
			end
		end

		local buttonNum = 1
		local bossname
		for k,v in ipairs(curInstance) do
			if AtlasLoot:FormatDataID(v[1]) and not v.hide then
				bossname = AtlasLoot:GetTableInfo(v[1])
				DefaultFrame.Frame.ScrollFrame.Buttons[buttonNum].Text:SetText(bossname)
				DefaultFrame.Frame.ScrollFrame.Buttons[buttonNum]:Show()
				DefaultFrame.Frame.ScrollFrame.Buttons[buttonNum].Loot:Show()
				DefaultFrame.Frame.ScrollFrame.Buttons[buttonNum].Selected:Hide()
				DefaultFrame.Frame.ScrollFrame.Buttons[buttonNum].boss = v[1]
				if not curBoss then
					DefaultFrame.Frame.ScrollFrame.Buttons[buttonNum]:Click()
				end
				buttonNum = buttonNum + 1
			end
		end
	elseif DEFAULTFRAME_STYLE_NUM_DUMMY == 2 then
	
	end
	
end

function DefaultFrame:Boss_OnClick()
	local self = self
	for k,v in ipairs(DefaultFrame.Frame.ScrollFrame.Buttons) do
		v.Loot:Show()
		v.Selected:Hide()
	end
	self.Loot:Hide()
	self.Selected:Show()

	AtlasLoot:ShowLootPage(self.boss)

	curBoss = self.boss
end

function DefaultFrame:SetBoss(boss)
	if not boss then return end
	for k,v in ipairs(DefaultFrame.Frame.ScrollFrame.Buttons) do
		if v.boss == boss then
			DefaultFrame.Boss_OnClick(v)
			return
		end
	end
end

-- instance table creator
do
	local function SortTable(t, f)
		local a = {}
		local a2 = {}
		for k,v in pairs(t) do 
			if v["Info"] and v["Info"][1] then
				a[#a + 1] = v["Info"][1]
				a2[v["Info"][1]] = k
			end
		end
		table.sort(a, f)
		local i = 0
		return function()
			i = i + 1
			return a2[ a[i] ], t[ a2[ a[i] ] ]
		end
	end

	--- Creats the instance table for the dropdowns
	-- @usage DefaultFrame:CreateInstanceTab()
	function DefaultFrame:CreateInstanceTab()
		for _,module in ipairs(AtlasLoot.Modules) do
			if module ~= "AtlasLootCrafting" and module ~= "AtlasLootWorldEvents" then
				instances[ module[1] ] = {}
			end
		end
		for ini,iniTab in SortTable(AtlasLoot_LootTableRegister["Instances"]) do
			if iniTab["Info"] and iniTab["Info"][2] and type(iniTab["Info"][2]) == "table" then
				for k,v in ipairs(iniTab["Info"][2]) do
					if instances[ v ] then
						instances[ v ][#instances[ v ] + 1] = {ini, iniTab["Info"].raid}
					end
				end
			elseif iniTab["Info"] and instances[ iniTab["Info"][2] ] then
				instances[ iniTab["Info"][2] ][#instances[ iniTab["Info"][2] ] + 1] = {ini, iniTab["Info"].raid}
			end
		end
	end
end

function DefaultFrame:MiniMap_OnClick_Replace()
	if AtlasLootDefaultFrame:IsVisible() then
		AtlasLootDefaultFrame:Hide()
	else
		AtlasLootDefaultFrame:Show()
	end
end

-- autoselect :)
-- /run print("mapname = \""..GetMapInfo().."\"")
do
	local mapRegister

	local function createMapRegister()
		mapRegister = {}
		for instance,iniTab in pairs(AtlasLoot_LootTableRegister["Instances"]) do
			if iniTab["Info"] and iniTab["Info"].mapname then
				if iniTab["Info"][2] then
					mapRegister[iniTab["Info"].mapname] = {
						instance,
						iniTab["Info"][2],
					}
				end
			end
		end
	end

	function DefaultFrame:AutoSelect()
		if not mapRegister then createMapRegister() end
		local mapname = GetMapInfo()
		if not mapname or not mapRegister[mapname] then return end
		
		if type(mapRegister[mapname][2]) == "table" then
			if UnitLevel("player") >= 85 and mapRegister[mapname][2][2] then
				db.module = mapRegister[mapname][2][2]
			else
				db.module = mapRegister[mapname][2][1]
			end
		else
			db.module = mapRegister[mapname][2]
		end
		db.instance = mapRegister[mapname][1]
		
		DefaultFrame:DropDownRefresh()
		--[[ sub Zone support 
		local level = GetCurrentMapDungeonLevel()
		if level == 0 then level = 1 end

		for i = level, 1, -1 do 
			if mapRegister[mapname][i] then
				db.module = mapRegister[mapname][i][2]
				db.instance = mapRegister[mapname][i][1]
				break
			end
		end
		]]--
	end
end

-- Scale
function AtlasLoot:DefaultFrame_RefreshScale()
	AtlasLootDefaultFrame:SetScale( AtlasLoot.db.profile.LootBrowserScale )
	AtlasLootTooltipTEMP:SetScale( AtlasLoot.db.profile.LootBrowserScale )
end

-- Alpha
function AtlasLoot:DefaultFrame_RefreshAlpha(frameLeave)
	if not AtlasLoot.db.profile.LootBrowserAlphaOnLeave then
		AtlasLootDefaultFrame:SetAlpha( AtlasLoot.db.profile.LootBrowserAlpha )
	else
		if frameLeave then
			AtlasLootDefaultFrame:SetAlpha( AtlasLoot.db.profile.LootBrowserAlpha )
		else
			AtlasLootDefaultFrame:SetAlpha( 1.0 )
		end
	end
end


-- Set cur instance
function AtlasLoot:DefaultFrame_SetInstance(module, instance, iniBoss)
	if module and instance then
		db.module = module
		db.instance = instance
		DefaultFrame.InstanceSelect_OnClick({value = instance})
	end

	if iniBoss then
		DefaultFrame:SetBoss(iniBoss)
	end
end

--[[
-----------------------------------------------------------------
-- HelpPlate
-- 13 down 46x46
-- frameName
--	"18", "-84"
local DefaultFrame_HelpPlate = {
	FramePos = { x = 0,          y = -35 },
	FrameSize = { width = 921, height = 566 },
	[1] = { ButtonPos = { x = 520,	y = -514.5 },  HighLightBox = { x = 545, y = -527, width = 200, height = 20 },	 ToolTipDir = "DOWN",  ToolTipText = "CompareFrame" },
	[2] = { ButtonPos = { x = 745,	y = -511.5 },  HighLightBox = { x = 745, y = -524, width = 23, height = 23 },	 ToolTipDir = "RIGHT",  ToolTipText = "EJ" },
	[3] = { ButtonPos = { x = 701,	y = -311.5 },  HighLightBox = { x = 540, y = -147, width = 368, height = 375 },	 ToolTipDir = "UP",  ToolTipText = "Boss Select" },
	[4] = { ButtonPos = { x = 250,	y = -237 },  HighLightBox = { x = 18, y = -49, width = 510, height = 450 },	 ToolTipDir = "UP",  ToolTipText = "ItemFrame" },
	[5] = { ButtonPos = { x = 162,	y = -497 },  HighLightBox = { x = 185, y = -507, width = 155, height = 25 },	 ToolTipDir = "LEFT",  ToolTipText = "QuickLoot" },
	[6] = { ButtonPos = { x = 397,	y = -497 },  HighLightBox = { x = 340, y = -507, width = 80, height = 25 },	 ToolTipDir = "RIGHT",  ToolTipText = "Filter" },
	[7] = { ButtonPos = { x = 157,	y = -1 },  HighLightBox = { x = 70, y = -1, width = 220, height = 45 },	 ToolTipDir = "DOWN",  ToolTipText = "Module select" },
	[8] = { ButtonPos = { x = 395,	y = -1 },  HighLightBox = { x = 308, y = -1, width = 220, height = 45 },	 ToolTipDir = "DOWN",  ToolTipText = "Instance select" },
}
local Helper = LibStub("LibHelpPlate")
function DefaultFrame:Helper()
	self.Frame.HelpPlate = Helper:Create(self.Frame, DefaultFrame_HelpPlate)
	self.Frame.HelpPlate:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 53, 10)
	
end
]]--