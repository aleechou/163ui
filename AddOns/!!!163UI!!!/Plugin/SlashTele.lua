
SLASH_SLASHTELE1 = '/tele'
function SlashCmdList.SLASHTELE()
    local inInstance, instanceType = IsInInstance()
    LFGTeleport(instanceType and instanceType == 'party')
end

