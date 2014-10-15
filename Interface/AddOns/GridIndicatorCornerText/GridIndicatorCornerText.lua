local n2s,max,floor,pairs=n2s,max,floor,pairs
-- ----------------------------------------------------------------------------
-- GridIndicatorCornerText by Szandos
-- ----------------------------------------------------------------------------
local L = GridIndicatorCornerTextLocale
local media = LibStub("LibSharedMedia-3.0", true)

local GridFrame = Grid:GetModule("GridFrame")
local GridIndicatorCornerText = GridFrame:NewModule("GridIndicatorCornerText", "AceTimer-3.0")

GridIndicatorCornerText.defaultDB = {
	CornerTextFontSize = 9,
	CornerTextLength = 3,
	CornerTextFont = "Friz Quadrata TT",
	CornerTextOutline = "NONE",
}

local indicators = GridFrame.prototype.indicators
table.insert(indicators, { type = "cornertexttopleft", order = 11.1, name = L["Corner Text Top Left"] })
table.insert(indicators, { type = "cornertexttopright", order = 11.2, name = L["Corner Text Top Right"] })
table.insert(indicators, { type = "cornertextbottomleft", order = 11.3, name = L["Corner Text Bottom Left"] })
table.insert(indicators, { type = "cornertextbottomright", order = 11.4, name = L["Corner Text Bottom Right"] })

local statusmap = GridFrame.defaultDB.statusmap
if not statusmap["cornertexttopleft"] then
	statusmap["cornertexttopleft"] = {}
	statusmap["cornertexttopright"] = {}
	statusmap["cornertextbottomleft"] = {}
	statusmap["cornertextbottomright"] = {}
end

if(GridFrame and GridFrame.db and GridFrame.db.profile) then
	statusmap = GridFrame.db.profile.statusmap
	if not statusmap["cornertexttopleft"] then
		statusmap["cornertexttopleft"] = {}
		statusmap["cornertexttopright"] = {}
		statusmap["cornertextbottomleft"] = {}
		statusmap["cornertextbottomright"] = {}
	end
end

local indicator_names = {"cornertexttopleft", "cornertexttopright", "cornertextbottomleft", "cornertextbottomright"}
function GridIndicatorCornerText:OnUpdate()
	for _, f in pairs(GridFrame.registeredFrames) do
		for _, indicator in pairs(indicator_names) do
			self:UpdateIndicatorText(f[indicator])
		end
	end
end

local interval = 0.5
function GridIndicatorCornerText:UpdateIndicatorText(indicator)
	if(indicator) then
		local timeLeft = indicator.timeLeft
		if(timeLeft) then
			indicator.timeLeft = timeLeft - interval
			indicator.Text:SetText(n2s(max(floor(indicator.timeLeft), 0)))
		end
	end
end

local options = {
	type = "group",
	name = L["Corner Text"],
	desc = L["Corner Text Options."],
	order = 1110,
	args = {
		["cornertextfontsize"] = {
			type = "range",
			name = L["Corner Text Font Size"],
			desc = L["Adjust the font size for Corner Text."],
			order = 111, width = "double",
			min = 4,
			max = 24,
			step = 1,
			get = function ()
				return GridIndicatorCornerText.db.profile.CornerTextFontSize
			end,
			set = function (_, v)
				GridIndicatorCornerText.db.profile.CornerTextFontSize = v
				GridFrame:WithAllFrames(function (f) GridIndicatorCornerText:UpdateFont(f) end)
			end,
		},
		["cornertextfont"] = {
			type = "select",
			name = L["Corner Text Font"],
			desc = L["Adjust the font setting for Corner Text."],
			order = 120, width = "double",
			values = media:HashTable("font"),
			dialogControl = "LSM30_Font",
			get = function ()
				return GridIndicatorCornerText.db.profile.CornerTextFont
			end,
			set = function (_, v)
				GridIndicatorCornerText.db.profile.CornerTextFont = v
				GridFrame:WithAllFrames(function (f) GridIndicatorCornerText:UpdateFont(f) end)
			end,
		},
		["cornertextoutline"] = {
			type = "select",
			name = L["Outline Text"],
			desc = L["Use outlined font"],
			order = 130, width = "double",
			values = { ["NONE"] = L["None"], ["OUTLINE"] = L["Thin"], ["THICKOUTLINE"] = L["Thick"] },
			get = function ()
				return GridIndicatorCornerText.db.profile.CornerTextOutline
			end,
			set = function (_, v)
				GridIndicatorCornerText.db.profile.CornerTextOutline = v
				GridFrame:WithAllFrames(function (f) GridIndicatorCornerText:UpdateFont(f) end)
			end,
		},

		["cornertextlength"] = {
			type = "range",
			name = L["Corner Text Length"],
			desc = L["Adjust the length for Corner Text."],
			order = 115, width = "double",
			min = 2,
			max = 10,
			step = 1,
			get = function ()
				return GridIndicatorCornerText.db.profile.CornerTextLength
			end,
			set = function (_, v)
				GridIndicatorCornerText.db.profile.CornerTextLength = v
				GridFrame:UpdateAllFrames()
			end,
		},

        },
}

GridFrame.options.args["GridIndicatorCornerText"] = options;

