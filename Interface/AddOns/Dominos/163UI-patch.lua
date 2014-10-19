
local Dominos = _G['Dominos']


--Dominos.oriOnInitialize = Dominos.OnInitialize
--[[Dominos.OnInitialize = function()
    -- XXX 163
    self.db = LibStub('AceDB-3.0'):New('DominosDB', self:GetDefaults(),
    '网易有爱-'..(GetRealmName())..'-'..(UnitName'player'))
    self:U1_InitPreset()
    -- XXX 163 end

    return self:oriOnInitialize()
end]]



do
    local key_163 = '163init'
    local key_db_ver = 1
    function Dominos:U1_InitPreset(force)
        if(not self.db.profile[key_163]) then
            self.db.profile[key_163] = key_db_ver
            force = true
        end

        if(not force) then return end

        local frames = self.db.profile.frames
        local num_bars = self.db.profile.ab.count
        local MAX_BUTTONS = 120

        local hideonvehicleui = '[novehicleui]'

        local style = U1GetCfgValue('Dominos', 'prestyle')
        if( style ~= 'MINI' and style ~= 'NORM' ) then
            style = 'MINI'
        end

        local mini = style == 'MINI'
        if(mini) then
            frames.menu = { x=0, y=0, point = 'BOTTOMRIGHT', }
            frames.bags = { x=0, y=40, point = 'BOTTOMRIGHT', }

            for i = 1, 10 do
                local def = {
                    pages = {},
                    x=0, y=0, point = 'BOTTOM',
                    spacing=4, padW=2, padH=2,
                    numButtons = floor(MAX_BUTTONS/num_bars),
                }
                frames[i] = def

                if(i~= 1) then
                    def.showstates = hideonvehicleui
                end

                if(i == 5) then
                    def.anchor = '1TC'
                elseif(i == 6) then
                    def.anchor = '5TC'
                elseif(i == 1) then
                    def.y = 0 + 15
                elseif(i == 3) then
                    def.point = 'BOTTOMRIGHT'
                    def.y = 80
                    def.columns = 1
                elseif(i == 4) then
                    def.point = 'RIGHT'
                    def.anchor = '3LC'
                    def.columns = 1
                elseif(i == 2) then
                    def.point = 'TOP'
                    def.y = -260
                    def.hidden = true
                else
                    def.hidden = true
                    def.anchor = (i==7 and '2' or tostring(i-1)).."TC"
                    def.y = 0
                end
            end

        else
            frames.menu = {
                x = 0, y = 0, point = 'BOTTOMRIGHT',
                anchor = '1RC',
                spacing = 3, padW = 4, padH = 4,
                scale = 0.9,
            }

            frames.bags = {
                x = 0, y = 0, point = 'BOTTOMRIGHT',
                anchor = 'menuRC',
                spacing = 2,
            }

            for i = 1, 10 do
                local def = frames[i] or {}
                frames[i] = def

                def.pages = {}
                def.spacing = 4
                def.padW = 2
                def.padH = 2
                def.point = 'BOTTOM'
                def.x = 0
                def.y = 0
                def.numButtons = floor(MAX_BUTTONS/num_bars)
                def.showstates = i ~= 1 and hideonvehicleui

                if(i == 1) then
                    def.point = 'BOTTOMRIGHT'
                    local screen_width = UIParent:GetWidth()
                    def.x = 0-(screen_width / 2)
                    def.y = 0 + 15
                elseif(i == 6) then
                    def.anchor = "1TR"
                elseif(i == 5) then
                    def.anchor = "6RT"
                elseif(i == 3) then
                    def.point = 'BOTTOMRIGHT'
                    def.y = 80
                    def.columns = 1
                elseif(i == 4) then
                    def.point = 'RIGHT'
                    def.anchor = '3LC'
                    def.columns = 1
                elseif(i == 2) then
                    def.point = 'TOP'
                    def.y = -260
                    def.hidden = true
                else
                    def.hidden = true
                    def.anchor = (i==7 and '2' or tostring(i-1)).."TC"
                    def.y = 0
                end
            end

        end

        frames.xp = {
            x=0, y=0, point = 'BOTTOM',
            alwaysShowText = true,
            width = mini and 0.3 or 0.6,
            height = 13,
            texture = 'Minimalist',
            alwaysShowXP = UnitLevel'player' ~= MAX_PLAYER_LEVEL and true,
        }

        frames.pet = {
            x=0, y=0, point = 'BOTTOMRIGHT',
            anchor = mini and '6TR' or '5TR',
            spacing=2, padW=5, padH=2,
        }

        frames.class = {
            x=0, y=0, point = 'BOTTOMLEFT',
            anchor = mini and 'petLB' or '6TL',
            spacing=2, padW=5, padH=2,
            showstates = hideonvehicleui,
        }

        frames.vehicle = {
            x=0, y=0, point = 'BOTTOMLEFT',
            anchor = mini and '5LT' or '6TR',
            numButtons = 3,
        }

        frames.cast = { x=0, y=200, point='BOTTOM', showText=true, }
        frames.roll = { x=0, y=0, point='CENTER', numButtons = NUM_GROUP_LOOT_FRAMES, spacing=2, columns=1, }
        frames.page = { x=0, y=0, point='BOTTOMLEFT', spacing=-8, columns=1, anchor='1LC', scale=0.9, fadeAlpha=0.35, }
    end
end