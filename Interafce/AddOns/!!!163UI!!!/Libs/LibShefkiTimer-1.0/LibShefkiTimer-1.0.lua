--- **LibShefkiTimer-1.0** provides a centeral facility for registering timers.
-- LibShefkiTimer supports one-shot timers and repeating tiemrs.  ShefkiTimer is
-- intended to be a drop in replacement for AceTimer.  Tiemrs are implemented using
-- AnimationGroup frames.  This allows the game engine to do all the scheduling
-- as opposed to a single OnUpdate event handler doing scheduling.  Timers
-- can be registered or canceled at any time, even from within a running
-- timer, without conflict or large overhead.\\
-- ShefkiTimer can fire timers at pretty much any resolution that the game can handle.
-- In fact it can fire timers at a higher resolution than GetTime() can report time
-- passing for. 
-- 
-- All `:Schedule` functions will return a handle to the timer it registered, which you will
-- need to store if you need to cancel the timer you just registered.
--
-- **LibShefkiTimer-1.0** can be embeded into your addon, either explicitly by calling
-- LibShefkiTimer:Embed(MyAddon) or by specifying it as an embeded library in your AceAddon.
-- All functions will be availalbe on your addon object and can be accesssed directly,
-- without having to explcitly calling ShefkiTimer itself.\\
-- It is recommended to embed ShefkiTimer, otherwise you'll have to specify a custom `self`
-- on calls you make into ShefkiTimer
-- @class file
-- @name LibShefkiTimer-1.0

--[[
	This is based largely on AceTimer-3.0 so a lot of code is borrowed.

	It should have the following advantages over AceTimer's implementation:
	* Smallest timer interval should be very very small, smaller than can be measured with GetTime()
	* It should have better performance with large numbers of timers, how much better depends on the internals of the Animation system which we have no way to know except through experimentation, which this is intended to test.
]]

local MAJOR, MINOR = "LibShefkiTimer-1.0", 3

local ShefkiTimer = LibStub:NewLibrary(MAJOR, MINOR)
if not ShefkiTimer then return end

ShefkiTimer.selfs = ShefkiTimer.selfs or {}
ShefkiTimer.frame = ShefkiTimer.frame or CreateFrame("Frame","ShefkiTimer10Frame")

-- Lua APIs
local assert, error, loadstring = assert, error, loadstring
local setmetatable, rawset, rawget = setmetatable, rawset, rawget
local select, pairs, type, next, tostring = select, pairs, type, next, tostring
local tconcat = table.concat

-- Global vars/functions that we don't upvalue since they might get hooked, or upgraded
-- List them here for Mikk's FindGlobals script
-- GLOBALS geterrorhandler

-- Full timer recycling unlike AceTimer.  We recycle everything because we don't
-- want to making any more AnimationGroup and Animation objects than necessary.
local timerCache = {}
local function new()
	local timer = next(timerCache)
	if timer then
		timerCache[timer] = nil
	else
		local ag = ShefkiTimer.frame:CreateAnimationGroup()
		timer = ag:CreateAnimation("Animation")
	end
	return timer
end

local function del(timer)
	if not timer then return end
	timerCache[timer] = true
	return nil
end

--[[
   xpcall safecall implementation
]]
local xpcall = xpcall

local function errorhandler(err)
	return geterrorhandler()(err)
end

local function CreateDispatcher(argCount)
	local code = [[
	local xpcall, eh = ...  -- our arguments are received as unnamed values in "..." since we don't have a proper function declaration
	local method, ARGS
	local function call() return method(ARGS) end

	local function dispatch(func, ...)
		method = func
		if not method then return end
		ARGS = ...
		return xpcall(call, eh)
	end

	return dispatch
	]]

	local ARGS = {}
	for i = 1, argCount do ARGS[i] = "arg"..i end
	code = code:gsub("ARGS", tconcat(ARGS, ", "))
	return assert(loadstring(code, "safecall Dispatcher["..argCount.."]"))(xpcall, errorhandler)
end

local Dispatchers = setmetatable({}, {
	__index=function(self, argCount)
		local dispatcher = CreateDispatcher(argCount)
		rawset(self, argCount, dispatcher)
		return dispatcher
	end
})
Dispatchers[0] = function(func)
	return xpcall(func, errorhandler)
end

local function safecall(func, ...)
	return Dispatchers[select('#', ...)](func, ...)
end

