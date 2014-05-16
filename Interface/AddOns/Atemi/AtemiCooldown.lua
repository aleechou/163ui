--[[

@class         AtemiCooldown
@description   holds up a spell with a cooldown duration properties and the UI elements to show this cooldown

public function API:
	void BindToNameplate(nameplate);
	void SetIconCoords(anchorRef, anchor, x, y, size);
	void Hide();
	bool IsExpiredBy(time);

public properties:
	int spellID;
	string spellName;
	double endTime;


example use:
	local cd = AtemiCooldown(spellID, spellCooldown + timeNow, self.db.profile)
	-- once you know the player's nameplate, bind the cooldown to show it atop
	cd.BindToNameplate(someNameplate)
]]

AtemiCooldown = {}
AtemiCooldown.__index = AtemiCooldown

-- {{{ some generic utility/helper functions
local function round(value)
	return ceil(value - 0.5)
end
-- }}}

-- creates a new cooldown for the given spell.
--
-- @param spellID    the spell ID of the spell to create the cooldown for
-- @param endTime    an absolute time when the cooldown is to expire
-- @param db         a pointer to the configuration to read color codes (etc) from
--
function AtemiCooldown:new(spellID, endTime, db)
	local self = {}
	setmetatable(self, AtemiCooldown)

	local name, rank, texture = GetSpellInfo(spellID)

	self.db = db
	self.spellID = spellID
	self.spellName = name
	self.texture = texture
	self.endTime = endTime

	Atemi:Debug(1, "New Spell cooldown (" .. tostring(spellID) .. ") " .. name .. "")

	return self
end

-- binds this cooldown to a specific nameplate (UI frame), if not yet done so, and shows the cooldowns UI elements atop of it.
--
-- @param nameplate the nameplate UI element this cooldown belongs to.
--
function AtemiCooldown:BindToNameplate(nameplate)
	Atemi:Debug(1, "Bind Spell cooldown (" .. tostring(self.spellID) .. ") " .. self.spellName .. "")
	self.nameplate = nameplate

	if not self.icon then
		self.icon = CreateFrame("Frame", nil, UIParent)
		self.icon:SetParent(self.nameplate)

		self.icon.texture = self.icon:CreateTexture(nil, "BORDER")
		self.icon.texture:SetAllPoints(self.icon)
		self.icon.texture:SetTexture(self.texture)

		self.iconText = self.icon:CreateFontString(nil, "OVERLAY")
		local color = self.db.textColor
		self.iconText:SetTextColor(color.red, color.green, color.blue)
		self.iconText:SetAllPoints(self.icon)
		self.iconText:SetFont(self.db.fontPath, self.db.fontSize, "OUTLINE")
		self.iconText:SetText("?")

		self.icon:Show()

		self.icon:SetScript("OnUpdate", function()
			self:onIconUpdate()
		end)

		if self.db.showTooltips then
			self.icon:SetScript("OnEnter", function()
				GameTooltip:ClearLines()
				GameTooltip:AddSpellByID(self.spellID)
				GameTooltip:Show()
			end)
			self.icon:SetScript("OnLeave", function()
				GameTooltip:FadeOut()
			end)
		end
	end
end

-- repositions the cooldown icon relative to an anchor UI element's x & y and resizes it to the given size.
--
-- @param anchorRef TOPLEFT, etc.
-- @param anchor    the frame to reposition the icon relative to
-- @param x         the X-coordinate or offset, relative to the anchor
-- @param y         the Y-coordinate or offset, relative to the anchor
-- @param size      the extents (width & height) of the icon
--
-- FIXME should we resize the icon text accordingly, too? would require an additional parameter.
--
function AtemiCooldown:SetIconCoords(anchorRef, anchor, x, y, size)
	self.icon:ClearAllPoints()
	self.icon:SetPoint(anchorRef, anchor, x, y)
	self.icon:SetWidth(size)
	self.icon:SetHeight(size)
end

-- redraws the icon (text).
--
-- @internal
--
function AtemiCooldown:onIconUpdate()
	local itimer = round(self.endTime - GetTime())

	if itimer > 60 then
		self.iconText:SetText(round(itimer / 60) .. "m")
	elseif itimer < 60 and itimer >= 1 then
		self.iconText:SetText(ceil(itimer))
	else
		self:Hide()
	end
end

-- hides the UI element(s) of this cooldown.
--
-- You must BindToNameplate() in order to show the icon again.
--
function AtemiCooldown:Hide()
	Atemi:Debug(1, "Hide Spell cooldown (" .. tostring(self.spellID) .. ") " .. self.spellName .. "")
	if self.icon then
		self.icon:Hide()
		self.icon:SetScript("OnUpdate", nil)
		self.icon:SetScript("OnEnter", nil)
		self.icon:SetScript("OnLeave", nil)
		self.icon:SetParent(nil)

		self.icon = nil
		self.iconText = nil
	end
end

-- tests whether or not the cooldown has expired (faded out) already.
--
function AtemiCooldown:IsExpiredBy(time)
	return round(self.endTime - time) <= 0
end
