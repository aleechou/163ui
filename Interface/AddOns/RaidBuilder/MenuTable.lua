BuildEnv(...)

local function menuDisable(data)
    return UnitLevel('player') < GetEventMinLevel(data.value)
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
                        ['text'] = '决战奥格瑞玛-25人',
                        ['value'] = 0x1B7B200,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '决战奥格瑞玛-10人',
                        ['value'] = 0x1B7B400,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['hasArrow'] = true,
                        ['menuTable'] = {
                            [1] = {
                                ['disabled'] = menuDisable,
                                ['text'] = '弹性-锦绣谷之殇',
                                ['value'] = 0x1B7B601,
                            },
                            [2] = {
                                ['disabled'] = menuDisable,
                                ['text'] = '弹性-复仇之门',
                                ['value'] = 0x1B7B602,
                            },
                            [3] = {
                                ['disabled'] = menuDisable,
                                ['text'] = '弹性-地下堡垒',
                                ['value'] = 0x1B7B604,
                            },
                            [4] = {
                                ['disabled'] = menuDisable,
                                ['text'] = '弹性-暴君的黄昏',
                                ['value'] = 0x1B7B608,
                            },
                        },
                        ['text'] = '决战奥格瑞玛-弹性',
                        ['value'] = 0x1B7B600,
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
                        ['text'] = '世界Boss一波流',
                        ['value'] = 0x1BFFF00,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '熊猫人之迷',
                ['value'] = 0x1B00000,
            },
            [2] = {
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
            [3] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '冰冠堡垒',
                        ['value'] = 0x1DF9F00,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '红玉圣殿',
                        ['value'] = 0x1DFAF00,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '十字军的试炼',
                        ['value'] = 0x1DFBF00,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '奥杜尔',
                        ['value'] = 0x1DFCF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '黑曜石圣殿',
                        ['value'] = 0x1DFDF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '永恒之眼',
                        ['value'] = 0x1DFEF00,
                    },
                    [7] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '阿尔卡冯的宝库',
                        ['value'] = 0x1DFFF00,
                    },
                },
                ['notClickable'] = true,
                ['text'] = '巫妖王之怒',
                ['value'] = 0x1D00000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '团队副本',
        ['value'] = 0x1000000,
    },
    [2] = {
        ['disabled'] = menuDisable,
        ['text'] = '地下城',
        ['value'] = 0x2000000,
    },
    [3] = {
        ['disabled'] = menuDisable,
        ['text'] = '场景战役',
        ['value'] = 0x3000000,
    },
    [4] = {
        ['disabled'] = menuDisable,
        ['hasArrow'] = true,
        ['menuTable'] = {
            [1] = {
                ['disabled'] = menuDisable,
                ['text'] = '2v2',
                ['value'] = 0x4001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '3v3',
                ['value'] = 0x4002000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['text'] = '5v5',
                ['value'] = 0x4003000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['text'] = '评级战场',
                ['value'] = 0x4004000,
            },
            [5] = {
                ['disabled'] = menuDisable,
                ['text'] = '随机战场',
                ['value'] = 0x4005000,
            },
            [6] = {
                ['disabled'] = menuDisable,
                ['text'] = '永恒岛PvP',
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
                        ['text'] = '永恒岛',
                        ['value'] = 0x800C001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['text'] = '雷神岛',
                        ['value'] = 0x800C002,
                    },
                },
                ['text'] = '潘达利亚',
                ['value'] = 0x800C000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['text'] = '诺森德',
                ['value'] = 0x800D000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['text'] = '外域',
                ['value'] = 0x800E000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['text'] = '艾泽拉斯',
                ['value'] = 0x800F000,
            },
        },
        ['notClickable'] = true,
        ['text'] = '任务',
        ['value'] = 0x8000000,
    },
    [6] = {
        ['disabled'] = menuDisable,
        ['text'] = '本周悬赏',
        ['value'] = 0xA000000,
    },
    [7] = {
        ['disabled'] = menuDisable,
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
                        ['text'] = '决战奥格瑞玛-25人',
                        ['value'] = 0x1B7B200,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '决战奥格瑞玛-10人',
                        ['value'] = 0x1B7B400,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['hasArrow'] = true,
                        ['menuTable'] = {
                            [1] = {
                                ['disabled'] = menuDisable,
                                ['notClickable'] = false,
                                ['text'] = '弹性-锦绣谷之殇',
                                ['value'] = 0x1B7B601,
                            },
                            [2] = {
                                ['disabled'] = menuDisable,
                                ['notClickable'] = false,
                                ['text'] = '弹性-复仇之门',
                                ['value'] = 0x1B7B602,
                            },
                            [3] = {
                                ['disabled'] = menuDisable,
                                ['notClickable'] = false,
                                ['text'] = '弹性-地下堡垒',
                                ['value'] = 0x1B7B604,
                            },
                            [4] = {
                                ['disabled'] = menuDisable,
                                ['notClickable'] = false,
                                ['text'] = '弹性-暴君的黄昏',
                                ['value'] = 0x1B7B608,
                            },
                        },
                        ['notClickable'] = false,
                        ['text'] = '决战奥格瑞玛-弹性',
                        ['value'] = 0x1B7B600,
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
                        ['text'] = '世界Boss一波流',
                        ['value'] = 0x1BFFF00,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '熊猫人之迷',
                ['value'] = 0x1B00000,
            },
            [2] = {
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
            [3] = {
                ['disabled'] = menuDisable,
                ['hasArrow'] = true,
                ['menuTable'] = {
                    [1] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '冰冠堡垒',
                        ['value'] = 0x1DF9F00,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '红玉圣殿',
                        ['value'] = 0x1DFAF00,
                    },
                    [3] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '十字军的试炼',
                        ['value'] = 0x1DFBF00,
                    },
                    [4] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '奥杜尔',
                        ['value'] = 0x1DFCF00,
                    },
                    [5] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '黑曜石圣殿',
                        ['value'] = 0x1DFDF00,
                    },
                    [6] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '永恒之眼',
                        ['value'] = 0x1DFEF00,
                    },
                    [7] = {
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
        },
        ['notClickable'] = false,
        ['text'] = '团队副本',
        ['value'] = 0x1000000,
    },
    [3] = {
        ['disabled'] = menuDisable,
        ['notClickable'] = false,
        ['text'] = '地下城',
        ['value'] = 0x2000000,
    },
    [4] = {
        ['disabled'] = menuDisable,
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
                ['notClickable'] = false,
                ['text'] = '2v2',
                ['value'] = 0x4001000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '3v3',
                ['value'] = 0x4002000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '5v5',
                ['value'] = 0x4003000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '评级战场',
                ['value'] = 0x4004000,
            },
            [5] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '随机战场',
                ['value'] = 0x4005000,
            },
            [6] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '永恒岛PvP',
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
                        ['text'] = '永恒岛',
                        ['value'] = 0x800C001,
                    },
                    [2] = {
                        ['disabled'] = menuDisable,
                        ['notClickable'] = false,
                        ['text'] = '雷神岛',
                        ['value'] = 0x800C002,
                    },
                },
                ['notClickable'] = false,
                ['text'] = '潘达利亚',
                ['value'] = 0x800C000,
            },
            [2] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '诺森德',
                ['value'] = 0x800D000,
            },
            [3] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '外域',
                ['value'] = 0x800E000,
            },
            [4] = {
                ['disabled'] = menuDisable,
                ['notClickable'] = false,
                ['text'] = '艾泽拉斯',
                ['value'] = 0x800F000,
            },
        },
        ['notClickable'] = false,
        ['text'] = '任务',
        ['value'] = 0x8000000,
    },
    [7] = {
        ['disabled'] = menuDisable,
        ['notClickable'] = false,
        ['text'] = '本周悬赏',
        ['value'] = 0xA000000,
    },
    [8] = {
        ['disabled'] = menuDisable,
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
            ['value'] = 8,
        },
        [5] = {
            ['text'] = '开荒',
            ['value'] = 4,
        },
    },
    [0x2000000] = {
        [1] = {
            ['text'] = '刷勇气',
            ['value'] = 10,
        },
        [2] = {
            ['text'] = '刷正义',
            ['value'] = 11,
        },
        [3] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
        [4] = {
            ['text'] = '自强',
            ['value'] = 9,
        },
        [5] = {
            ['text'] = '挑战',
            ['value'] = 14,
        },
    },
    [0x3000000] = {
        [1] = {
            ['text'] = '刷勇气',
            ['value'] = 10,
        },
        [2] = {
            ['text'] = '成就',
            ['value'] = 3,
        },
    },
    [0x4000000] = {
        [1] = {
            ['text'] = '刷荣誉',
            ['value'] = 13,
        },
        [2] = {
            ['text'] = '刷征服',
            ['value'] = 12,
        },
        [3] = {
            ['text'] = '冲分',
            ['value'] = 15,
        },
        [4] = {
            ['text'] = '混分',
            ['value'] = 16,
        },
    },
    [0x8000000] = {
        [1] = {
            ['text'] = '练级',
            ['value'] = 17,
        },
        [2] = {
            ['text'] = '声望',
            ['value'] = 18,
        },
        [3] = {
            ['text'] = '任务',
            ['value'] = 19,
        },
    },
    [0xA000000] = {
        [1] = {
            ['text'] = '其它',
            ['value'] = 7,
        },
    },
    [0xF000000] = {
        [1] = {
            ['text'] = '其它',
            ['value'] = 7,
        },
    },
}