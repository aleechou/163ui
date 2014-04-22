-- Author      : s1172
-- Create Date : 2013/5/1 14:59:45

local class = select(2,UnitClass("player"))
local NewbieAssistantPanelTalentFrame_DisplayData

if class == "PRIEST" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-priest-1",
			text = "使用魔法护盾保护盟友不受伤害，也能及时治愈他们的伤口。",
		},
		[2] = {
			texture = "spec-priest-2",
			text = "多才多艺的治疗者，能够单体治疗也能照顾到整个团队，甚至能在牺牲后继续治疗。",
		},
		[3] = {
			texture = "spec-priest-3",
			text = "使用邪恶的暗影魔法彻底根除敌人，尤其擅长持续伤害法术。",
		},
	}
elseif class == "HUNTER" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-hunter-1",
			text = "对荒野了如指掌，他能够驯服多种多样的野兽协助作战。",
		},
		[2] = {
			texture = "spec-hunter-2",
			text = "百步穿杨的神射手，擅长远距离夺走敌人的性命。",
		},
		[3] = {
			texture = "spec-hunter-3",
			text = "精练的追踪者，能将动物剧毒，爆炸物和陷阱当作致命的武器来使用。",
		},
	}
elseif class == "MAGE" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-mage-1",
			text = "操纵奥术之力，以压倒性的能量毁灭敌人。",
		},
		[2] = {
			texture = "spec-mage-2",
			text = "使用灼热的火球和燃烧的烈焰烧尽敌人。",
		},
		[3] = {
			texture = "spec-mage-3",
			text = "使用冰霜魔法冻结敌人的脚步，再彻底粉碎他们的身体。",
		},
	}
elseif class == "MONK" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-monk-1",
			text = "坚韧的勇士，以行云流水、变化莫测的身法闪避伤害并保护盟友。",
		},
		[2] = {
			texture = "spec-monk-2",
			text = "融汇熊猫人武学奥秘与传统草药医学的医者。",
		},
		[3] = {
			texture = "spec-monk-3",
			text = "武艺无双，尤其擅长拳脚功夫的武者。",
		},
	}
elseif class == "PALADIN" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-paladin-1",
			text = "唤起圣光的能量来保护和治疗盟友。",
		},
		[2] = {
			texture = "spec-paladin-2",
			text = "使用神圣的魔法为自己和盟友提供防护。",
		},
		[3] = {
			texture = "spec-paladin-3",
			text = "正义的十字军，使用手中的武器和神圣的魔法对敌人进行审判和制裁。",
		},
	}
elseif class == "ROGUE" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-rogue-1",
			text = "致命的使毒高手，能够使用匕首迅速而冷酷的杀死敌人。",
		},
		[2] = {
			texture = "spec-rogue-2",
			text = "敏捷而狡诈的游荡剑客，擅长与敌人短兵相接。",
		},
		[3] = {
			texture = "spec-rogue-3",
			text = "阴影中的追猎者，擅长在最恰当的时机对毫无戒备的猎物发起致命的伏击。",
		},
	}
elseif class == "SHAMAN" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-shaman-1",
			text = "能够驾驭元素的施法者，使用自然的毁灭之力打击敌人。",
		},
		[2] = {
			texture = "spec-shaman-2",
			text = "信仰图腾之力的战士，使用灌注元素能量的武器攻击敌人。",
		},
		[3] = {
			texture = "spec-shaman-3",
			text = "能召唤先祖之魂的治疗者，使用水之净化能量来治愈盟友的创伤。",
		},
	}
elseif class == "WARLOCK" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-warlock-1",
			text = "暗影魔法大师，擅长吸取能量和持续伤害法术。",
		},
		[2] = {
			texture = "spec-warlock-2",
			text = "精通恶魔法术，能够变身成恶魔形态，并奴役强大的恶魔为其效命。",
		},
		[3] = {
			texture = "spec-warlock-3",
			text = "使用混乱魔法的大师，能够降下灾厄的烈焰，将敌人焚烧殆尽。",
		},
	}
elseif class == "WARRIOR" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-warrior-1",
			text = "久经沙场的战斗大师，擅使双手武器，利用灵活的移动和压制性的攻击来摧垮敌人。",
		},
		[2] = {
			texture = "spec-warrior-2",
			text = "暴怒的狂战士，双手各持一柄武器，掀起的暴力飓风能够轻易将敌人切碎。",
		},
		[3] = {
			texture = "spec-warrior-3",
			text = "坚毅的保护者，使用手中的盾牌为自己和盟友构筑可靠的防御。",
		},
	}
elseif class == "DRUID" then
	NewbieAssistantPanelTalentFrame_DisplayData = {
		[1] = {
			texture = "spec-druid-1",
			text = "可以变形为强大的枭兽，释放奥术和自然的平衡之力在远距离毁灭敌人。",
		},
		[2] = {
			texture = "spec-druid-2",
			text = "致命的猎豹形态，利用撕咬和流血造成大量伤害。",
		},
		[3] = {
			texture = "spec-druid-3",
			text = "强大的熊形态，吸收伤害并保护盟友。",
		},
		[4] = {
			texture = "spec-druid-4",
			text = "使用持续性治疗法术来维持盟友的生命。",
		},
	}
end


function NewbieAssistantPanelTalentFrame_OnShow(self)
	if not NewbieAssistantPanelTalentFrame_DisplayData then return end

	if #NewbieAssistantPanelTalentFrame_DisplayData == 4 then
		self.SpecParentFrame:SetPoint("TOPLEFT",self,"TOPLEFT",35,-400)
		self.SpecParentFrame:SetScale(0.76)
	end

	for i,k in pairs(NewbieAssistantPanelTalentFrame_DisplayData) do
		self.SpecParentFrame["TEXT"..i]:SetText(k.text)
		self.SpecParentFrame["TEXT"..i]:Show()
		self.SpecParentFrame["SpecTexture"..i]:SetTexture("Interface\\AddOns\\NewbieAssistant\\Media\\Textures\\Panel\\Talent\\"..k.texture)
		self.SpecParentFrame["SpecTexture"..i]:Show()
	end

end