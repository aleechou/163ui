--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Locales/Locale-zhCN.lua - Localized string constants (zh-CN).              *
  ****************************************************************************]]


if ( GetLocale() ~= "enCN" and GetLocale() ~= "zhCN" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan-overlay/localization/zhCN/
local Overlay = select( 2, ... );
Overlay.L = setmetatable( {
	NPCs = setmetatable( {
		[ 18684 ] = "独行者布罗加斯",
		[ 32491 ] = "迷失的始祖幼龙",
		[ 33776 ] = "古德利亚",
		[ 35189 ] = "逐日",
		[ 38453 ] = "阿克图瑞斯",
		[ 49822 ] = "玉牙页岩蛛",
		[ 49913 ] = "蕾蒂拉拉",
		[ 50005 ] = "波塞冬斯",
		[ 50009 ] = "魔布斯",
		[ 50050 ] = "索克沙拉克",
		[ 50051 ] = "鬼脚蟹",
		[ 50052 ] = "布尔吉·黑心",
		[ 50053 ] = "被放逐的萨图科",
		[ 50056 ] = "加尔",
		[ 50057 ] = "焰翼",
		[ 50058 ] = "泰罗佩内",
		[ 50059 ] = "格尔加洛克",
		[ 50060 ] = "泰博鲁斯",
		[ 50061 ] = "埃克萨妮奥娜",
		[ 50062 ] = "奥伊纳克斯",
		[ 50063 ] = "阿卡玛哈特",
		[ 50064 ] = "乌黑的赛勒斯",
		[ 50065 ] = "硕铠鼠",
		[ 50085 ] = "崩裂之怒主宰",
		[ 50086 ] = "邪恶的塔乌斯",
		[ 50089 ] = "厄运尤拉克",
		[ 50138 ] = "卡洛玛",
		[ 50154 ] = "梅迪克西斯",
		[ 50159 ] = "桑巴斯",
		[ 50815 ] = "刀疤",
		[ 50959 ] = "卡尔金",
		[ 51071 ] = "弗罗伦斯船长",
		[ 51079 ] = "船长费尔温德",
		[ 54318 ] = "安卡",
		[ 54319 ] = "马格瑞亚",
		[ 54320 ] = "班萨罗斯",
		[ 54321 ] = "莎利克斯",
		[ 54322 ] = "德丝缇拉克",
		[ 54323 ] = "柯尔利克斯",
		[ 54324 ] = "掠行之火",
		[ 54338 ] = "安塞瑞丝",
		[ 60491 ] = "怒之煞",
		[ 62346 ] = "炮舰",
	}, { __index = Overlay.L.NPCs; } );

	CONFIG_ALPHA = "透明度",
	CONFIG_DESC = "设置在哪个地图上显示怪物路径。大部分地图插件都通过世界地图的设置来控制。",
	CONFIG_SHOWALL = "永远显示所有路径",
	CONFIG_SHOWALL_DESC = "通常地图上不会显示非搜索中的怪物的路径，打开这个选项将显示所有已知的怪物的路径。",
	CONFIG_TITLE = "路径图",
	CONFIG_TITLE_STANDALONE = "_|cffCCCC88NPCScan|r.Overlay",
	MODULE_ALPHAMAP3 = "AlphaMap3 插件",
	MODULE_BATTLEFIELDMINIMAP = "战场小地图",
	MODULE_MINIMAP = "小地图",
	MODULE_RANGERING_DESC = "提示：在有稀有怪的地图上才会显示距离环。",
	MODULE_RANGERING_FORMAT = "显示大概%d码的侦测距离环",
	MODULE_WORLDMAP = "世界地图",
	MODULE_WORLDMAP_KEY_FORMAT = "%s",
	MODULE_WORLDMAP_TOGGLE = "NPCs",
	MODULE_WORLDMAP_TOGGLE_DESC = "显示_|cffCCCC88NPCScan|r.Overlay已知怪物路径的路径图。",
}, { __index = Overlay.L; } );