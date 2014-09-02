﻿if GetLocale() ~= "zhCN" then return end
BINDING_HEADER_GRIDBUFFICONS = "Grid增益减益图标";
BINDING_NAME_GRIDBUFFICONS_TOGGLE_BUFF = "切换显示增益或减益";
BINDING_NAME_GRIDBUFFICONS_TOGGLE_BUFF_FILTER = "切换显示全部或仅仅可施放(可移除)的状态";

GridBuffIconsLocale = {
	["Buff Icons"] = "额外状态图标",

	["Show Buff instead of Debuff"] = "显示增益状态",
	["If selected, the icons will present unit buffs instead of debuffs."] = "默认显示Debuff, 如果选中则显示Buff",

	["Only castable/removable"] = "仅显示可施放(可移除)状态",
	["If selected, only shows the buffs you can cast or the debuffs you can remove."] = "勾选此项则显示Debuff时仅显示你可以驱散的, 显示Buff时仅显示你可以施加的",

	["Buff Name Filter"] = "隐藏特定状态",
	["Buffs NOT TO show. Use ',' between the names."] = "输入要隐藏的增益或减益名称, 用','分隔多个, 例如'精疲力竭,英勇风采'",
	
	["Icons Size"] = "图标大小",
	["Size for each buff icon"] = "每个图标的大小",
	
	["Offset X"] = "X轴偏移",
	["X-axis offset from the selected anchor point, minus value to move inside."] = "第一个图标的偏移量, 负数表示向内移动, 正数表示向外",

	["Offset Y"] = "Y轴偏移",
	["Y-axis offset from the selected anchor point, minus value to move inside."] = "第一个图标的偏移量, 负数表示向内移动, 正数表示向外",

	["Alpha"] = "图标透明度",
	["Alpha value for each buff icon"] = "每个图标的透明度",

	["Icon Numbers"] = "图标个数",
	["Max icons to show."] = "最多显示的buff/debuff个数",
	["Icons Per Row"] = "一列的图标数",
	["Sperate icons in several rows."] = "通过限制一列的图标数, 可以将图标分为若干列",

	["Orientation of Icon"] = "图标排列方向",
	["Set icons list orientation."] = "选择图标是水平排列还是垂直排列",

	["VERTICAL"] = "垂直",
	["HORIZONTAL"] = "水平",

	["Anchor Point"] = "图标位置",
	["Anchor point of the first icon."] = "第一个图标相对Grid框架的位置",
	["TOPRIGHT"] = "右上角",
	["TOPLEFT"] = "左上角",
	["BOTTOMLEFT"] = "左下角",
	["BOTTOMRIGHT"] = "右下角",
}
