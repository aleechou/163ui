if ( GetLocale() == "zhCN" ) then 
    FMXP_BUTTON_OPEN_ARMORY = "查看英雄榜(内置浏览器)"
end


local function findElement(t,val)
    for k,v in pairs(t) do
        if val==v then
            return k
        end
    end
end
local function insertAfter(t,v,after)
    local pos = findElement(t,after)
    tinsert(t,pos+1,v)
end
local function urlencode(obj)
    local currentIndex = 1;
    local charArray = {}
    while currentIndex <= #obj do
        local char = string.byte(obj, currentIndex);
        charArray[currentIndex] = char
        currentIndex = currentIndex + 1
    end
    local converchar = "";
    for _, char in ipairs(charArray) do
        converchar = converchar..string.format("%%%X", char)
    end
    return converchar;
end

insertAfter(FriendsMenuXP_ButtonSet["NORMAL"],"OPEN-ARMORY","ARMORY")
insertAfter(FriendsMenuXP_ButtonSet["RAID"],"OPEN-ARMORY","ARMORY")
insertAfter(FriendsMenuXP_ButtonSet["OFFLINE"],"OPEN-ARMORY","ARMORY")
insertAfter(FriendsMenuXP_ButtonSet["UNITPOPUP"],"OPEN-ARMORY","ARMORY")


FriendsMenuXP_ButtonSet["GUILD"] = {
    "GET_NAME",
    "ARMORY",
    "OPEN-ARMORY",
}

FriendsMenuXP_Buttons["OPEN-ARMORY"] = {
    text = FMXP_BUTTON_OPEN_ARMORY,
    func = function(name)
        local n,r = name:match"(.*)-(.*)"
        n = n or name
        r = r or GetRealmName()

        local portal = GetCVar'portal'
        local host = portal == 'cn' and "http://www.battlenet.com.cn/" or ("http://%s.battle.net/"):format(GetCVar'portal')

        local armory = host.."wow/character/"..urlencode(r).."/"..urlencode(n).."/advanced"
        local armoryNoDecode = host.."wow/character/"..r.."/"..n.."/advanced"

        if ThreeDimensionsCode_Send and Cmd3DCode_CheckoutClientAndPrompt and Cmd3DCode_CheckoutClientAndPrompt("没有检测到有爱客户端，无法启动有爱内置浏览器") then
            ThreeDimensionsCode_Send("innerbrowser",armoryNoDecode)
        end
    end,
}


-- 公会成员列表右键
local clickGuildRosterIdx = 0
local function HookSriptBefore(frm,type,func)
    local oriFunc = frm:GetScript(type)
    frm:SetScript(type,function(...)
        func(...)
        if oriFunc then oriFunc(...) end
    end)
end

hooksecurefunc("ToggleGuildFrame",function(...)
    for i=1, #GuildRosterContainer.buttons do
        local btn = GuildRosterContainer.buttons[i]
        if not btn.onclickFunc then
            btn.onclickFunc = function(btn,type)
                if type~="RightButton" then return end
                clickGuildRosterIdx = btn.guildIndex



            end
            HookSriptBefore(btn,"OnClick",btn.onclickFunc)
        end
    end
end)

hooksecurefunc("ToggleDropDownMenu", function(...)
    if clickGuildRosterIdx<1 then
        return 
    end

    local name --[[, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName, achievementPoints, achievementRank, isMobile]]
            = GetGuildRosterInfo(clickGuildRosterIdx)
    local last = FriendsMenuXP

    FriendsMenuXP_ShowDropdown(
        "GUILD", false, "TOPLEFT", "BOTTOMLEFT", 0, 0
        , name, last.connected, last.lineID, last.chatType, last.chatFrame, last.friendsList, last.isMobile)
    clickGuildRosterIdx = 0
end)