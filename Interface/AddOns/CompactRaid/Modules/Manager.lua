------------------------------------------------------------
-- Manager.lua
--
-- Abin
-- 2012/1/03
------------------------------------------------------------

local _G = _G
local type = type
local GetLocale = GetLocale
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local tostring = tostring
local strlower = strlower
local CreateFrame = CreateFrame
local format = format
local pairs = pairs
local GetActiveSpecGroup = GetActiveSpecGroup
local GetNumSpecGroups = GetNumSpecGroups
local TALENT_SPEC_PRIMARY = TALENT_SPEC_PRIMARY
local TALENT_SPEC_SECONDARY = TALENT_SPEC_SECONDARY

local _, addon = ...
local L = addon.L

local OBSOLETE_MODULES = { ["BarTextures"] = 1, ["RaidDebuff_Records"] = 1, ["PartyTargets"] = 1, ["Direction"] = 1 } -- Obsolete modules, reject them from registering
local OBSOLETE_ADDONS = { ["CompactRaid_ClickSets"] = 1, ["CompactRaid_PartyTargets"] = 1, ["CompactRaid_RaidDebuff_WotLK"] = 1, ["CompactRaid_RaidDebuff_CTM"] = 1, ["CompactRaid_Direction"] = 1 }

local modules = {}
local moduleLocales = {}

function addon:RegisterLocale(name, locale, data)
	if type(name) == "string" and type(data) == "table" and type(locale) == "string" then
		if not moduleLocales[name] then
			moduleLocales[name] = {}
		end

		if not moduleLocales[name][locale] then
			moduleLocales[name][locale] = data
		end
	end
end

function addon:GetLocale(name, locale)
	local data = moduleLocales[name]
	if data then
		if type(locale) ~= "string" then
			locale = GetLocale()
		end

		return data[locale] or data.enUS
	end
end

local function Print(module, msg, r, g, b)
	if msg then
		local header = addon.name
		if type(module) == "table" then
			header = header.."-"..(module.title or module.name or UNKNOWN)
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff78"..header..":|r "..tostring(msg), r or 0.5, g or 0.75, b or 1) -- All modules use uniformed message color, please!
	end
end

function addon:FindModule(name)
	return modules[name]
end

local function Module_GetVisual(self, frame)
	return self.__visualFrames[frame]
end

local function Module_EnumVisuals(self, object, func, ...)
	return addon._EnumFrames(self.__visualFrames, object, func, ...)
end

local function Module_IsDualTalentsSynced(self)
	return self.chardb.talent_Synced and "talent_Synced" or nil
end

local function Module_IsEnabled(self)
	return self._moduleEnabled
end

local function Module_ShowVisuals(self, show)
	Module_EnumVisuals(self, show and "Show" or "Hide")
end

local function Module_HasFlag(self, flag)
	if type(flag) == "string" then
		local result = strfind(self.__flags, flag)
		return result
	end
end

-- Create a new module, must be called before "PLAYER_LOGIN"
function addon:CreateModule(name, title, version, desc, flags, parent)
	if type(name) ~= "string" or modules[name] or OBSOLETE_MODULES[name] then
		return
	end

	if type(flags) == "string" then
		flags = strlower(flags)
	else
		flags = ""
	end

	local module = {}
	module.name = name
	module.title = title or name
	module.version = version
	module.desc = desc
	module.parent = parent
	module.__visualFrames = {}
	module.__flags = flags

	module.Print = Print
	module.pcall = addon.pcall
	module.RequestRestoreDefaults = addon.RestoreModuleDefaults
	module.CombatSafeCall = addon.CombatSafeCall
	module.CancelPendingCombatSafeCall = addon.CancelPendingCombatSafeCall
	module.IsEnabled = Module_IsEnabled
	module.IsDualTalentsSynced = Module_IsDualTalentsSynced
	module.GetVisual = Module_GetVisual
	module.ShowVisuals = Module_ShowVisuals
	module.EnumVisuals = Module_EnumVisuals
	module.EnumUnitFrames = addon.EnumUnitFrames
	module.CloneTable = addon.CloneTable
	module.HasFlag = Module_HasFlag

	EmbedEventObject(module)
	modules[name] = module
	self:BroadcastEvent("OnModuleCreated", module)
	return module
end

function addon:EnumModules(func, ...)
	if type(func) == "function" then
		local name, module
		for name, module in pairs(modules) do
			func(name, module, ...)
		end
	end
end

function addon:CallModuleFunc(module, func, ...)
	func = module and module[func]
	if type(func) == "function" then
		-- Why pcall? One module's error won't halt the entire process. I do need a way to let the module know
		-- it's encountering errors, though, so just print out the error message. You got a better idea?
		module:pcall(func, module, ...)
	end
end

function addon:CallAllModulesFunc(func, ...)
	local module
	for _, module in pairs(modules) do
		addon:CallModuleFunc(module, func, ...)
	end
