local _G = _G;
local format = format;
local floor = floor;
local ceil = ceil;
local next = next;
local find = string.find;
local type,n2s,f2s = type,n2s,f2s
local UPDATE_TIME = 0.1;
local CreateFrame = CreateFrame;
local GetTime = GetTime;

local timers = {};
local shines = {};
local actives = {};
local tCD = tdCooldown2;
local ABCS = {};
for i=1, NUM_ACTIONBAR_BUTTONS do
	ABCS[i] = _G["ActionButton" .. i .. "Cooldown"];
end

tCD.methods.cdloaded = true;

tCD:SetScript("OnUpdate", function(self, elapsed) self:UpdateAllShines(elapsed) end);

tCD.style = {
	"Interface\\Cooldown\\star4",
	"Interface\\Cooldown\\ping4",
	"Interface\\Cooldown\\starburst",
	"Interface\\AddOns\\tdCooldown2\\media\\heart",
}

local N2T, N2P;
if (GetLocale() == "zhCN") then
	N2T = {["图标"] = 0, ["小闪光"] = 1, ["雷达"] = 2, ["大闪光"] = 3}; 
	N2P = {["左上"] ="TOPLEFT", ["上边"] = "TOP", ["右上"] = "TOPRIGHT", ["左边"] = "LEFT", ["正中"] = "CENTER", ["右边"] = "RIGHT", ["左下"] = "BOTTOMLEFT", ["底部"] = "BOTTOM", ["右下"] = "BOTTOMRIGHT"};
elseif (GetLocale() == "zhTW") then
	N2T = {["圖示"] = 0, ["小閃光"] = 1, ["雷達"] = 2, ["大閃光"] = 3};
	N2P = {["左上"] ="TOPLEFT", ["上邊"] = "TOP", ["右上"] = "TOPRIGHT", ["左邊"] = "LEFT", ["正中"] = "CENTER", ["右邊"] = "RIGHT", ["左下"] = "BOTTOMLEFT", ["底部"] = "BOTTOM", ["右下"] = "BOTTOMRIGHT"};
else
	N2T = {["icon"] = 0, ["star"] = 1, ["ping"] = 2, ["starburst"] = 3};
	N2P = {["Top Left"] ="TOPLEFT", ["Top"] = "TOP", ["Top Right"] = "TOPRIGHT", ["Left"] = "LEFT", ["Center"] = "CENTER", ["Right"] = "RIGHT", ["BottomLeft"] = "BOTTOMLEFT", ["Bottom"] = "BOTTOM", ["Bottom Right"] = "BOTTOMRIGHT"}
end

function tCD:SetShineType(styp)
    self.db.ACTION.style = styp;
end

function tCD:SetBuffAchor(name)
	if (N2P[name]) then
		self.db.BUFF.point = N2P[name];
	end
end

local function Timer_Update(self, elapsed)
	if not self.cooldown:IsVisible() then
		self:Hide();
	else
		if self.nextUpdate <= 0 then
			tCD:UpdateTimer(self);
		else
			self.nextUpdate = self.nextUpdate - elapsed;
		end
	end
end

local function Timer_Hide(self)
	self.nextUpdate = 0;
	self.cooldown:SetAlpha(1);
    self.cooldown.tcdDuration = nil
end

function tCD:GetButtonType(button)
    local name = button:GetName() or "";
    if tCD.db.ignoreCompactRaid and name:find("^CompactRaidFrame") then return end
	if button.unit then
		return "BUFF"
	else
		if find(name, "[Bb][Uu][Ff][Ff]") or find(name, "[Aa][Uu][Rr][Aa]") then
			return "BUFF"
		end
	end
	return "ACTION"
end

--[[------------------------------------------------------------
    -- XXX
    -- implement of cooldown detection for 4.3
---------------------------------------------------------------]]

if(U1Hook_SetActionUIButton) then
    local shown = U1Hook_SetActionUIButton
    tdCooldownUpdateCooldowns = function()
        local mindur = tCD.db and tCD.db.ACTION and tCD.db.ACTION.min or 1.5
        for cd in next, shown do
            local start, duration = GetActionCooldown(cd.tcdAction)
            --if(cd.tcdAction==1) then print("VISIBLE", cd:IsVisible(), start, duration) end
            if (start ~= cd.tcdStart or duration ~= cd.tcdDuration) then
                if (duration > mindur) then
                    cd.tcdStart = start
                    cd.tcdDuration = duration
                    tCD:SetCooldown(cd, start, duration)
                elseif (cd.tcdDuration and duration <= 1.5 and timers[cd]) then
                    timers[cd]:Hide()
                end
            end
        end
    end
    CoreOnEventBucket("ACTIONBAR_UPDATE_COOLDOWN", 0.2, tdCooldownUpdateCooldowns)
