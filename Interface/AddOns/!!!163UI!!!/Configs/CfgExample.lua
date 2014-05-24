U1RegisterAddon("$NAME$", {
    title = "$NAME$",
    defaultEnable = 0,
    --optionsAfterVar = 1, --对于在VARIABLES_LOADED事件里初始化并执行操作的插件来说，比如BlizzMove，没有办法在初始DB创建后，执行操作前进行拦截，只能用U1GetCfgValue
    --optionsAfterLogin = 1, --一些Ace插件是在LOGIN事件中OnEnable的，然后才有db，所以
    --runBeforeLoad = function(info, name) end --在ADDON_LOADED事件之前, NORMAL插件可以有此属性
    --runAfterLoad = function(info, name) end --在ADDON_LOADED事件之后, NORMAL插件没有此属性
    --load = "LOGIN",
    --secure = 1,
    --minimap = "",
    --dummy = "",
    --hide = 1,
    --protected = 1,
    --frames = {""}, --需要保存位置的框体
    --已取消 simulateAddonLoaded = 1, --已取消，是否触发模拟事件，此选项已取消，如果需要的话，在toggle里自行模拟
    --deps = {"libbabble",}, --parent之外的依赖, 这里面的插件应该都是LoadOnDemand的，不然只要开了子插件，就会自动启用并加载父插件。而不是用父插件控制子插件。
    --optdeps = {"A", "B", "C", }, --控制插件的加载顺序，被依赖的会先加载，其次是插件名顺序。如果父插件设置子插件为optdeps，则会先加载子插件

    tags = { TAG_ },
    icon = [[Interface\Icons\ACHIEVEMENT_GUILDPERK_HASTYHEARTH]],
    --alwaysRegister = 1, --如果不提供，则当插件的vendor为false时，会跳过设置页面的注册
    --desc = "",
    --nopic = true, 是否没有图片
    --pics = 2, -- 一共多少张图片，都在图片Pics/插件名.tga里，高度128，宽度200。
    --picsWidth = 1024, -- 图片材质的宽度，默认为1024，可以存两张图

    --author = "|cffcd1a1c[网易原创]|r",
    --modifier = "|cffcd1a1c[网易]|r",

    --toggle = function(name, info, enable, justload) end, --如果未开插件，则初始不会调用。

    --已取消 wrapload = function(pre) end, --(已失效，通过ADDON_LOADED前后的事件即可，pre=false和toggle是一起的 --在LoadAddOn后，分别于模拟事件之前和之后触发的，pre=true时为模拟事件之前
    --已取消 ace = "Gladius", --表示这个是一个Ace3插件，名字就是Ace3AddOn的名字。
    --已取消 aceInit = function(self) end, --提供了ace参数必须有这个, 会在OnInitiate之后调用。runAfterLoad是等价的

    --nolodbutton 不创建强制加载的按钮

    --[[------ Options --------
    {
        var = "",
        default = "",
        text = "",
        callback = function(cfg, v, loading) end,
    },
    {
        var = "", --变量，如果有变量则type默认为"checkbox"否则为"button"
        lower = false, --如果为true则点击此选项后，控制台面板会调整层次。注意，button类型如果不提供此选项则默认为true
        enableOnNotLoad = true, --当插件没有加载的时候也会可用，用于强制load
        disableOnLoad = true, --当插件启用后不可用
        alwaysEnable = true, --总是可用
        tip = "", --用`分割的说明
        default = 1, --不会自动保存，除非有getvalue
        getvalue = function() end, --当打开面板和退出游戏时会调用，加载游戏时不调用
        callback = function(cfg, v, loading) end,
        confirm = "text", --提供此选项，则设置会出现提示
        reload = 1,

        --单选
        type = "radio",
        options = {"显示1", 值1, "显示", 值2},
        cols = 3, --每行的选项数
        indent = 1, 是否缩进

        --段落分割
        type = "text",
    },
    --]]
});

--如果提供 UI163_USER_MODE = 1 则不需要写alwaysRegister，而且插件会列在有爱整合里，如果不提供USER_MODE，只写alwaysRegister，则插件会列在分类里，但仍然在单体插件里，而不是有爱整合里