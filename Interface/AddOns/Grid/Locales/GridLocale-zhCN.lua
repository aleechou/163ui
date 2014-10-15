--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2012 Kyle Smith (a.k.a. Pastamancer), A. Kinley (a.k.a. Phanx) <addons@phanx.net>
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
------------------------------------------------------------------------
	GridLocale-zhCN.lua
	Simplified Chinese (简体中文) localization.
	Contributors: ananhaid, candykiss, flyflame, Ghostar, isler, samuelcup, wowuicn, yleaf
----------------------------------------------------------------------]]

if GetLocale() ~= "zhCN" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "调试"
L["Debugging"] = "调试"
L["Module debugging menu."] = "调试模块功能表。"
L["Show minimap icon"] = "显示迷你地图图标"
L["Hide minimap icon"] = "隐藏迷你地图图标"
L["Module debugging menu."] = "调试模块配置。"
L["Toggle debugging for %s."] = "打开/关闭%s的调试。"

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "调整字体轮廓。"
L["Adjust the font settings"] = "调整字体设置"
L["Adjust the font size."] = "调整字体尺寸。"
L["Adjust the height of each unit's frame."] = "调整个体框架的高度。"
L["Adjust the size of the border indicators."] = "调整每个按钮边框指示的大小。"
L["Adjust the size of the center icon."] = "调整中心图标的尺寸。"
L["Adjust the size of the center icon's border."] = "调整屏幕中心图标外框的尺寸。"
L["Adjust the size of the corner indicators."] = "调整边角指示的尺寸。"
L["Adjust the texture of each unit's frame."] = "调整个体框架的材质。"
L["Adjust the width of each unit's frame."] = "调整个体框架的宽度。"
L["Always"] = "一直"
L["Bar Options"] = "血条样式"
L["Border"] = "边框"
L["Border Size"] = "边框宽窄"
L["Bottom Left Corner"] = "左下角"
L["Bottom Right Corner"] = "右下角"
L["Center Icon"] = "中心图标"
L["Center Text"] = "中心文本"
L["Center Text 2"] = "中心文本2"
L["Center Text Length"] = "中心文本长度"
L["Color the healing bar using the active status color instead of the health bar color."] = "治疗预测条颜色使用当前状态（诅咒、中毒等）的颜色而不是血条颜色。"
L["Corner Size"] = "边角指示尺寸"
L["Darken the text color to match the inverted bar."] = "文本颜色变暗以匹配反转条。"
L["Enable Mouseover Highlight"] = "启用鼠标悬停高亮"
L["Enable right-click menu"] = "启用右击菜单"
L["Enable %s"] = "启用%s"
L["Enable %s indicator"] = "启用%s指示"
L["Font"] = "字体"
L["Font Outline"] = "字体轮廓"
L["Font Shadow"] = "字体阴影"
L["Font Size"] = "字体尺寸"
L["Frame"] = "框架"
L["Frame Alpha"] = "框架透明度"
L["Frame Height"] = "框架高度"
L["Frame Texture"] = "框架材质"
L["Frame Width"] = "框架宽度"
L["Healing Bar"] = "血条"
L["Healing Bar Opacity"] = "血条透明度"
L["Healing Bar Uses Status Color"] = "血条使用状态颜色"
L["Health Bar"] = "血条"
L["Health Bar Color"] = "血条颜色"
L["Horizontal"] = "水平"
L["Icon Border Size"] = "图标外框尺寸"
L["Icon Cooldown Frame"] = "图标冷却时间框架"
L["Icon Options"] = "图标样式"
L["Icon Size"] = "图标大小"
L["Icon Stack Text"] = "图标堆叠文字"
L["Indicators"] = "指示器"
L["Invert Bar Color"] = "反转颜色"
L["Invert Text Color"] = "反转文本颜色"
L["Make the healing bar use the status color instead of the health bar color."] = "治疗条使用状态颜色而不是治疗条颜色。"
L["Never"] = "不显示"
L["None"] = "无"
L["Number of characters to show on Center Text indicator."] = "中间文字提示器所显示文字的长度。"
L["OOC"] = "非战斗"
L["Options for assigning statuses to indicators."] = "设置界面各个位置（边、角、条、图标等）显示的信息。"
L["Options for GridFrame."] = "设置Grid框体及各个指示器的自身参数，例如宽度、高度、字体、方向等。"
L["Options for %s indicator."] = "设置%s提示器显示的内容。"
L["Options related to bar indicators."] = "血条指示器的选项"
L["Options related to icon indicators."] = "中央图标指示器的选项."
L["Options related to text indicators."] = "文字指示器的选项"
L["Orientation of Frame"] = "框架方向"
L["Orientation of Text"] = "文字方向"
L["Set frame orientation."] = "设置框架方向。"
L["Set frame text orientation."] = "设置文字方向。"
L["Sets the opacity of the healing bar."] = "设置血条的透明度。"
L["Show the standard unit menu when right-clicking on a frame."] = "右击框体显示标准单位菜单。"
L["Show Tooltip"] = "显示提示信息"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "显示单位框架的鼠标信息。选择“一直”，“不显示”或“非战斗”。"
L["Statuses"] = "状态"
L["Swap foreground/background colors on bars."] = "反转提示条上背景/前景的颜色。"
L["Text Options"] = "文字样式"
L["Thick"] = "粗"
L["Thin"] = "细"
L["Throttle Updates"] = "控制框架刷新频率"
L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = "控制团队框架刷新的频率。这个选项可能会导致Grid框架反应延迟，所以一般不需打开，除非有人加入/离开团队时会造成游戏停顿。"
L["Toggle center icon's cooldown frame."] = "打开/关闭中心图标的冷却时间框架。"
L["Toggle center icon's stack count text."] = "打开/关闭中心图标的堆叠计数文字。"
L["Toggle mouseover highlight."] = "打开/关闭鼠标悬停高亮。"
L["Toggle status display."] = "打开/关闭显示状态。"
L["Toggle the font drop shadow effect."] = "开启或关闭字体阴影效果."
L["Toggle the %s indicator."] = "打开/关闭%s指示。"
L["Top Left Corner"] = "左上角"
L["Top Right Corner"] = "右上角"
L["Vertical"] = "垂直"
L["Icon X offset"] = "横向偏移量"
L["Adjust the offset of the X-axis for center icon."] = "调整中心图标距离中心点的横坐标偏移量，左侧为负值，右侧为正值"
L["Icon Y offset"] = "纵向偏移量"
L["Adjust the offset of the Y-axis for center icon."] = "调整中心图标距离中心点的纵向偏移量，上方为正值，下方为负值"
L["Main"] = "主框架"
L["Change the main frame options."] = "修改Grid默认界面样式, 包括单位按钮长宽，血条颜色等。"

