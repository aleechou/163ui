BuildEnv(...)

local function menuDisable(data)
    return UnitLevel('player') < GetEventMinLevel(data.value) or (IsHasPVPRating(data.value) and GetCurrentArenaSeason() == 0)
end

EVENT_CREATE_MENUTABLE  = {
    [1] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑石铸造厂-普通',
                        ['value'] = 0x1A7E100,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑石铸造厂-英雄',
                        ['value'] = 0x1A7E200,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑石铸造厂-史诗',
                        ['value'] = 0x1A7E300,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '悬槌堡-普通',
                        ['value'] = 0x1A7F100,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '悬槌堡-英雄',
                        ['value'] = 0x1A7F200,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '悬槌堡-史诗',
                        ['value'] = 0x1A7F300,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '德拉诺-鲁克玛',
                        ['value'] = 0x1AFFD00,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '德拉诺-永恒的塔尔纳',
                        ['value'] = 0x1AFFE00,
                    },
                    [9] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '德拉诺-毁灭者多弗',
                        ['value'] = 0x1AFFF00,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '德拉诺之王',
                ['value'] = 0x1A00000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '决战奥格瑞玛-普通',
                        ['value'] = 0x1B7B100,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '决战奥格瑞玛-英雄',
                        ['value'] = 0x1B7B200,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '决战奥格瑞玛-史诗',
                        ['value'] = 0x1B7B300,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '雷电王座',
                        ['value'] = 0x1B7CF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '永春台',
                        ['value'] = 0x1B7DF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '恐惧之心',
                        ['value'] = 0x1B7EF00,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '魔古山宝库',
                        ['value'] = 0x1B7FF00,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '斡耳朵斯',
                        ['value'] = 0x1BFDF00,
                    },
                    [9] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '四大天神',
                        ['value'] = 0x1BFEF00,
                    },
                    [10] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '熊猫人之迷世界Boss',
                        ['value'] = 0x1BFFF00,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '熊猫人之迷',
                ['value'] = 0x1B00000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '巨龙之魂',
                        ['value'] = 0x1CFAF00,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '火焰之地',
                        ['value'] = 0x1CFBF00,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '风神王座',
                        ['value'] = 0x1CFCF00,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑翼血环',
                        ['value'] = 0x1CFDF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '暮光堡垒',
                        ['value'] = 0x1CFEF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '巴拉丁监狱',
                        ['value'] = 0x1CFFF00,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '大地的裂变',
                ['value'] = 0x1C00000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '冰冠堡垒',
                        ['value'] = 0x1D79F00,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '红玉圣殿',
                        ['value'] = 0x1D7AF00,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '十字军的试炼',
                        ['value'] = 0x1D7BF00,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '奥杜尔',
                        ['value'] = 0x1D7CF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑曜石圣殿',
                        ['value'] = 0x1D7DF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '永恒之眼',
                        ['value'] = 0x1D7EF00,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '纳克萨玛斯',
                        ['value'] = 0x1D7FF00,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '奥妮克希亚的巢穴',
                        ['value'] = 0x1DFEF00,
                    },
                    [9] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '阿尔卡冯的宝库',
                        ['value'] = 0x1DFFF00,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '巫妖王之怒',
                ['value'] = 0x1D00000,
            },
            [5] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '太阳之井',
                        ['value'] = 0x1E78000,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑暗神殿',
                        ['value'] = 0x1E79000,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '海加尔山之战',
                        ['value'] = 0x1E7A000,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '风暴要塞',
                        ['value'] = 0x1E7B000,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '毒蛇神殿',
                        ['value'] = 0x1E7C000,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '格鲁尔的巢穴',
                        ['value'] = 0x1E7D000,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '玛瑟里顿的巢穴',
                        ['value'] = 0x1E7E000,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '卡拉赞',
                        ['value'] = 0x1E7F000,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '燃烧的远征',
                ['value'] = 0x1E00000,
            },
            [6] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '安其拉神殿',
                        ['value'] = 0x1F7C000,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '安其拉废墟',
                        ['value'] = 0x1F7D000,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑翼之巢',
                        ['value'] = 0x1F7E000,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '熔火之心',
                        ['value'] = 0x1F7F000,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '经典旧世',
                ['value'] = 0x1F00000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '团队副本',
        ['value'] = 0x1000000,
    },
    [2] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['text'] = '英雄地下城',
                ['value'] = 0x2001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '普通地下城',
                ['value'] = 0x2002000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['text'] = '挑战地下城',
                ['value'] = 0x2003000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '地下城',
        ['value'] = 0x2000000,
    },
    [3] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['text'] = '英雄场景战役',
                ['value'] = 0x3001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '普通场景战役',
                ['value'] = 0x3002000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '场景战役',
        ['value'] = 0x3000000,
    },
    [4] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '2v2',
                        ['value'] = 0x4001001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '3v3',
                        ['value'] = 0x4001002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '5v5',
                        ['value'] = 0x4001003,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '2v2练习赛',
                        ['value'] = 0x4001004,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '3v3练习赛',
                        ['value'] = 0x4001005,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '竞技场',
                ['value'] = 0x4001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '评级战场',
                        ['value'] = 0x4008001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '随机战场',
                        ['value'] = 0x4008002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '奖励战场',
                        ['value'] = 0x4008003,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '小号战场',
                        ['value'] = 0x4008004,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '战场',
                ['value'] = 0x4008000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '屠城',
                        ['value'] = 0x40FF001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '野外PvP',
                        ['value'] = 0x40FF002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '阿什兰PvP',
                        ['value'] = 0x40FF0FF,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '世界战场',
                ['value'] = 0x40FF000,
            },
        },
        ['notClickable'] = true,
        ['text'] = 'PvP',
        ['value'] = 0x4000000,
    },
    [5] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '霜火岭',
                        ['value'] = 0x6001001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '影月谷',
                        ['value'] = 0x6001002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '戈尔隆德',
                        ['value'] = 0x6001003,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '塔拉多',
                        ['value'] = 0x6001004,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '阿兰卡峰林',
                        ['value'] = 0x6001005,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '纳格兰',
                        ['value'] = 0x6001006,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '塔纳安丛林',
                        ['value'] = 0x6001007,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '阿什兰',
                        ['value'] = 0x6001008,
                    },
                },
                ['text'] = '任务升级',
                ['value'] = 0x6001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '副本升级',
                ['value'] = 0x6002000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '升级',
        ['value'] = 0x6000000,
    },
    [6] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['text'] = '同职业战场',
                ['value'] = 0x7001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '同职业副本',
                ['value'] = 0x7002000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['text'] = '直播',
                ['value'] = 0x7003000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['text'] = '成就',
                ['value'] = 0x7005000,
            },
            [5] = {
                ['disabled'] = menuDisable,
                ['text'] = '看风景',
                ['value'] = 0x7006000,
            },
            [6] = {
                ['disabled'] = menuDisable,
                ['text'] = '怀旧',
                ['value'] = 0x7007000,
            },
            [7] = {
                ['disabled'] = menuDisable,
                ['text'] = '宠物对战',
                ['value'] = 0x7008000,
            },
            [8] = {
                ['disabled'] = menuDisable,
                ['text'] = '活动',
                ['value'] = 0x7009000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '娱乐',
        ['value'] = 0x7000000,
    },
    [7] = {
        ['disabled'] = menuDisable,
        ['text'] = '寻求帮助',
        ['value'] = 0x9000000,
    },
    [8] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['text'] = '公会招募',
                ['value'] = 0xE001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '固定团招募',
                ['value'] = 0xE002000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '招募',
        ['value'] = 0xE000000,
    },
    [9] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['text'] = '少昊皇帝声望',
                ['value'] = 0xF001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '黑王子声望',
                ['value'] = 0xF002000,
            },
        },
        ['text'] = '其它',
        ['value'] = 0xF000000,
    },
}

