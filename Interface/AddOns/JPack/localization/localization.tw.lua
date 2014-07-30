--[=[
	Language Localization: zhTW
	Translated by: name <email address>
]=]

if GetLocale() ~= "zhTW" then return end
local L = JPackLocale

L.TYPE_BAG = "容器"
L.TYPE_FISHWEAPON = "魚竿"
L.TYPE_MISC = "雜項"
L.TYPE_CONSUMABLE = "消耗品"

JPACK_ORDER = {"爐石","##坐騎","採礦鎬","剝皮小刀","寶石匠的工具箱","簡單的磨粉機","魚竿","#魚竿","#武器","#護甲","#武器##其它","#護甲##其它","#配方","#任務","##元素材料","##金屬與石頭","##草藥","#材料","##珠宝","#消耗品","##布料","#商人","##肉類","#","魚油","灵魂碎片","#其它"}
JPACK_DEPOSIT = {"#商人","#材料","##草藥","##肉類","#珠寶","#容器"}
JPACK_DRAW = {"#任務"}

L["HELP"] = '輸入"/jpack help"獲取幫助.'
L["COMPLETE"] = "整理完畢..."
L["WARN"] = "請先拿掉你鼠標上的物品. 整理時不要抓起物品、金錢、法術."
L["Unknown command"] = "未知指令"

-- Help info
L["Slash command"] = "命令"
L["Pack"] = "整理"
L["Set sequence to ascend"] = "正序整理"
L["Set sequence to descend"] = "逆序整理"
L["Save to the bank"] = "保存到銀行"
L["Load from the bank"] = "從銀行取出"
L["Packup guildbank"] = "整理公會銀行"
L["Print help info"] = "顯示幫助"

L["Sequence"] = "整理順序"
L["asc"] = "正序"
L["desc"] = "逆序"

L["Click"] = "點擊"
L["Pack"] = "整理"

L["Alt + Left-Click"] = "Alt + 左鍵"
L["Shift + Left-Click"] = "Shift + 左鍵"
L["Ctrl + Left-Click"] = "Ctrl + 左鍵"
L["Shift + Right-Click"] = "Shift + 右鍵"
L["Ctrl + Right-Click"] = "Ctrl + 右鍵"

