--[[
	Copyright (c) 2014, Lars "Goldpaw" Norberg

	Web: http://www.goldpawsgui.com
	Contact: goldpaw@goldpawsgui.com

	All rights reserved

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
	A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
	EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
	PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
	PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
	LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
	NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]--
local addon,ns = ...

local MSQ = LibStub("Masque", true)
if not MSQ then return end

local path = "Interface\\AddOns\\" .. addon .. "\\textures\\"
local BLANK = [[Interface\ChatFrame\ChatFrameBackground]]

-- Masque scaling 101:
-- Masque believes all buttons should be 36x36 points large. 
-- Scale is calculated by buttonWidth/36, buttonHeight/36 
-- Textures are drawn at a size of texWidth * scaleX, texHeight * scaleY
-- ...which we can translate to texWidth * buttonWidth/36, texHeight * buttonHeight/36
-- ...so for our textures to be correctly sized in freaking Masque, we need to apply this formula to our sizes:
-- newValue = value * 1/(actualButtonSize/masqeAssumedButtonSize)

local pet_scale, button_scale, masque_scale = 30, 36, 36
local function scale(regionSize, buttonSize)
	return regionSize / ((buttonSize or button_scale)/masque_scale)
end

-- Goldpaw's UI: Warcraft
MSQ:AddSkin("Goldpaw's UI: Normal", {
	Author = "Lars Norberg",
	Version = "1.0.Release-r1",
	Shape = "Square",
	Masque_Version = 60000,
	Backdrop = {
		Width = scale(44, button_scale),
		Height = scale(44, button_scale),
		TexCoords = { 10/64, 54/64, 10/64, 54/64 },
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_44x44_Backdrop_Warcraft.tga"
	},
	Icon = {
		Width = scale(34, button_scale),
		Height = scale(34, button_scale),
		TexCoords = { 5/64, 59/64, 5/64, 59/64 }
	},
	Flash = {
		Width = scale(34, button_scale),
		Height = scale(34, button_scale),
		Color = { .7, 0, 0, .30 },
		Texture = BLANK
	},
	Cooldown = {
		Width = scale(34, button_scale),
		Height = scale(34, 44)
	},
	Pushed = {
		Width = scale(44, button_scale),
		Height = scale(44, button_scale),
		Color = { 1, .97, 0, .25 },
		Texture = BLANK
	},
	Normal = {
		Width = scale(54, button_scale),
		Height = scale(54, button_scale),
		TexCoords = { 5/64, 59/64, 5/64, 59/64 },
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_44x44_Normal_Warcraft.tga",
		EmptyTexture = path .. "gUI4_Button_44x44_Empty_Warcraft.tga",
		EmptyColor = { 1, 1, 1, 1 }
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = scale(54, button_scale),
		Height = scale(54, button_scale),
		TexCoords = { 5/64, 59/64, 5/64, 59/64 },
		BlendMode = "BLEND",
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_44x44_Checked_Warcraft.tga"
	},
	Border = {
		Width = scale(54, button_scale),
		Height = scale(54, button_scale),
		TexCoords = { 5/64, 59/64, 5/64, 59/64 },
		BlendMode = "BLEND",
		Texture = path .. "gUI4_Button_44x44_Highlight_Warcraft.tga"
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = scale(86, button_scale),
		Height = scale(86, button_scale),
		OffsetX = 0,
		OffsetY = 0,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]]
	},
	Highlight = {
		Width = scale(54, button_scale),
		Height = scale(54, button_scale),
		TexCoords = { 5/64, 59/64, 5/64, 59/64 },
		BlendMode = "BLEND",
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_44x44_Highlight_Warcraft.tga"
	},
	Name = {
		Width = 34,
		Height = 10,
		OffsetY = 4
	},
	Count = {
		Width = 34,
		Height = 10,
		OffsetX = 0,
		OffsetY = 0
	},
	HotKey = {
		Width = 34,
		Height = 10,
		OffsetX = 0
	},
	Duration = {
		Width = 34,
		Height = 10,
		OffsetY = 0
	},
	AutoCast = {
		Width = 24,
		Height = 24,
		OffsetX = 1,
		OffsetY = -1
	}
}, true)

