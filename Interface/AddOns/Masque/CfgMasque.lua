
U1RegisterAddon("Masque", {
    title = "按钮美化",
    defaultEnable = 0,
    --optionsAfterVar = 1,
    minimap = "LibDBIcon10_Masque",
    load = "NORMAL", --支持其他第三方插件

    tags = { TAG_INTERFACE,},
    icon = [[Interface\Addons\Masque\Textures\Icon]],
    desc = "为动作条按钮提供样式切换，拥有众多的皮肤类扩展，是此类美化插件的第一选择。`网易有爱在原版的基础上整合了玩家增益美化，并精选了几种有代表性的皮肤样式，可以用控制台轻松选择。当然，您也可以下载任意皮肤包放到插件目录里，网易有爱对此提供良好的兼容。",
 {
        text = "设置按钮皮肤",	
		tip = "首次进入游戏需要点击多次",
			callback = function() 
            SlashCmdList["MASQUE"]() 				
			end
    },
	

	
});
	

U1RegisterAddon("ButtonFacade", {
    title = "ButtonFacade",
    parent = "Masque",
    desc = "为Masque提供兼容老版的接口,不可关闭",
    protected = 1,
    load = "NORMAL",
    secure = 1,
    hide = 1,
    toggle = function(name, info, enable, justload)
        if justload then
            CoreScheduleTimer(false, 0.2, UUI.Right.ADDON_SELECTED);
        end
    end,
});

if hooksecurefunc then
    --满级以后的条
    hooksecurefunc("ReputationWatchBar_Update", function(newLevel)
        local name, reaction, min, max, value = GetWatchedFactionInfo();
        local visibilityChanged = nil;
        if ( not newLevel ) then
            newLevel = UnitLevel("player");
        end
        if ( name ) then
            if not ( newLevel < MAX_PLAYER_LEVEL and not IsXPUserDisabled() ) then
                ReputationWatchStatusBar:SetHeight(11);
            end
        end
    end)
end
