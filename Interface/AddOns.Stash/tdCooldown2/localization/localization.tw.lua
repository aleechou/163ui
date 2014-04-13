
if GetLocale() ~= "zhTW" then return end

COOLLINE_UNLOCK_TEXT = "線性冷卻 - 拖動冷卻條改變位置, 拖動紅色小點改變大小";
local L = TDCOOLDOWN2_LACALE

L.Rank = "^等級 (%d+)$";
L.Move = "移動";
L.CDOver = "%s冷卻完成";
L.Updated = "升級到%s beta！";
L.UpdatedIncompatible = "無法從不兼容的版本升級，加載默認配置。";
L.NewUser = "這是該帳號第一次使用tdCooldown2，已載入默認設置。";
L.ErrorFont = "錯誤的字體設置%s，%s已載入。";
L.Title = "太多冷卻2 设置";
L["Options loaded !"] = "設置介面已載入！"; 
L["options load failed!!"] = "設置介面載入失敗！";
L["RightClick to locked"] = "右鍵單擊鎖定冷卻計時條";
L["Loaded Default Settings"] = "已載入默認設置。";
L["Center Anchor Text"] = "左键-拖动\n右键-隐藏";
L.Subtitle = [[


關於： 


    插件名稱：太多冷卻2 
    插件作者：太多太多（ldz5） 
    插件版本：%s 


小帖士： 


     1.輸入/tCD /tCD2 /tdCooldown2均可進入設置介面。 
     2.拖動條右邊的方框可精確修改。 
     3.所有輸入框體需按回車後生效。 
     4.Buff的計時上限設為0,即可設為無上限。 
     5.計時條的測試按鈕能夠讓你快速預覽效果。 
     6.不計時列表只對計時條與中部提示有效。
]];