TidyPlatesHubLocalization = TidyPlatesHubLocalization or {}


----------------------------------------------------------------------
-- Localization
----------------------------------------------------------------------

--[[  Example of Localization LUA...

TidyPlatesHubLocalizedFont = "FONTS/ARIALN.TTF"

if GetLocale() == "zhCN" then
	TidyPlatesHubLocalization["Style"] = "Translation of STYLE"
	TidyPlatesHubLocalization["Headline Mode"] = "No-Bars Mode"
end
--]]

function TidyPlatesHub_GetLocalizedString(str)
	if str then return TidyPlatesHubLocalization[str] or str
	else return "" end
end

local L = TidyPlatesHub_GetLocalizedString



	--[[
		Color Guide:
		|cffffdd00		for Yellow
		|cffff6906		for Orange
		|cff999999		for Grey
		|cffffaa33		for Brownish Orange
	--]]

	-- For making tooltips....
	-- .tooltipTitle = "Default", tooltipText = "Health bars always visible.", tooltipOnButton = true,

	--[[ 6.7 Testing
	TidyPlatesHubModes.ArtStyles = {{ text = "Blizzard", notCheckable = 1 } ,}

	TidyPlatesHubModes.ArtModes = {
		{ text = "By Elite", notCheckable = 1 } ,
		{ text = "By Enemy", notCheckable = 1 } ,
		{ text = "By NPC", notCheckable = 1 } ,
	}

	--]]

----------------------------------------------------------------------
-- Dropdown menu choices (corresponds to functions)
----------------------------------------------------------------------

TidyPlatesHubModes = {}

TidyPlatesHubModes.StyleModes = {
				{ text = L("默认"), notCheckable = 1, } ,
				{ text = L("|cffffaa33文字(没血条)"),	notCheckable = 1, } ,
				{ text = L("|cffffaa33脱离没条;|r 战斗启动"), notCheckable = 1, } ,
				{ text = L("|cffffaa33正常没条;|r ADD/少血/标记启动"),	notCheckable = 1, } ,
				{ text = L("|cffffaa33一直没条;|r 精英启动"), notCheckable = 1 } ,
				{ text = L("|cffffaa33没标记没条;|r 标记才有"), notCheckable = 1 } ,
				{ text = L("|cffffaa33NPC启动;|r 玩家启动"), notCheckable = 1 } ,
				{ text = L("|cffffaa33不选没条;|r 选中启动"), notCheckable = 1 } ,
				{ text = L("|cffffaa33满仇恨没条;|r 低仇恨/要OT启动(不是坦克手别贱)"), notCheckable = 1 } ,
			}

TidyPlatesHubModes.TextModes = {
				{ text = L("无"), notCheckable = 1 },
				{ text = L("百分比"), notCheckable = 1 } ,
				{ text = L("精确"), notCheckable = 1 } ,
				{ text = L("少多少血"), notCheckable = 1 } ,
				{ text = L("总量 & %"), notCheckable = 1 } ,
				{ text = L("总血量+百分比"), notCheckable = 1 } ,
				{ text = L("她的目标"), notCheckable = 1 } ,
				{ text = L("大概"), notCheckable = 1 } ,
				{ text = L("等级"), notCheckable = 1 } ,
				{ text = L("等级and生命"), notCheckable = 1 } ,
				{ text = L("竞技场ID,生命,能量"), notCheckable = 1 } ,
			}

			--[[
			-- Status Text Ingredients
			-- Text Builder

			TidyPlatesHubModes.TextModes = {
				{ text = L("无"), notCheckable = 1 },
				{ text = L("生命"), notCheckable = 1 } ,
				{ text = L("目标"), notCheckable = 1 } ,
				{ text = L("大概"), notCheckable = 1 } ,
				{ text = L("等级"), notCheckable = 1 } ,
				{ text = L("等级和生命"), notCheckable = 1 } ,
				{ text = L("竞技场ID, 生命,能量"), notCheckable = 1 } ,
			}

			TidyPlatesHubModes.TextIngredientList = {
				{ text = L("无"), notCheckable = 1 },
				{ text = L("百分比"), notCheckable = 1 } ,
				{ text = L("大概"), notCheckable = 1 } ,
				{ text = L("精确值"), notCheckable = 1 } ,

				{ text = L("血少多少"), notCheckable = 1 } ,

				{ text = L("目标"), notCheckable = 1 } ,

				{ text = L("等级"), notCheckable = 1 } ,
				{ text = L("生命"), notCheckable = 1 } ,
				{ text = L("竞技场ID"), notCheckable = 1 } ,
				{ text = L("能量"), notCheckable = 1 } ,
			}

			--]]

TidyPlatesHubModes.RangeModes = {
				{ text = L("9 码")} ,
				{ text = L("15 码") } ,
				{ text = L("28 码") } ,
				{ text = L("40 码") } ,
			}

TidyPlatesHubModes.DebuffStyles = {
				{ text = L("宽松"), notCheckable = 1 } ,
				{ text = L("紧凑(重载UI生效)"), notCheckable = 1 } ,
			}

TidyPlatesHubModes.DebuffModes = {
				{ text = L("显示所有"), notCheckable = 1 } ,
				{ text = L("显示这些... "), notCheckable = 1 } ,
				{ text = L("显示我的所有 "), notCheckable = 1 } ,
				{ text = L("显示我的... "), notCheckable = 1 } ,
				{ text = L("前缀..."), notCheckable = 1 } ,
			}

