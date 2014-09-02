local MAX_BUFFS = 6

local L = setmetatable(GridBuffIconsLocale or {}, {__index = function(t, k) t[k] = k return k end})

local GridRoster = Grid:GetModule("GridRoster")
local GridFrame = Grid:GetModule("GridFrame")
local GridBuffIconStatus = Grid:NewModule("GridBuffIconStatus", "AceBucket-3.0")

GridBuffIconStatus.menuName = L["Buff Icons"]

GridBuffIconStatus.defaultDB = {
    enabled = true,
	iconsize = 9,
	offsetx = 9,
	offsety = -1,
	alpha = 0.8,
	iconnum = 4,
	iconperrow = 2,
	showbuff = nil, 
	bufffilter = true,
	namefilter = nil,
	orientation = "VERTICAL",
	anchor = "TOPRIGHT",
	color = { r = 0, g = 0.5, b = 1.0, a = 1.0 },
	ecolor = { r = 1, g = 1, b = 0, a = 1.0 },
	rcolor = { r = 1, g = 0, b = 0, a = 1.0 },
	unit_buff_icons = {
		color = { r=1, g=1, b=1, a=1 },
		text = "BuffIcons",
		enable = true,
		priority = 30,
		range = false
	} 
}

local options = {
	type = "group",
    inline = GridFrame.options.args.bar.inline,
	name = L["Buff Icons"],
	desc = L["Buff Icons"],
    order = 1200,
	args = {
		["Enable"] = {
			order = 40, width = "double",
			type = "toggle",
			name = L["启用模块"],
			desc = L["启用/停用模块，会在框体外部(可设置)显示所有的增益或负面状态图标。"],
			get = function()
				return GridBuffIconStatus.db.profile.enabled;
			end,
			set = function(_, v)
                GridBuffIconStatus.db.profile.enabled = v;
                if v and not GridBuffIconStatus.enabled then
                    GridBuffIconStatus:OnEnable()
                elseif not v and GridBuffIconStatus.enabled then
                    GridBuffIconStatus:OnDisable()
                end
			end,
		},
		["Show Buff Not Debuff"] = {
			order = 50, width = "double",
			type = "toggle",
			name = L["Show Buff instead of Debuff"],
			desc = L["If selected, the icons will present unit buffs instead of debuffs."],
			get = function()
				return GridBuffIconStatus.db.profile.showbuff;
			end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.showbuff = v;
				GridBuffIconStatus:UpdateAllUnitsBuffs();
			end,
		},
		["Buff Filter"] = {
			order = 50, width = "double",
			type = "toggle",
			name = L["Only castable/removable"],
			desc = L["If selected, only shows the buffs you can cast or the debuffs you can remove."],
			get = function()
				return GridBuffIconStatus.db.profile.bufffilter;
			end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.bufffilter = v;
				GridBuffIconStatus:UpdateAllUnitsBuffs();
			end,
		},
		["Buff Name Filter"] = {
			order = 52, width = "full",
			type = "input",
			name =  L["Buff Name Filter"],
			desc =  L["Buffs NOT TO show. Use ',' between the names."],
			get = function()
				return GridBuffIconStatus.db.profile.namefilter;
			end,
			usage =  "<buff name>",
			set = function(_, v) 
				GridBuffIconStatus.db.profile.namefilter = v;
				GridBuffIconStatus:SetNameFilter()
				GridBuffIconStatus:UpdateAllUnitsBuffs();
			end,
		},
		["Icons size"] = {
			order = 55, width = "double",
			type = "range",
			name = L["Icons Size"],
			desc = L["Size for each buff icon"],
			max = 16,
			min = 5,
			step = 1,
			get = function () return GridBuffIconStatus.db.profile.iconsize end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.iconsize = v;
				GridFrame:WithAllFrames(function (f) GridBuffIconStatus.ResetBuffIconSize(f) end)
			end
		},
		["Alpha"] = {
			order = 70, width = "double",
			type = "range",
			name = L["Alpha"],
			desc = L["Alpha value for each buff icon"],
			max = 1,
			min = 0.1,
			step = 0.1,
			get = function () return GridBuffIconStatus.db.profile.alpha end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.alpha = v;
				GridFrame:WithAllFrames(function (f) GridBuffIconStatus.ResetBuffIconAlpha(f) end)
			end
		},
        ["Offset X"] = {
			order = 60, width = "double",
			type = "range",
			name = L["Offset X"],
			desc = L["X-axis offset from the selected anchor point, minus value to move inside."],
			max = 20,
			min = -20,
			step = 1,
			get = function () return GridBuffIconStatus.db.profile.offsetx end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.offsetx = v;
				GridFrame:WithAllFrames(function (f) GridBuffIconStatus.ResetBuffIconPos(f) end)
			end
		},
		["Offset Y"] = {
			order = 65, width = "double",
			type = "range",
			name = L["Offset Y"],
			desc = L["Y-axis offset from the selected anchor point, minus value to move inside."],
			max = 20,
			min = -20,
			step = 1,
			get = function () return GridBuffIconStatus.db.profile.offsety end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.offsety = v;
				GridFrame:WithAllFrames(function (f) GridBuffIconStatus.ResetBuffIconPos(f) end)
			end
		},
		["Icon Numbers"] = {
			order = 75, width = "double",
			type = "range",
			name = L["Icon Numbers"],
			desc = L["Max icons to show."],
			max = MAX_BUFFS,
			min = 1,
			step = 1,
			get = function()
				return GridBuffIconStatus.db.profile.iconnum;
			end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.iconnum = v;
				GridBuffIconStatus:UpdateAllUnitsBuffs();
			end,
		},
		["Icons Per Row"] = {
			order = 75, width = "double",
			type = "range",
			name = L["Icons Per Row"],
			desc = L["Sperate icons in several rows."],
			max = MAX_BUFFS,
			min = 0,
			step = 1,
			get = function()
				return GridBuffIconStatus.db.profile.iconperrow;
			end,
			set = function(_, v)
				GridBuffIconStatus.db.profile.iconperrow = v;
				GridFrame:WithAllFrames(function (f) GridBuffIconStatus.ResetBuffIconPos(f) end);
			end,
		},
		["orientation"] = {
			order = 80,  width = "double",
			type = "select",
			name = L["Orientation of Icon"],
			desc = L["Set icons list orientation."],
			get = function ()
				      return GridBuffIconStatus.db.profile.orientation
				end,
			set = function(_, v)
				      GridBuffIconStatus.db.profile.orientation = v
				      GridFrame:WithAllFrames(function (f) GridBuffIconStatus.ResetBuffIconPos(f) end)
				end,
			values ={["HORIZONTAL"] = L["HORIZONTAL"], ["VERTICAL"] = L["VERTICAL"]}
		},
		["anchor"] = {
			order = 90,  width = "double",
			type = "select",
			name = L["Anchor Point"],
			desc = L["Anchor point of the first icon."],
			get = function ()
				      return GridBuffIconStatus.db.profile.anchor
				end,
			set = function(_, v)
				      GridBuffIconStatus.db.profile.anchor = v
				      GridFrame:WithAllFrames(function (f) GridBuffIconStatus.ResetBuffIconPos(f) end)
				end,
			values ={["TOPRIGHT"] = L["TOPRIGHT"], ["TOPLEFT"] = L["TOPLEFT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]}
		},
	}
}
GridFrame.options.args.GridBuffIconStatus = options;

function GridBuffIconStatus.InitializeFrame(gridFrameObj, f)
    if not f.BuffIcons then
        f.BuffIcons = {};
        for i=1, MAX_BUFFS do
            f.BuffIcons[i] = f.Bar:CreateTexture("BuffIcon"..i, "OVERLAY");
            f.BuffIcons[i]:SetTexCoord(0.05, 0.95, 0.05, 0.95)
            f.BuffIcons[i]:SetTexture(1,1,1,0)
        end

        GridBuffIconStatus.ResetBuffIconSize(f);
        GridBuffIconStatus.ResetBuffIconPos(f);
        GridBuffIconStatus.ResetBuffIconAlpha(f);
    end
end

function GridBuffIconStatus.ResetBuffIconSize(f)
	if(f.BuffIcons) then
		for _,v in pairs(f.BuffIcons) do
			v:SetWidth(GridBuffIconStatus.db.profile.iconsize);
			v:SetHeight(GridBuffIconStatus.db.profile.iconsize);
		end
	end
end

function GridBuffIconStatus.ResetBuffIconPos(f)
	local icons = f.BuffIcons
	local xadjust = 1;
	local yadjust = 1;
	local p = GridBuffIconStatus.db.profile;
	if(string.find(p.anchor, "BOTTOM")) then yadjust = -1; end;
	if(string.find(p.anchor, "LEFT")) then xadjust = -1; end;
	if(icons) then
		for k,v in pairs(icons) do
			v:ClearAllPoints();
			if(k==1) then
				v:SetPoint(p.anchor, f, p.anchor, xadjust * p.offsetx, yadjust * p.offsety)
			elseif(p.iconperrow and p.iconperrow>0 and (k-1)%p.iconperrow==0) then
				if(p.orientation == "VERTICAL") then
					if(string.find(p.anchor, "RIGHT")) then
						if(p.offsetx<=0) then
							v:SetPoint("RIGHT", icons[k-p.iconperrow], "LEFT", -1, 0); --向内侧(左)
						else
							v:SetPoint("LEFT", icons[k-p.iconperrow], "RIGHT", 1, 0);  --向外侧(右)
						end
					elseif(string.find(p.anchor, "LEFT")) then
						if(p.offsetx<=0) then
							v:SetPoint("LEFT", icons[k-p.iconperrow], "RIGHT", 1, 0);  --向内侧(右)
						else
							v:SetPoint("RIGHT", icons[k-p.iconperrow], "LEFT", -1, 0);
						end
					end
				else
					if(string.find(p.anchor, "TOP")) then
						if(p.offsety<=0) then
							v:SetPoint("TOP", icons[k-p.iconperrow], "BOTTOM", 0, -1);  --向内侧(下)
						else
							v:SetPoint("BOTTOM", icons[k-p.iconperrow], "TOP", 0, 1);  --向内侧(上)
						end
					elseif(string.find(p.anchor, "BOTTOM")) then
						if(p.offsety<=0) then
							v:SetPoint("BOTTOM", icons[k-p.iconperrow], "TOP", 0, 1);
						else
							v:SetPoint("TOP", icons[k-p.iconperrow], "BOTTOM", 0, -1);
						end
					end
				end
			else
				if(p.orientation == "VERTICAL") then
					if(string.find(p.anchor, "BOTTOM")) then
						v:SetPoint("BOTTOM", icons[k-1], "TOP", 0, 1);  --向上增长
					else
						v:SetPoint("TOP", icons[k-1], "BOTTOM", 0, -1); --向下增长
					end
				else
					if(string.find(p.anchor, "LEFT")) then
						v:SetPoint("LEFT", icons[k-1], "RIGHT", 1, 0);  --向右增长
					else
						v:SetPoint("RIGHT", icons[k-1], "LEFT", -1, 0);  --向左增长
					end
				end
			end
		end
	end
end

function GridBuffIconStatus.ResetBuffIconAlpha(f)
	if(f.BuffIcons) then
		for k,v in pairs(f.BuffIcons) do
			v:SetAlpha( GridBuffIconStatus.db.profile.alpha );
		end
	end
end

function GridBuffIconStatus:OnInitialize()
	self.super.OnInitialize(self)
	GridFrame:WithAllFrames(function(f) GridBuffIconStatus.InitializeFrame(nil, f); end)
	hooksecurefunc(GridFrame, "InitializeFrame", self.InitializeFrame);
end

function GridBuffIconStatus:OnEnable()
    if not GridBuffIconStatus.db.profile.enabled then return end
    self.enabled = true
	self:RegisterEvent("UNIT_AURA")
	if(not self.bucket) then
		self:Debug("registering bucket");
		self.bucket = self:RegisterBucketMessage("Grid_UpdateLayoutSize", 1, "UpdateAllUnitsBuffs")
	end
	self:SetNameFilter()

	self:UpdateAllUnitsBuffs();
end

function GridBuffIconStatus:OnDisable()
    self.enabled = nil
	self:UnregisterEvent("UNIT_AURA")
	if(self.bucket) then
		self:Debug("unregistering bucket");
		self:UnregisterBucket(self.bucket);
		self.bucket = nil;
	end
	for k,v in pairs(GridFrame.registeredFrames) do
		if(v.BuffIcons) then
			for i=1, MAX_BUFFS do v.BuffIcons[i]:SetTexture(nil); end
		end
	end
end

function GridBuffIconStatus:SetNameFilter()
	local str = string.gsub(GridBuffIconStatus.db.profile.namefilter or "", "，", ",")
	self.namefilter = {strsplit(",", str)}
end

function GridBuffIconStatus:Reset()
	self.super.Reset(self)
	self:SetNameFilter()
end

local function updateFrame(v)
    --if(not v.BuffIcons) then
    --	v:CreateIndicator("bufficons");
    --end

    local i = 1
    local n = 1
    while(n <= GridBuffIconStatus.db.profile.iconnum and i<40) do
        local name, rank, iconTexture, count, duration, timeLeft;
        if GridBuffIconStatus.db.profile.showbuff then
            name, rank, iconTexture, count, duration, timeLeft = UnitBuff(v.unit, i, GridBuffIconStatus.db.profile.bufffilter and "RAID");
        else
            name, rank, iconTexture, count, duration, timeLeft = UnitDebuff(v.unit,i, GridBuffIconStatus.db.profile.bufffilter and "RAID");
        end
        if(name) then
            local flag = true
            for k,v in pairs(GridBuffIconStatus.namefilter) do
                if(name==v) then
                    flag = false;
                    break;
                end
            end
            if(flag)then
                v.BuffIcons[n]:SetTexture(iconTexture);
                n=n+1
            end
        else
            break;
        end
        i=i+1
    end
    for i=n, MAX_BUFFS do
        v.BuffIcons[i]:SetTexture(nil);
    end
end

function GridBuffIconStatus:UNIT_AURA(event, unitid)
	if not self.enabled then return end
	-- if GridRoster.GetRaidUnitGUID then
	-- 	local guid = GridRoster:GetRaidUnitGUID(unitid)
	-- 	if not guid then return end
	-- 	GridFrame:WithGUIDFrames(guid, updateFrame)
	-- else
		local guid = UnitGUID(unitid)
		if not GridRoster:IsGUIDInRaid(guid) then return end
		for k,v in pairs(GridFrame.registeredFrames) do
			if v.unitGUID == guid then updateFrame(v) end
		end
	-- end
	
end

function GridBuffIconStatus:UpdateAllUnitsBuffs()
	for guid, unitid in GridRoster:IterateRoster() do
		self:UNIT_AURA("UpdateAllUnitsBuffs", unitid)
	end
	--self:UNIT_AURA("player");
end