end

function tCD:HookCooldown()
    local methods = getmetatable(CreateFrame("Cooldown", nil, nil, "CooldownFrameTemplate")).__index;
    hooksecurefunc(methods, "SetCooldown", function(cooldown, start, duration)
        tCD:SetCooldown(cooldown, start, duration);
    end)
    hooksecurefunc(methods, "SetReverse", function(cooldown, reverse)
        cooldown.type = reverse and "BUFF" or "ACTION";
    end)

	--------------
	-- 消除主动作条CD重叠
	--hooksecurefunc("ShowBonusActionBar", function()
	--	tCD:ShowBonusActionBar();
	--end);
	--hooksecurefunc("HideBonusActionBar", function()
	--	tCD:HideBonusActionBar();
	--end);
end

function tCD:SetCooldown(cooldown, start, duration)
	if cooldown.noCooldownCount then
		if timers[cooldown] then timers[cooldown]:Hide(); end
		return 
	end
	cooldown.button = cooldown.button or cooldown:GetParent();
	if cooldown.button then
		if(not cooldown.type) then cooldown.type = self:GetButtonType(cooldown.button) end

		if cooldown.type then
			if start > 0 and duration > (self.db[cooldown.type].min or 0) and self.db[cooldown.type].config then
				self:StartTimer(cooldown, start, duration);
			elseif timers[cooldown] then
				timers[cooldown]:Hide();
			end
		end
	end
end

if CoreHookAuraUpdate then CoreHookAuraUpdate(function() return tCD.db.mine, timers end) end

function tCD:CreateTimer(cooldown)
	local timer = CreateFrame("Frame", nil, cooldown.button);
	timer.cooldown = cooldown;
	
	timer:SetFrameLevel(cooldown:GetFrameLevel() + 5);
	timer:SetAllPoints(cooldown);
	--timer:SetToplevel(true);
	timer:Hide();
	timer:SetScript("OnUpdate", Timer_Update);
	timer:SetScript("OnHide", Timer_Hide);

	local text = timer:CreateFontString(nil, "OVERLAY");
    local count = timer:GetParent():GetName() and _G[timer:GetParent():GetName().."Count"];
    if(count) then
        --count:SetPoint("BOTTOMRIGHT", 7, -2)
    end
	text:SetPoint("CENTER", timer, self.db[cooldown.type].point or "CENTER", 0, 0);
	timer.text = text;

	if cooldown.button.icon then
		timer.icon = cooldown.button.icon;
	else
		local name = cooldown.button:GetName();
		if name then
			timer.icon = _G[name .. "Icon"] or _G[name .. "IconTexture"];
		end
	end

	timers[cooldown] = timer;
	return timer;
end

function tCD:UpdateTimer(timer)
	timer.cooldown:SetAlpha(self.db[timer.cooldown.type].hidecooldown and 0 or 1);
	
	local time = timer.duration - (GetTime() - timer.start);
	local max = self.db[timer.cooldown.type].max;
	if (not self.db[timer.cooldown.type].config) then
		if (timer.text:IsVisible()) then
			timer.text:Hide();
		end		
		return;
	end

	if ((max and max > 0 and time > max)) then
		timer.text:Hide();
	elseif time > 0 then
		local str, scale, r, g, b, nextUpdate = self:GetFormattedTime(time, self.db[timer.cooldown.type].long);
		local size = timer:GetWidth() or timer.cooldown.button:GetWidth();
		size = floor(size / 36 * self.db[timer.cooldown.type].size * scale);
		
		if size <= 0 then
			timer.nextUpdate = 0.2;
		else
			timer.text:SetFont(self.db[timer.cooldown.type].font, size, "OUTLINE");
			timer.text:SetText(str);
			timer.text:SetTextColor(r, g, b);
			timer.text:SetAlpha(self.db[timer.cooldown.type].alpha);
            local db = self.db[timer.cooldown.type];
			timer.text:SetPoint(db.point or "CENTER", timer, db.point or "CENTER", db.x or 0, db.y or 0);
			timer.text:Show();
			timer.nextUpdate = nextUpdate;
		end
	else
		timer:Hide();
		if time > -1 and self.db[timer.cooldown.type].shine then
			self:StartShine(timer);
		end
	end
