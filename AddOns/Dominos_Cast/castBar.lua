--[[
	castBar.lua
		A dominos based casting bar
--]]

--[[
	Copyright (c) 2008-2009 Jason Greer
	All rights reserved.

	Redistribution and use in source and binary forms, with or without 
	modification, are permitted provided that the following conditions are met:

		* Redistributions of source code must retain the above copyright notice, 
		  this list of conditions and the following disclaimer.
		* Redistributions in binary form must reproduce the above copyright
		  notice, this list of conditions and the following disclaimer in the 
		  documentation and/or other materials provided with the distribution.
		* Neither the name of the author nor the names of its contributors may 
		  be used to endorse or promote products derived from this software 
		  without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE 
	LIABLE FORANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
	POSSIBILITY OF SUCH DAMAGE.
--]]


local DCB = Dominos:NewModule('cast', 'AceHook-3.0')
local CastBar, CastingBar

function DCB:Load()
    self.frame = CastBar:New()
    self:SecureHook('PlayerFrame_DetachCastBar', 'PlayerFrame_DetachCastBar')
    self:SecureHookScript(CastingBarFrame, 'OnShow', 'OnShow')
end

function DCB:Unload()
    self:Unhook('PlayerFrame_DetachCastBar', 'PlayerFrame_DetachCastBar')
    self:Unhook(CastingBarFrame, 'OnShow', 'OnShow')
    self.frame:Free()
end

function DCB:PlayerFrame_DetachCastBar()
    self.frame:AttachBlizzBar()
	CastingBarFrame.ignoreFramePositionManager = true
end

function DCB:OnShow()
    if(self.frame) then
        return self.frame:OnShow()
    end
end

CastBar = Dominos:CreateClass('Frame', Dominos.Frame)

function CastBar:New()
    local f = self.super.New(self, 'cast')
    f:SetFrameStrata('HIGH')
    f:AttachBlizzBar()

    f.header:SetParent(nil)
    f.header:ClearAllPoints()
    f:Layout()

    return f
end

function CastBar:Free()
    self:DetachBlizzBar()
    self.super.Free(self)
end

function CastBar:Layout()
    self:SetSize(195,13)
end

function CastBar:AttachBlizzBar()
    --print('PLAYER_FRAME_CASTBARS_SHOWN', PLAYER_FRAME_CASTBARS_SHOWN)
    if(not PLAYER_FRAME_CASTBARS_SHOWN) then
        CastingBarFrame:ClearAllPoints()
        CastingBarFrame:SetParent(self)
        CastingBarFrame:SetPoint('CENTER', self)
        CastingBarFrame.ignoreFramePositionManager = true
    end
end

function CastBar:DetachBlizzBar()
    if(not PLAYER_FRAME_CASTBARS_SHOWN) then
        CastingBarFrame:SetParent(UIParent)
        CastingBarFrame:SetToplevel(true)
        CastingBarFrame:ClearAllPoints()
        CastingBarFrame:SetPoint('BOTTOM', 0, 55)
    end
end

function CastBar:OnShow()
    if(not PLAYER_FRAME_CASTBARS_SHOWN) then
        --CastingBarFrame.ignoreFramePositionManager = true
        --self:AttachBlizzBar()
    end
end

