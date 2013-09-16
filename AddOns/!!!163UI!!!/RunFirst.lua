local _, U1 = ...

---创建一个locale表, 对于["text"]=true的值会返回"text", 同时L["zhCN"]会有值
local localeMetaTable = {__newindex = function(t, k, v) rawset(t, k, v==true and k or v) end}
function NewLocale()
    local loc = GetLocale();
    return setmetatable({[loc]=true}, localeMetaTable);
end

U1.L = NewLocale()
local L = U1.L

if U1RunFirstEventFrame then
    U1.eventframe = U1RunFirstEventFrame
else
    local f = CreateFrame("Frame") --最先注册
    f:RegisterEvent("ADDON_LOADED") --ADDON_LOADED已经可以获取db了
    f:RegisterEvent("VARIABLES_LOADED")
    f:RegisterEvent("PLAYER_LOGIN")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("PLAYER_LOGOUT")
    U1.eventframe = f
    --f:SetScript("OnEvent", function(...) print(...) end)
end

--这里是所有要第一时间运行的函数
function normalize(num, min, max)
    return (num < min and min) or (num > max and max) or num;
end

function U1Message(text, r, g, b, chatFrame)
    (chatFrame or DEFAULT_CHAT_FRAME):AddMessage(L["|cffcd1a1c【网易有爱】|r- "]..text, r, g, b);
end

local cfNames = {} for i=1, NUM_CHAT_WINDOWS do cfNames[i] = "ChatFrame"..i end
function WithAllChatFrame(func, ...)
    for i=1, NUM_CHAT_WINDOWS do
        local chatFrame = _G[cfNames[i]]
        if chatFrame then func(chatFrame, ...); end
    end
end

--U1.removedAddOns = {"Fizzle", }

NO_SAFE_CALL = true
--UI163_USER_MODE = 1 --alwaysRegister=1 and not checkVendor
--UI163_USE_X_CATEGORIES = 1 --use X-Categories tag