end

function tCD:StartTimer(cooldown, start, duration)
	local timer = timers[cooldown] or self:CreateTimer(cooldown);
	if timer then
		timer.start = start;
		timer.duration = duration;
		timer.nextUpdate = 0;
		timer:Show();
	end
end

function tCD:GetFormattedTime(t, long)
	local style, str, nextUpdate;
	if t < 9 then
		style = self.db.short;
		str = n2s(ceil(t));
		nextUpdate = t-floor(t);		
		-- added by dugu@bigfoot
		if (nextUpdate > 0.5) then
			style.g = 0.82;
		else
			style.g = 0.12;
		end
	elseif t < 60 then
		style = self.db.secs;
		str = n2s(ceil(t));
		nextUpdate = t-floor(t);
	elseif t < 3600 then
		style = self.db.mins;
		if t < 600 and long then
			--str = format("%d:%02d",floor(t/60),t%60); --13
            str = n2s(floor(t/60))..n2s(t%60, 2) --10
			nextUpdate = t-floor(t);
		else
			--str = format("%dm", ceil(t/60));
            str = n2s(ceil(t/60)).."m"
			nextUpdate = t%60;
		end
	elseif (t < 86400) then
		style = self.db.hrs;
		--str = format("%dh", ceil(t/3600));
        str = n2s(ceil(t/3600)).."h"
		nextUpdate = t%3600;
	else
		style = self.db.days;
        --str = format("%dd", ceil(t));
		str = n2s(ceil(t)).."d";
		nextUpdate = t%86400;
	end
	return str, style.s, style.r, style.g, style.b, UPDATE_TIME;
end

function tCD:ShowBonusActionBar()
	if (BonusActionBarFrame:IsVisible()) then
		for i, cd in ipairs(ABCS) do
			if (timers[cd]) then
				timers[cd]:SetAlpha(0);
			end
		end
	end	
end

function tCD:HideBonusActionBar()
	for i, cd in ipairs(ABCS) do
		if (timers[cd]) then
			timers[cd]:SetAlpha(1);
		end	
	end
end

function TCooldown_ShowActionBarCooldown()
	tCD:HideBonusActionBar();
end
-- shine
function tCD:CreateShine(button)
	local frame = CreateFrame("Frame", nil, button);
	frame:SetAllPoints(button);
	frame:SetToplevel(true);

	local icon = frame:CreateTexture(nil, 'OVERLAY');
	icon:SetPoint('CENTER');
	icon:SetBlendMode('ADD');
	icon:SetHeight(frame:GetHeight());
	icon:SetWidth(frame:GetWidth());
	frame.icon = icon;

	shines[button] = frame;
	return frame;
end

function tCD:StartShine(timer)
    local shineStyle = self.db[timer.cooldown.type].style
    if shineStyle and shineStyle == -1 then return end
    local icon = timer.icon;
	local button = timer.cooldown.button;
    if(button.noCooldownAnimation) then return end
	if button and button:IsVisible() then
		local shine = shines[button] or self:CreateShine(button);
		if shine and not actives[shine] then
			shine.type = timer.cooldown.type;
			local style = self.style[shineStyle];
			if not style and icon then
				local texture = type(icon.GetTexture) == "function" and icon:GetTexture() or nil;
				shine.icon:SetTexture(texture);
                shine.icon:SetTexCoord(4/64, 60/64, 4/64, 60/64)
			else
				shine.icon:SetTexture(style);
                shine.icon:SetTexCoord(0,1,0,1)
			end

			shine.completed = 0;
			shine:Show();

			actives[shine] = true;
			self:Show();
		end
	end
end

function tCD:UpdateShine(shine, elapsed)
	shine.completed = (shine.completed or 0) + elapsed;

	local scale = (self.db[shine.type].scale - 1) * (1 - shine.completed) + 1;

	if scale <= 1 then
		actives[shine] = nil;
		shine:Hide();
	else
		shine.icon:SetHeight(shine:GetHeight() * scale);
		shine.icon:SetWidth(shine:GetWidth() * scale);
	end
end

function tCD:UpdateAllShines(elapsed)
	if next(actives) then
		for shine in pairs(actives) do
			self:UpdateShine(shine, elapsed);
		end
	else
		self:Hide();
	end
end
