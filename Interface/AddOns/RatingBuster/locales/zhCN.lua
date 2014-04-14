--[[
Name: RatingBuster zhCN locale
Revision: $Revision: 339 $
Translated by:
- iceburn
- 急云@CWDG
- 天下牧@萨格拉斯
]]

local L = LibStub("AceLocale-3.0"):NewLocale("RatingBuster", "zhCN")
if not L then return end
-- This file is coded in UTF-8
-- If you don't have a editor that can save in UTF-8, I recommend Ultraedit
----
-- To translate AceLocale strings, replace true with the translation string
-- Before: L["Show Item ID"] = true,
-- After:  L["Show Item ID"] = "显示物品编号",
---------------
-- Waterfall --
---------------
L["RatingBuster Options"] = "RatingBuster选项"
L["Enabled"] = "启用"
L["Suspend/resume this addon"] = "暂停/继续使用这个插件"
---------------------------
-- Slash Command Options --
---------------------------
L["Always"] = "永远显示"
L["ALT Key"] = "ALT 键"
L["CTRL Key"] = "CTRL 键"
L["SHIFT Key"] = "SHIFT 键"
L["Never"] = "不显示"
L["General Settings"] = "通用设置"
L["Profiles"] = "设定档"
-- /rb win
L["Options Window"] = "选项窗口"
L["Shows the Options Window"] = "打开选项窗口"
-- /rb hidebzcomp
L["Hide Blizzard Item Comparisons"] = "隐藏暴雪的物品比较"
L["Disable Blizzard stat change summary when using the built-in comparison tooltip"] = "观看已装备物品提示时不显示暴雪的物品比较功能"
-- /rb statmod
L["Enable Stat Mods"] = "属性加成"
L["Enable support for Stat Mods"] = "启用属性加成计算"
-- /rb subtract_equip
L["Enable Subtract Equipped Stats"] = "扣掉目前装备的数值后再计算"
L["Enable for more accurate calculation of Mana Regen from Intellect and Spirit, and diminishing stats like Dodge, Parry, Resilience"] = "可以更精确的计算来自智力与精神得回魔，以及计算闪避、招架、韧性等递减数值"
-- /rb enable_reforge_ui
L["Enable integration with Blizzard Reforging UI"] = "整合到暴雪重铸界面"
L["Add rating information to the Blizzard Reforging UI"] = "在暴雪重铸界面上显示等级信息"
-- /rb usereqlv
L["Use Required Level"] = "使用需要等级"
L["Calculate using the required level if you are below the required level"] = "如果你的等级低于需要等级则用需要等级来换算"
-- /rb level
L["Set Level"] = "设定换算等级"
L["Set the level used in calculations (0 = your level)"] = "设定换算等级 (0 = 你的目前的等级)"
-- /rb ilvlid
L["Item Level and ID"] = "物品等级与编号"
L["Settings for Item Level and Item ID"] = "物品等级与编号设定"
-- /rb ilvlid coloritemlevel
L["Colorize Item Level"] = "物品等级着色"
L["Customize the color of the Item Level text"] = "设置物品等级文字的颜色"
-- /rb ilvlid itemlevelall
L["Show Item Level on all items"] = "显示所有物品等级"
L["Display the Item Level on all items instead of just on equippable items"] = "在所有物品上显示物品等级，而非只显示在装备上"
-- /rb ilvlid itemid
L["Show Item ID"] = "显示物品编号"
L["Display the Item ID on all items"] = "在所有物品上显示物品编号"
---------------------------------------------------------------------------
-- /rb rating
L["Rating"] = "属性等级"
L["Options for Rating display"] = "设定属性等级显示"
-- /rb rating show
L["Show Rating Conversions"] = "显示属性等级转换"
L["Select when to show rating conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "在提示框架中显示属性等级转换结果"
-- /rb rating spell
L["Show Spell Hit/Haste"] = "显示法术命中/急速"
L["Show Spell Hit/Haste from Hit/Haste Rating"] = "显示命中/急速等级给的法术命中/急速加成"
-- /rb rating physical
L["Show Physical Hit/Haste"] = "显示物理命中/急速"
L["Show Physical Hit/Haste from Hit/Haste Rating"] = "显示命中/急速等级给的物理命中/急速加成"
-- /rb rating detail
L["Show Detailed Conversions Text"] = "显示详细转换文本"
L["Show detailed text for Resilience and Expertise conversions"] = "显示详细的韧性和精准等级转换"
-- /rb rating exp
L["Expertise Breakdown"] = "精准效能"
L["Convert Expertise into Dodge Neglect and Parry Neglect"] = "转换精准等级为忽略躲闪和忽略招架"
---------------------------------------------------------------------------
-- /rb rating color
L["Change Text Color"] = "设定文字颜色"
L["Changes the color of added text"] = "设定RB所增加的文字的颜色"
-- /rb rating color pick
L["Pick Color"] = "挑选颜色"
L["Pick a color"] = "挑选颜色"
-- /rb rating color enable
L["Enable Color"] = "启用文字颜色"
L["Enable colored text"] = "启用文字颜色"
---------------------------------------------------------------------------
-- /rb stat
L["Stat Breakdown"] = "基本属性解析"
L["Changes the display of base stats"] = "设定基本属性的解析显示"
-- /rb stat show
L["Show Base Stat Conversions"] = "显示基本属性解析"
L["Select when to show base stat conversions in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "在物品提示中显示基本属性解析"
---------------------------------------------------------------------------
-- /rb stat str
L["Strength"] = "力量"
L["Changes the display of Strength"] = "自订力量解析项目"
-- /rb stat str ap
L["Show Attack Power"] = "显示近战攻击强度"
L["Show Attack Power from Strength"] = "显示力量给的近战攻击强度"
-- /rb stat str block
L["Show Block Value"] = "显示格档值"
L["Show Block Value from Strength"] = "显示力量给的格档值"
-- /rb stat str dmg
L["Show Spell Damage"] = "显示法伤"
L["Show Spell Damage from Strength"] = "显示力量给的法术伤害加成"
-- /rb stat str heal
L["Show Healing"] = "显示治疗"
L["Show Healing from Strength"] = "显示力量给的治疗加成"
-- /rb stat str parryrating
L["Show Parry Rating"] = "显示招架等级"
L["Show Parry Rating from Strength"] = "显示力量给的招架加成"
-- /rb stat str parry
L["Show Parry"] = "显示招架"
L["Show Parry from Strength"] = "显示力量给的招架加成"
---------------------------------------------------------------------------
-- /rb stat agi
L["Agility"] = "敏捷"
L["Changes the display of Agility"] = "自定义敏捷解析项目"
-- /rb stat agi crit
L["Show Crit"] = "显示物理爆击"
L["Show Crit chance from Agility"] = "显示敏捷给的物理爆击几率"
-- /rb stat agi dodge
L["Show Dodge"] = "显示躲闪"
L["Show Dodge chance from Agility"] = "显示敏捷给的躲闪几率"
-- /rb stat agi ap
L["Show Attack Power"] = "显示近战攻击强度"
L["Show Attack Power from Agility"] = "显示敏捷给的近战攻击强度"
-- /rb stat agi rap
L["Show Ranged Attack Power"] = "显示远程攻击强度"
L["Show Ranged Attack Power from Agility"] = "显示敏捷给的远程攻击强度"
-- /rb stat agi dmg
L["Show Spell Damage"] = "显示法伤"
L["Show Spell Damage from Agility"] = "显示敏捷给的法术伤害加成"
-- /rb stat agi heal
L["Show Healing"] = "显示治疗"
L["Show Healing from Agility"] = "显示敏捷给的治疗加成"
---------------------------------------------------------------------------
-- /rb stat sta
L["Stamina"] = "耐力"
L["Changes the display of Stamina"] = "自定义耐力解析项目"
-- /rb stat sta hp
L["Show Health"] = "显示生命值"
L["Show Health from Stamina"] = "显示耐力给的生命值"
-- /rb stat sta dmg
L["Show Spell Damage"] = "显示法伤"
L["Show Spell Damage from Stamina"] = "显示耐力给的法术伤害加成"
-- /rb stat sta heal
L["Show Healing"] = "显示治疗"
L["Show Healing from Stamina"] = "显示智力给的治疗加成"
-- /rb stat sta ap
L["Show Attack Power"] = "显示攻击强度"
L["Show Attack Power from Stamina"] = "显示智力给的攻击强度加成"
---------------------------------------------------------------------------
-- /rb stat int
L["Intellect"] = "智力"
L["Changes the display of Intellect"] = "自定义智力解析项目"
-- /rb stat int spellcrit
L["Show Spell Crit"] = "显示法术爆击"
L["Show Spell Crit chance from Intellect"] = "显示智力给的法术爆击几率"
-- /rb stat int mp
L["Show Mana"] = "显示法力值"
L["Show Mana from Intellect"] = "显示智力给的法力值"
-- /rb stat int dmg
L["Show Spell Damage"] = "显示法伤"
L["Show Spell Damage from Intellect"] = "显示智力给的法术伤害加成"
-- /rb stat int heal
L["Show Healing"] = "显示治疗"
L["Show Healing from Intellect"] = "显示智力给的治疗加成"
-- /rb stat int mp5
L["Show Combat Mana Regen"] = "显示战斗回魔"
L["Show Mana Regen while in combat from Intellect"] = "显示智力给的战斗中法力恢复量"
-- /rb stat int mp5oc
L["Show Normal Mana Regen"] = "显示正常回魔"
L["Show Mana Regen while not in combat from Intellect"] = "显示在非战斗状态时，智力给的法力恢复量"
-- /rb stat int rap
L["Show Ranged Attack Power"] = "显示远程攻击强度"
L["Show Ranged Attack Power from Intellect"] = "显示智力给的远程攻击强度"
-- /rb stat int ap
L["Show Attack Power"] = "显示攻击强度"
L["Show Attack Power from Intellect"] = "显示智力给的攻击强度加成"
---------------------------------------------------------------------------
-- /rb stat spi
L["Spirit"] = "精神"
L["Changes the display of Spirit"] = "自定义精神解析项目"
-- /rb stat spi mp5
L["Show Combat Mana Regen"] = "显示战斗回魔"
L["Show Mana Regen while in combat from Spirit"] = "显示在战斗中状态时，精神给的法力恢复量"
-- /rb stat spi mp5oc
L["Show Normal Mana Regen"] = "显示正常回魔"
L["Show Mana Regen while not in combat from Spirit"] = "显示在非战斗状态时，精神给的法力恢复量"
-- /rb stat spi hp5
L["Show Normal Health Regen"] = "显示回血"
L["Show Health Regen while not in combat from Spirit"] = "显示精神给的正常回血"
-- /rb stat spi dmg
L["Show Spell Damage"] = "显示法伤"
L["Show Spell Damage from Spirit"] = "显示精神给的法术伤害加成"
-- /rb stat spi heal
L["Show Healing"] = "显示治疗"
L["Show Healing from Spirit"] = "显示精神给的治疗加成"
-- /rb stat spi spellcrit
L["Show Spell Crit"] = "显示法术暴击"
L["Show Spell Crit chance from Spirit"] = "显示精神给的法术暴击几率"
-- /rb stat spi spellhitrating
L["Show Spell Hit Rating"] = "显示法术命中等级"
L["Show Spell Hit Rating from Spirit"] = "显示精神给的法术命中等级"
-- /rb stat spi spellhit
L["Show Spell Hit"] = "显示法术命中"
L["Show Spell Hit from Spirit"] = "显示精神给的法术命中几率"
---------------------------------------------------------------------------
-- /rb stat armor
L["Armor"] = "护甲"
L["Changes the display of Armor"] = "自定义护甲解析项目"
-- /rb stat armor ap
L["Show Attack Power"] = "显示攻击强度"
L["Show Attack Power from Armor"] = "显示护甲给的攻击强度"
---------------------------------------------------------------------------
-- /rb sum
L["Stat Summary"] = "属性统计"
L["Options for stat summary"] = "自定义属性选项"
-- /rb sum show
L["Show Stat Summary"] = "显示属性统计"
L["Select when to show stat summary in tooltips. Modifier keys needs to be pressed before showing the tooltips."] = "在物品提示中显示属性统计"
-- /rb sum ignore
L["Ignore Settings"] = "忽略设定"
L["Ignore stuff when calculating the stat summary"] = "设定在统计总合时所要忽略的项目"
-- /rb sum ignore unused
L["Ignore Undesirable Items"] = "忽略不想要的物品"
L["Hide stat summary for undesirable items"] = "只在你可以装备的物品显示属性统计"
-- /rb sum ignore quality
L["Minimum Item Quality"] = "最低物品品质"
L["Show stat summary only for selected quality items and up"] = "只在你所选的品质或更好的物品上显示属性统计"
-- /rb sum ignore armor
L["Armor Types"] = "护甲种类"
L["Select armor types you want to ignore"] = "选择你想忽略的护甲种类"
-- /rb sum ignore armor cloth
L["Ignore Cloth"] = "忽略布甲"
L["Hide stat summary for all cloth armor"] = "隐藏所有布甲的属性统计"
-- /rb sum ignore armor leather
L["Ignore Leather"] = "忽略皮甲"
L["Hide stat summary for all leather armor"] = "隐藏所有皮甲的属性统计"
-- /rb sum ignore armor mail
L["Ignore Mail"] = "忽略锁甲"
L["Hide stat summary for all mail armor"] = "隐藏所有锁甲的属性统计"
-- /rb sum ignore armor plate
L["Ignore Plate"] = "忽略板甲"
L["Hide stat summary for all plate armor"] = "隐藏所有板甲的属性统计"
-- /rb sum ignore equipped
L["Ignore Equipped Items"] = "忽略已装备的物品"
L["Hide stat summary for equipped items"] = "隐藏已装备的物品的统计总合"
-- /rb sum ignore enchant
L["Ignore Enchants"] = "忽略附魔"
L["Ignore enchants on items when calculating the stat summary"] = "计算时忽略物品上的附魔效果"
-- /rb sum ignore gem
L["Ignore Gems"] = "忽略宝石"
L["Ignore gems on items when calculating the stat summary"] = "计算时忽略物品上的宝石效果"
-- /rb sum ignore prismaticSocket
L["Ignore Prismatic Sockets"] = "忽略棱彩插槽"
L["Ignore gems in prismatic sockets when calculating the stat summary"] = "计算时忽略棱彩插槽里的宝石效果"
-- /rb sum diffstyle
L["Display Style For Diff Value"] = "差异值显示方式"
L["Display diff values in the main tooltip or only in compare tooltips"] = "设定在主提示框架或只在比较框架中显示差异值"
-- /rb sum space
L["Add Empty Line"] = "加入空白列"
L["Add a empty line before or after stat summary"] = "在物品提示中的属性统计前或后加入空白列"
-- /rb sum space before
L["Add Before Summary"] = "加在统计前"
L["Add a empty line before stat summary"] = "在物品提示中的属性统计前加入空白列"
-- /rb sum space after
L["Add After Summary"] = "加在统计后"
L["Add a empty line after stat summary"] = "在物品提示中的属性统计后加入空白列"
-- /rb sum icon
L["Show Icon"] = "显示图标"
L["Show the sigma icon before summary listing"] = "在属性统计前显示图标"
-- /rb sum title
L["Show Title Text"] = "显示标题"
L["Show the title text before summary listing"] = "在属性统计前显示标题文字"
-- /rb sum showzerostat
L["Show Zero Value Stats"] = "显示数值为0的属性"
L["Show zero value stats in summary for consistancy"] = "为了一致性，在统计中显示数值为0的属性"
-- /rb sum calcsum
L["Calculate Stat Sum"] = "计算总和统计"
L["Calculate the total stats for the item"] = "计算物品的总和统计"
-- /rb sum calcdiff
L["Calculate Stat Diff"] = "计算差异统计"
L["Calculate the stat difference for the item and equipped items"] = "计算物品和已装备物品的统计差异"
-- /rb sum sort
L["Sort StatSummary Alphabetically"] = "按照字母排序"
L["Enable to sort StatSummary alphabetically, disable to sort according to stat type(basic, physical, spell, tank)"] = "启用以按照字母顺序排列，禁用按照属性类型排列(基础、物理、法术、抵抗……)"
-- /rb sum avoidhasblock
L["Include Block Chance In Avoidance Summary"] = "在躲避统计中显示格挡几率"
L["Enable to include block chance in Avoidance summary, Disable for only dodge, parry, miss"] = "启用该选项后将在躲避统计中加入格挡几率，禁用将仅显示躲闪，招架，未击中"
---------------------------------------------------------------------------
-- /rb sum basic
L["Stat - Basic"] = "属性 - 基本"
L["Choose basic stats for summary"] = "选择想要统计的基本属性"
-- /rb sum basic hp
L["Sum Health"] = "统计生命值"
L["Health <- Health, Stamina"] = "生命值 ← 生命值、耐力"
-- /rb sum basic mp
L["Sum Mana"] = "统计法力值"
L["Mana <- Mana, Intellect"] = "法力值 ← 法力值、智力"
-- /rb sum basic mp5
L["Sum Combat Mana Regen"] = "统计战斗回魔"
L["Combat Mana Regen <- Mana Regen, Spirit"] = "战斗回魔 ← 法力恢复、精神"
-- /rb sum basic mp5oc
L["Sum Normal Mana Regen"] = "统计正常回魔"
L["Normal Mana Regen <- Spirit"] = "正常回魔 ← 精神"
-- /rb sum basic hp5
L["Sum Combat Health Regen"] = "统计生命恢复"
L["Combat Health Regen <- Health Regen"] = "生命恢复 ← 生命恢复"
-- /rb sum basic hp5oc
L["Sum Normal Health Regen"] = "统计生命恢复(未战斗时)"
L["Normal Health Regen <- Spirit"] = "生命恢复(未战斗时) ← 精神"
-- /rb sum basic str
L["Sum Strength"] = "统计力量"
L["Strength Summary"] = "统计力量"
-- /rb sum basic agi
L["Sum Agility"] = "统计敏捷"
L["Agility Summary"] = "统计敏捷"
-- /rb sum basic sta
L["Sum Stamina"] = "统计耐力"
L["Stamina Summary"] = "统计耐力"
-- /rb sum basic int
L["Sum Intellect"] = "统计智力"
L["Intellect Summary"] = "统计智力"
-- /rb sum basic spi
L["Sum Spirit"] = "统计精神"
L["Spirit Summary"] = "统计精神"
-- /rb sum basic mastery
L["Sum Mastery"] = "统计精通"
L["Mastery Summary"] = "统计精通"
-- /rb sum basic masteryrating
L["Sum Mastery Rating"] = "统计精通等级"
L["Mastery Rating Summary"] = "统计精通等级"
---------------------------------------------------------------------------
-- /rb sum physical
L["Stat - Physical"] = "属性 - 物理"
L["Choose physical damage stats for summary"] = "选择想要统计的物理攻击属性"
-- /rb sum physical ap
L["Sum Attack Power"] = "统计近战攻击强度"
L["Attack Power <- Attack Power, Strength, Agility"] = "近战攻击强度 ← 攻击强度、力量、敏捷"
-- /rb sum physical rap
L["Sum Ranged Attack Power"] = "统计远程攻击强度"
L["Ranged Attack Power <- Ranged Attack Power, Intellect, Attack Power, Strength, Agility"] = "远程攻击强度 ← 远程攻击强度、智力、攻击强度、力量、敏捷"
-- /rb sum physical hit
L["Sum Hit Chance"] = "统计物理命中几率"
L["Hit Chance <- Hit Rating"] = "物理命中几率 ← 命中等级、武器技能等级"
-- /rb sum physical hitrating
L["Sum Hit Rating"] = "统计命中等级"
L["Hit Rating Summary"] = "统计命中等级"
-- /rb sum physical crit
L["Sum Crit Chance"] = "统计物理爆击几率"
L["Crit Chance <- Crit Rating, Agility"] = "物理爆击几率 ← 爆击等级、敏捷、武器技能等级"
-- /rb sum physical critrating
L["Sum Crit Rating"] = "统计爆击等级"
L["Crit Rating Summary"] = "统计爆击等级"
-- /rb sum physical haste
L["Sum Haste"] = "统计急速"
L["Haste <- Haste Rating"] = "急速 ← 急速等级"
-- /rb sum physical hasterating
L["Sum Haste Rating"] = "统计急速等级"
L["Haste Rating Summary"] = "统计急速等级"
-- /rb sum physical rangedhit
L["Sum Ranged Hit Chance"] = "统计远程命中几率"
L["Ranged Hit Chance <- Hit Rating, Ranged Hit Rating"] = "远程命中几率 ← 命中等级、武器技能等级、远程命中等级"
-- /rb sum physical rangedhitrating
L["Sum Ranged Hit Rating"] = "统计远程命中等级"
L["Ranged Hit Rating Summary"] = "统计远程命中等级"
-- /rb sum physical rangedcrit
L["Sum Ranged Crit Chance"] = "统计远爆击几率"
L["Ranged Crit Chance <- Crit Rating, Agility, Ranged Crit Rating"] = "远程爆击几率 ← 爆击等级、敏捷、武器技能等级、远程爆击等级"
-- /rb sum physical rangedcritrating
L["Sum Ranged Crit Rating"] = "统计远程爆击等级"
L["Ranged Crit Rating Summary"] = "统计远程爆击等级"
-- /rb sum physical rangedhaste
L["Sum Ranged Haste"] = "统计远程急速"
L["Ranged Haste <- Haste Rating, Ranged Haste Rating"] = "远程急速 ← 急速等级、远程急速等级"
-- /rb sum physical rangedhasterating
L["Sum Ranged Haste Rating"] = "统计远程急速等级"
L["Ranged Haste Rating Summary"] = "统计远程急速等级"
-- /rb sum physical maxdamage
L["Sum Weapon Max Damage"] = "统计武器最大伤害"
L["Weapon Max Damage Summary"] = "统计武器最大伤害"
-- /rb sum physical weapondps
L["Sum Weapon DPS"] = "统计武器DPS"
L["Weapon DPS Summary"] = "武器DPS统计"
-- /rb sum physical wpn
L["Sum Weapon Skill"] = "统计武器技能"
L["Weapon Skill <- Weapon Skill Rating"] = "武器技能 ← 武器技能等级"
-- /rb sum physical exp
L["Sum Expertise"] = "统计精准"
L["Expertise <- Expertise Rating"] = "精准 ← 精准等级"
-- /rb sum physical exprating
L["Sum Expertise Rating"] = "统计精准等级"
L["Expertise Rating Summary"] = "统计精准等级"
---------------------------------------------------------------------------
-- /rb sum spell
L["Stat - Spell"] = "属性 - 法术"
L["Choose spell damage and healing stats for summary"] = "选择想要统计的法术攻击和治疗的属性"
-- /rb sum spell power
L["Sum Spell Power"] = "统计法术强度"
L["Spell Power <- Spell Power, Intellect, Agility, Strength"] = "法术强度 ← 法术伤害、智力、精神、耐力"
-- /rb sum spell dmg
L["Sum Spell Damage"] = "统计法术伤害"
L["Spell Damage <- Spell Damage, Intellect, Spirit, Stamina"] = "法术伤害 ← 法术伤害、智力、精神、耐力"
-- /rb sum spell dmgholy
L["Sum Holy Spell Damage"] = "统计神圣法术伤害"
L["Holy Spell Damage <- Holy Spell Damage, Spell Damage, Intellect, Spirit"] = "神圣法术伤害 ← 神圣法术伤害、法术伤害、智力、精神"
-- /rb sum spell dmgarcane
L["Sum Arcane Spell Damage"] = "统计奥术法术伤害"
L["Arcane Spell Damage <- Arcane Spell Damage, Spell Damage, Intellect"] = "奥术法术伤害 ← 奥术法术伤害、法术伤害、智力"
-- /rb sum spell dmgfire
L["Sum Fire Spell Damage"] = "统计火焰法术伤害"
L["Fire Spell Damage <- Fire Spell Damage, Spell Damage, Intellect, Stamina"] = "火焰法术伤害 ← 火焰法术伤害、法术伤害、智力、耐力"
-- /rb sum spell dmgnature
L["Sum Nature Spell Damage"] = "统计自然法术伤害"
L["Nature Spell Damage <- Nature Spell Damage, Spell Damage, Intellect"] = "自然法术伤害 ← 自然法术伤害、法术伤害、智力"
-- /rb sum spell dmgfrost
L["Sum Frost Spell Damage"] = "统计冰霜法术伤害"
L["Frost Spell Damage <- Frost Spell Damage, Spell Damage, Intellect"] = "冰霜法术伤害 ← 冰霜法术伤害、法术伤害、智力"
-- /rb sum spell dmgshadow
L["Sum Shadow Spell Damage"] = "统计暗影法术伤害"
L["Shadow Spell Damage <- Shadow Spell Damage, Spell Damage, Intellect, Spirit, Stamina"] = "暗影法术伤害 ← 暗影法术伤害、法术伤害、智力、精神、耐力"
-- /rb sum spell heal
L["Sum Healing"] = "统计治疗"
L["Healing <- Healing, Intellect, Spirit, Agility, Strength"] = "治疗 ← 治疗、智力、精神、敏捷、力量"
-- /rb sum spell crit
L["Sum Spell Crit Chance"] = "统计法术爆击几率"
L["Spell Crit Chance <- Spell Crit Rating, Intellect"] = "法术爆击几率 ← 法术爆击等级、智力"
-- /rb sum spell hit
L["Sum Spell Hit Chance"] = "统计法术命中几率"
L["Spell Hit Chance <- Spell Hit Rating"] = "法术命中几率 ← 法术命中等级"
-- /rb sum spell haste
L["Sum Spell Haste"] = "统计法术急速"
L["Spell Haste <- Spell Haste Rating"] = "法术急速 ← 法术急速等级"
-- /rb sum spell pen
L["Sum Penetration"] = "统计穿透"
L["Spell Penetration Summary"] = "统计法术穿透"
-- /rb sum spell hitrating
L["Sum Spell Hit Rating"] = "统计法术命中等级"
L["Spell Hit Rating Summary"] = "统计法术命中等级"
-- /rb sum spell critrating
L["Sum Spell Crit Rating"] = "统计法术爆击等级"
L["Spell Crit Rating Summary"] = "统计法术爆击等级"
-- /rb sum spell hasterating
L["Sum Spell Haste Rating"] = "统计法术急速等级"
L["Spell Haste Rating Summary"] = "统计法术急速等级"
---------------------------------------------------------------------------
-- /rb sum tank
L["Stat - Tank"] = "属性 - 抗打击"
L["Choose tank stats for summary"] = "选择你想要统计的抗打击能力的属性"
-- /rb sum tank armor
L["Sum Armor"] = "统计护甲值"
L["Armor <- Armor from items and bonuses"] = "护甲值 ← 物品护甲、护甲加成、敏捷、智力"
-- /rb sum tank dodge
L["Sum Dodge Chance"] = "统计躲闪几率"
L["Dodge Chance <- Dodge Rating, Agility"] = "躲闪几率 ← 躲闪等级、敏捷、防御等级"
-- /rb sum tank parry
L["Sum Parry Chance"] = "统计招架几率"
L["Parry Chance <- Parry Rating"] = "招架几率 ← 招架等级、防御等级"
-- /rb sum tank block
L["Sum Block Chance"] = "统计格挡几率"
L["Block Chance <- Block Rating"] = "格挡几率 ← 格挡等级、防御等级"
-- /rb sum tank neglectdodge
L["Sum Dodge Neglect"] = "统计防止被躲闪"
L["Dodge Neglect <- Expertise"] = "防止被躲闪 ← 精准等级、武器技能等级"
-- /rb sum tank neglectparry
L["Sum Parry Neglect"] = "统计防止被招架"
L["Parry Neglect <- Expertise"] = "防止被招架 ← 精准等级、武器技能等级"
-- /rb sum tank resarcane
L["Sum Arcane Resistance"] = "统计奥术抗性"
L["Arcane Resistance Summary"] = "统计奥术抗性"
-- /rb sum tank resfire
L["Sum Fire Resistance"] = "统计火焰抗性"
L["Fire Resistance Summary"] = "统计火焰抗性"
-- /rb sum tank resnature
L["Sum Nature Resistance"] = "统计自然抗性"
L["Nature Resistance Summary"] = "统计自然抗性"
-- /rb sum tank resfrost
L["Sum Frost Resistance"] = "统计冰霜抗性"
L["Frost Resistance Summary"] = "统计冰霜抗性"
-- /rb sum tank resshadow
L["Sum Shadow Resistance"] = "统计暗影抗性"
L["Shadow Resistance Summary"] = "统计暗影抗性"
-- /rb sum tank dodgerating
L["Sum Dodge Rating"] = "统计躲闪等级"
L["Dodge Rating Summary"] = "统计躲闪等级"
-- /rb sum tank parryrating
L["Sum Parry Rating"] = "统计招架等级"
L["Parry Rating Summary"] = "统计招架等级"
-- /rb sum tank blockrating
L["Sum Block Rating"] = "统计格挡等级"
L["Block Rating Summary"] = "统计格挡等级"
-- /rb sum tank res
L["Sum Resilience"] = "统计韧性"
L["Resilience Summary"] = "统计韧性等级"
-- /rb sum tank tp
L["Sum TankPoints"] = "统计抗打击能力"
L["TankPoints <- Health, Total Reduction"] = "抗打击能力 ← 生命值, 所有伤害减免"
-- /rb sum tank tr
L["Sum Total Reduction"] = "统计伤害减免"
L["Total Reduction <- Armor, Dodge, Parry, Block, MobMiss, MobCrit, MobCrush, DamageTakenMods"] = "所有伤害减免 <- 护甲值, 躲闪, 招架, 格挡, 格挡值, 防御技能, 韧性, 怪物未击中几率, 怪物重击几率, 怪物碾压打击几率, 伤害减免"
-- /rb sum tank avoid
L["Sum Avoidance"] = "统计躲避"
L["Avoidance <- Dodge, Parry, MobMiss, Block(Optional)"] = "躲避 ← 躲闪, 招架, 怪物未命中, 格挡(可选)"
---------------------------------------------------------------------------
-- /rb sum gemset
L["Gem Set"] = "宝石设定"
L["Select a gem set to configure"] = "选择一组宝石设定"
L["Default Gem Set 1"] = "宝石设定1"
L["Default Gem Set 2"] = "宝石设定2"
L["Default Gem Set 3"] = "宝石设定3"
-- /rb sum gem
L["Auto fill empty gem slots"] = "自动填充空宝石位"
-- /rb sum gem red
L["Red Socket"] = EMPTY_SOCKET_RED
L["ItemID or Link of the gem you would like to auto fill"] = "你想要填充该空格位的物品ID或者链接"
L["<ItemID|Link>"] = "<物品编号|链接>"
L["|cffffff7f%s|r is now set to |cffffff7f[%s]|r"] = "|cffffff7f%s|r 已设置为 |cffffff7f[%s]|r"
L["Invalid input: %s. ItemID or ItemLink required."] = "输入错误：%s，请输入物品编号或物品链接。"
L["Queried server for Gem: %s. Try again in 5 secs."] = "对服务器查询宝石: %s。将会在5秒后重试。"
-- /rb sum gem yellow
L["Yellow Socket"] = EMPTY_SOCKET_YELLOW
-- /rb sum gem blue
L["Blue Socket"] = EMPTY_SOCKET_BLUE
-- /rb sum gem meta
L["Meta Socket"] = EMPTY_SOCKET_META
-- /rb sum gem2
L["Second set of default gems which can be toggled with a modifier key"] = "你可以使用 SHIFT, ALT 或 CTRL 来切换第二组预设宝石设定"
L["Can't use the same modifier as Gem Set 3"] = "无法使用与第 3 组预设宝石设定相同的切换键"
-- /rb sum gem2 key
L["Toggle Key"] = "切换键"
L["Use this key to toggle alternate gems"] = "选择一个按键来切换这组宝石设定"
-- /rb sum gem3
L["Third set of default gems which can be toggled with a modifier key"] = "你可以使用 SHIFT, ALT 或 CTRL 来切换第三组预设宝石设定"
L["Can't use the same modifier as Gem Set 2"] = "无法使用与第 2 组预设宝石设定相同的切换键"

-----------------------
-- Item Level and ID --
-----------------------
L["ItemLevel: "] = "物品等级: "
L["ItemID: "] = "物品编号: "
-----------------------
-- Matching Patterns --
-----------------------
-- Items to check --
--------------------
-- [Potent Ornate Topaz]
-- +6 Spell Damage, +5 Spell Crit Rating
--------------------
-- ZG enchant
-- +10 Defense Rating/+10 Stamina/+15 Block Value
--------------------
-- [Glinting Flam Spessarite]
-- +3 Hit Rating and +3 Agility
--------------------
-- ItemID: 22589
-- [Atiesh, Greatstaff of the Guardian] warlock version
-- Equip: Increases the spell critical strike rating of all party members within 30 yards by 28.
--------------------
-- [Brilliant Wizard Oil]
-- Use: While applied to target weapon it increases spell damage by up to 36 and increases spell critical strike rating by 14 . Lasts for 30 minutes.
----------------------------------------------------------------------------------------------------
-- I redesigned the tooltip scanner using a more locale friendly, 2 pass matching matching algorithm.
--
-- The first pass searches for the rating number, the patterns are read from L["numberPatterns"] here,
-- " by (%d+)" will match strings like: "Increases defense rating by 16."
-- "%+(%d+)" will match strings like: "+10 Defense Rating"
-- You can add additional patterns if needed, its not limited to 2 patterns.
-- The separators are a table of strings used to break up a line into multiple lines what will be parsed seperately.
-- For example "+3 Hit Rating, +5 Spell Crit Rating" will be split into "+3 Hit Rating" and " +5 Spell Crit Rating"
--
-- The second pass searches for the rating name, the names are read from L["statList"] here,
-- It will look through the table in order, so you can put common strings at the begining to speed up the search,
-- and longer strings should be listed first, like "spell critical strike" should be listed before "critical strike",
-- this way "spell critical strike" does get matched by "critical strike".
-- Strings need to be in lower case letters, because string.lower is called on lookup
--
-- IMPORTANT: there may not exist a one-to-one correspondence, meaning you can't just translate this file,
-- but will need to go in game and find out what needs to be put in here.
-- For example, in english I found 3 different strings that maps to CR_CRIT_MELEE: "critical strike", "critical hit" and "crit".
-- You will need to find out every string that represents CR_CRIT_MELEE, and so on.
-- In other languages there may be 5 different strings that should all map to CR_CRIT_MELEE.
-- so please check in game that you have all strings, and not translate directly off this table.
--
-- Tip1: When doing localizations, I recommend you set debugging to true in RatingBuster.lua
-- Find RatingBuster:SetDebugging(false) and change it to RatingBuster:SetDebugging(true)
-- or you can type /rb debug to enable it in game
--
-- Tip2: The strings are passed into string.find, so you should escape the magic characters ^$()%.[]*+-? with a %
L["numberPatterns"] = {
	{pattern = "(%d+)。", addInfo = "AfterNumber", space = " ", },
	{pattern = "([%+%-]%d+)", addInfo = "AfterStat", space = " ", },
	{pattern = "佩戴者.-(%d+)", addInfo = "AfterNumber", space = " ", }, -- for "grant you xx stat" type pattern, ex: Quel'Serrar, Assassination Armor set
	{pattern = "提高.-(%d+)", addInfo = "AfterNumber", space = " ", },
	-- Added [^%%] so that it doesn't match strings like "Increases healing by up to 10% of your total Intellect." [Whitemend Pants] ID: 24261
	-- Added [^|] so that it doesn't match enchant strings (JewelTips)
	{pattern = "(%d+)([^%d%%|]+)", addInfo = "AfterStat", space = " ", }, -- [发光的暗影卓奈石] +6法术伤害及5耐力
}
L["separators"] = {
	"/", "和", ",", "。", " 持续 ", "&", "及", "并", "，","、",
}
--[[ Rating ID
CR_WEAPON_SKILL = 1;
CR_DEFENSE_SKILL = 2;
CR_DODGE = 3;
CR_PARRY = 4;
CR_BLOCK = 5;
CR_HIT_MELEE = 6;
CR_HIT_RANGED = 7;
CR_HIT_SPELL = 8;
CR_CRIT_MELEE = 9;
CR_CRIT_RANGED = 10;
CR_CRIT_SPELL = 11;
CR_HIT_TAKEN_MELEE = 12;
CR_HIT_TAKEN_RANGED = 13;
CR_HIT_TAKEN_SPELL = 14;
COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15;
COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16;
CR_CRIT_TAKEN_SPELL = 17;
CR_HASTE_MELEE = 18;
CR_HASTE_RANGED = 19;
CR_HASTE_SPELL = 20;
CR_WEAPON_SKILL_MAINHAND = 21;
CR_WEAPON_SKILL_OFFHAND = 22;
CR_WEAPON_SKILL_RANGED = 23;
CR_EXPERTISE = 24;
--
SPELL_STAT1_NAME = "Strength"
SPELL_STAT2_NAME = "Agility"
SPELL_STAT3_NAME = "Stamina"
SPELL_STAT4_NAME = "Intellect"
SPELL_STAT5_NAME = "Spirit"
--]]
L["statList"] = {
	{pattern = string.lower(SPELL_STAT1_NAME), id = SPELL_STAT1_NAME}, -- Strength
	{pattern = string.lower(SPELL_STAT2_NAME), id = SPELL_STAT2_NAME}, -- Agility
	{pattern = string.lower(SPELL_STAT3_NAME), id = SPELL_STAT3_NAME}, -- Stamina
	{pattern = string.lower(SPELL_STAT4_NAME), id = SPELL_STAT4_NAME}, -- Intellect
	{pattern = string.lower(SPELL_STAT5_NAME), id = SPELL_STAT5_NAME}, -- Spirit
	{pattern = "防御等级", id = CR_DEFENSE_SKILL},
	{pattern = "躲闪等级", id = CR_DODGE},
	{pattern = "格挡等级", id = CR_BLOCK}, -- block enchant: "+10 Shield Block Rating"
	{pattern = "招架等级", id = CR_PARRY},

	{pattern = "法术爆击等级", id = CR_CRIT_SPELL},
	{pattern = "法术爆击命中等级", id = CR_CRIT_SPELL},
	{pattern = "法术爆击等级", id = CR_CRIT_SPELL},
	{pattern = "远程爆击等级", id = CR_CRIT_RANGED},
	{pattern = "远程爆击命中等级", id = CR_CRIT_RANGED},
	{pattern = "远程爆击等级", id = CR_CRIT_RANGED},
	{pattern = "近战爆击等级", id = CR_CRIT_MELEE},
	{pattern = "爆击等级", id = CR_CRIT_MELEE},

	{pattern = "法术命中等级", id = CR_HIT_SPELL},
	{pattern = "远程命中等级", id = CR_HIT_RANGED},
	{pattern = "命中等级", id = CR_HIT_MELEE},

	{pattern = "韧性等级", id = COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN}, -- resilience is implicitly a rating

	{pattern = "法术急速等级", id = CR_HASTE_SPELL},
	{pattern = "远程急速等级", id = CR_HASTE_RANGED},
	{pattern = "急速等级", id = CR_HASTE_MELEE},
	{pattern = "加速等级", id = CR_HASTE_MELEE}, -- [Drums of Battle]

	{pattern = "武器技能等级", id = CR_WEAPON_SKILL},
	{pattern = "精准等级", id = CR_EXPERTISE},

	{pattern = "命中躲闪等级", id = CR_HIT_TAKEN_MELEE},
	{pattern = "护甲穿透等级", id = CR_ARMOR_PENETRATION},
	{pattern = "精通等级", id = CR_MASTERY},
	{pattern = string.lower(ARMOR), id = ARMOR},
	--[[
	{pattern = "匕首技能等级", id = CR_WEAPON_SKILL},
	{pattern = "剑技能等级", id = CR_WEAPON_SKILL},
	{pattern = "双手剑技能等级", id = CR_WEAPON_SKILL},
	{pattern = "斧技能等级", id = CR_WEAPON_SKILL},
	{pattern = "弓技能等级", id = CR_WEAPON_SKILL},
	{pattern = "弩技能等级", id = CR_WEAPON_SKILL},
	{pattern = "枪械技能等级", id = CR_WEAPON_SKILL},
	{pattern = "野性战斗技能等级", id = CR_WEAPON_SKILL},
	{pattern = "锤技能等级", id = CR_WEAPON_SKILL},
	{pattern = "长柄武器技能等级", id = CR_WEAPON_SKILL},
	{pattern = "法杖技能等级", id = CR_WEAPON_SKILL},
	{pattern = "双手斧技能等级", id = CR_WEAPON_SKILL},
	{pattern = "双手锤技能等级", id = CR_WEAPON_SKILL},
	{pattern = "徒手战斗技能等级", id = CR_WEAPON_SKILL},
	--]]
}
-------------------------
-- Added info patterns --
-------------------------
-- $value will be replaced with the number
-- EX: "$value% Crit" -> "+1.34% Crit"
-- EX: "Crit $value%" -> "Crit +1.34%"
L["$value% Crit"] = "$value% 爆击"
L["$value% Spell Crit"] = "$value% 法爆"
L["$value% Dodge"] = "$value% 躲闪"
L["$value HP"] = "$value 生命"
L["$value MP"] = "$value 法力"
L["$value AP"] = "$value 攻击强度"
L["$value SP"] = "$value 法术强度"
L["$value RAP"] = "$value 远攻强度"
L["$value Pwr"] = "$value 法伤"
L["$value Heal"] = "$value 治疗"
L["$value Armor"] = "$value 护甲"
L["$value Block"] = "$value 格挡值"
L["$value MP5"] = "$value 战斗回魔"
L["$value MP5(OC)"] = "$value 正常回魔"
L["$value HP5"] = "$value 回血"
L["$value to be Dodged/Parried"] = "$value 被躲闪/被招架"
L["$value to be Crit"] = "$value 被爆击"
L["$value Crit Dmg Taken"] = "$value 爆击伤害减免"
L["$value DOT Dmg Taken"] = "$value 持续伤害减免"
L["$value PVP Dmg Taken"] = "$value PVP伤害减免"
L["$value Parry"] = "$value 招架"
-- for hit rating showing both physical and spell conversions
-- (+1.21%, S+0.98%)
-- (+1.21%, +0.98% S)
L["$value Spell"] = "$value 法术"
L["$value Spell Hit"] = "$value 法术命中"

------------------
-- Stat Summary --
------------------
L["Stat Summary"] = "属性统计"

