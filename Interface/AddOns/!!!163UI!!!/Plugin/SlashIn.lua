--[[
    yleaf (yaroot@gmail.com)

    /in 5 /say hi

    I hereby put this file in the Public Domain.
]]

local AceTimer = LibStub and LibStub('AceTimer-3.0')
if not AceTimer then return end

local IsSecureCmd = IsSecureCmd

local editbox = CreateFrame('Editbox', 'SlashInEditBox')
editbox:Hide()
local eb = DEFAULT_CHAT_FRAME.editBox

local function execute(line)
    editbox:SetAttribute('chatType', eb:GetAttribute('chatType'))
    editbox:SetAttribute('tellTarget', eb:GetAttribute('tellTarget'))
    editbox:SetAttribute('channelTarget', eb:GetAttribute('channelTarget'))
    editbox:SetText(line)
    ChatEdit_SendText(editbox)
end

local function err(value, msg)
    if not value then
        print(msg)
        return true
    end
end

local function slash_in(msg)
    local seconds, command, args = strsplit(' ', msg, 3)
    seconds = tonumber(seconds)

    if err(seconds, 'Error, bad arguments to /in. Must be in the form of "/in 5 /say hi"') or
        err(not IsSecureCmd(command), ('Error, /in cannot call secure command: %s'):format(command)) then
        return
    end

    AceTimer:ScheduleTimer(execute, seconds, strjoin(' ', command, args))
end


SLASH_ACE3IN1 = '/in'
SlashCmdList['ACE3IN'] = slash_in

