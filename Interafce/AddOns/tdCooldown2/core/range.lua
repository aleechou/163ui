local tCD = tdCooldown2;
local IsActionInRange = IsActionInRange;
local _G = _G

tCD.methods.range = true

local function tdRange_GetColor(id)
	local isUsable, notEnoughMana = IsUsableAction(id)
	if notEnoughMana then
		if IsActionInRange(id) == 0 then
			return 0.75, 0.5, 1.0, 1
		else
			return 0.5, 0.5, 1.0, 2
		end
	elseif not isUsable then
		return 0.4, 0.4, 0.4, 3
	elseif IsActionInRange(id) == 0 then
		return 0.5, 0.1, 0.1, 4
	else
		return 1.0, 1.0, 1.0, 0
	end
end

local iconNameCache = {}
function tCD:ActionButton_UpdateUsable(btn, updateUsable)
	local r, g, b, index = tdRange_GetColor(btn.action)
	if not (btn.index and btn.index == index) then
		btn.index = index
		if not updateUsable or (index==4 or index==1) then
            local icon = iconNameCache[btn]
            if not icon then
                icon = _G[btn:GetName().."Icon"]
                iconNameCache[btn] = icon
            end
			icon:SetVertexColor(r, g, b);
		end
	end
end

function tCD:LoadRedRange()
    local db = tCD.db
    hooksecurefunc("ActionButton_UpdateUsable", function(self)
        if ( db.redout ) then
            self.index = nil
            tCD:ActionButton_UpdateUsable(self, true);
        end	
    end);

    hooksecurefunc("ActionButton_OnUpdate", function(self, elapsed)
        if ( db.redout and self.rangeTimer and self.rangeTimer > TOOLTIP_UPDATE_TIME - 0.001 ) then
            tCD:ActionButton_UpdateUsable(self);
        end
    end)

end

