local L = LibStub("AceLocale-3.0"):NewLocale("DuowanChat", "zhCN",true)
if not L then return end
L["DWChatTitle"]="魔盒聊天条"
L["DWChat"]="魔盒聊天"
L["ChatFrame"]="聊天快捷栏"
L["IconFrame"]="聊天表情栏"
L["DWChat provides you convient tools like copy text, name highlight and timestamps"]="魔盒聊天条为你提供复制聊天文字，高亮姓名等各种功能。"
L["Enable DWChat"]="使用魔盒聊天增强"
L["Timestamp setting"]="聊天时间设置"
L["Enable timestamp"]="显示聊天时间"
L["Enable second"]="显示具体秒数"
L["Class setting"]="职业设置"
L["Enable Class Color"]="显示职业颜色"
L["Enable Level"]="显示发言人的级别"
L["Enable Group"]="团队时显示小队编号"

L["BigFoot Channel has been blocked"] = "|cffd20000停止接收世界频道及转发消息。|r"
L["BigFoot Channel has been unblocked"] = "|cff00d200继续接收世界频道及转发消息。|r"

L["Channel mute label"] = "屏蔽世界频道";
L["Channel mute desc"] = "屏蔽世界频道，不再收到此频道的消息。";

L["Channel setting"]="频道设置"
L["Use short channel names"]="使用短频道名"
L["Enable copy text"]="复制聊天文字"
L["Use short channel names"]="使用短频道名"
L["Enable emotion icons"]="使用聊天图标"
L["Enable channel buttons"]="显示频道快捷切换按钮"
L["Enable channel buttons move"]="解锁频道快捷栏(可移动)"
L["Fast chat channel provides you easy access to different channels"] = "提供快速切换至不同聊天频道的按钮，并可以自定义快捷键"
L["this function allows you to use emtion icons in your chat, and others who has this addon enabled can see your emtion icons"]="为使用者提供可在聊天中使用的表情图标，并且其他有此插件的人可以看到这些图标"
L["Press Ctrl-C to Copy the text"]="使用Ctrl+C来复制文字"
L["Chat Channel"] = "聊天通道"

-- 属性
L["HEAD"] = "";
L["HP"] = "生命";
L["MP"] = "魔法";
L["LV"] = "等级";
L["CLASS"] = "职业";
L["MTALENT"] = "主";
L["STALENT"] = "副";
L["STR"] = "力量";
L["AGI"] = "敏捷";
L["STA"] = "耐力";
L["INT"] = "智力";
L["SPI"] = "精神";
L["AP"] = "强度";
L["HIT"] = "命中";
L["CRIT"] = "爆击";
L["EXPER"] = "精准";
L["MST"] = "精通";
L["SSP"] = "法伤";
L["SHP"] = "治疗";
L["HASTE"] = "急速";
L["SMR"] = "5秒回蓝";
L["ARMOR"] = "护甲";
L["DEF"] = "防御";
L["DODGE"] = "躲闪";
L["PARRY"] = "招架";
L["BLOCK"] = "格挡";
L["CRDEF"] = "韧性";
L["NONE"] = "无";
L["ILV"] = "装备等级";
L["MRPEN"] = "护甲穿透";
L["SPEN"] = "法术穿透";

--class names
L.Mage ="法师"
L.Druid ="德鲁伊"
L.Hunter="猎人"
L.Paladin ="圣骑士"
L.Priest ="牧师"
L.Rogue ="潜行者"
L.Shaman ="萨满祭司"
L.Warlock ="术士"
L.Warrior ="战士"
L.DeathKnight="死亡骑士"

--channels
L["Guild"]="公会"
L["Raid"]="团队"
L["Party"]="小队"
L["General"]="综合"
L["Trade"]="交易"
L["WorldDefense"]="世界防务"
L["LocalDefense"]="本地防务"
L["BattleGround"]="战场"

