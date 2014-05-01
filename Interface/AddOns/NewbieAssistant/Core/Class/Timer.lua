-- Author      : s1172
-- Create Date : 2013/4/24 16:06:47

local Timer={}

function Timer:new()
	local o={}
	setmetatable(o,self)
	self.__index=self
	return o
end

function Timer:CreateTimer(s)
	local f=CreateFrame("frame")
	local g=f:CreateAnimationGroup()
	local a=g:CreateAnimation("Path")
	a:SetDuration(s)
	g:Play()
	return g
end

function Timer:Delay(s,handler)
	local Timer=self:CreateTimer(s)
	Timer:SetScript("OnFinished",handler)
end

function Timer:Repeat(s,handler,t)
	local Timer=self:CreateTimer(s)
	local function action()
		if type(t)=="number" then
			if t>1 then
				t=t-1
				self:Repeat(s,handler,t)
			end
		else
			self:Repeat(s,handler,t)
		end
		handler()
	end
	Timer:SetScript("OnFinished",action)
end

NAApi.Timer=Timer