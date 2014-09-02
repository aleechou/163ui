local _, Bartender4 = ...

local config163UI = {
    ["ActionBars"] = {
        {
            ["version"] = 3,
            ["position"] = {
                ["y"] = 52,
                ["x"] = -232.000016869274,
                ["point"] = "BOTTOM",
            },
            ["enabled"] = true,
        }, -- [1]
        nil, -- [2]
        {
            ["padding"] = 5,
            ["rows"] = 12,
            ["version"] = 3,
            ["position"] = {
                ["y"] = 610,
                ["x"] = -43,
                ["point"] = "BOTTOMRIGHT",
            },
            ["enabled"] = true,
        }, -- [3]
        {
            ["padding"] = 5,
            ["rows"] = 12,
            ["version"] = 3,
            ["position"] = {
                ["y"] = 610,
                ["x"] = -82,
                ["point"] = "BOTTOMRIGHT",
            },
            ["enabled"] = true,
        }, -- [4]
        {
            ["version"] = 3,
            ["position"] = {
                ["y"] = 90,
                ["x"] = -232.000016869274,
                ["point"] = "BOTTOM",
            },
            ["enabled"] = true,
        }, -- [5]
        {
            ["version"] = 3,
            ["position"] = {
                ["y"] = 128,
                ["x"] = -232,
                ["point"] = "BOTTOM",
            },
            ["enabled"] = true,
        }, -- [6]
    } ,
    ["BagBar"] = {
        ["version"] = 3,
        ["position"] = {
            ["y"] = 64,
            ["x"] = -164.000361564766,
            ["point"] = "BOTTOMRIGHT",
        },
    } ,
    ["MicroMenu"] = {
        ["version"] = 3,
        ["position"] = {
            ["y"] = 32.4000002016431,
            ["x"] = -226.799542427395,
            ["point"] = "BOTTOMRIGHT",
            ["scale"] = 0.800000011920929,
        },
    },
    ["ExtraActionBar"] = {
        ["version"] = 3,
        ["position"] = {
            ["y"] = -14.0774673597127,
            ["x"] = 161.520443380743,
            ["point"] = "CENTER",
        },
    },
    ["XPBar"] = {
        ["enabled"] = true,
        ["version"] = 3,
        ["position"] = {
            ["y"] = 7.84000235683969,
            ["x"] = -254.310014662054,
            ["point"] = "BOTTOM",
            ["scale"] = 0.490000009536743,
        },
    },
    ["BlizzardArt"] = {
        ["artLayout"] = "ONEBAR",
        ["version"] = 3,
        ["position"] = {
            ["y"] = 47,
            ["x"] = -256,
            ["point"] = "BOTTOM",
        },
    } ,
    ["Vehicle"] = {
        ["version"] = 3,
        ["position"] = {
            ["y"] = 88,
            ["x"] = -267,
            ["point"] = "BOTTOM",
        },
    },
    ["Vehicle"] = {
        ["version"] = 3,
        ["position"] = {
            ["y"] = 88,
            ["x"] = -267,
            ["point"] = "BOTTOM",
        },
    },
    ["StanceBar"] = {
        ["version"] = 3,
        ["position"] = {
            ["y"] = 160,
            ["x"] = -232.000088844841,
            ["point"] = "BOTTOM",
            ["scale"] = 1,
        },
    },
    ["PetBar"] = {
        ["version"] = 3,
        ["position"] = {
            ["y"] = 160,
            ["x"] = -96,
            ["point"] = "BOTTOM",
        },
    },
    ["RepBar"] = {
        ["enabled"] = true,
        ["version"] = 3,
        ["position"] = {
            ["y"] = 11.850002785291,
            ["x"] = -227.26002360295,
            ["point"] = "BOTTOM",
            ["scale"] = 0.439999997615814,
        },
    },
}

local function SetBarLocation(config, point, x, y)
    config.position.point = point
    config.position.x = x
    config.position.y = y
end
function Bartender4_Build163UIProfile()

    local function setconfig(confobj,defConfobj)
        confobj.enabled = true
        for k, vv in pairs(defConfobj) do
            if k~="position" then
                confobj[k] = vv
            end
        end

        SetBarLocation( confobj, defConfobj.position.point, defConfobj.position.x, defConfobj.position.y )
        if defConfobj.position and defConfobj.position.scale then
            confobj.position.scale = defConfobj.position.scale
        end

    end

    local config

    Bartender4.db.profile.blizzardVehicle = false
    Bartender4.db.profile.outofrange = "hotkey"
    Bartender4.db.profile.focuscastmodifier = false

    -- 动作条
    config = Bartender4.db:GetNamespace("ActionBars").profile
    for i, bar in pairs(config163UI.ActionBars) do
        setconfig(config.actionbars[i],bar)
    end

    -- 其它
    for name,preconfig in pairs(config163UI) do
        if name~="ActionBars" then
            config = Bartender4.db:GetNamespace(name).profile
            setconfig(config,preconfig)
            Bartender4:GetModule(name):Enable()
        end
    end

    Bartender4.db:GetNamespace("BlizzardArt").profile.enabled = false
    Bartender4:GetModule("BlizzardArt"):Disable()
end

function Bartender4_ResetConfig()
    Bartender4.db:ResetProfile()
    Bartender4_Build163UIProfile()
    Bartender4:UpdateModuleConfigs()
end