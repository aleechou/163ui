------------------------------------------------------------
-- MainFrame.lua
--
-- Abin
-- 2010-9-28
------------------------------------------------------------

local L = WHISPERPOP_LOCALE

local function SetFrameMobile(frame)
	frame:SetMovable(true)
	frame:SetUserPlaced(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
end

-- Tip frame
local tipFrame = CreateFrame("Button", "WhisperPopTipFrame", UIParent)
WhisperPop.tipFrame = tipFrame
SetFrameMobile(tipFrame)
--tipFrame:SetPoint("BOTTOMRIGHT", nil, "BOTTOMRIGHT", 0, -2)
tipFrame:SetPoint('BOTTOM', FriendsMicroButton, 'TOP', 0, 2)
tipFrame:SetWidth(20)
tipFrame:SetHeight(20)
tipFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")

tipFrame.icon = tipFrame:CreateTexture(tipFrame:GetName().."Icon", "ARTWORK")
tipFrame.icon:SetAllPoints(tipFrame)
tipFrame.icon:SetTexture("Interface\\Icons\\INV_Letter_05")
tipFrame.icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
tipFrame.icon:SetDesaturated(true)

tipFrame.text = tipFrame:CreateFontString(tipFrame:GetName().."Text", "ARTWORK", "GameFontGreenSmall")
tipFrame.text:SetPoint("LEFT", tipFrame, "RIGHT")

local function TipFrame_OnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed > 0.5 then
		self.elapsed = 0
		if self.icon:IsShown() then
			self.icon:Hide()
		else
			self.icon:Show()
		end
	end
end

function tipFrame:SetTip(name)
	if type(name) ~= "string" then
		name = nil
	end

	if name == self.name then
		return
	end

	self.name = name
	self.elapsed = 0
	self.icon:Show()
	if name then
		self.icon:SetDesaturated(false)
		self.text:SetText(name)
		self:SetScript("OnUpdate", TipFrame_OnUpdate)
	else
		self.icon:SetDesaturated(true)
		self.text:SetText()
		self:SetScript("OnUpdate", nil)
	end
end

tipFrame:SetScript("OnClick", function(self)
	GameTooltip:Hide()
	WhisperPop:ToggleFrame()
end)

tipFrame:SetScript("OnEnter", function(self)
	GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	GameTooltip:ClearLines()
	GameTooltip:AddLine("WhisperPop "..WhisperPop.version)
	GameTooltip:AddLine(L["tip tooltip"], 0, 1, 0, 1)
	GameTooltip:Show()
end)

tipFrame:SetScript("OnLeave", function(self)
	GameTooltip:Hide()
end)

--tipFrame:SetTip("Test")

-- Main frame
local frame = WhisperPop:CreateCommonFrame("WhisperPopFrame", UIParent, "ÃÜÓï¼ÇÂ¼ "..WhisperPop.version)
WhisperPop.mainFrame = frame
tinsert(UISpecialFrames, frame:GetName())
SetFrameMobile(frame)
frame:SetToplevel(true)
frame:SetFrameStrata("DIALOG")
frame:SetPoint("CENTER", 0, -20)

-- Player list
local list = UICreateVirtualScrollList(frame:GetName().."List", frame, 10)
WhisperPop.list = list
list:SetHeight(200)
list:SetPoint("TOPLEFT", 7, -28)
list:SetPoint("TOPRIGHT", -7, -28)

local topLine = list:CreateTexture(nil, "ARTWORK")
topLine:SetTexture("Interface\\OptionsFrame\\UI-OptionsFrame-Spacer")
topLine:SetHeight(16)
topLine:SetPoint("LEFT", list, "TOPLEFT", -1, 5)
topLine:SetPoint("RIGHT", list, "TOPRIGHT", 1, 5)

local bottomLine = list:CreateTexture(nil, "ARTWORK")
bottomLine:SetTexture("Interface\\OptionsFrame\\UI-OptionsFrame-Spacer")
bottomLine:SetHeight(16)
bottomLine:SetPoint("LEFT", list, "BOTTOMLEFT", -1, -2)
bottomLine:SetPoint("RIGHT", list, "BOTTOMRIGHT", 1, -2)

local function CompareData(data, name)
	return data.name == name
end

local function DeleteButton_OnClick(self)
	WhisperPop.messageFrame:Hide()
	list:RemoveData(list:FindData(self:GetParent().name, CompareData))
	WhisperPop:OnListUpdate()
end

function list:OnButtonCreated(button)
	WhisperPop:CreatePlayerButton(button)
	button:RegisterForClicks("AnyUp")

	local del = CreateFrame("Button", button:GetName().."Delete", button, "UIPanelCloseButton")
	button.deleteButton = del
	del:SetWidth(16)
	del:SetHeight(16)
	del:SetPoint("RIGHT")
	del:SetScript("OnClick", DeleteButton_OnClick)

	button.nameText:SetPoint("RIGHT", del, "LEFT")
end

function list:OnButtonUpdate(button, data)
	button.name = data.name
	button:SetPlayer(data.class, data.name)
	if data.new then
		button.nameText:SetTextColor(0, 1, 0)
	elseif data.received then
		button.nameText:SetTextColor(1, 1, 1)
	else
		button.nameText:SetTextColor(0.5, 0.5, 0.5)
	end
end

function list:OnButtonEnter(button, data)
	if WhisperPop.db.receiveonly and not data.received then
		WhisperPop.messageFrame:Hide()
		return
	end

	if data.new then
		data.new = nil
		button.nameText:SetTextColor(1, 1, 1)
		WhisperPop:OnListUpdate()
	end

	WhisperPop.messageFrame:ClearAllPoints()

	if button:GetLeft() > 350 then
		WhisperPop.messageFrame:SetPoint("RIGHT", button, "LEFT", -4, 0)
	else
		WhisperPop.messageFrame:SetPoint("LEFT", button, "RIGHT", 4, 0)
	end

	WhisperPop.messageFrame:SetData(data.class, data.name, data.messages, data.bnFriend)
	WhisperPop.messageFrame:StopCounting()
end

function list:OnButtonLeave(button, data)
	WhisperPop.messageFrame:StartCounting()
end

function list:OnButtonClick(button, data, flag)
	local presenceID = BNet_GetPresenceID(data.name)
	if flag == "RightButton" then
		-- Right click brings up unit drop down menu
		if data.bnFriend then
			FriendsFrame_ShowBNDropdown(data.name, 1, nil, "BN_WHISPER", _, nil, presenceID)
		else
			FriendsFrame_ShowDropdown(data.name, 1)
		end
	elseif flag == "LeftButton" then
		if IsShiftKeyDown() then
			-- Query player info
			SendWho("n-"..data.name)
		elseif IsAltKeyDown() then
			-- Invite
			InviteUnit(data.name)
		else
			if data.bnFriend then
				SetItemRef( "BNplayer:"..(data.name)..":"..presenceID, ("|Hplayer:%1$s|h[%1$s]|h"):format(data.name), "LeftButton" )
			else
				ChatFrame_SendTell(data.name)
			end
		end
	end
end

list:RegisterEvent("CHAT_MSG_WHISPER")
list:RegisterEvent("CHAT_MSG_WHISPER_INFORM")
list:RegisterEvent("CHAT_MSG_BN_WHISPER")
list:RegisterEvent("CHAT_MSG_BN_WHISPER_INFORM")

list:SetScript("OnEvent", function (self, event, text, name, _, _, _, status, _, _, _, _, _, guid, BNguid)
	if type(text) ~= "string" or type(name) ~= "string" or (BNguid == 0 and (type(guid) ~= "string")) or WhisperPop:IsIgnoredMessage(text) or status == "DND" then
		return
	end
	local bnFriend = event == "CHAT_MSG_BN_WHISPER" or event == "CHAT_MSG_BN_WHISPER_INFORM"

	-- Whenever we recieve a whisper message, we check if the person is already in list, if it is, we bring it to top
	local inform = event == "CHAT_MSG_WHISPER_INFORM" or event == "CHAT_MSG_BN_WHISPER_INFORM"
	local timeStamp = "|cffffd200"..strsub(date(), 10, 17).."|r"
	local reading = WhisperPop.messageFrame:IsReading() == name

	local idx = list:FindData(name, CompareData)
	local data = list:GetData(idx)
	if data then
		if idx ~= 1 then
			list:ShiftData(idx, 1)
		elseif reading then
			WhisperPop.messageFrame:AddMessage(timeStamp, text, inform, bnFriend)
			WhisperPop.messageFrame:UpdateHeight()
		end
	else
		data = { name = name, class = class, messages = {}, bnFriend = bnFriend } -- Person not in list, create a new record for him
		if bnFriend then
			data.class = "BN"
		elseif status == "GM" then
			data.class = "GM"
		elseif type(guid) == "string" then
			data.class = select(2, GetPlayerInfoByGUID(guid))
		end
		list:InsertData(data, 1)
	end

	tinsert(data.messages, { text = text, time = timeStamp, timeraw = time(), inform = inform })
	if inform then
		-- Replying a person removes the "new" mark from him
		data.new = nil
	else
		data.received = 1
		if not reading then
			data.new = 1
		end
	end

	list:UpdateData(1)
	WhisperPop:OnNewMessage(name, text, inform, guid, bnFriend)
	WhisperPop:OnListUpdate()
end)