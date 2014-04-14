-----------------------------------------------------------------------
-- Locals
-----------------------------------------------------------------------
local _, cf = ...

cf.L = {
	["You"] = "You",
	["Space"] = ", ",
	["Channel"] = "大脚世界频道",
	["RaidAlert"] = "%*%*(.+)%*%*",
	["QuestReport"] = "Quest progress%s?:",
	["Achievement"] = "[%s] have earned the achievement %s!",
	["LearnSpell"] = "You have learned: %s",
	["UnlearnSpell"] = "You have unlearned: %s",
	["FriendlistFull"] = "Your friend list is full, remove 2 for this addon to function properly!",
}
if (GetLocale() == "zhCN") then
	cf.L = {
		["You"] = "你",
		["Space"] = "、",
		["Channel"] = "大脚世界频道",
		["RaidAlert"] = "%*%*(.+)%*%*",
		["QuestReport"] = "任务进度%s?[:：]",
		["Achievement"] = "[%s]获得了成就%s!",
		["LearnSpell"] = "你学会了技能: %s",
		["UnlearnSpell"] = "你遗忘了技能: %s",
		["FriendlistFull"] = "你的好友列表已满，现已关闭过滤小号功能，如需再次打开，请在腾出空位后输入/cf level开启。",
	}
elseif (GetLocale() == "zhTW") then
	cf.L = {
		["You"] = "你",
		["Space"] = "、",
		["Channel"] = "大腳世界頻道",
		["RaidAlert"] = "%*%*(.+)%*%*",
		["QuestReport"] = "任務進度%s?[:：]",
		["Achievement"] = "[%s]獲得了成就%s!",
		["LearnSpell"] = "你學會了技能: %s",
		["UnlearnSpell"] = "你遺忘了技能: %s",
		["FriendlistFull"] = "你的好友列表已滿，現已關閉過濾小號功能，如需再次打開，請在騰出空位後輸入/cf level開啓。",
	}
end