L["Yell"]="喊道"
L["Say"]="说"
L["WhisperTo"]="发送给"
L["WhisperFrom"]="悄悄地说"
L["BigFootChannel"] = "大脚世界频道"
L["WorldChannel"] = "世界频道"
L["JoinChannel1"] = "进入频道"
L["JoinChannel2"] = "加入频道"
L["LeaveChannel"] = "离开频道"
L["OwnChannel"] = "频道所有者已变更为"
L["PasswordChange"] = "密码已被"
L["ModifyChannel"] = "获得了修改权限"
L["SayTooltip"] = "普通说话"
L["PartyTooltip"] = "小队发言"
L["RaidTooltip"] = "团队发言"
L["BGTooltip"] = "战场发言"
L["GuildTooltip"] = "公会发言"
L["YellTooltip"] = "大喊"
L["WhisperTooltip"] = "密语"
L["OfficerTooltip"] = "官员频道"
L["BigFootTooltip"] = "大脚世界频道"
L["LFG"] = "寻求组队"
L["GuildRecruit"]="公会招募"

L["GuildShort"]="会"
L["RaidShort"]="团"
L["PartyShort"]="队"
L["YellShort"]="喊"
L["BattleGroundShort"]="战"
L["OfficerShort"]="官"
L["BigFootShort"]="世"
L["WhisperToShort"]="密"
L["WhisperFromShort"]="密"
L["ShortLFG"] = "组"
L["GeneralShort"]="综"
L["TradeShort"]="交"
L["LocalDefenseShort"]="本"
L["WorldDefenseShort"]="世"
L["GuildRecruitShort"]="招"
L["DWLFG"] = "转"
L["InstanceShort"] = "副"

-- Capital Cities
L["Shattrath City"] = "沙塔斯城"
L["Exodar"] = "艾索达"
L["Silvermoon City"] = "银月城"
L["Dalaran"] = "达拉然"
L["Orgrimmar"] = "奥格瑞玛"
L["Stormwind City"] = "暴风城"
L["Ironforge"] = "铁炉堡"
L["Darnassus"] = "达纳苏斯"
L["Undercity"] = "幽暗城"
L["Thunder Bluff"] = "雷霆崖"

--- emo icons
L.Angel="天使"
L.Angry="生气"
L.Biglaugh="大笑"
L.Clap="鼓掌"
L.Cool="酷"
L.Cry="哭"
L.Cute="可爱"
L.Despise="鄙视"
L.Dreamsmile="美梦"
L.Embarras="尴尬"
L.Evil="邪恶"
L.Excited="兴奋"
L.Faint="晕"
L.Fight="打架"
L.Flu="流感"
L.Freeze="呆"
L.Frown="皱眉"
L.Greet="致敬"
L.Grimace="鬼脸"
L.Growl="龇牙"
L.Happy="开心"
L.Heart="心"
L.Horror="恐惧"
L.Ill="生病"
L.Innocent="无辜"
L.Kongfu="功夫"
L.Love="花痴"
L.Mail="邮件"
L.Makeup="化妆"
L.Mario="马里奥"
L.Meditate="沉思"
L.Miserable="可怜"
L.Okay="好"
L.Pretty="漂亮"
L.Puke="吐"
L.Shake="握手"
L.Shout="喊"
L.Silent="闭嘴"
L.Shy="害羞"
L.Sleep="睡觉"
L.Smile="微笑"
L.Suprise="吃惊"
L.Surrender="失败"
L.Sweat="流汗"
L.Tear="流泪"
L.Tears="悲剧"
L.Think="想"
L.Titter="偷笑"
L.Ugly="猥琐"
L.Victory="胜利"
L.Volunteer="雷锋"
L.Wronged="委屈"

if GetLocale()=="zhCN" then
	BINDING_HEADER_DWCTITLE="魔盒聊天条"
	BINDING_NAME_DWCSAY="说话"
	BINDING_NAME_DWCPARTYCHANNEL="小队频道发言"
	BINDING_NAME_DWCRAIDCHANNEL="团队频道发言"
	BINDING_NAME_DWCBGCHANNEL="战场频道发言"
	BINDING_NAME_DWCGUILDCHANNEL="公会频道发言"
	BINDING_NAME_DWCYELL="大喊"
	BINDING_NAME_DWCWHISPER="密聊"
	BINDING_NAME_DWCOFFICER="官员频道发言"
end