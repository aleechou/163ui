local L = LibStub("AceLocale-3.0"):NewLocale("ChannelClean","zhTW")
if not L then return end

L["NOTICE_message"] = "內容過濾: %s (#%d)"
L["NOTICE_player"] = "玩家過濾: %s (#%d)"
L["NOTICE_trigger"] = "內容觸發器: %s (#%d)"
L["NOTICE_trigger_temp"] = "觸發器自動過濾玩家: %s"
L["NOTICE_flush"] = "刷屏過濾: %s"
L["NOTICE_flushSimilar"] = "相似刷屏過濾: %s"

L["Flush Control"] = "刷屏控制"
L["Enable anti flush control"] = "啟用防止刷屏控制"
L["Only anti same message"] = "只過濾相同內容的刷屏"
L["Anti flush ban time"] = "臨時禁止刷屏時間"
L["Flush control monitor"] = "防刷屏監控頻道"
L["Only anti similar message"] = "只過濾相似內容的刷屏"
L["Message similar score (percent)"] = "內容相似度 (百分比)"

L["Filter And Notice Options"] = "監控及提示設置"
L["Enable notice"] = "開啟提示"
L["Notice interval"] = "提示間隔"
L["Bypass self"] = "不過濾自己"

L["ResetDB_Confirm"] = "是否確認重置所有選項為默認值?"
L["All settings are reset to default value."] = "所有選項已經重置為默認值."
L["Reset to Default Profile"] = "重置為默認配置"

L["CHAT_MSG_CHANNEL"] = GLOBAL_CHANNELS
L["CHAT_MSG_SAY"] = CHAT_MSG_SAY
L["CHAT_MSG_WHISPER"] = CHAT_MSG_WHISPER_INFORM
L["CHAT_MSG_YELL"] = CHAT_MSG_YELL
L["CHAT_MSG_GUILD"] = CHAT_MSG_GUILD
L["CHAT_MSG_PARTY"] = CHAT_MSG_PARTY
L["CHAT_MSG_RAID"] = CHAT_MSG_RAID
L["CHAT_MSG_SYSTEM"] = CHAT_MSG_SYSTEM
L["CHAT_MSG_BATTLEGROUND"] = CHAT_MSG_BATTLEGROUND
L["CHAT_MSG_BATTLEGROUND_LEADER"] = CHAT_MSG_BATTLEGROUND_LEADER
L["CHAT_MSG_RAID_LEADER"] = CHAT_MSG_RAID_LEADER

L["Filter Monitor"] = "過濾監控頻道"

L["Load Default Rules"] = "載入默認過濾規則"
L["Load Default Rules Desc"] = "將清除你所有的過濾規則並載入默認的過濾規則"

L["Add Rule"] = "添加規則(1級小號已被自動過濾掉密語發言！)"
L['Delete Rule'] = "刪除規則"

L["Message Filter"] = "內容過濾"
L["Player Filter"] = "玩家過濾"
L["Trigger Filter"] = "觸發器過濾"
L["Trigger Filter Desc"] = "触发器功能说明：一旦某个玩家发布的消息符合触发器的规则，就始终把这个玩家屏蔽掉，适用于预判发广告的。"


L["Already loaded default rules."] = "已加載默認規則"
L["ChannelClean"] = "聊天過濾";
L["DefaultRules"] = {
	["trigger"] = {
		"[0-9]+金=[0-9]+元",
		"[0-9]+G=[0-9]+元",
		"代.*刷",
		"代.*打",
		"代.*練",
		"淘.*寶",
		"遊.*戲.*幣",
		"優.*惠.*促.*銷",
		"平臺交易",
		"擔保",
		"純手工",
		"淘寶",
		"遊戲幣",
		"代打",
		"代練",
		"工作室",
		"戰點",
		"手工金",
		"手工G",
		"皇冠店",
		"一賠",
		"點心",
		"沖鉆",
		"店鋪",
		"皇冠",
		"評級",
		"小卡",
		"大卡",
		"套餐",
		"手工帶",
		"代刷",
		"帶刷",
		"手工帶",
		"元=",
		"手工帶",
		"消保",
		"好評",
	}
}