MSQ:AddSkin("Goldpaw's UI: Small", {
	Author = "Lars Norberg",
	Version = "1.0.Release-r1",
	Shape = "Square",
	Masque_Version = 60000,
	Backdrop = {
		Width = scale(64, button_scale),
		Height = scale(64, button_scale),
		TexCoords = { 0, 1, 0, 1 },
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_36x36_Backdrop_Warcraft.tga"
	},
	Icon = {
		Width = scale(26, button_scale),
		Height = scale(26, button_scale),
		TexCoords = { 5/64, 59/64, 5/64, 59/64 }
	},
	Flash = {
		Width = scale(26, button_scale),
		Height = scale(26, button_scale),
		Color = { .7, 0, 0, .30 },
		Texture = BLANK
	},
	Cooldown = {
		Width = scale(26, button_scale),
		Height = scale(26, button_scale),
	},
	Pushed = {
		Width = scale(26, button_scale),
		Height = scale(26, button_scale),
		Color = { 1, .97, 0, .25 },
		Texture = BLANK
	},
	Normal = {
		Width = scale(64, button_scale),
		Height = scale(64, button_scale),
		TexCoords = { 0, 1, 0, 1 },
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_36x36_Normal_Warcraft.tga",
		EmptyTexture = path .. "gUI4_Button_36x36_Empty_Warcraft.tga",
		EmptyColor = { 1, 1, 1, 1 }
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = scale(64, button_scale),
		Height = scale(64, button_scale),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_36x36_Checked_Warcraft.tga"
	},
	Border = {
		Width = scale(64, button_scale),
		Height = scale(64, button_scale),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Texture = path .. "gUI4_Button_36x36_Highlight_Warcraft.tga"
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = scale(58, button_scale),
		Height = scale(58, button_scale),
		OffsetX = 0,
		OffsetY = 0,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]]
	},
	Highlight = {
		Width = scale(64, button_scale),
		Height = scale(64, button_scale),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "ADD",
		Color = { .7, .7, .7, .5 },
		Texture = path .. "gUI4_Button_36x36_Highlight_Warcraft.tga"
	},
	Name = {
		Width = 26,
		Height = 10,
		OffsetY = 4
	},
	Count = {
		Width = 26,
		Height = 10,
		OffsetX = 0,
		OffsetY = 0
	},
	HotKey = {
		Width = 26,
		Height = 10,
		OffsetX = 0
	},
	Duration = {
		Width = 26,
		Height = 10,
		OffsetY = 0
	},
	AutoCast = {
		Width = scale(34, button_scale),
		Height = scale(34, button_scale),
		OffsetX = 0,
		OffsetY = 0
	}
}, true)

MSQ:AddSkin("Goldpaw's UI: PetBar", {
	Author = "Lars Norberg",
	Version = "1.0.Release-r1",
	Shape = "Square",
	Masque_Version = 60000,
	Backdrop = {
		Width = scale(64, pet_scale),
		Height = scale(64, pet_scale),
		TexCoords = { 0, 1, 0, 1 },
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_36x36_Backdrop_Warcraft.tga"
	},
	Icon = {
		Width = scale(26, pet_scale),
		Height = scale(26, pet_scale),
		TexCoords = { 5/64, 59/64, 5/64, 59/64 }
	},
	Flash = {
		Width = scale(26, pet_scale),
		Height = scale(26, pet_scale),
		Color = { .7, 0, 0, .30 },
		Texture = BLANK
	},
	Cooldown = {
		Width = scale(26, pet_scale),
		Height = scale(26, pet_scale),
	},
	Pushed = {
		Width = scale(26, pet_scale),
		Height = scale(26, pet_scale),
		Color = { 1, .97, 0, .25 },
		Texture = BLANK
	},
	Normal = {
		Width = scale(64, pet_scale),
		Height = scale(64, pet_scale),
		TexCoords = { 0, 1, 0, 1 },
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_36x36_Normal_Warcraft.tga",
		EmptyTexture = path .. "gUI4_Button_36x36_Empty_Warcraft.tga",
		EmptyColor = { 1, 1, 1, 1 }
	},
	Disabled = {
		Hide = true,
	},
	Checked = {
		Width = scale(64, pet_scale),
		Height = scale(64, pet_scale),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Color = { 1, 1, 1, 1 },
		Texture = path .. "gUI4_Button_36x36_Checked_Warcraft.tga"
	},
	Border = {
		Width = scale(64, pet_scale),
		Height = scale(64, pet_scale),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "BLEND",
		Texture = path .. "gUI4_Button_36x36_Highlight_Warcraft.tga"
	},
	Gloss = {
		Hide = true,
	},
	AutoCastable = {
		Width = scale(58, pet_scale),
		Height = scale(58, pet_scale),
		OffsetX = 0,
		OffsetY = 0,
		Texture = [[Interface\Buttons\UI-AutoCastableOverlay]]
	},
	Highlight = {
		Width = scale(64, pet_scale),
		Height = scale(64, pet_scale),
		TexCoords = { 0, 1, 0, 1 },
		BlendMode = "ADD",
		Color = { .7, .7, .7, .5 },
		Texture = path .. "gUI4_Button_36x36_Highlight_Warcraft.tga"
	},
	Name = {
		Width = 26,
		Height = 10,
		OffsetY = 4
	},
	Count = {
		Width = 26,
		Height = 10,
		OffsetX = 0,
		OffsetY = 0
	},
	HotKey = {
		Width = 26,
		Height = 10,
		OffsetX = 0
	},
	Duration = {
		Width = 26,
		Height = 10,
		OffsetY = 0
	},
	AutoCast = {
		Width = scale(34, pet_scale),
		Height = scale(34, pet_scale),
		OffsetX = 0,
		OffsetY = 0
	}
}, true)
