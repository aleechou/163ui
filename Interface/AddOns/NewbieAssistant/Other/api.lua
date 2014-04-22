-- Author      : s1172
-- Create Date : 2013/2/28 17:22:12

local NAOtherApi=CreateFrame("frame", "NAOtherApi", UIParent)

NAOtherApi.Localization={}

--- Returns localized string
-- @param str The string to localize.
-- @return The localized string.
function NAOtherApi:Localize(str)
	return self.Localization[str]
end

--- 
function NAOtherApi:DisableAddon()
	local emptyFunc = function()end

	-- 注销事件
	local eventDb = NAApi.DBEventFunc

	for table,v in pairs(eventDb) do
		table:UnregisterAllEvents()
	end

	-- 注销钩子
	local hookDb = NAApi.DBSecureHook
	for k,v in pairs(hookDb) do
		for handler,func in pairs(v) do
			if func[1] then
				func[1] = nil
			end
		end
	end

	-- 注销新手提示
	for item in pairs(ToolTip_Logic) do
		ToolTip_Logic[item] = type(item) == "string" and emptyFunc
	end

	-- 关闭界面
	NewbieAssistantPannelFrame:Hide()
	NewbieAssistantPannelFrameToggleButton:Hide()
	
	-- 关闭路径提示
	NewbieAssistantNavigationFrame:UnregisterAllEvents()
	wipe(NewbieAssistantNavigationApi.Lines)
	NewbieAssistantNavigationFrame:Hide()

	-- 关闭小精灵
	NewbieAssistantElfintipFrameTimer:SetScript("OnUpdate", nil)
	NewbieAssistantElfintipFrame:Hide()

	-- 禁用插件
	DisableAddOn("NewbieAssistant")

	-- 关闭各类提示框
	TutorialTinyMsgFrame_Hide(-1)
	TutorialSmallMsgFrame_Hide(-1)
	TutorialMiniFrame_Hide()
	NAApi:SetAddonDB("DisableAddon", true)
end

StaticPopupDialogs["DisableNewbieAssistant"] = {
	text = TutorialApi:Localize("DisableAddon"),
	button1 = "启用",
	button2 = "禁用",
	OnAccept = function(self)
		local disable = NAApi:GetAddonDB("DisableAddon")
		if not disable then
			if NewbieAssistantToturialKeyboardFrame.ShowKB then
				LoadBindings(0)	--恢复默认
				SaveBindings(2)	--保存至角色
				SetTracking(1)	--追踪宠物关闭
				NewbieAssistantToturialKeyboardFrame:Show()
			else
				ToolTip_Logic:TutorialStart()
			end
		else
			NAApi:SetAddonDB("DisableAddon", nil)
			EnableAddOn("NewbieAssistant")
			ReloadUI()
		end
	end,
	OnCancel = function(self)
		if not NAApi:GetAddonDB("DisableAddon") then
			NAOtherApi:DisableAddon()
		end
	end,
	showAlert = 1,
	timeout = 0,
	exclusive = 1,
}

StaticPopupDialogs["CopyNewbieAssistantFeedbackUrl"] = {
	text = TutorialApi:Localize("CopyNewbieAssistantFeedbackUrl"),
	button1 = "确定",
	-- button2 = NO,
	OnAccept = function(self)
		self:Hide()
	end,
	OnCancel = function(self)
		self:Hide()
	end,
	OnShow = function(self)
		self.editBox:SetFocus()
		self.editBox:SetText(TutorialApi:Localize("Feed back url"))
		self.editBox:SetCursorPosition(0)
		self.editBox:HighlightText()
	end,
	timeout = 0,
	whileDead = 1,
	exclusive = 1,
	showAlert = 1,
	hideOnEscape = 1,
	hasEditBox = 1,
}