end

------------------------------------------------------------
-- Internal module events handling
------------------------------------------------------------

local function CopyDefaultDB(module, key, db, ...)
	if type(db) ~= "table" then
		return
	end

	local defaults
	if type(module.GetDefaultDB) == "function" then
		defaults = module:GetDefaultDB(key, ...)
	end

	wipe(db)
	if defaults then
		addon:CloneTable(defaults, db)
	end
end

local function EnumModuleProc_OnTalentSwitch(name, module, spec, init)
	if not module:IsEnabled() or not module:HasFlag("talent") then
		return
	end

	local talentName = spec == 2 and TALENT_SPEC_SECONDARY or TALENT_SPEC_PRIMARY
	local label = module.optionPage and module.optionPage.dualTalentText
	if label then
		label:SetText("["..talentName.."]")
	end

	if Module_IsDualTalentsSynced(module) then
		if init then
			if label then
				label:Hide()
			end
			module.talentdb = module.chardb.talent_Synced
			module:pcall(module.OnTalentGroupChange, module, "sync", module.talentdb)
		end
	else
		local key = "talent"..spec
		local firstTime
		local talentdb = module.chardb[key]
		if type(module.chardb[key]) ~= "table" then
			firstTime = 1
			talentdb = {}
			module.chardb[key] = talentdb
			CopyDefaultDB(module, "talent", talentdb, spec)
		end
		module.talentdb = talentdb
		module:pcall(module.OnTalentGroupChange, module, spec, talentdb, firstTime)
	end
end

local function VisualFrame_GetUnitFrame(self)
	return self._unitFrame
end

local function OnCreateVisualEnumProc(unitFrame, module, dynamic)
	if Module_GetVisual(module, unitFrame) then
		return
	end

	local visualParent = unitFrame.visualParent
	local visual = CreateFrame(module.visualType or "Frame", module.visualName and visualParent:GetName().."_"..module.visualName or nil, visualParent, module.visualTemplate)
	visual:Hide()
	visual._unitFrame = unitFrame
	visual.GetUnitFrame = VisualFrame_GetUnitFrame
	module.__visualFrames[unitFrame] = visual
	module:OnCreateVisual(visual, unitFrame, dynamic)
end

local function OnUpdateNotifyEnumProc(frame, module)
	addon:CallModuleFunc(module, "OnUnitChange", frame, frame:GetUnitInfo())
	addon:CallModuleFunc(module, "OnUnitFlagChange", frame, frame:GetUnitFlag())
	addon:CallModuleFunc(module, "OnRangeChange", frame, frame:IsInRange())
	addon:CallModuleFunc(module, "OnRoleIconChange", frame, frame:GetRoleIconStatus())
	addon:CallModuleFunc(module, "OnRaidIconChange", frame, frame:GetRaidIconStatus())
	addon:CallModuleFunc(module, "OnAurasChange", frame, frame:GetUnitInfo())
end

local function OnEnableModule(module)
	if type(module.OnCreateVisual) == "function" then
		addon:EnumUnitFrames(OnCreateVisualEnumProc, module)
	end

	module._moduleEnabled = 1
	addon:CallModuleFunc(module, "OnEnable")
	EnumModuleProc_OnTalentSwitch(module.name, module, GetActiveSpecGroup(), 1)
	addon:EnumUnitFrames(OnUpdateNotifyEnumProc, module)
end

local function EnumModuleProc_OnInitialize(name, module, db, chardb)
	if module._moduleInitDone then
		return
	end

	local firstTime, accountdb, playerdb
	accountdb = db[name]
	if module:HasFlag("account") then
		if type(accountdb) ~= "table" then
			firstTime = 1
			accountdb = {}
			db[name] = accountdb
			CopyDefaultDB(module, "account", accountdb)
		end
	else
		db[name] = nil
	end

	playerdb = chardb[name]
	if type(playerdb) ~= "table" then
		firstTime = 1
		playerdb = {}
		chardb[name] = playerdb
		CopyDefaultDB(module, "char", playerdb)
	end

	module.db = accountdb
	module.chardb = playerdb

	addon:CallModuleFunc(module, "OnInitialize", accountdb, playerdb, firstTime)
	module._moduleInitDone = 1

	addon:BroadcastEvent("OnModuleInitialize", module, accountdb, playerdb, firstTime)

	if firstTime and module.initialOff then
		playerdb.disabled = 1
	end

	if not playerdb.disabled then
		OnEnableModule(module)
		addon:BroadcastEvent("OnModuleEnable", module)
	end
end

