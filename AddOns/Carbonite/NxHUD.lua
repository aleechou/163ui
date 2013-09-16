local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxHUD - HUD code
-- Copyright 2007-2012 Carbon Based Creations, LLC
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------
-- Carbonite - Addon for World of Warcraft(tm)
-- Copyright 2007-2012 Carbon Based Creations, LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
---------------------------------------------------------------------------------------

--------
-- Init HUD data

function Nx.HUD:Init()

	Nx.HUD.TexNames = { "", "Chip", "Gloss", "Glow", "Neon" }

	Nx.HUD:Open()
end

--------
-- Open HUD

function Nx.HUD:Open()

	if not self.Created then

		self:Create()
		self.Created = true
	end

	local inst = self

	inst.Win:Show()
end

--------
-- Open HUD

function Nx.HUD:Create()

	local inst = self

	local gopts = Nx.GetGlobalOpts()
	inst.GOpts = gopts

	inst.ETADelay = 0

	-- Create Window

--	Nx.Window:ClrSaveData ("NxHUD")

	Nx.Window:SetCreateFade (1, .15)

	local win = Nx.Window:Create ("NxHUD", nil, nil, nil, 2, 1, nil, true)
	inst.Win = win

--	win:CreateButtons (nil, true)

	win:SetTitleJustify ("CENTER", 1)
	win:SetTitleJustify ("CENTER", 2)

--	win:SetBGColor (0, 0, 0, .5)
	win:SetBGAlpha (0, 1)

	win:InitLayoutData (nil, 999999, -.17, 1, 1)

	win.Frm:SetToplevel (true)

	-- Create arrow frame

	local f = CreateFrame ("Frame", nil, win.Frm)

	inst.Frm = f
	f.NxInst = inst

	f:EnableMouse (false)
--	f:SetScript ("OnMouseDown", self.OnMouseDown)

	local t = f:CreateTexture()
	t:SetAllPoints (f)
	f.texture = t

	-- Create button

--PAIDS!

	local but = CreateFrame ("Button", nil, UIParent, "SecureUnitButtonTemplate")
	inst.But = but

	but:SetAttribute ("type", "target")
	but:SetAttribute ("unit", "player")

	but:RegisterForClicks ("LeftButtonDown", "RightButtonDown")

	local t = but:CreateTexture()
	t:SetAllPoints (but)
	t:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\IconCircle")
--	t:SetTexture (1, 1, 1, 1)
	but.texture = t

	but:SetWidth (10)
	but:SetHeight (10)

--PAIDE!

	--

	self:UpdateOptions()
end

--------
-- Get tracking info. For other addon use

function Nx.HUDGetTracking()

	local map = Nx.Map:GetMap (1)
	return map.TrackDir, map.TrackDistYd, map.TrackName
end

--------
-- Set fade. Ovveride default fade

function Nx.HUD:SetFade (fade)
end

function Nx.HUD:Show (show)
	self.Win:Show (show)
end

function Nx.HUD:UpdateOptions()

	local win = self.Win

--PAIDS!
	if not Nx.Free then

		local lock = win:IsLocked()

		win:SetBGAlpha (0, lock and 0 or 1)

--		self.Frm:EnableMouse (not lock)
	end
--PAIDE!

	local gopts = self.GOpts

	local name = gopts["HUDAGfx"]
	self.Frm.texture:SetTexture ("Interface\\AddOns\\Carbonite\\Gfx\\Map\\HUDArrow" .. name)

	local f = self.Frm

	f:SetPoint ("CENTER", gopts["HUDAXO"], -win.TitleH / 2 - 32 - gopts["HUDAYO"])

	local wh = gopts["HUDASize"]
	f:SetWidth (wh)
	f:SetHeight (wh)

--PAIDS!
	if not InCombatLockdown() then
		local f = self.But
		f:SetWidth (wh)
		f:SetHeight (wh)
		f:Hide()
	end
--PAIDE!

	self.ButR, self.ButG, self.ButB, self.ButA = Nx.Util_num2rgba (gopts["HUDTButColor"])
	self.ButCR, self.ButCG, self.ButCB, self.ButCA = Nx.Util_num2rgba (gopts["HUDTButCombatColor"])
end

--[[
function Nx.HUD:OnMouseDown (button)
	if button == "RightButton" then
	end
end
--]]

function Nx.HUD:Update (map)

