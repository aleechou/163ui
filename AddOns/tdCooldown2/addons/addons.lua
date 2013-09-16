local IsAddOnLoaded = IsAddOnLoaded;

local tCD = tdCooldown2;
tCD.methods.addons = true;
local addons = {};

function tCD:SetAddOn(addon, func)
	tinsert(addons, {addon = addon, func = func});
end

function tCD:DoAddOns()
	for i, v in ipairs(addons) do
		if IsAddOnLoaded(v.addon) then
			v.func();
		end
	end
	-- addons = nil;
	-- self.SetAddOn = nil;
	-- self.DoAddOns = nil;
end
