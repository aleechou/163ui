-- Author      : s1172
-- Create Date : 2013/5/6 12:26:12

-- locale
local L = TutorialApi.Localization
local buttonTable = {"W","S","A","D","Q","E"}
local buttonIndex = 1

function NewbieAssistantToturialKeyboardFrame_OnChar(self, ...)
	local key = string.upper(...)
	if buttonTable[buttonIndex] == key then
		self["Button_"..key]:SetTexCoord(0.158203125,0.298828125,0.8144531,0.9433594)
		buttonIndex = buttonIndex + 1
		if buttonTable[buttonIndex] then
			self["Button_"..buttonTable[buttonIndex]]:SetTexCoord(0.005859375,0.14453125,0.83203125,0.96484375)
		end
	end

	if buttonIndex > 6 then
		buttonIndex = 1
		self["Button_W"]:SetTexCoord(0.005859375,0.14453125,0.83203125,0.96484375)
		self:Hide()
	end
end


function NewbieAssistantToturialKeyboardFrame_OnShow(self)

	self["Keys"] = {
		["A"] = "A",
		["S"] = "S",
		["D"] = "D",
		["Q"] = "Q",
		["W"] = "W",
		["E"] = "E",
		--["A"] = GetBindingKey("TURNLEFT"),
		--["S"] = GetBindingKey("MOVEBACKWARD"),
		--["D"] = GetBindingKey("TURNRIGHT"),
		--["Q"] = GetBindingKey("STRAFELEFT"),
		--["W"] = GetBindingKey("MOVEFORWARD"),
		--["E"] = GetBindingKey("STRAFERIGHT"),
	}
	
	for i,k in pairs(self["Keys"]) do
		self["Text"..i]:SetText(k)
		self["Arrow_"..i]:Show()
		self["Button_"..i]:Show()
		self["Text"..i]:Show()
	end

	self["Keys"]["Count"] = 6

	self.Title:SetText(string.format(
		L["You can follow the arrow to move your character."],
		self["Keys"]["W"],self["Keys"]["S"],
		self["Keys"]["Q"],self["Keys"]["E"],
		self["Keys"]["A"],self["Keys"]["D"]
		))
	self:SetScale(0.8)

	TutorialTinyMsgFrame_Show("BOTTOMLEFT","BOTTOM",NewbieAssistantToturialKeyboardFrame,"TOPRIGHT",0,0,L["follow the picture."])
end

function NewbieAssistantToturialKeyboardFrame_OnLoad(self)
	self:RegisterEvent("TIME_PLAYED_MSG")
	self:RegisterEvent("VARIABLES_LOADED")
end

function NewbieAssistantToturialKeyboardFrame_OnEvent(self, event, ...)
	if NAApi:GetLvl("player") <= 20 then
		if event == "VARIABLES_LOADED" then
			RequestTimePlayed()
		elseif event == "TIME_PLAYED_MSG" then
			if not NAApi:GetAddonDB("DisableAddon") then
				local total = ...
				self:UnregisterAllEvents()

				if tonumber(total)<=10 then
					self:RegisterEvent("CINEMATIC_STOP")
				else
					ToolTip_Logic:TutorialStart()
				end
			else
				NAOtherApi:DisableAddon()
			end
		elseif event == "CINEMATIC_STOP" then
			self:UnregisterAllEvents()
			NewbieAssistantToturialKeyboardFrame.ShowKB = true
			NAApi:Sleep(2,function()ToolTip_Logic:TutorialStart()end)
		end
	else
		self:UnregisterAllEvents()
	end
end

function NewbieAssistantToturialKeyboardFrame_OnHide(self)
	TutorialTinyMsgFrame_Hide(-1)
	NewbieAssistantToturialMouseFrame:Show()
end