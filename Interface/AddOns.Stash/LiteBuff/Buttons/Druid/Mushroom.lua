------------------------------------------------------------
-- Mushroom.lua
--
-- Abin
-- 2012/1/29
------------------------------------------------------------

if select(2, UnitClass("player")) ~= "DRUID" then return end


local _, addon = ...
local L = addon.L

local button = addon:CreateActionButton("DruidMushroom", 88747, nil, 300, "DUAL")
button:SetSpell(88747)
button:SetAttribute("spell", button.spell)
button:SetSpell2(88751)
button:SetAttribute("spell2", button.spell2)
button:SetFlyProtect()
button:RequireSpell(88747)

button.icon.text:ClearAllPoints()
button.icon.text:SetPoint("BOTTOMRIGHT")

function button:OnUpdateTimer(spell)
	local shortest, count = 0, 0
	local i
	for i = 1, 3 do
		local haveTotem, name, startTime, duration = GetTotemInfo(i)
		if haveTotem and (startTime or 0 ) > 0 and (duration or 0) > 0 then
			count = count + 1
			local expires = startTime + duration
			if shortest == 0 or expires < shortest then
				shortest = expires
			end
		end
	end

	if count > 0 then
		local r, g, b = addon:GetGradientColor(count, 3)
		self.icon:SetText(count, r, g, b)
	else
		self.icon:SetText()
	end

	if count == 3 then
		return 1, shortest
	elseif count > 0 then
		return -1, shortest
	end
end
--163uiedit
local function update()
    local spellID = 102791 -- 恢复
    if(GetSpecialization() == 1) then
        spellID = 88751 -- 平衡
    end
    button:SetSpell2(spellID)
    button:SetAttribute('spell2', button.spell2)
    button:RequireSpell(spellID)
end

addon:__163_OnSpellChanged(update)

