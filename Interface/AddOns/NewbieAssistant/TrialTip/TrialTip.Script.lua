-- Author      : s1172
-- Create Date : 2013/2/28 13:17:52

local TrialTip_Script = CreateFrame("frame","TrialTip_Script")

-- locale
local L = TrialTipApi.Localization

-- 提示框字体大小
TrialTip_Script.FONTSIZE = 20

-- 官方公会名称
TrialTip_Script.GuildName = L["Guild Name"]
TrialTip_Script.GuildContent = L["WoW Newbie Assistant"]

-- 充值优势
TrialTip_Script.ChargeDescription={
	L["TrialAccountTips1"],
	L["TrialAccountTips2"],
	L["TrialAccountTips3"],
	L["TrialAccountTips4"],
	L["TrialAccountTips5"],
	L["TrialAccountTips6"],
	L["TrialAccountTips7"],
}

--- 试玩账号限制事件
-- 事件名称,point,relativeFrame,relativePoint,ofsx,ofsy
TrialTip_Script.Event={
	{"CHAT_MSG_CHANNEL_NOTICE","BOTTOM","ChatFrame1","TOP",0,5},
	{"MAIL_SHOW","BOTTOM","MailFrame","TOP",0,5},
	{"TRADE_CLOSED","TOP","UIParent","TOP",0,0},
}

-- 初始化
function TrialTip_Script:OnLoad()
	if IsTrialAccount() then
		TrialTip_Script:TrialTips()
	elseif not IsInGuild() and  NAApi:GetLvl("player") <= 5 and UnitFactionGroup("player") ~= "Neutral" then
		if not NAApi:GetAddonDB("GuildInvited") then
			--NAApi:RegEvent(TrialTip_Script,"PLAYER_REGEN_ENABLED",TrialTip_Script["PLAYER_REGEN_ENABLED"],true)
		end
	end
end

-- 自动接受官方公会邀请
function TrialTip_Script:GUILD_INVITE_REQUEST(self,...)
	local invitename, gname = ...
	if gname == TrialTip_Script.GuildName then
		NAApi:Sleep(0.1,function()GuildInviteFrameJoinButton:Click()end)
		NAApi:UnregEvent(TrialTip_Script,"GUILD_INVITE_REQUEST",TrialTip_Script["GUILD_INVITE_REQUEST"])
	end
end

-- 脱离战斗后显示邀请加公会提示
function TrialTip_Script:PLAYER_REGEN_ENABLED(self,event,...)
	-- 提示框
	StaticPopupDialogs["TrialTip_Script_Invite_Frame"] = {
		text = L["We invite you join offical guild"],
		button1 = OKAY,
		button2 = CANCEL,
		timeout = 0,
		hideOnEscape = 0,
		OnAccept = function(self)
			NAApi:RegEvent(TrialTip_Script,"GUILD_INVITE_REQUEST",TrialTip_Script["GUILD_INVITE_REQUEST"])
			LookingForGuildFrameTab3:Click()
			RequestGuildMembership(TrialTip_Script.GuildName,TrialTip_Script.GuildContent)
			ToggleGuildFinder()
		end,
		OnCancel = function(self)
			ToggleGuildFinder()
		end,
	}
	if not IsInGuild() then
		StaticPopup_Show("TrialTip_Script_Invite_Frame")
		ToggleGuildFinder()
		NAApi:SetAddonDB("GuildInvited", true)

		-- 公会查找器按钮
		btnGuildFinder={
			LookingForGuildQuestButton,-- 任务
			LookingForGuildDungeonButton,-- 地下城
			LookingForGuildRaidButton,-- 团队副本
			LookingForGuildPvPButton,-- PvP
			LookingForGuildRPButton,-- 角色扮演
			LookingForGuildWeekdaysButton,-- 平日
			LookingForGuildWeekendsButton,-- 周末
			LookingForGuildTankButton["checkButton"],-- 坦克
			LookingForGuildHealerButton["checkButton"],-- 治疗
			LookingForGuildDamagerButton["checkButton"],-- 伤害输出
			LookingForGuildBrowseButton,-- 浏览公会
		}

		for i = 1, #btnGuildFinder-1, 1 do
			if not btnGuildFinder[i]:GetChecked() then
				btnGuildFinder[i]:Click()
			end
		end

		NAApi:Sleep(0.5,function()btnGuildFinder[#btnGuildFinder]:Click()end)
		--NAApi:Sleep(0.2,function()btnGuildFinder[#btnGuildFinder]:Click()end)
	end
end

-- 试玩限制激活
function TrialTip_Script:TrialTips()
	for i = 1, #TrialTip_Script.ChargeDescription, 1 do
		NAApi:AddLine(TrialTip_GameToolTip.Text,TrialTip_Script.ChargeDescription[i])
	end

	for i,k in pairs(TrialTip_Script.Event) do
		NAApi:RegEvent(self,k[1],function(self,event,...)
			arg1 = ...
			if not arg1 or arg1 == "TRIAL_RESTRICTED" then
				TrialTipFrame_Show(nil,_G[k[3]],k[2],_G[k[3]],k[4],k[5],k[6],TrialTipApi:Localize("IsTrialAccount"),TrialTip_Script.FONTSIZE)
			end
		end)
	end
end

function TrialTip_Script:UpdateGameTooltip()
	TrialTip_GameToolTip:ClearAllPoints()
    TrialTip_GameToolTip:SetPoint("TOP", TrialTipFrame, "BOTTOM",0,-5)
	TrialTip_GameToolTip:Show()
end

function TrialTipFrame:OnEnter()
	self.Hover = true
	TrialTip_Script:UpdateGameTooltip()
end

function TrialTipFrame:OnLeave()
	TrialTip_GameToolTip:Hide()

	self.Hover = false
	self:Hide()
	self:ClearAllPoints()
end

NAApi:RegEvent(TrialTip_Script,"VARIABLES_LOADED",TrialTip_Script["OnLoad"],true)