addon:RegisterEventCallback("SyncDaulTalents", function(module, enable)
	if not module or not module:HasFlag("talent") or not module:IsDualTalentsSynced() == not enable then
		return
	end

	if enable then
		module.chardb.talent_Synced = module.talentdb
		module.chardb.talent1 = nil
		module.chardb.talent2 = nil
		module:Print(L["sync dual-talent enabled"])
		addon:BroadcastEvent("OnModuleSync", module)
	else
		local commondb = module.chardb.talent_Synced
		if not commondb or not module.talentdb or module.talentdb ~= module.talentdb then
			return
		end

		module.chardb.talent1 = addon:CloneTable(commondb)
		if GetNumSpecGroups() == 2 then
			module.chardb.talent2 = addon:CloneTable(commondb)
			module.talentdb = GetActiveSpecGroup() == 2 and module.chardb.talent2 or module.chardb.talent1
		else
			module.talentdb = module.chardb.talent1
		end

		module.chardb.talent_Synced = nil
		module:Print(L["sync dual-talent disabled"])
		addon:BroadcastEvent("OnModuleUnsync", module)
	end
end)

addon:RegisterEventCallback("EnableModule", function(module, enable)
	if not module or not module:IsEnabled() == not enable then
		return
	end

	if enable then
		module.chardb.disabled = nil
		OnEnableModule(module)
		module:Print(L["module enabled"])
		addon:BroadcastEvent("OnModuleEnable", module)
	else
		module.chardb.disabled = 1
		module._moduleEnabled = nil
		module:UnregisterAllEvents()
		module:UnregisterTick()
		addon:CallModuleFunc(module, "OnDisable")
		Module_ShowVisuals(module)
		module:Print(L["module disabled"])
		addon:BroadcastEvent("OnModuleDisable", module)
	end
end)

local function EnumModuleProc_OnUnitNotify(name, module, frame, func, ...)
	if module:IsEnabled() then
		addon:CallModuleFunc(module, func, frame, ...)
	end
end

addon:RegisterEventCallback("OnUnitNotify", function(frame, func, ...)
	addon:EnumModules(EnumModuleProc_OnUnitNotify, frame, func, ...)
end)

local function OnDynamicUnitFrameCreated(unitFrame)
	local module
	for _, module in pairs(modules) do
		if module:IsEnabled() then
			addon:CallModuleFunc(module, "OnCreateDynamic", unitFrame)
			if type(module.OnCreateVisual) == "function" then
				OnCreateVisualEnumProc(unitFrame, module, 1)
			end
			OnUpdateNotifyEnumProc(unitFrame, module)
		end
	end
end

addon:RegisterEventCallback("OnPlayerLogin", function(db, chardb)
	-- Do one-time initializtion on all modules
	addon:EnumModules(EnumModuleProc_OnInitialize, db.modules, chardb.modules)
	addon.CreateModule = nil
	addon:BroadcastEvent("OnModulesInitDone")

	-- Remove obsoleted data
	local obsoleted
	for obsoleted in pairs(OBSOLETE_MODULES) do
		db.modules[obsoleted] = nil
		chardb.modules[obsoleted] = nil
	end

	-- Disable obsoleted addons
	for obsoleted in pairs(OBSOLETE_ADDONS) do
		DisableAddOn(obsoleted)
	end

	-- Unit frames created after this point are all dynamic
	addon:RegisterEventCallback("UnitButtonCreated", OnDynamicUnitFrameCreated)
end)

addon:RegisterEventCallback("OnTalentSwitch", function(spec)
	addon:EnumModules(EnumModuleProc_OnTalentSwitch, spec)
end)

------------------------------------------------------------
-- For modules' "Restore Defaults" features, new feature added in 0.2 beta
------------------------------------------------------------

local function OnConfirmRestore(module)
	if InCombatLockdown() and module:HasFlag("secure") then
		module:Print(L["cannot cange these settings while in combat"], 1, 0, 0)
		return
	end

	if module ~= addon:GetCoreModule() then
		if module:HasFlag("account") then
			CopyDefaultDB(module, "account", module.db)
		end

		local talentKey, talentdb
		if module:HasFlag("talent") and module.talentdb then
			talentKey = module:IsDualTalentsSynced(module)
			if not talentKey then
				talentKey = "talent"..(GetActiveSpecGroup() or 1)
			end
			talentdb = module.talentdb
			CopyDefaultDB(module, "talent", talentdb)
		end

		CopyDefaultDB(module, "char", module.chardb)
		if talentKey then
			module.chardb[talentKey] = talentdb
		end
	end

	if type(module.OnRestoreDefaults) == "function" then
		module:OnRestoreDefaults()
	end

	module:Print(L["defaults restored"])
	addon:BroadcastEvent("OnModuleRestoreDefaults", module)
end

function addon:RestoreModuleDefaults(module)
	if type(module) == "table" then
		local text = format(L["restore defaults text"], module.title or module.name or UNKNOWN)
		LibMsgBox:Confirm(text, "MB_OKCANCEL", OnConfirmRestore, module)
	end
end

------------------------------------------------------------
-- Obsoleted functions, only present in order not to generate lua errors
------------------------------------------------------------

function addon:RegisterModule() end
function addon:GetModule() end