EVENT_FILTER_MENUTABLE  = {
    [1] = {
        ['text'] = '全部',
        ['value'] = 0,
    },
    [2] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑石铸造厂-普通',
                        ['value'] = 0x1A7E100,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑石铸造厂-英雄',
                        ['value'] = 0x1A7E200,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑石铸造厂-史诗',
                        ['value'] = 0x1A7E300,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '悬槌堡-普通',
                        ['value'] = 0x1A7F100,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '悬槌堡-英雄',
                        ['value'] = 0x1A7F200,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '悬槌堡-史诗',
                        ['value'] = 0x1A7F300,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '德拉诺-鲁克玛',
                        ['value'] = 0x1AFFD00,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '德拉诺-永恒的塔尔纳',
                        ['value'] = 0x1AFFE00,
                    },
                    [9] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '德拉诺-毁灭者多弗',
                        ['value'] = 0x1AFFF00,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '德拉诺之王',
                ['value'] = 0x1A00000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '决战奥格瑞玛-普通',
                        ['value'] = 0x1B7B100,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '决战奥格瑞玛-英雄',
                        ['value'] = 0x1B7B200,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '决战奥格瑞玛-史诗',
                        ['value'] = 0x1B7B300,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '雷电王座',
                        ['value'] = 0x1B7CF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '永春台',
                        ['value'] = 0x1B7DF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '恐惧之心',
                        ['value'] = 0x1B7EF00,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '魔古山宝库',
                        ['value'] = 0x1B7FF00,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '斡耳朵斯',
                        ['value'] = 0x1BFDF00,
                    },
                    [9] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '四大天神',
                        ['value'] = 0x1BFEF00,
                    },
                    [10] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '熊猫人之迷世界Boss',
                        ['value'] = 0x1BFFF00,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '熊猫人之迷',
                ['value'] = 0x1B00000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '巨龙之魂',
                        ['value'] = 0x1CFAF00,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '火焰之地',
                        ['value'] = 0x1CFBF00,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '风神王座',
                        ['value'] = 0x1CFCF00,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑翼血环',
                        ['value'] = 0x1CFDF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '暮光堡垒',
                        ['value'] = 0x1CFEF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '巴拉丁监狱',
                        ['value'] = 0x1CFFF00,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '大地的裂变',
                ['value'] = 0x1C00000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '冰冠堡垒',
                        ['value'] = 0x1D79F00,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '红玉圣殿',
                        ['value'] = 0x1D7AF00,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '十字军的试炼',
                        ['value'] = 0x1D7BF00,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '奥杜尔',
                        ['value'] = 0x1D7CF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑曜石圣殿',
                        ['value'] = 0x1D7DF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '永恒之眼',
                        ['value'] = 0x1D7EF00,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '纳克萨玛斯',
                        ['value'] = 0x1D7FF00,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '奥妮克希亚的巢穴',
                        ['value'] = 0x1DFEF00,
                    },
                    [9] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '阿尔卡冯的宝库',
                        ['value'] = 0x1DFFF00,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '巫妖王之怒',
                ['value'] = 0x1D00000,
            },
            [5] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '太阳之井',
                        ['value'] = 0x1E78000,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑暗神殿',
                        ['value'] = 0x1E79000,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '海加尔山之战',
                        ['value'] = 0x1E7A000,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '风暴要塞',
                        ['value'] = 0x1E7B000,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '毒蛇神殿',
                        ['value'] = 0x1E7C000,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '格鲁尔的巢穴',
                        ['value'] = 0x1E7D000,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '玛瑟里顿的巢穴',
                        ['value'] = 0x1E7E000,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '卡拉赞',
                        ['value'] = 0x1E7F000,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '燃烧的远征',
                ['value'] = 0x1E00000,
            },
            [6] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '安其拉神殿',
                        ['value'] = 0x1F7C000,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '安其拉废墟',
                        ['value'] = 0x1F7D000,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑翼之巢',
                        ['value'] = 0x1F7E000,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '熔火之心',
                        ['value'] = 0x1F7F000,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '经典旧世',
                ['value'] = 0x1F00000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '团队副本',
        ['value'] = 0x1000000,
    },
    [3] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '英雄地下城',
                ['value'] = 0x2001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '普通地下城',
                ['value'] = 0x2002000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '挑战地下城',
                ['value'] = 0x2003000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '地下城',
        ['value'] = 0x2000000,
    },
    [4] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '英雄场景战役',
                ['value'] = 0x3001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '普通场景战役',
                ['value'] = 0x3002000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '场景战役',
        ['value'] = 0x3000000,
    },
    [5] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '2v2',
                        ['value'] = 0x4001001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '3v3',
                        ['value'] = 0x4001002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '5v5',
                        ['value'] = 0x4001003,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '2v2练习赛',
                        ['value'] = 0x4001004,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '3v3练习赛',
                        ['value'] = 0x4001005,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '竞技场',
                ['value'] = 0x4001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '评级战场',
                        ['value'] = 0x4008001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '随机战场',
                        ['value'] = 0x4008002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '奖励战场',
                        ['value'] = 0x4008003,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '小号战场',
                        ['value'] = 0x4008004,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '战场',
                ['value'] = 0x4008000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '屠城',
                        ['value'] = 0x40FF001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '野外PvP',
                        ['value'] = 0x40FF002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '阿什兰PvP',
                        ['value'] = 0x40FF0FF,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '世界战场',
                ['value'] = 0x40FF000,
            },
        },
        ['notClickable'] = false,
        ['text'] = 'PvP',
        ['value'] = 0x4000000,
    },
    [6] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '霜火岭',
                        ['value'] = 0x6001001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '影月谷',
                        ['value'] = 0x6001002,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '戈尔隆德',
                        ['value'] = 0x6001003,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '塔拉多',
                        ['value'] = 0x6001004,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '阿兰卡峰林',
                        ['value'] = 0x6001005,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '纳格兰',
                        ['value'] = 0x6001006,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '塔纳安丛林',
                        ['value'] = 0x6001007,
                    },
                    [8] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '阿什兰',
                        ['value'] = 0x6001008,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '任务升级',
                ['value'] = 0x6001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '副本升级',
                ['value'] = 0x6002000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '升级',
        ['value'] = 0x6000000,
    },
    [7] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '同职业战场',
                ['value'] = 0x7001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '同职业副本',
                ['value'] = 0x7002000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '直播',
                ['value'] = 0x7003000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '成就',
                ['value'] = 0x7005000,
            },
            [5] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '看风景',
                ['value'] = 0x7006000,
            },
            [6] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '怀旧',
                ['value'] = 0x7007000,
            },
            [7] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '宠物对战',
                ['value'] = 0x7008000,
            },
            [8] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '活动',
                ['value'] = 0x7009000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '娱乐',
        ['value'] = 0x7000000,
    },
    [8] = {
        ['disabled'] = menuDisable,
        ['notClickable'] = false,
        ['text'] = '寻求帮助',
        ['value'] = 0x9000000,
    },
    [9] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '公会招募',
                ['value'] = 0xE001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '固定团招募',
                ['value'] = 0xE002000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '招募',
        ['value'] = 0xE000000,
    },
    [10] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '少昊皇帝声望',
                ['value'] = 0xF001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '黑王子声望',
                ['value'] = 0xF002000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '其它',
        ['value'] = 0xF000000,
    },
}