------------------------------------------------------------------------
--	GridLayout

L["10 Player Raid Layout"] = "10人团队布局"
L["25 Player Raid Layout"] = "25人团队布局"
L["40 Player Raid Layout"] = "40人团队布局"
L["Adjust background color and alpha."] = "调整背景颜色和透明度。"
L["Adjust border color and alpha."] = "调整外框的颜色和透明度。"
L["Adjust frame padding."] = "调整每个按钮之间的间距。"
L["Adjust frame spacing."] = "调整按钮与框架外框的距离。"
L["Adjust Grid scale."] = "调整框架大小比率。"
L["Advanced"] = "高级"
L["Advanced options."] = "高级选项。"
L["Allows mouse click through the Grid Frame."] = "是否允许透过 Grid 框体点击。"
L["Alt-Click to permanantly hide this tab."] = "Alt-单击总是隐藏此标签。"
L["Arena Layout"] = "竞技场布局"
L["Background color"] = "背景"
L["Battleground Layout"] = "战场布局"
L["Beast"] = "野兽"
L["Border color"] = "外框"
L["Border Texture"] = "外框材质"
L["Bottom"] = "底部"
L["Bottom Left"] = "左下"
L["Bottom Right"] = "右下"
L["By Creature Type"] = "以种类（野兽/恶魔/人型）"
L["By Owner Class"] = "以主人的职业颜色"
L["Center"] = "中心"
L["Choose the layout border texture."] = "选择外框材质布局。"
L["Clamped to screen"] = "保持在屏幕上"
L["Class colors"] = "职业颜色"
L["Click through the Grid Frame"] = "透过 Grid 框体点击"
L["Color for %s."] = "%s的颜色。"
L["Color of pet unit creature types."] = "宠物的生物种类的颜色。"
L["Color of player unit classes."] = "玩家职业颜色。"
L["Color of unknown units or pets."] = "未知单位/宠物颜色。"
L["Color options for class and pets."] = "玩家和宠物的颜色选项。"
L["Colors"] = "颜色"
L["Creature type colors"] = "生物种类颜色"
L["Demon"] = "恶魔"
L["Do not show the tab when Grid is unlocked."] = "当未锁定 Grid 时不显示标签。"
L["Dragonkin"] = "龙类"
L["Drag this tab to move Grid."] = "拖动此标签移动 Grid。"
L["Elemental"] = "元素"
L["Fallback colors"] = "已知颜色"
L["Frame lock"] = "锁定框架"
L["Group Anchor"] = "队伍锚点"
L["Hide tab"] = "隐藏标签"
L["Horizontal groups"] = "横向排列队伍"
L["Humanoid"] = "人型"
L["Layout"] = "布局"
L["Layout Anchor"] = "布局锚点"
L["Left"] = "左侧"
L["Lock Grid to hide this tab."] = "锁定 Grid 隐藏此标签。"
L["Locks/unlocks the grid for movement."] = "锁定/解锁 Grid 框体来让其移动。"
L["Not specified"] = "未分类"
L["Options for GridLayout."] = "Grid 布局的选项。"
L["Padding"] = "间距"
L["Party Layout"] = "小队布局"
L["Pet color"] = "宠物颜色"
L["Pet coloring"] = "宠物颜色"
L["Reset Position"] = "重置位置"
L["Resets the layout frame's position and anchor."] = "重置布局框架的位置和锚点。"
L["Right"] = "右侧"
L["Scale"] = "大小比率"
L["Select which layout to use when in a 10 player raid."] = "10人团队时所选择使用的布局。"
L["Select which layout to use when in a 25 player raid."] = "25人团队时所选择使用的布局。"
L["Select which layout to use when in a 40 player raid."] = "40人团队时所选择使用的布局。"
L["Select which layout to use when in a battleground."] = "在战场时所选择使用的布局。"
L["Select which layout to use when in an arena."] = "在竞技场时所选择使用的布局。"
L["Select which layout to use when in a party."] = "在小队时所选择使用的布局。"
L["Select which layout to use when not in a party."] = "没有小队时所选择使用的布局。"
L["Sets where Grid is anchored relative to the screen."] = "设置屏幕中 Grid 的锚点。"
L["Sets where groups are anchored relative to the layout frame."] = "设置布局中队伍的锚点。"
L["Set the coloring strategy of pet units."] = "设置宠物颜色策略。"
L["Set the color of pet units."] = "设定宠物的颜色。"
L["Show a tab for dragging when Grid is unlocked."] = "当未锁定 Grid 时显示标签。"
L["Show Frame"] = "显示框架"
L["Show tab"] = "显示标签"
L["Solo Layout"] = "单人布局"
L["Spacing"] = "外框距离"
L["Switch between horizontal/vertical groups."] = "选择横向/竖向显示队伍。"
L["The color of unknown pets."] = "未知宠物的颜色。"
L["The color of unknown units."] = "未知单位颜色。"
L["Toggle whether to permit movement out of screen."] = "打开/关闭是否允许把窗口移到超出屏幕的位置。"
L["Top"] = "顶部"
L["Top Left"] = "左上"
L["Top Right"] = "右上"
L["Undead"] = "亡灵"
L["Unknown Pet"] = "未知宠物"
L["Unknown Unit"] = "未知单位"
L["Using Fallback color"] = "使用已知颜色"
L["World Raid as 40 Player"] = "野外40人团队"

