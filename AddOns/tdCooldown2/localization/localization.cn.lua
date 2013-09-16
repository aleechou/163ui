
if GetLocale() ~= "zhCN" then return end
COOLLINE_UNLOCK_TEXT = "线性冷却 - 拖动冷却条改变位置, 拖动红色小点改变大小";
local L = TDCOOLDOWN2_LACALE

L.Rank = "^等级 (%d+)$"
L.Move = "移动"
L.CDOver = "%s冷却完成"
L.Updated = "升级到 %s beta！"
L.UpdatedIncompatible = "无法从不兼容的版本升级，加载默认配置。"
L.NewUser = "这是该帐号第一次使用tdCooldown2，已载入默认设置。"
L.ErrorFont = "错误的字体设置%s，%s已载入。"
L.Title = "太多冷却2 设置";
L["Options loaded !"] = "设置界面已载入！";
L["options load failed!!"] = "设置界面载入失败！";
L["RightClick to locked"] = "右键单击锁定冷却计时条";
L["Loaded Default Settings"] = "已载入默认设置。";
L["Center Anchor Text"] = "左键:拖动\n右键:隐藏";
L.Subtitle = [[


关于：


    插件名称：太多冷却2
    插件作者：太多太多（ldz5）
    插件版本：%s


小帖士：


    1.输入/tCD /tCD2 /tdCooldown2均可进入设置界面。
    2.拖动条右边的方框可精确修改。
    3.拖动条可以使用鼠标滚轮来调节。
    4.所有输入框体需按回车后生效。
    5.Buff的计时上限设为0,即可设为无上限。
    6.计时条的测试按钮能够让你快速预览效果。
    7.不计时列表只对计时条与中部提示有效。
]];