local OnFinished
do
	-- state variables to prevent timers canceled during callbacks from being returned
	-- from the pool until OnFinished finishes.
	local in_OnFinished
	local canceled_in_OnFinished

	--- Cancels a timer with the given handle, registered by same addon object as used for
	-- `:ScheduleTimer`  Bot one-shot and repeating timers can be canceled wit this function,
	-- as long as the `handle` is valid and the timer has not fired yet or was canceled before.
	-- @param handle The handle of the timer, as returned by `:ScheduleTimer` or `:ScheduleRepeatingTimer`
	-- @param silent If true, no error is raised if the tiemr handle is invalid (expired or already canceled)
	-- @return True if the timer was successfully cancelled.
	function ShefkiTimer:CancelTimer(handle, silent)
		if not handle then return end
		if type(handle) ~= "string" then
			error(MAJOR..": CancelTimer(handle): 'handle' - expected a string", 2)
		end
		local selftimers = ShefkiTimer.selfs[self]
		local timer = selftimers and selftimers[handle]
		if silent then
			if timer then
				timer:GetParent():Stop()
				if not in_OnFinished and in_OnFinished ~= timer then
					selftimers[handle] = del(timer)
				else
					-- delay returning anim object to timerCache until the end of the OnFinished.
					canceled_in_OnFinished = true
				end
			end
			return not not timer
		else
			if not timer then
				geterrorhandler()(MAJOR..": CancelTimer(handle[, silent]): '"..tostring(handle).."' - no such timer registered")
				return false
			end
			timer:GetParent():Stop()
			if not in_OnFinished and in_OnFinished ~= timer then
				selftimers[handle] = del(timer)
			else
				-- delay returning anim object to timerCache until the end of the OnFinished.
				canceled_in_OnFinished = true
			end
			return true
		end
	end

	-- --------------------------------------------------------------------
	-- OnFinished handler
	--
	--called when the timer has expired and it should be fired.  Non repeating
	-- timers are canceled here. 
	function OnFinished(self, elapsed)
		in_OnFinished = self 
		local repeating = self.repeating
		if not elapsed then
			-- OnFinished doesn't pass elapsed so we have to get it.
			-- OnUpdate does which is used for 0 length timers.
			elapsed = self:GetElapsed()
		end
		if self.delay == 0 and elapsed == 0 then return end -- skip first call for 0 length
		-- thorttle if the elapsed time is more than 20% longer than the timer duration
		-- but only if it's a repeating timer.
		if not repeating or elapsed < repeating then
			local callback = self.callback
			if type(callback) == "string" then
				safecall(self.object[callback], self.object, self.arg)
			elseif callback then
				safecall(callback, self.arg)
			end
		end
		in_OnFinished = nil
		if not repeating or canceled_in_OnFinished then
			ShefkiTimer.CancelTimer(self.object, tostring(self), true)
			canceled_in_OnFinished = nil
		end
	end
end

-- ---------------------------------------------------------------------
-- Reg( callback, delay, arg, repeating )
--
-- callback( function or string ) - direct function ref or method name in our object for the callback
-- delay(int) - delay for the timer
-- arg(variant) - any argument to be passed to the callback function
-- repeating(boolean) - repeating timer, or oneshot
--
-- returns the handle of the timer for later processing (canceling etc)
local function Reg( self, callback, delay, arg, repeating )
	if type(callback) ~= "string" and type(callback) ~= "function" then
		local error_origin = repeating and "ScheduleRepeatingTimer" or "ScheduleTimer"
		error(MAJOR..": " .. error_origin .. "(callback, delay, arg): 'callback' - function or method name expected.", 3)
	end
	if type(callback) == "string" then
		if type(self)~="table" then
			local error_origin = repeating and "ScheduleRepeatingTimer" or "ScheduleTimer"
			error(MAJOR..": " .. error_origin .. "(\"methodName\", delay, arg): 'self' - must be a table.", 3)
		end
		if type(self[callback]) ~= "function" then
			local error_origin = repeating and "ScheduleRepeatingTimer" or "ScheduleTimer"
			error(MAJOR..": " .. error_origin .. "(\"methodName\", delay, arg): 'methodName' - method not found on target object.", 3)
		end
	end

	local timer = new()

	timer.object = self
	timer.callback = callback
	timer.arg = arg
	timer.delay = delay

	local ag = timer:GetParent()
	if delay == 0 then
		-- If the delay is 0 switch the OnFinished to be called on the next
		-- OnUpdate.  0 length durations do nothing in the animation system
		-- so if we want 0 lenth durations to work we have to handle them
		-- ourselves.
		timer:SetScript("OnFinished",nil)
		timer:SetScript("OnUpdate",OnFinished)
		timer:SetDuration(1) -- just set the delay to 1 second.
		-- Always setup 0 length durations as repeating timers.  OnUpdate gets
		-- called as soon as you call Play().  Which is not our intent with 0
		-- length timers.
		ag:SetLooping("REPEAT")
		timer.repeating = 1.2 
	else
		timer:SetScript("OnFinished",OnFinished)
		timer:SetScript("OnUpdate",nil)
		timer:SetDuration(delay)
		timer.repeating = repeating and delay * 1.2
		if repeating then
			ag:SetLooping("REPEAT")
		else
			ag:SetLooping("NONE")
		end
	end

	local handle = tostring(timer)
	local selftimers = ShefkiTimer.selfs[self]
	if not selftimers then
		selftimers = {}
		ShefkiTimer.selfs[self] = selftimers
	end
	selftimers[handle] = timer

	ag:Play()

	return handle