--	if IsControlKeyDown() then
--		Nx.prtFrame ("HUD", self.Frm)
--		Nx.prtVar ("Trk", map.TrackDir)
--	end

	local win = self.Win

	local gopts = self.GOpts
	local opts = Nx:GetHUDOpts()
	local noLockDown = not InCombatLockdown()

	if map.TrackDir and not gopts["HUDHide"] and not (Nx.InBG and gopts["HUDHideInBG"]) then

		local frm = self.Frm
		local but = self.But
		local wfrm = win.Frm

		if not wfrm:IsVisible() then	-- Show also raises so only do if hidden
			if not win:IsCombatHidden() then
				win:Show()
			end
		end

		local dist = map.TrackDistYd
		local dir = (map.TrackDir - map.PlyrDir) % 360
		if dist < 1 then
			dir = 0
		end
		local dirDist = dir <= 180 and dir or 360 - dir

		local str = _TRANS(map.TrackName) or ""
		win:SetTitle (str)

--PAIDS!
		if map.TrackPlayer and noLockDown then
--			Nx.prt ("HUD %s", map.TrackPlayer)
			but:SetAttribute ("unit1", map.TrackPlayer)
			but:SetAttribute ("shift-unit1", map.TrackPlayer .. "-target")
			but:SetAttribute ("unit2", map.TrackPlayer .. "-target")
		end
--PAIDE!

		local col = dirDist < 5 and "|cffa0a0ff" or ""
		local str = format (L["%s%d yds"], col, dist)

		if gopts["HUDShowDir"] then
			local fmt = dirDist < 1 and L[" %.1f deg"] or L[" %d deg"]
			str = str .. format (fmt, dirDist)
		end

		if map.PlyrSpeed > .1 then

--			Nx.prt ("HUD dir %f %f spd %f", dir, dirDist, map.PlyrSpeed)

			self.ETADelay = self.ETADelay - 1

			if self.ETADelay <= 0 then

				self.ETADelay = 10

				local eta = map.TrackETA or dist / map.PlyrSpeed

				if eta < 60 then
					self.ETAStr = format (L["|cffdfffdf %.0f secs"], eta)
				else
					self.ETAStr = format (L["|cffdfdfdf %.1f mins"], eta / 60)
				end
			end

			str = str .. self.ETAStr

		else
			self.ETADelay = 3		-- Delay for time to stabilize
			self.ETAStr = ""
		end

		win:SetTitle (str, 2)

		local atPt, relTo, relPt, x, y = wfrm:GetPoint()

		local w, h = win:GetSize()
		local tw = win:GetTitleTextWidth() + 2

		local d = (tw - w) / 2

		if strfind (atPt, "LEFT") then
			x = x - d
		elseif strfind (atPt, "RIGHT") then
			x = x + d
		end

		wfrm:ClearAllPoints()
		wfrm:SetPoint (atPt, x, y)
		win:SetSize (tw, 0, true)

--PAIDS!
		if gopts["HUDTBut"] and not win:IsCombatHidden() then

			if noLockDown then
				but:SetPoint ("TOPLEFT", UIParent, "BOTTOMLEFT", frm:GetLeft(), frm:GetTop())
				but:SetScale (wfrm:GetScale())
				but:Show()
				but.texture:SetVertexColor (self.ButR, self.ButG, self.ButB, self.ButA)
			else
				but.texture:SetVertexColor (self.ButCR, self.ButCG, self.ButCB, self.ButCA)
			end
		end
--PAIDE!

		local texX1 = -.5
		local texX2 = .5
		local texY1 = -.5
		local texY2 = .5
		local co = cos (dir)
		local si = sin (dir)
		t1x = texX1 * co + texY1 * si + .5
		t1y = texX1 * -si + texY1 * co + .5
		t2x = texX1 * co + texY2 * si + .5
		t2y = texX1 * -si + texY2 * co + .5
		t3x = texX2 * co + texY1 * si + .5
		t3y = texX2 * -si + texY1 * co + .5
		t4x = texX2 * co + texY2 * si + .5
		t4y = texX2 * -si + texY2 * co + .5

		local tex = frm.texture
		tex:SetTexCoord (t1x, t1y, t2x, t2y, t3x, t3y, t4x, t4y)

		if dirDist < 5 then
			if dist < 1 then
				tex:SetVertexColor (.2, 1, .2, .4)
				tex:SetBlendMode ("BLEND")
			else
				tex:SetVertexColor (.7, .7, 1, 1)
				tex:SetBlendMode ("ADD")
			end
		else
			tex:SetVertexColor (1, 1, .5, .9)
			tex:SetBlendMode ("BLEND")
		end
	else

		win:Show (false)

--PAIDS!
		if noLockDown then
			self.But:Hide()
		end
--PAIDE!
	end
end

-------------------------------------------------------------------------------
-- EOF

















