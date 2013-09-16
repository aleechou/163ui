function ChatEdit_CustomTabPressed(...)
    ChatEdit_CustomTabPressed_Inner(...);
end
local cycles = {
    {
        chatType = "SAY",
        use = function(self, editbox) return 1 end,
    },
    {
        chatType = "YELL",
        use = function(self, editbox) return 1 end,
    },
    {
        chatType = "PARTY",
        use = function(self, editbox) return IsInGroup() end,
    },
    {
        chatType = "RAID",
        use = function(self, editbox) return IsInRaid() end,
    },
    {
        chatType = "INSTANCE_CHAT",
        use = function(self, editbox) return select(2, IsInInstance()) == 'pvp' end,
    },
    {
        chatType = "GUILD",
        use = function(self, editbox) return IsInGuild() end,
    },
    {
        chatType = "CHANNEL",
        use = function(self, editbox, currChatType)
            if U1GetCfgValue and U1GetCfgValue("163ui_chat", "customtab/tabchannel") then
                if currChatType~="CHANNEL" then
                    currNum = IsShiftKeyDown() and 21 or 0
                else
                    currNum = editbox:GetAttribute("channelTarget");
                end
                local h, r, step = currNum+1, 20, 1
                if IsShiftKeyDown() then h, r, step = currNum-1, 1, -1 end
                for i=h,r,step do
                    local channelNum, channelName = GetChannelName(i);
                    if channelNum > 0 and not channelName:find("本地防务 %-") then
                        editbox:SetAttribute("channelTarget", i);
                        return true;
                    end
                end
            end
        end,
    },
    {
        chatType = "SAY",
        use = function(self, editbox) return 1 end,
    },

}
function ChatEdit_CustomTabPressed_Inner(self)
	if strsub(tostring(self:GetText()), 1, 1) == "/" then return end
    local currChatType = self:GetAttribute("chatType")
    --对于说然后SHIFT的情况，因为没有return，所以第一层循环会一直遍历到最后的SAY
    for i, curr in ipairs(cycles) do
        if curr.chatType== currChatType then
            local h, r, step = i+1, #cycles, 1
            if IsShiftKeyDown() then h, r, step = i-1, 1, -1 end
            if currChatType=="CHANNEL" then h = i end --频道仍然要测试一下
            for j=h, r, step do
                if cycles[j]:use(self, currChatType) then
                    self:SetAttribute("chatType", cycles[j].chatType);
                    ChatEdit_UpdateHeader(self);
                    return;
                end
            end
        end
    end
end

function U1Chat_SetChatType(chatType, index)
    local chatFrame = GetCVar("chatStyle")=="im" and SELECTED_CHAT_FRAME or DEFAULT_CHAT_FRAME
	local text = "";
	if (string.find(chatType, "CHANNEL")) then
		chatFrame.editBox:Show();
		if (chatFrame.editBox:GetAttribute("chatType") == "CHANNEL") and (chatFrame.editBox:GetAttribute("channelTarget") == index) then
			ChatFrame_OpenChat("", chatFrame);
		else
			chatFrame.editBox:SetAttribute("chatType", "CHANNEL");
			chatFrame.editBox:SetAttribute("channelTarget", index);
			ChatEdit_UpdateHeader(chatFrame.editBox);
		end
	else
		if (chatType == "WHISPER") then
			text = "";
			ChatFrame_ReplyTell(chatFrame);
			if (UnitExists("target") and UnitIsFriend("target", "player") and UnitIsPlayer("target")) then
				text = text .. UnitName("target").." ";
			end

			ChatFrame_OpenChat(text, chatFrame);
		else
			if (not chatFrame.editBox:IsVisible()) then
				ChatFrame_OpenChat("", chatFrame);
			end
			-- ChatFrame_OpenChat("", chatFrame);
			text = chatFrame.editBox:GetText();
			text = string.gsub(text, "^/[Ww] ", "");
			chatFrame.editBox:SetText(text);
			chatFrame.editBox:SetAttribute("chatType", chatType);
			ChatEdit_UpdateHeader(chatFrame.editBox);
		end
	end
	chatFrame.editBox:SetFocus();
end
