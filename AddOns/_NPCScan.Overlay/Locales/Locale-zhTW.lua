--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Locales/Locale-zhTW.lua - Localized string constants (zh-TW).              *
  ****************************************************************************]]


if ( GetLocale() ~= "enTW" and GetLocale() ~= "zhTW" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan-overlay/localization/zhTW/
local Overlay = select( 2, ... );
Overlay.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "無氏族的伯卡茲",
		[ 32491 ] = "時光流逝元龍",
		[ 33776 ] = "剛卓亞",
		[ 35189 ] = "史科爾",
		[ 38453 ] = "大角",
		[ 49822 ] = "翡翠牙",
		[ 49913 ] = "女神菈菈",
		[ 50005 ] = "波賽達斯",
		[ 50009 ] = "莫比斯",
		[ 50050 ] = "肖克·薩菈克",
		[ 50051 ] = "鬼蟹",
		[ 50052 ] = "伯吉·黑心",
		[ 50053 ] = "『流亡者』薩爾圖克",
		[ 50056 ] = "加爾",
		[ 50057 ] = "燄翼",
		[ 50058 ] = "懼龜",
		[ 50059 ] = "戈爾加羅克",
		[ 50060 ] = "特波魯斯",
		[ 50061 ] = "克薩瑞歐納",
		[ 50062 ] = "艾歐納克斯",
		[ 50063 ] = "阿克瑪哈特",
		[ 50064 ] = "黑翼席魯斯",
		[ 50065 ] = "末日犰狳",
		[ 50085 ] = "霸主怒斬",
		[ 50086 ] = "邪惡的塔維斯",
		[ 50089 ] = "毀滅祖拉克",
		[ 50138 ] = "卡羅馬",
		[ 50154 ] = "麥碟司",
		[ 50159 ] = "森巴斯",
		[ 50815 ] = "斯卡爾",
		[ 50959 ] = "卡爾金",
		[ 51071 ] = "佛羅倫斯船長",
		[ 51079 ] = "劣風船長",
		[ 54318 ] = "安卡",
		[ 54319 ] = "瑪格瑞亞",
		[ 54320 ] = "班薩洛斯",
		[ 54321 ] = "索利克斯",
		[ 54322 ] = "殆死堤拉克",
		[ 54323 ] = "基利克斯",
		[ 54324 ] = "掠焰",
		[ 54338 ] = "安斯銳斯",
		[ 60491 ] = "憤怒之煞",
		[ 62346 ] = "帆船",
	}, { __index = Overlay.L.NPCs; } );

	CONFIG_ALPHA = "透明度",
	CONFIG_DESC = "設定在哪張地圖顯示怪物移動路徑。大部分的地圖插件都針對世界地圖做設定。",
	CONFIG_SHOWALL = "永遠顯示所有路徑",
	CONFIG_SHOWALL_DESC = "通常地圖上不會顯示非搜尋中的怪物的路徑圖。開啟這個選項將永遠顯示所有已知的路徑圖。",
	CONFIG_TITLE = "路徑圖",
	CONFIG_TITLE_STANDALONE = "_|cffCCCC88NPCScan|r.Overlay",
	MODULE_ALPHAMAP3 = "AlphaMap3 插件",
	MODULE_BATTLEFIELDMINIMAP = "顯示戰場迷你地圖",
	MODULE_MINIMAP = "小地圖",
	MODULE_RANGERING_DESC = "提示： 在有稀有怪的地圖才顯示距離環(例如主城跟冬握就不會顯示).",
	MODULE_RANGERING_FORMAT = "顯示大概 %d碼的偵測距離環",
	MODULE_WORLDMAP = "主要世界地圖",
	MODULE_WORLDMAP_KEY_FORMAT = "• %s",
	MODULE_WORLDMAP_TOGGLE = "NPCs",
	MODULE_WORLDMAP_TOGGLE_DESC = "如果開啟，顯示_|cffCCCC88NPCScan|r.Overlay已知怪物路徑的路徑圖。",
}, { __index = Overlay.L; } );