EVENT_MODE_MENUTABLE = {
    [0x1000000] = {
        [1] = {
            ['text'] = 'Roll',
            ['value'] = 1,
        },
        [2] = {
            ['text'] = '带新',
            ['value'] = 2,
        },
        [3] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
        [4] = {
            ['text'] = '幻化',
            ['value'] = 5,
        },
        [5] = {
            ['text'] = '开荒',
            ['value'] = 4,
        },
    },
    [0x2000000] = {
        [1] = {
            ['text'] = '勇气',
            ['value'] = 7,
        },
        [2] = {
            ['text'] = '正义',
            ['value'] = 8,
        },
        [3] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
        [4] = {
            ['text'] = '自强',
            ['value'] = 6,
        },
        [5] = {
            ['text'] = '挑战',
            ['value'] = 11,
        },
    },
    [0x3000000] = {
        [1] = {
            ['text'] = '勇气',
            ['value'] = 7,
        },
        [2] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
    },
    [0x4000000] = {
        [1] = {
            ['text'] = '荣誉',
            ['value'] = 10,
        },
        [2] = {
            ['text'] = '征服',
            ['value'] = 9,
        },
        [3] = {
            ['text'] = '冲分',
            ['value'] = 12,
        },
        [4] = {
            ['text'] = '混分',
            ['value'] = 13,
        },
    },
    [0x6000000] = {
        [1] = {
            ['text'] = '练级',
            ['value'] = 14,
        },
    },
    [0x7000000] = {
        [1] = {
            ['text'] = '娱乐',
            ['value'] = 17,
        },
    },
    [0x9000000] = {
        [1] = {
            ['text'] = '求助',
            ['value'] = 19,
        },
        [2] = {
            ['text'] = '声望',
            ['value'] = 15,
        },
        [3] = {
            ['text'] = '任务',
            ['value'] = 16,
        },
    },
    [0xE000000] = {
        [1] = {
            ['text'] = '招募',
            ['value'] = 18,
        },
    },
    [0xF000000] = {
        [1] = {
            ['text'] = '其它',
            ['value'] = 99,
        },
        [2] = {
            ['text'] = '声望',
            ['value'] = 15,
        },
        [3] = {
            ['text'] = '任务',
            ['value'] = 16,
        },
    },
}