------------------------------------------------------------------------
--	GridLayoutLayouts

L["By Class 10"] = "10人职业"
L["By Class 10 w/Pets"] = "10人职业以及宠物"
L["By Class 25"] = "25人职业以及宠物"
L["By Class 25 w/Pets"] = "25人职业"
L["By Group 10"] = "10人团队"
L["By Group 10 w/Pets"] = "10人团队以及宠物"
L["By Group 15"] = "15人团队"
L["By Group 15 w/Pets"] = "15人团队以及宠物"
L["By Group 25"] = "25人团队"
L["By Group 25 w/Pets"] = "25人团队以及宠物"
L["By Group 25 w/Tanks"] = "25人团队及坦克"
L["By Group 40"] = "40人团队"
L["By Group 40 w/Pets"] = "40人团队以及宠物"
L["By Group 5"] = "5人小队"
L["By Group 5 w/Pets"] = "5人小队以及宠物"
L["None"] = "无"
L["Force Layout"] = "强制布局"
L["If this layout is set to any value but 'NONE', all other layout settings will not take effect."] = "如果设置此布局，则忽略其他布局设置，任何情况下都使用这种布局（无论小队团队还是10人25人）"

------------------------------------------------------------------------
--	GridLDB

L["Click to toggle the frame lock."] = "左键点击锁定/解锁框架。"
L["Right-Click to open the options menu."] = "右击打开选项功能单。"
L["Right-Click for more options."] = "右键点击打开设置界面。\n（战斗中需按住CTRL+ALT）"

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

