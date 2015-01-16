local Evie, next, securecall, _, T = {}, next, securecall, ...
local frame, listeners, locked = CreateFrame("FRAME"), {}, {}

local function Register(event, func)
	if type(event) ~= "string" or type(func) ~= "function" then
		error('Syntax: RegisterEvent("event", handlerFunction)', 2)
	end
	local lock = locked[event]
	if lock == true then
		locked[event] = {[func] = 1}
	elseif lock then
		lock[func] = 1
	else
		frame:RegisterEvent(event)
		listeners[event] = listeners[event] or {}
		listeners[event][func] = 1
	end
end
local function Unregister(event, func)
	local list, lock = listeners[event], locked[event]
	if list and list[func] then
		list[func] = nil
		if not next(list) then
			listeners[event] = nil
			frame:UnregisterEvent(event)
		end
	end
	if lock and lock ~= true then
		lock[func] = nil
	end
end
local function RaiseEvent(_, event, ...)
	if listeners[event] then
		local lock = locked[event]
		locked[event] = lock or true
		for kf in next, listeners[event] do
			if securecall(kf, event, ...) == "remove" then
				Unregister(event, kf)
			end
		end
		if not lock then
			lock, locked[event] = locked[event]
			if lock ~= true then
				for kf in next, lock do
					Register(event, kf)
				end
			end
		end
	end
end
function Evie.RaiseEvent(event, ...)
	return RaiseEvent(nil, event, ...)
end
do
	local function ok(f, ...)
		return true, f(...)
	end
	function Evie.ProtectedCall(...)
		return securecall(ok, ...)
	end
end

frame:SetScript("OnEvent", RaiseEvent)
T.Evie, Evie.RegisterEvent, Evie.UnregisterEvent = Evie, Register, Unregister