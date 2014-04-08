------------------------------------------------------------
-- OptionFrame.lua
--
-- Abin
-- 2010-9-28
------------------------------------------------------------

local L = WHISPERPOP_LOCALE
BINDING_HEADER_WHISPERPOP_TITLE = L["title"]
BINDING_NAME_WHISPERPOP_TOGGLE = L["toggle frame"]

-- Option frame
local frame = CreateFrame("Frame", "WhisperPopOptionFrame", WhisperPop.mainFrame)
frame:SetWidth(135)
frame:SetHeight(20)
frame:SetPoint("BOTTOMLEFT", 12, 7)

local prev
local function CreateOptionButton(name, icon, key, tooltipTitle, tooltipText)
	local button = CreateFrame(key and "CheckButton" or "Button", frame:GetName()..name.."Button", frame)
	button:SetWidth(16)
	button:SetHeight(16)
	if prev then
		button:SetPoint("LEFT", prev, "RIGHT", 6, 0)
	else
		button:SetPoint("LEFT")
	end
	prev = button

	button.key, button.tooltipTitle, button.tooltipText = key, tooltipTitle, tooltipText

	button.icon = button:CreateTexture(nil, "BORDER")
	button.icon:SetAllPoints(button)
	button.icon:SetTexture(icon)
	button.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)

	if key then
		local checkedTexture = button:CreateTexture(nil, "OVERLAY")
		button:SetCheckedTexture(checkedTexture)
		checkedTexture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
		checkedTexture:SetPoint("TOPLEFT", button.icon, "TOPLEFT", -4, 4)
		checkedTexture:SetPoint("BOTTOMRIGHT", button.icon, "BOTTOMRIGHT", 4, -4)
	end

	button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")

	button.Float = function(self)
		self.icon:ClearAllPoints()
		self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", -1, 1)
		self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -1, 1)
	end

	button.Sink = function(self)
		self.icon:ClearAllPoints()
		self.icon:SetPoint("TOPLEFT", self, "TOPLEFT", 1, -1)
		self.icon:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", 1, -1)
	end

	button.Restore = function(self)
		self.icon:ClearAllPoints()
		self.icon:SetAllPoints(self)
	end

	button.ShowTooltip = function(self)
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
		GameTooltip:ClearLines()
		if self.tooltipTitle then
			GameTooltip:AddLine(self.tooltipTitle)
		end

		if self.tooltipText then
			GameTooltip:AddLine(self.tooltipText, 0, 1, 0, 1)
		end

		GameTooltip:Show()
	end

	button:SetScript("OnEnter", function(self)
		self:Float()
		self:ShowTooltip()
	end)

	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
		self:Restore()
	end)

	button:SetScript("OnMouseDown", button.Sink)
	button:SetScript("OnMouseUp", button.Restore)

	button:SetScript("OnClick", function(self, ...)
		WhisperPop.messageFrame:Hide()
		if self.key then
			if WhisperPop.db[self.key] then
				WhisperPop.db[self.key] = nil
			else
				WhisperPop.db[self.key] = 1
			end
		end

		if type(button.OnClick) == "function" then
			button:OnClick(...)
		end
	end)

	return button
end

-- Option buttons
local recOnlyButton = CreateOptionButton("ReceiveOnly", "Interface\\Icons\\INV_Scroll_10", "receiveonly", L["receive only"], L["receive only tooltip"])
local soundButton = CreateOptionButton("Sound", "Interface\\Icons\\INV_Misc_Bell_01", "sound", L["sound notifying"], L["sound notifying tooltip"])
local timeButton = CreateOptionButton("Time", "Interface\\Icons\\INV_Misc_PocketWatch_02", "time", L["time"], L["time tooltip"])
local keepButton = CreateOptionButton("Keep", "Interface\\AddOns\\!!!163UI!!!\\Textures\\IconNetEase", "keep", "保留历史记录", "保留一天以内的消息，而且同帐号的各个角色均可查看。\n \n|cffff3333严重警告：因密语记录可以打开魔兽存档随意查看，因此请不要在网吧等公共环境开启此选项，以免信息泄漏。|r")
local clearButton = CreateOptionButton("Clear", "Interface\\Icons\\Spell_Shadow_SacrificialShield", nil, L["delete messages"], L["delete messages tooltip"])

function clearButton:OnClick()
	WhisperPop.list:Clear()
	WhisperPop:OnListUpdate()
end

frame:RegisterEvent("VARIABLES_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGOUT" then
        if WhisperPop.db.keep then
            WhisperPop.db.keepDatas = WhisperPopFrameList.listData
        else
            WhisperPop.db.keepDatas = nil
        end
    elseif event == "VARIABLES_LOADED" then
		if type(WhisperPopDB) ~= "table" then
			WhisperPopDB = WhisperPop.db
		else
			WhisperPop.db = WhisperPopDB
        end

        if WhisperPop.db.keep then
            WhisperPopFrameList.listData = WhisperPop.db.keepDatas or WhisperPopFrameList.listData;
            local keepTime = time() - 60*60*24;
            for i = #WhisperPopFrameList.listData, 1, -1 do
                local messages = WhisperPopFrameList.listData[i].messages
                while messages and messages[1] and (not messages[1].timeraw or messages[1].timeraw < keepTime) do
                    table.remove(messages, 1)
                end
                if not messages or #messages == 0 then
                    table.remove(WhisperPopFrameList.listData, i)
                end
            end
            WhisperPop.db.keepDatas = nil
            WhisperPopFrameList.needRefresh = 1
            DEFAULT_CHAT_FRAME:AddMessage("有爱提示：密语记录插件正在记录并保存私聊信息，如果您正在网吧等公共环境，建议关闭此功能。", 1, .5, .5);
        end

		recOnlyButton:SetChecked(WhisperPop.db.receiveonly)
		soundButton:SetChecked(WhisperPop.db.sound)
        timeButton:SetChecked(WhisperPop.db.time)
        keepButton:SetChecked(WhisperPop.db.keep)
	end
end)

-------------------------------------------------
-- Slash handler
-------------------------------------------------

SLASH_WHISPERPOP1 = "/whisperpop"
SlashCmdList["WHISPERPOP"] = function() WhisperPop:ToggleFrame() end