L["Color"] = "颜色"
L["Color for %s"] = "%s的颜色"
L["Enable"] = "启用"
L["Options for %s."] = "%s的选项。"
L["Options for GridStatus."] = "设置各种状态信息的选项，例如优先级，触发后的颜色、透明度等等"
L["Options for %s."] = "%s状态的选项。"
L["Priority"] = "优先度"
L["Priority for %s"] = "%s的优先度"
L["Range filter"] = "范围过滤"
L["Range filter for %s"] = "%s的距离过滤"
L["Reset class colors"] = "重置职业颜色"
L["Reset class colors to defaults."] = "重置职业颜色为默认。"
L["Show status only if the unit is in range."] = "单位只在范围内时显示状态"
L["Status"] = "状态"
L["Status: %s"] = "状态：%s"
L["Text"] = "文字"
L["Text to display on text indicators"] = "在文字提示器上显示文字"

------------------------------------------------------------------------
--	GridStatusAggro

L["Absorbs"] = "吸收"
L["Only show total absorbs greater than this percent of the unit's maximum health."] = "只有当吸收量大于该值时才显示吸收"

------------------------------------------------------------------------
--	GridStatusAggro

L["Aggro"] = "仇恨"
L["Aggro alert"] = "仇恨警报"
L["Aggro color"] = "仇恨颜色"
L["Color for Aggro."] = "获得仇恨时的颜色。"
L["Color for High Threat."] = "高威胁时的颜色。"
L["Color for Tanking."] = "坦克时的颜色。"
L["High"] = "高"
L["High Threat color"] = "高威胁颜色"
L["Show more detailed threat levels."] = "显示更多威胁分级。"
L["Tank"] = "坦克"
L["Tanking color"] = "坦克颜色"
L["Threat"] = "威胁"

