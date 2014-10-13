--[[
Copyright 2014 João Cardoso
AddonList is distributed under the terms of the GNU General Public License (or the Lesser GPL).
This file is part of AddonList.

AddonList is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

AddonList is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with AddonList. If not, see <http://www.gnu.org/licenses/>.
--]]

local Lib = LibStub:NewLibrary('AddonList-1.0', 2)
if not Lib then
	return
else
	Lib.index = {}

	for i = 1, GetNumAddOns() do
		Lib.index[GetAddOnInfo(i)] = i
	end
end

function Lib:IsEnabled(name)
	local i = self.index[name]
	return i and GetAddOnEnableState(UnitName('player'), i) >= 2
end

function Lib:GetInfo(name)
	local i = self.index[name]
	if i then
		return GetAddOnInfo(i)
	end
end