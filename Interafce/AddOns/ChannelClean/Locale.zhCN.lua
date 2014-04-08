local L = LibStub("AceLocale-3.0"):NewLocale("ChannelClean","zhCN")
if not L then return end

L["NOTICE_message"] = "内容过滤: %s (#%d)"
L["NOTICE_player"] = "玩家过滤: %s (#%d)"
L["NOTICE_trigger"] = "内容触发器: %s (#%d)"
L["NOTICE_trigger_temp"] = "触发器自动过滤玩家: %s"
L["NOTICE_flush"] = "刷屏过滤: %s"
L["NOTICE_flushSimilar"] = "相似刷屏过滤: %s"

L["Flush Control"] = "刷屏控制"
L["Enable anti flush control"] = "启用防止刷屏控制"
L["Only anti same message"] = "只过滤相同内容的刷屏"
L["Anti flush ban time"] = "临时禁止刷屏时间"
L["Flush control monitor"] = "防刷屏监控频道"
L["Only anti similar message"] = "只过滤相似内容的刷屏"
L["Message similar score (percent)"] = "内容相似度 (百分比)"

L["Filter And Notice Options"] = "监控及提示设置"
L["Enable notice"] = "开启提示"
L["Notice interval"] = "提示间隔"
L["Bypass self"] = "不过滤自己"

L["ResetDB_Confirm"] = "是否确认重置所有选项为默认值?"
L["All settings are reset to default value."] = "所有选项已经重置为默认值."
L["Reset to Default Profile"] = "重置为默认配置"

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

L["Filter Monitor"] = "过滤监控频道"

L["Add Rule"] = "添加规则"
L['Delete Rule'] = "删除规则"

L["Message Filter"] = "内容过滤"
L["Player Filter"] = "玩家过滤"
L["Trigger Filter"] = "触发器过滤"
L["Trigger Filter Desc"] = "触发器功能说明：一旦某个玩家发布的消息符合触发器的规则，就始终把这个玩家屏蔽掉，适用于预判发广告的。"


L["Already loaded default rules."] = "已加载默认规则"
L["ChannelClean"] = "聊天过滤";
L["DefaultRules"] = {
	["trigger"] = {
		"★",
		"☆",
		"●",
		"◆",
		"■",
		"▲",
		"〓",
		"※",
		"▆",
        "淘.*宝",
        "tao.*bao",
        "代.*练",
        "代.*打",
        "代.*刷",
        "英.*星",
        "七.*煌",
        "平台交易",
    }
}
