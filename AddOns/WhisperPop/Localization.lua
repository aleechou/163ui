------------------------------------------------------------
-- Localization.lua
--
-- Abin
-- 2010-9-28
------------------------------------------------------------

-- Default(English)
WHISPERPOP_LOCALE = {
	["title"] = "WhisperPop",
	["tip tooltip"] = "Left-drag to move this tip icon, left-click to open WhisperPop main frame.",
	["no new messages"] = "No unread messages",
	["new messages from"] = "Unread messages from: ",
	["receive only"] = "Show received messages only",
	["sound notifying"] = "Sound notifying",
	["time"] = "Show time stamp",
	["receive only tooltip"] = "If checked, sent messages will not be displayed in the list.",
	["sound notifying tooltip"] = "If checked, you will be notifyed with a sound alert every time a new message comes in.",
	["time tooltip"] = "If checked, a time stamp will be displayed in front of every message text.",
	["delete messages"] = "Delete all messages",
	["delete messages tooltip"] = "Click to delete all existing messages.",
	["keep messages"] = "Keep all messages",
	["keep messages tooltip"] = "Keep all existing messages.",
	["toggle frame"] = "Toggle WhisperPop frame",
}

if GetLocale() == "zhCN" then
	-- 简体中文
	WHISPERPOP_LOCALE = {
		["title"] = "密语记录",
		["tip tooltip"] = "拖拽左键以移动此提示图标，点击左键打开WhisperPop主框体。",
		["no new messages"] = "没有未阅读消息",
		["new messages from"] = "未阅读消息来自: ",
		["receive only"] = "仅显示接收到的消息",
		["sound notifying"] = "声音提示",
		["time"] = "显示时间标签",
		["receive only tooltip"] = "如果选中，外发的消息将不会显示在列表中。",
		["sound notifying tooltip"] = "如果选中，每次接收到新消息时将发出声音提示。",
		["time tooltip"] = "如果选中，时间标签将被添加到每一行消息文字前面。",
		["delete messages"] = "删除所有消息",
		["delete messages tooltip"] = "点击删除所有现有的消息。",
		["keep messages"] = "保留历史记录",
		["keep messages tooltip"] = "保留一天以内的消息，而且同帐号的各个角色均可查看。\n \n|cffff3333严重警告：因密语记录可以打开魔兽存档随意查看，因此请不要在网吧等公共环境开启此选项，以免信息泄漏。|r",
		["toggle frame"] = "打开/关闭WhisperPop框体",
	}

elseif GetLocale() == "zhTW" then
	-- 繁體中文
	WHISPERPOP_LOCALE = {
		["title"] = "WhisperPop",
		["tip tooltip"] = "拖拽左鍵以移動此提示圖標，點擊左鍵打開WhisperPop主框體。",
		["no new messages"] = "沒有未閱讀消息",
		["new messages from"] = "未閱讀消息來自: ",
		["receive only"] = "僅顯示接收到的消息",
		["sound notifying"] = "聲音提示",
		["time"] = "顯示時間標簽",
		["receive only tooltip"] = "如果選中，外發的消息將不會顯示在列表中。",
		["sound notifying tooltip"] = "如果選中，每次接收到新消息時將發出聲音提示。",
		["time tooltip"] = "如果选中，時間標簽將被添加到每一行消息文字前面。",
		["delete messages"] = "刪除所有消息",
		["delete messages tooltip"] = "點擊刪除所有現有的消息。",
		["delete messages"] = "保留歷史記錄",
		["delete messages tooltip"] = "保留一天內消息 \n|cffff3333嚴重警告：因密語記錄可打開魔獸存檔隨意查看，因此請不要在網吧等公共環境開啟此項，以免信息洩露。|r",
		["toggle frame"] = "打開/關閉WhisperPop框體",
	}
end