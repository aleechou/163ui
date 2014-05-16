
local function load_opt()
    local OPT = 'Ellipsis_Options'
    if(not select(4, GetAddOnInfo(OPT))) then
        EnableAddOn(OPT)
    end
    if(not IsAddOnLoaded(OPT)) then
        LoadAddOn(OPT)
    end
    if( not Ellipsis.optFrame ) then
        Ellipsis:LoadOptions()
    end
end

U1RegisterAddon("Ellipsis", {
    title = "法术计时",
    tags = { TAG_COMBATINFO },
    icon = [[Interface\Icons\SPELL_HOLY_BORROWEDTIME]],
    desc = "多功能法术计时器",
    defaultEnable = 1,


    {
        text = '锁定',
        type = 'checkbox',
        getvalue = function()
            return Ellipsis and Ellipsis.db.profile.lock
        end,

        --     function Ellipsis:SetOption(info, value)
        --         self.db.profile[info[#info]] = value
        --         self:ApplyConfigSettings()
        --     end
        callback = function(cfg, v, loading)
            if(not loading) then
                Ellipsis.db.profile.lock = not not v
                Ellipsis:ConfigureAnchors(true)
            end
        end,
    },

    {
        text = '测试计时条',
        callback = function()
            load_opt()
            if(Ellipsis and Ellipsis.SampleTimers) then
                Ellipsis:SampleTimers()
            end
        end,
    },

    {
        text = '关闭线性冷却条',
        tip = '关闭线性冷却条`如果冷却条上已经有技能显示请重载或等上面所有技能冷却完成\n`重新打开冷却条请选中 <冷却监视> 内需要监视的内容`并且在 <显示设置/冷却计时1> 下选择不计时时是否隐藏',
        callback = function()
            load_opt()
            local profile = Ellipsis and Ellipsis.db and Ellipsis.db.profile
            if(profile) then
                profile.cdSpell = false
                profile.cdItem = false
                profile.cdPet = false
                profile.cdHideWhenNone = true
                Ellipsis:ApplyConfigSettings()
            end
        end,
    },

    {
        text = "配置选项",
        callback = function()
            load_opt()
            if(Ellipsis) then
                return Ellipsis:OpenOptFrame()
            end
        end,
    },
})

U1RegisterAddon("Ellipsis_Options", {title = '', hide = 1, })

