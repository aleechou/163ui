local Recount = _G.Recount

local revision = tonumber(string.sub("$Revision: 1270 $", 12, -3))
if Recount.Version < revision then
	Recount.Version = revision
end

local _G = _G

local GetChatWindowInfo = GetChatWindowInfo
local GetTime = GetTime

local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS

if false then
	function Recount:DPrint(str)
		
	end

--Recount.DPrint = function() end

else

	Recount.Debug = true

	function Recount:GetDebugFrame()
		for i = 1, NUM_CHAT_WINDOWS do
			local windowName = GetChatWindowInfo(i)
			if windowName == "Debug" then
				return _G["ChatFrame"..i]
			end
		end
	end

	function Recount:DPrint(str)
		local debugframe = Recount:GetDebugFrame()

		if debugframe then
			Recount:Print(debugframe, str)
		end
	end

	function Recount.TestCLLoad(load)
		local timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags

		timestamp = GetTime()
		eventtype = "SWING_DAMAGE"
		srcGUID = "Player-0-007DB5FD"
		srcName = "Renetta"
		srcFlags = 0x511
		dstGUID = "Creature-0-0-0-0-24026-00002EA33A"
		--dstName = "Fanggore Worg"
		dstName = "Archimonde"
		dstFlags = 0x10a48
		local earg1, earg2, earg3, earg4, earg5, earg6, earg7, earg8, earg9 = 158, 0, 1, 0, 0, 0, nil, nil, nil
		for i = 1, load do
			local _
			Recount:CombatLogEvent(_, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, earg1, earg2, earg3, earg4, earg5, earg6, earg7, earg8, earg9)
			Recount:CombatLogEvent(_, timestamp, eventtype, dstGUID, dstName, dstFlags, srcGUID, srcName, srcFlags, earg1, earg2, earg3, earg4, earg5, earg6, earg7, earg8, earg9)
		end
	end
end
