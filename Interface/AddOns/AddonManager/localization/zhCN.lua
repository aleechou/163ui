if GetLocale() == "zhCN" then

local L = AddonManagerLocale

-- slash command
L["/am"]										="/am"
L["/addonmanager"]								="/addonmanager"

-- general ui labels and buttons
L["Addon Manager v%s"]							="Addon Manager v%s"
L["Written by Crepusculu of Stormrage-US"]		="Written by Crepusculu of Stormrage-US"
L["Find my addons listed at WoWInterface.com"]	="Find my addons listed at WoWInterface.com"
L["CPU Profiling"]								="CPU Profiling"
L["Periodical Polling"]							="Periodical Polling"
L["*  CPU Profiling Enabled  *"]				="*  CPU Profiling Enabled  *"
L["Exit"]										="退出"
L["Addon CPU usage: "]							="插件CPU占用: "
L["###"]										="###"
L["Memory Usage: "]								="内存占用: "
L["Reload UI"]									="重载UI"
L["Reset CPU"]									="重置CPU"
L["Update"]										="刷新"
L["Collect Garbage"]							="清理垃圾"
--[[
["CPU / Memory View"]							="CPU / Memory View"
["(user)"]										="(user)"
["(blizzard)"]									="(blizzard)"
["(total)"]										="(total)"
]]
L["Periodical Polling"]							="定期刷新"
L["Last Collection"]							="上一次收集"
L["CPU Start"]									="CPU状态"
L["Addon Memory Consumption"]					="插件内存消耗"
L["-nil-"]										="-空-"

-- status information
L["Loaded"]										="正在运行"
L["Click to Load"]								="可加载"
L["Dependency Disabled"]						="Dependency Disabled"
L["Dependency Needed"]							="Dependency Needed"
L["Disabled"]								    ="关闭"
L["Dependencies:"]								="依赖:"
L["No Dependencies"]							="No Dependencies"

-- table titles
L["Addon"]										="插件"
L["Status"]										="状态"
L["Active"]										="活动"
L["Current"]									="当前"
L["Max"]										="最大"
L["Cummulative"]								="消耗"
L["Peak"]										="高峰"
L["Total"]										="总"
L["Notes"]										="说明"

end