end

--- Schedule a new one-shot timer.
-- The timer will fire once in `delay` seconds, unless canceled before.
-- @param callback Callback function for the timer pulse (funcref or method name).
-- @param delay Delay for the timer, in seconds.
-- @param arg An optional argument to be passed to the callback function.
-- @usage
-- MyAddon = LibStub("AceAddon-3.0"):NewAddon("TimerTest", "LibShefkiTimer-1.0")
-- 
-- function MyAddon:OnEnable()
--   self:ScheduleTimer("TimerFeedback", 5)
-- end
--
-- function MyAddon:TimerFeedback()
--   print("5 seconds passed")
-- end
function ShefkiTimer:ScheduleTimer(callback, delay, arg)
	return Reg(self, callback, delay, arg)
end

--- Schedule a repeating timer.
-- The timer will fire every `delay` seconds, until canceled.
-- @param callback Callback function for the timer pulse (funcref or method name).
-- @param delay Delay for the timer, in seconds.
-- @param arg An optional argument to be passed to the callback function.
-- @usage
-- MyAddon = LibStub("AceAddon-3.0"):NewAddon("TimerTest", "LibShefkiTimer-1.0")
-- 
-- function MyAddon:OnEnable()
--   self.timerCount = 0
--   self.testTimer = self:ScheduleRepeatingTimer("TimerFeedback", 5)
-- end
--
-- function MyAddon:TimerFeedback()
--   self.timerCount = self.timerCount + 1
--   print(("%d seconds passed"):format(5 * self.timerCount))
--   -- run 30 seconds in total
--   if self.timerCount == 6 then
--     self:CancelTimer(self.testTimer)
--   end
-- end
function ShefkiTimer:ScheduleRepeatingTimer(callback, delay, arg)
	return Reg(self, callback, delay, arg, true)
end

--- Cancels all timers registered to the current addon object ('self')
function ShefkiTimer:CancelAllTimers()
	if not(type(self) == "string" or type(self) == "table") then
		error(MAJOR..": CancelAllTimers(): 'self' - must be a string or table",2)
	end
	if self == ShefkiTimer then
		error(MAJOR..": CancelAllTimers(): supply a meaningful 'self'", 2)
	end

	local selftimers = ShefkiTimer.selfs[self]
	if selftimers then
		for handle,v in pairs(selftimers) do
			ShefkiTimer.CancelTimer(self, handle, true)
		end
	end
end

--- Returns the time left for a timer with the given handle, registered by the current addon object ('self').
-- This function will raise a warning when the handle is invalid, but not stop execution.
-- @param handle The handle of the timer, as returned by `:ScheduleTimer` or `:ScheduleRepeatingTimer`
-- @return The time left on the timer, or false if the handle is invalid.
function ShefkiTimer:TimeLeft(handle)
	if not handle then return end
	if type(handle) ~= "string" then
		error(MAJOR..": TimeLeft(handle): 'handle' - expected a string", 2)
	end
	local selftimers = ShefkiTimer.selfs[self]
	local timer = selftimers and selftimers[handle]
	if not timer then
		geterrorhandler()(MAJOR..": TimeLeft(handle): '"..tostring(handle).."' - no such timer registered")
		return false
	end
	return timer:GetDuration() - timer:GetElapsed()
end

ShefkiTimer.embeds = ShefkiTimer.embeds or {}

local mixins = {
	"ScheduleTimer", "ScheduleRepeatingTimer",
	"CancelTimer", "CancelAllTimers",
	"TimeLeft"
}

function ShefkiTimer:Embed(target)
	ShefkiTimer.embeds[target] = true
	for _,v in pairs(mixins) do
		target[v] = ShefkiTimer[v]
	end
	return target
end

-- ShefkiTimer:OnEmbedDisable( target )
-- target (object) - target object that ShefkiTimer is embedded in.
--
-- cancel all timers registered for the object
function ShefkiTimer:OnEmbedDisable( target )
	target:CancelAllTimers()
end


for addon in pairs(ShefkiTimer.embeds) do
	ShefkiTimer:Embed(addon)
end