------------------------------------------------------------------------
--	GridStatusAuras

L["Add new Buff"] = "增加新的增益"
L["Add new Debuff"] = "增加新的减益"
L["Adds a new buff to the status module"] = "状态模块添加一个新的增益"
L["Adds a new debuff to the status module"] = "状态模块添加一个新的减益"
L["Auras"] = "光环"
L["<buff name>"] = "<增益名称>"
L["Buff: %s"] = "增益：%s"
L["Change what information is shown by the status color."] = "更改状态颜色信息显示。"
L["Change what information is shown by the status color and text."] = "更改状态颜色和文本信息显示。"
L["Change what information is shown by the status text."] = "更改状态文本信息显示。"
L["Class Filter"] = "职业过滤"
L["Color Shows:"] = "颜色表示的信息："
L["Color when %s is above the high threshold value."] = "%s超过高阈值时显示的颜色。"
L["Color when %s is between the low and high threshold values."] = "%s在高阈值和低阈值之间时显示的颜色。"
L["Color when %s is below the low threshold value."] = "%s小于低阈值时显示的颜色。"
L["Curse"] = "诅咒"
L["<debuff name>"] = "<减益名称>"
L["(De)buff name"] = "增（减）益名称"
L["Debuff: %s"] = "减益：%s"
L["Debuff type: %s"] = "减益类型：%s"
L["Delete (De)buff"] = "删除增（减）益"
L["Deletes an existing debuff from the status module"] = "删除状态模块内已有的一个增（减）益"
L["Disease"] = "疾病"
L["Display status only if the buff is not active."] = "仅在缺少此增益时才显示状态。"
L["Display status only if the buff was cast by you."] = "仅显示由你施放的增益。"
L["Ghost"] = "幽灵"
L["High color"] = "高值颜色"
L["High threshold"] = "高阈值"
L["Low color"] = "低值颜色"
L["Low threshold"] = "低阈值"
L["Magic"] = "魔法"
L["Middle color"] = "中值颜色"
L["Pet"] = "宠物"
L["Poison"] = "毒药"
L["Present or missing"] = "固定为所选颜色"
L["Refresh interval"] = "刷新间隔"
L["Remove %s from the menu"] = "从列表中移除%s"
L["%s colors"] = "%s颜色"
L["%s colors and threshold values."] = "%s颜色和阈值"
L["Show duration"] = "显示持续效果"
L["Show if mine"] = "我施放的"
L["Show if missing"] = "缺少时显示"
L["Show on pets and vehicles."] = "显示宠物和载具"
L["Show on %s players."] = "在%s玩家上显示。"
L["Show status for the selected classes."] = "显示选定职业的状态。"
L["Show the time left to tenths of a second, instead of only whole seconds."] = "显示零点几秒剩余时间，而不是整数秒。"
L["Show the time remaining, for use with the center icon cooldown."] = "显示的剩余时间，用于中心图标冷却。"
L["Show time left to tenths"] = "时间精确到小数点后一位"
L["%s is high when it is at or above this value."] = "达到或高于此值时%s过高。"
L["%s is low when it is at or below this value."] = "达到或低于此值时%s过低。"
L["Stack count"] = "堆叠层数"
L["Status Information"] = "设置显示的文字和颜色的含义"
L["Text Shows:"] = "文字内容显示为："
L["Time in seconds between each refresh of the status time left."] = "状态每次刷新剩余时间的秒数。"
L["Time left"] = "剩余时间"
L["Show advanced options"] = "显示每个增（减）益的高级选项"
L["Show advanced options for buff and debuff statuses.\n\nBeginning users may wish to leave this disabled until you are more familiar with Grid, to avoid being overwhelmed by complicated options menus."] = "显示增益和减益状态的高级选项，例如快结束时变色、显示剩余时间或是堆叠层数等。\n\n初级玩家建议关闭此选项，否则会被过于复杂的设置搞晕掉。"
L["Change which information is shown by the status color."] = "修改此状态的颜色所表达的信息"
L["Duration"] = "剩余时间"
L["Change which information is shown by the status text."] = "修改此状态的文字所显示的内容，例如当设置'中文文字'或'边角数字'指示器为此状态会显示所选内容，而不是固定为状态名称。"
L["Time in seconds between each refresh of the duration status."] = "每隔多少秒刷新一次剩余时间文字，不要设置的过低，会影响帧数"
L["%s is high above this value."] = "%s超过此值时，会使用'高值颜色'"
L["%s is low below this value."] = "%s小于此值时，会使用'低值颜色'"
------------------------------------------------------------------------
--	GridStatusHeals