function GridIndicatorCornerText:OnInitialize()
	GridFrame:RegisterModule(self.moduleName, self)
	
	hooksecurefunc(GridFrame.prototype, "CreateIndicator", GridIndicatorCornerText.CreateIndicator)
	hooksecurefunc(GridFrame.prototype, "PositionIndicator", GridIndicatorCornerText.PositionIndicator)
	hooksecurefunc(GridFrame.prototype, "SetIndicator", GridIndicatorCornerText.SetIndicator)
	hooksecurefunc(GridFrame.prototype, "ClearIndicator", GridIndicatorCornerText.ClearIndicator)
	if IsLoggedIn() then
		GridFrame:UpdateOptionsMenu();
		GridFrame:WithAllFrames(function(f) for k, v in pairs(GridFrame.prototype) do f[k] = v end end)
	end
end

function GridIndicatorCornerText:OnEnable()
	self:ScheduleRepeatingTimer("OnUpdate", interval, self)
end

function GridIndicatorCornerText:PositionIndicator(indicator)
	if indicator == "cornertexttopleft"
	or indicator == "cornertexttopright"
	or indicator == "cornertextbottomleft"
	or indicator == "cornertextbottomright"
	then
		if self[indicator] and self[indicator].Text then
			local borderSize = GridFrame.db.profile.borderSize
			if indicator == "cornertexttopleft" then
				self[indicator].Text:SetPoint("TOPLEFT", self, "TOPLEFT", borderSize, -borderSize)
			elseif indicator == "cornertexttopright" then
				self[indicator].Text:SetPoint("TOPRIGHT", self, "TOPRIGHT",-borderSize, -borderSize)
			elseif indicator == "cornertextbottomleft" then
				self[indicator].Text:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", borderSize, borderSize)
			elseif indicator == "cornertextbottomright" then
				self[indicator].Text:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -borderSize, borderSize)
			end
		end
	end
end

function GridIndicatorCornerText:CreateIndicator(indicator)
	if indicator == "cornertexttopleft"
	or indicator == "cornertexttopright"
	or indicator == "cornertextbottomleft"
	or indicator == "cornertextbottomright"
	then
		local font = media and media:Fetch("font", GridIndicatorCornerText.db.profile.CornerTextFont) or STANDARD_TEXT_FONT
		self[indicator].Text = self[indicator]:CreateFontString(nil, "OVERLAY")
		self[indicator].Text:SetFontObject(GameFontHighlightSmall)
		self[indicator].Text:SetFont(font, GridIndicatorCornerText.db.profile.CornerTextFontSize, GridIndicatorCornerText.db.profile.CornerTextOutline)
		self[indicator].Text:SetJustifyH("CENTER")
		self[indicator].Text:SetJustifyV("CENTER")
		
		self:PositionIndicator(indicator)
	end
	
end

function GridIndicatorCornerText:SetIndicator(indicator, color, text, value, maxValue, texture, start, duration, stack)
	if indicator == "cornertexttopleft"
		or indicator == "cornertexttopright"
		or indicator == "cornertextbottomleft"
		or indicator == "cornertextbottomright"
	then
		if not self[indicator] then
			self:CreateIndicator(indicator)
		end
		local c = strbyte(text, 1)
		--local text = text:utf8sub(1, GridFrame.db.profile.textlength)
		if(c and c >= 224 and text.utf8sub) then
			text = text:utf8sub(1, math.floor(GridIndicatorCornerText.db.profile.CornerTextLength / 2));
		else
			text = text:sub(1, GridIndicatorCornerText.db.profile.CornerTextLength)
		end
		self[indicator].Text:SetText(text)
		if text and text ~= "" then
			self[indicator]:Show()
		else
			self[indicator]:Hide()
		end
		if color then
			self[indicator].Text:SetTextColor(color.r, color.g, color.b, color.a)
		end

		if(duration and start) then
			self[indicator].timeLeft = duration + start - GetTime()
			self[indicator].timeLeftFloor = floor(self[indicator].timeLeft)
			self[indicator].Text:SetText(n2s(self[indicator].timeLeftFloor))
		end

	end
end

function GridIndicatorCornerText:ClearIndicator(indicator)
	if indicator == "cornertexttopleft"
		or indicator == "cornertexttopright"
		or indicator == "cornertextbottomleft"
		or indicator == "cornertextbottomright"
	then
		if self[indicator] then
			self[indicator]:Hide()
			self[indicator].timeLeft=nil
			self[indicator].timeLeftFloor=nil
		end
	end
end

function GridIndicatorCornerText:UpdateFont(f)
	local font = media and media:Fetch("font", GridIndicatorCornerText.db.profile.CornerTextFont) or STANDARD_TEXT_FONT
	local size = GridIndicatorCornerText.db.profile.CornerTextFontSize
	local outline = GridIndicatorCornerText.db.profile.CornerTextOutline
	if f["cornertexttopleft"] then 
		f["cornertexttopleft"].Text:SetFont(font, size, outline)
	end
	if f["cornertexttopright"] then 
		f["cornertexttopright"].Text:SetFont(font, size, outline)
	end
	if f["cornertextbottomleft"] then 
		f["cornertextbottomleft"].Text:SetFont(font, size, outline)
	end
	if f["cornertextbottomright"] then 
		f["cornertextbottomright"].Text:SetFont(font, size, outline)
	end
end

function GridIndicatorCornerText:Reset()
end