TidyPlatesHubModes.AuraWidgetModes = {
				{ text = L("Debuffs"), notCheckable = 1 } ,
				{ text = L("Buffs "), notCheckable = 1 } ,
				{ text = L("自定义..."), notCheckable = 1 } ,
			}

TidyPlatesHubModes.ScaleModes = {
				{ text = L("无"), notCheckable = 1 } ,
				{ text = L("精英"), notCheckable = 1 } ,
				{ text = L("目标"), notCheckable = 1 } ,
				{ text = L("仇恨"), notCheckable = 1 } ,
				{ text = L("光环"), notCheckable = 1 } ,
				{ text = L("敌对"), notCheckable = 1 } ,
				{ text = L("NPC"), notCheckable = 1 } ,
				{ text = L("团队图标"), notCheckable = 1 } ,
				{ text = L("敌对治疗"), notCheckable = 1 } ,
				{ text = L("低血量"), notCheckable = 1 } ,
				{ text = L("Boss"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.OpacityModes = {
				{ text = L("无"), notCheckable = 1 } ,
				{ text = L("仇恨"), notCheckable = 1 } ,
				{ text = L("光环"), notCheckable = 1 } ,
				{ text = L("敌对"), notCheckable = 1 } ,
				{ text = L("NPCs"), notCheckable = 1 } ,
				{ text = L("团队图标"), notCheckable = 1 } ,
				{ text = L("激活"), notCheckable = 1 } ,
				{ text = L("敌对治疗"), notCheckable = 1 } ,
				{ text = L("低血量"), notCheckable = 1 } ,
				}

--[[
	Friendly Unit Bar Coloring					Enemy Unit Bar Coloring
		- Reaction								- Threat
		- Health								- Reaction
		- Class									- Health
												- Raid Icon * Remove * Add to a checkbox
												- Class
--]]

TidyPlatesHubModes.FriendlyBarModes = {
				{ text = L("反应类型"), notCheckable = 1 } ,
				{ text = L("职业"), notCheckable = 1 } ,
				{ text = L("生命"), notCheckable = 1 } ,
				--{ text = L("团队图标"), notCheckable = 1 } ,
				{ text = L("Pass-through"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.EnemyBarModes = {
				{ text = L("仇恨"), notCheckable = 1 } ,
				{ text = L("反映类型"), notCheckable = 1 } ,
				{ text = L("职业"), notCheckable = 1 } ,
				{ text = L("生命"), notCheckable = 1 } ,
				--{ text = L("团队图标"), notCheckable = 1 } ,
				{ text = L("Pass-through"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.NameColorModes = {
				{ text = L("默认"), notCheckable = 1 } ,
				{ text = L("职业"), notCheckable = 1 } ,
				{ text = L("仇恨"), notCheckable = 1 } ,
				{ text = L("反映类型"), notCheckable = 1 } ,
				{ text = L("生命"), notCheckable = 1 } ,
				{ text = L("等级"), notCheckable = 1 } ,
				{ text = L("普通/精英/Boss"), notCheckable = 1 } ,
				}

-----
--[[
TidyPlatesHubModes.HealthColorModes = {
				{ text = L("默认"), notCheckable = 1 } ,
				{ text = L("敌对"), notCheckable = 1 } ,
				{ text = L("仇恨"), notCheckable = 1 } ,
				{ text = L("反应类型"), notCheckable = 1 } ,
				{ text = L("等级"), notCheckable = 1 } ,
				{ text = L("团队图标"), notCheckable = 1 } ,
				{ text = L("生命值"), notCheckable = 1 } ,
				{ text = L("友好"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.NameColorModes = {
				{ text = L("默认"), notCheckable = 1 } ,
				{ text = L("敌对"), notCheckable = 1 } ,
				{ text = L("仇恨"), notCheckable = 1 } ,
				{ text = L(应类型"), notCheckable = 1 } ,
				{ text = L("等级"), notCheckable = 1 } ,
				{ text = L("生命值"), notCheckable = 1 } ,
				{ text = L("普通/精英/BOSS"), notCheckable = 1 } ,
				{ text = L("友好"), notCheckable = 1 } ,
				}

--]]
TidyPlatesHubModes.WarningGlowModes = {
				{ text = L("无"), notCheckable = 1 } ,
				{ text = L("仇恨"), notCheckable = 1 } ,
				{ text = L("治疗"), notCheckable = 1 } ,
				}

				--[[
				By Threat
				By Low Health
				By Healers

				[] Use Class Color for healers
				[] Healer Color
				--]]


TidyPlatesHubModes.TextPlateFieldModes = {
				{ text = L("无"), notCheckable = 1 } ,
				{ text = L("百分比"), notCheckable = 1 } ,		--
				{ text = L("角色, 公会 or 等级"), notCheckable = 1 } ,
				{ text = L("角色 or 公会"), notCheckable = 1 } ,
				{ text = L("NPC "), notCheckable = 1 } ,
				{ text = L("等级"), notCheckable = 1 } ,
				{ text = L("角色, 公会, 等级 or 百分比"), notCheckable = 1 } ,
				}

TidyPlatesHubModes.ThreatWidgetModes = {
					{ text = L("仇恨组件"), notCheckable = 1 } ,
					{ text = L("仇恨链"), notCheckable = 1 } ,
					}

TidyPlatesHubModes.ThreatModes = {
					{ text = L("自动(Color Swap)"), notCheckable = 1 } ,
					{ text = L("坦克"), notCheckable = 1 } ,
					{ text = L("DPS/治疗"), notCheckable = 1 } ,
					}