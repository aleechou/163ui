--[=[
	Language Localization: zhCN
	Translated by: name <email address>
]=]

if GetLocale() ~= "zhCN" then return end
local L = JPackLocale


L.TYPE_BAG = "容器"
L.TYPE_FISHWEAPON = "鱼竿"
L.TYPE_MISC = "其它"
L.TYPE_CONSUMABLE = "消耗品"

JPACK_ORDER={"旅店老板的女儿","炉石","##坐骑","矿工锄","剥皮小刀","鱼竿","#鱼竿","#武器","#护甲",
"#武器##其它","#护甲##其它","#配方","#任务","##元素","##金属和矿石","##草药",
"#材料","##珠宝","#消耗品","##布料","#商品","##肉类","#","鱼油","灵魂碎片","#其它"}

JPACK_DEPOSIT={"##元素","##金属和矿石","#材料","##草药","#珠宝","#容器"}
JPACK_DRAW={"#任务","##草药"}

L["HELP"] = '输入"/jpack help"获取帮助.'
L["COMPLETE"] = "整理完毕..."
L["WARN"] = "请先拿掉你鼠标上的物品. 整理时不要抓起物品、金钱、法术."
L["Unknown command"] = "未知命令"

-- Help info
L["Slash command"] = "命令"
L["Pack"] = "整理"
L["Set sequence to ascend"] = "正序整理"
L["Set sequence to descend"] = "逆序整理"
L["Save to the bank"] = "保存到银行"
L["Load from the bank"] = "从银行取出"
L["Packup guildbank"] = "整理公会银行"
L["Print help info"] = "显示帮助"

L["Sequence"] = "整理顺序"
L["asc"] = "正序"
L["desc"] = "逆序"

L["Click"] = "点击"
L["Pack"] = "整理"

L["Alt + Left-Click"] = "Alt + 左键"
L["Shift + Left-Click"] = "Shift + 左键"
L["Ctrl + Left-Click"] = "Ctrl + 左键"
L["Shift + Right-Click"] = "Shift + 右键"
L["Ctrl + Right-Click"] = "Ctrl + 右键"
	