L["Heals"] = "治疗"
L["Ignore heals cast by you."] = "忽略对自己施放的治疗。"
L["Ignore Self"] = "忽略自己"
L["Incoming heals"] = "正被治疗"
L["Minimum Value"] = "最低值"
L["Only show incoming heals greater than this percent of the unit's maximum health."] = "只当治疗量大于该值时才显示正被治疗."

------------------------------------------------------------------------
--	GridStatusHealth

L["Color deficit based on class."] = "用职业颜色来显示损失的血量。"
L["Color health based on class."] = "用职业颜色来显示血量。"
L["DEAD"] = "死"
L["Death warning"] = "死亡警报"
L["FD"] = "假"
L["Feign Death warning"] = "假死提示"
L["Health"] = "血量"
L["Health deficit"] = "损失的血量"
L["Health threshold"] = "血量临界点"
L["Low HP"] = "低"
L["Low HP threshold"] = "低血量临界点"
L["Low HP warning"] = "低血量警报"
L["Offline"] = "离"
L["Offline warning"] = "掉线警报"
L["Only show deficit above % damage."] = "只显示已经损失了%的血量。"
L["Set the HP % for the low HP warning."] = "设置低血量警报的临界点。"
L["Show dead as full health"] = "把死亡的显示为满血"
L["Treat dead units as being full health."] = "把死亡的显示为满血。"
L["Unit health"] = "血量"
L["Use class color"] = "使用职业颜色"

------------------------------------------------------------------------
--	GridStatusMana

L["Low Mana"] = "低法力"
L["Low Mana warning"] = "低法力警报"
L["Mana"] = "法力"
L["Mana threshold"] = "法力临界点"
L["Set the percentage for the low mana warning."] = "设置低法力警告的临界点。"

------------------------------------------------------------------------
--	GridStatusName

L["Color by class"] = "使用职业颜色"
L["Unit Name"] = "名字"

------------------------------------------------------------------------
--	GridStatusRange

L["Out of Range"] = "超出范围"
L["Range"] = "范围"
L["Range check frequency"] = "范围检测的频率"
L["Seconds between range checks"] = "多少秒检测一次范围"

------------------------------------------------------------------------
--	GridStatusReadyCheck

L["?"] = "？"
L["AFK"] = "暂离"
L["AFK color"] = "暂离颜色"
L["Color for AFK."] = "暂离时的颜色。"
L["Color for Not Ready."] = "未准备好时的颜色。"
L["Color for Ready."] = "已就绪时的颜色。"
L["Color for Waiting."] = "等待时的颜色。"
L["Delay"] = "延迟"
L["Not Ready color"] = "未准备好颜色"
L["R"] = "是"
L["Ready Check"] = "检查就绪"
L["Ready color"] = "就绪颜色"
L["Set the delay until ready check results are cleared."] = "设置准备就绪检查结果清除的延迟。"
L["Waiting color"] = "等待颜色"
L["X"] = "否"

------------------------------------------------------------------------
--	GridStatusTarget

L["Target"] = "目标"
L["Your Target"] = "你的目标"

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "驾驶中"
L["In Vehicle"] = "使用载具"

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "正在说话"
L["Voice Chat"] = "语音聊天"
