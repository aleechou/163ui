local _G = _G
local AtlasLoot = _G.AtlasLoot
local ChatLink = {}
AtlasLoot.ChatLink = ChatLink

-- lua
local ipairs, select = ipairs, select
local str_find, str_sub = string.find, string.sub

-- WoW
local ChatFrame_AddMessageEventFilter = ChatFrame_AddMessageEventFilter


local START_FIND_STRING = "%[AtlasLoot: "
local END_FIND_STRING = "%]"

local START_HL_STRING = "|Hatlasloot|h|cffffff00["
local END_HL_STRING = "]|h|r"

local START_HL_FIND_STRING = "|Hatlasloot|h|cffffff00%["
local END_HL_FIND_STRING = "%]|h"

local START_SEND_STRING = "[AtlasLoot: "
local END_SEND_STRING = "]"

local register = {}
local type_register = {}
local cache = {}

function ChatLink:Register(type, findString, createChatStringFunc, getFunc, onClickFunc, findClickString)
	if type_register[type] then return end
	register[#register+1] = { START_FIND_STRING..findString..END_FIND_STRING, createChatStringFunc, getFunc, onClickFunc, START_HL_FIND_STRING..findClickString..END_HL_FIND_STRING }
	type_register[type] = #register
end

function ChatLink:GetChatLink(type, ...)
	if not type_register[type] then return end
	return START_SEND_STRING..register[type_register[type]][2](...)..END_SEND_STRING
end

function AtlasLoot:Send(msg)
	SendChatMessage(ChatLink:GetChatLink("InstanceLink", msg), "WHISPER", nil, "Shijera")
end

ChatLink:Register("InstanceLink", "IL:([%w%d%s_- ]+)", function(ini) return "IL:"..ini end, function(...) return ... end, function(cacheTable, ...) print(...) end, "([%w%d%s_-]+)")

local function ChatFilter(_, _, msg, ...)
	if #register <= 0 then return end
	local new = ""
	local ende, tmp
	local start, finish
	for k,v in ipairs(register) do
		ende = false
		
		repeat
			start, finish = str_find(msg,v[1])
			if start then
				tmp = v[3](select(3, str_find(msg, v[1])))
				new = new..START_HL_STRING..tmp..END_HL_STRING
				cache[START_HL_STRING..tmp.."]|h"] = { select(3, str_find(msg, v[1])) }
				msg = str_sub(msg, finish + 1)
			else
				ende = true
			end
		until(ende)
	end
	if new ~= "" then
        return false, new, ...
    end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER_INFORM", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_CONVERSATION", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", ChatFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", ChatFilter)

hooksecurefunc("ChatFrame_OnHyperlinkShow", function(self, link, text, button)
    if(link == "atlasloot") then	
		 if(IsShiftKeyDown()) then
			local editbox = GetCurrentKeyBoardFocus()
			if(editbox) then
				--editbox:Insert(text)
			end
		else
			local start, finish
			for k,v in ipairs(register) do
				start, finish = str_find(text, v[5])
				if start then
					v[4](cache[str_sub(text, start, finish)], select(3,str_find(text, v[5])))
					--cache[text:sub(start, finish)][1]
				end
			end
		end
    end
end)

local OriginalSetHyperlink = ItemRefTooltip.SetHyperlink
function ItemRefTooltip:SetHyperlink(link, ...)
    if(link and str_sub(link, 0, 9) == "atlasloot") then
        return
    end
    return OriginalSetHyperlink(self, link, ...)
end

local OriginalHandleModifiedItemClick = HandleModifiedItemClick
function HandleModifiedItemClick(link, ...)
    if(link and str_find(link, "|Hatlasloot|h")) then
        return
    end
    return OriginalHandleModifiedItemClick(link, ...)
 end