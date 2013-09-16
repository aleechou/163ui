local L = Carbonite_Strings
--local function _NPC(s) if not NPC_Strings and Quest_Strings then return s end return NPC_Strings[s] or Quest_Strings[s] or s end 
--local function _TRANS(s) if not Carbonite_Strings then return s end return Carbonite_Strings[s] or s end 
--local function _Quest(s) if not Quest_Strings then return s end return Quest_Strings[s] or s end 
--local function _Travel(s) return string.gsub(s, "(%w+ to )(.+)", function(a,b) local t=NXTravel[a] or a local n=NXlMapNames[b] or b return t..n end) end 
--local function _MapName(name) return string.gsub(name, "(%w[^:]+)", function(s) return NXlMapNames[s] or s end) end
--local function _TaxiName(name) if name then local _, _, subzone, zone = name:find("(.+), (.+)") subzone = subzone or name return (NXlTaxiNames[subzone] or subzone)..(zone and ","..(NXlTaxiNames[zone] or zone) or "")end end
--local function _Tax(s) return string.gsub(s, "(.-), (.+)", function(a,b) local t=_NPC(a) or a return t..",".._TaxiName(b) end) end
---------------------------------------------------------------------------------------
-- NxTimer - Timers and profiling
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

-----------------------------------------------------------------------------
-- Generic timer

function Nx.Timer:Init()

	self.Data = {}
	self:ProfilerInit()
end

--------
-- Start a timer

function Nx.Timer:Start (name, time, user, func)

--	Nx.prt ("Timer Start %s %d", name, time)

	if not self.Data[name] then
		self.Data[name] = {}
	end

	local tm = self.Data[name]
	tm.T = time
	tm.U = user
	tm.F = func

	return tm
end

--------
-- Stop a timer

function Nx.Timer:Stop (name)

--	Nx.prt ("Timer Stop %s", name)

	self.Data[name] = nil
end

--------
-- Set timer user function

function Nx.Timer:SetFunc (name, func)

	if self.Data[name] then
		self.Data[name].F = func
	end
end

--------
-- Check if timer active

function Nx.Timer:IsActive (name)

	return self.Data[name]
end

--------
-- Get timer time remaining

function Nx.Timer:Time (name)

	if self.Data[name] then
		return self.Data[name].T
	end
end

--------
-- Generic update

function Nx.Timer:OnUpdate (elapsed)

--	if elapsed > .5 then
--		Nx.prt ("Timer update %f", elapsed)
--	end

	elapsed = min (elapsed, .5)

	for name, tm in pairs (self.Data) do

		tm.T = tm.T - elapsed

		if tm.T <= 0 then

--			Nx.prt ("Timer %s", name)

--			local mem = collectgarbage ("count")

			if tm.F then
				tm.T = tm.F (tm.U, name, tm)
			end

--			mem = collectgarbage ("count") - mem
--			if mem > 0 then
--				Nx.prt ("Tm garbage %s %f", name, mem)
--			end

			if not tm.T then
				self.Data[name] = nil
			end
		end
	end

	self:ProfilerOnUpdate()
end

--------
-- Force timer to fire

function Nx.Timer:Fire (name)

	local tm = self.Data[name]

	if tm then

		if tm.F then
			tm.T = tm.F (tm.U, name, tm)
		end

		if not tm.T then
			self.Data[name] = nil
		end
	end
end

-------------------------------------------------------------------------------

function Nx.Timer.Win:Open()

--PAIDS!

	if Nx.Free then
		return
	end

	local win = self.Win

	if win then
		if win:IsShown() then
			win:Show (false)
		else
			win:Show()
		end
		return
	end

--PAIDE!

end

-------------------------------------------------------------------------------
-- Profiler

function Nx.Timer:ProfilerInit()
	self.Profiles = {}
	self.RunTime = GetTime()
end

function Nx.Timer:ProfilerOnUpdate()

--[[

	for _, pro in ipairs (self.Profiles) do
		if pro.Reset then
			pro.LastCnt = pro.Cnt
			pro.Cnt = 0
		end
	end

--]]

end

function Nx.Timer:ProfilerStart (name, reset)

	local pro = self.Profiles[name]
	if not pro then

		pro = {}
		self.Profiles[name] = pro
		tinsert (self.Profiles, pro)

		pro.Name = name
		pro.Time = 0
		pro.TimeLast = 0
		pro.Cnt = 0
		pro.Reset = reset
	end

	pro.Start = GetTime()
	pro.Cnt = pro.Cnt + 1
end

function Nx.Timer:ProfilerEnd (name)

	local pro = self.Profiles[name]
	assert (pro)

	pro.TimeLast = GetTime() - pro.Start
	pro.Time = pro.Time + pro.TimeLast
end

--------
-- Get last profile time

function Nx.Timer:ProfilerGetLastTime (name)

	local pro = self.Profiles[name]
	return pro and pro.TimeLast or 0
end

--------

function Nx.Timer:ProfilerDump()

	sort (self.Profiles, function (a, b) return a.Name < b.Name end)

	Nx.prt (L["Profiler: FPS %.0f"], GetFramerate())

	for _, pro in ipairs (self.Profiles) do
		Nx.prt (L[" %s %.4f %.4f avrg, #%s, %.3f tot"], pro.Name, pro.TimeLast, pro.Time / pro.Cnt, pro.Cnt, pro.Time)

--[[

		if pro.LastCnt then
			Nx.prt ("  #%s", pro.LastCnt)
		end

--]]

	end

	Nx.prt (L["Run time %.0f"], GetTime() - self.RunTime)
end

-------------------------------------------------------------------------------
-- EOF

















