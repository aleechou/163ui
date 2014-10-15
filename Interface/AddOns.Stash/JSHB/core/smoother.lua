--
-- JSHB - smoother for bars
--

-- Upvalues
local min, max, abs = math.min, math.max, math.abs

local function Smooth(self, value)
	if (value ~= self:GetValue() ) or (value == 0) then
		self.smoothing = value
	else
		self.smoothing = nil
	end
end

function JSHB.MakeSmooth(powerFrame)
	if powerFrame.SetValue_ORI then return end
	
	powerFrame.SetValue_ORI = powerFrame.SetValue
	powerFrame.SetValue = Smooth
	powerFrame.smoother = powerFrame.smoother or CreateFrame("Frame", nil, powerFrame)
	powerFrame.smoother:SetParent(powerFrame)
	powerFrame.smoother:SetScript("OnUpdate", function(self)
		local rate = GetFramerate()
		local limit = 30 / rate
		if self:GetParent().smoothing then
			local cur = self:GetParent():GetValue()
			local new = cur + min( (self:GetParent().smoothing - cur) / 3, max(self:GetParent().smoothing - cur, limit) )
			self:GetParent():SetValue_ORI(new)
			if (cur == self:GetParent().smoothing) or (abs(new - self:GetParent().smoothing) < 2) then
				self:GetParent():SetValue_ORI(self:GetParent().smoothing)
				self:GetParent().smoothing = nil
			end
		end
	end)
	powerFrame.smoother:Show()
end

function JSHB.RemoveSmooth(powerFrame)
	if not powerFrame.SetValue_ORI then return end
	
	powerFrame.smoother:Hide()
	powerFrame.smoother:SetScript("OnUpdate", nil)
	powerFrame.smoother:SetParent(nil)
	
	powerFrame.SetValue = powerFrame.SetValue_ORI
	powerFrame.SetValue_ORI = nil
end