EVENT_MODE_MENUTABLE_WITHALL = {
    [0x1000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = 'Roll',
            ['value'] = 1,
        },
        [3] = {
            ['text'] = '带新',
            ['value'] = 2,
        },
        [4] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
        [5] = {
            ['text'] = '幻化',
            ['value'] = 5,
        },
        [6] = {
            ['text'] = '开荒',
            ['value'] = 4,
        },
    },
    [0x2000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '勇气',
            ['value'] = 7,
        },
        [3] = {
            ['text'] = '正义',
            ['value'] = 8,
        },
        [4] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
        [5] = {
            ['text'] = '自强',
            ['value'] = 6,
        },
        [6] = {
            ['text'] = '挑战',
            ['value'] = 11,
        },
    },
    [0x3000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '勇气',
            ['value'] = 7,
        },
        [3] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
    },
    [0x4000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '荣誉',
            ['value'] = 10,
        },
        [3] = {
            ['text'] = '征服',
            ['value'] = 9,
        },
        [4] = {
            ['text'] = '冲分',
            ['value'] = 12,
        },
        [5] = {
            ['text'] = '混分',
            ['value'] = 13,
        },
    },
    [0x6000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '练级',
            ['value'] = 14,
        },
    },
    [0x7000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '娱乐',
            ['value'] = 17,
        },
    },
    [0x9000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '求助',
            ['value'] = 19,
        },
        [3] = {
            ['text'] = '声望',
            ['value'] = 15,
        },
        [4] = {
            ['text'] = '任务',
            ['value'] = 16,
        },
    },
    [0xE000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '招募',
            ['value'] = 18,
        },
    },
    [0xF000000] = {
        [1] = {
            ['text'] = '全部',
            ['value'] = 0,
        },
        [2] = {
            ['text'] = '其它',
            ['value'] = 99,
        },
        [3] = {
            ['text'] = '声望',
            ['value'] = 15,
        },
        [4] = {
            ['text'] = '任务',
            ['value'] = 16,
        },
    },
}