--[[ Credit for these translations goes to:
	lsjyzjl
	wowuicn
--]]
local L = LibStub("AceLocale-3.0"):NewLocale("TellMeWhen", "zhCN", false)
if not L then return end


L["ABSORBAMT"] = "护盾吸收量"
L["ABSORBAMT_DESC"] = "检测单位上的护盾的吸收总量."
L["ACTIVE"] = "%d 作用中"
L["AIR"] = "空气图腾"
L["ALLOWCOMM"] = "允许图标导入"
L["ALLOWCOMM_DESC"] = "允许另一个TellMeWhen使用者给你发送数据."
L["ALLOWVERSIONWARN"] = "新版本通知"
L["ALPHA"] = "透明度"
L["ALWAYSSUBLINKS"] = "总是替换为链接"
L["ALWAYSSUBLINKS_DESC"] = "默认情况下,法术/物品只会在文字输出事件时被替换为链接,勾选此设置将使所有的法术/物品被替换成链接,包括图标的绑定/标签文字."
L["ANCHORTO"] = "附着框架"
L["ANIM_ACTVTNGLOW"] = "图标:激活边框"
L["ANIM_ACTVTNGLOW_DESC"] = "在图标上显示暴雪的法术激活边框."
L["ANIM_ALPHASTANDALONE"] = "透明度"
L["ANIM_ALPHASTANDALONE_DESC"] = "设置动画的最大不透明度"
L["ANIM_ANCHOR_NOT_FOUND"] = "动画无法附着到框架%q. 当前图标是否没有使用到这个框架?"
L["ANIM_ANIMSETTINGS"] = "设置"
L["ANIM_ANIMTOUSE"] = "使用的动画效果"
L["ANIM_COLOR"] = "颜色/不透明度"
L["ANIM_COLOR_DESC"] = "设置闪光的颜色和不透明度."
L["ANIM_DURATION"] = "动画持续时间"
L["ANIM_DURATION_DESC"] = "设置动画触发后持续显示多久."
L["ANIM_FADE"] = "淡入淡出闪光"
L["ANIM_FADE_DESC"] = [=[勾选此项使每个闪光之间平滑的淡入淡出.不勾选则直接闪光.

(译者注:具体的差别请自行进行区分,我测试的效果除了第一次闪光之外,后面的闪光区别并不明显.)]=]
L["ANIM_ICONALPHAFLASH"] = "图标:透明度闪烁"
L["ANIM_ICONALPHAFLASH_DESC"] = "通过改变图标的不透明度达到闪烁提示的效果."
L["ANIM_ICONBORDER"] = "图标:边框"
L["ANIM_ICONBORDER_DESC"] = "在图标上生成一个有颜色的边框."
L["ANIM_ICONCLEAR"] = "图标:停止动画"
L["ANIM_ICONCLEAR_DESC"] = "停止当前图标播放的所有动画效果."
L["ANIM_ICONFADE"] = "图标:淡入/淡出"
L["ANIM_ICONFADE_DESC"] = "在选定的事件发生时透明度将会渐变."
L["ANIM_ICONFLASH"] = "图标:颜色闪烁"
L["ANIM_ICONFLASH_DESC"] = "利用颜色重叠在整个图标上闪烁,达到提示的效果."
L["ANIM_ICONOVERLAYIMG"] = "图标:图像重叠"
L["ANIM_ICONOVERLAYIMG_DESC"] = "在图标上重叠显示自定义图像."
L["ANIM_ICONSHAKE"] = "图标:抖动"
L["ANIM_ICONSHAKE_DESC"] = "在事件触发时抖动图标."
L["ANIM_INFINITE"] = "无限重复播放"
L["ANIM_INFINITE_DESC"] = [=[勾选此项将会重复播放动画直到同个图标上另一相同类型的动画开始播放,或是在'%q'触发之后才会停止.

说明:比如在事件'开始'中设置了'图标:颜色闪烁',并且勾上了'无限重复播放',在事件'结束'设置了'图标:颜色闪烁'(持续时间3秒),事件'开始'中的'无限重复播放'就会在事件'结束'的动画播放结束后停止. 假如在同一个图标中没有设置相同类型的动画那就只能在'图标:停止动画'触发之后才会停止播放.如果还是不明白,就这样理解,同个图标中相同类型的动画只会存在一个,后面触发的会覆盖掉前面触发的.]=]
L["ANIM_MAGNITUDE"] = "抖动幅度"
L["ANIM_MAGNITUDE_DESC"] = "设置抖动的幅度需要多猛烈."
L["ANIM_PERIOD"] = "闪光周期"
L["ANIM_PERIOD_DESC"] = [=[设置每次闪烁应当持续多久 - 闪烁的显示时间或消退时间.

如果设置为0则不会闪烁和淡出.]=]
L["ANIM_PIXELS"] = "%s像素"
L["ANIM_SCREENFLASH"] = "屏幕:闪烁"
L["ANIM_SCREENFLASH_DESC"] = "利用颜色重叠在整个游戏屏幕上闪烁,达到提示的效果."
L["ANIM_SCREENSHAKE"] = "屏幕:抖动"
L["ANIM_SCREENSHAKE_DESC"] = [=[在事件触发时抖动整个游戏屏幕.

注意:屏幕抖动只能在离开战斗后使用,或者在你登陆之后没有启用姓名版的情况下使用.

(第一点啰嗦的解释:如果你在登陆之后按下显示姓名板的快捷键或者姓名板原本就已经启用了,就无法在战斗中使用屏幕抖动,如果你需要在战斗中使用请继续往下看.

第二点啰嗦的解释:如果一定要在战斗中使用屏幕抖动请先关闭在‘ESC->界面->名字’中有关显示单位姓名板的选项,然后小退,登陆之后切记不可以按到任何显示姓名板的快捷键.）]=]
L["ANIM_SECONDS"] = "%s秒"
L["ANIM_SIZE_ANIM"] = "边框大小"
L["ANIM_SIZE_ANIM_DESC"] = "设置边框的尺寸大小为多少."
L["ANIM_SIZEX"] = "图像宽度"
L["ANIM_SIZEX_DESC"] = "设置图像的宽度为多少."
L["ANIM_SIZEY"] = "图像高度"
L["ANIM_SIZEY_DESC"] = "设置图像的高度为多少."
L["ANIM_TAB"] = "动画"
L["ANIM_TEX"] = "材质"
L["ANIM_TEX_DESC"] = [=[选择你要用来覆盖图标的材质.

你可以输入一个材质路径, 例如'Interface/Icons/spell_nature_healingtouch', 假如材质路径为'Interface/Icons'可以只输入'spell_nature_healingtouch'.

你也能使用放在WoW目录中的自定义材质(请在该字段输入材质的相对路径,像是'tmw/ccc.tga'),仅支持尺寸为2的N次方(32, 64, 128,等)并且类型为.tga和.blp的材质文件.]=]
L["ANIM_THICKNESS"] = "边框粗细"
L["ANIM_THICKNESS_DESC"] = "设置边框的粗细为多少.(一个图标的默认尺寸为30)"
L["ANN_CHANTOUSE"] = "使用频道"
L["ANN_EDITBOX"] = "要输出的文字内容"
L["ANN_EDITBOX_DESC"] = "输入事件触发时你想输出的文字内容."
L["ANN_EDITBOX_WARN"] = "在此输入你想要输出的文字内容"
L["ANN_EVENT_GLOBALDESC"] = "在此列表中的事件是按照从上到下的顺序来检测.如果一个事件触发并且输出了文字内容,在它之后的事件将不再输出任何文字内容."
L["ANN_FCT_DESC"] = [=[使用暴雪的浮动战斗文字功能输出.必须先启用界面选项中的文字输出.
]=]
L["ANN_NOTEXT"] = "<无文字>"
L["ANN_SHOWICON"] = "显示图标材质"
L["ANN_SHOWICON_DESC"] = "一些文本目标能随文字内容一起显示一个材质.勾选此项启用该功能."
L["ANN_STICKY"] = "静态模式"
L["ANN_SUB_CHANNEL"] = "输出位置"
L["ANN_TAB"] = "文字"
L["ANN_WHISPERTARGET"] = "悄悄话目标"
L["ANN_WHISPERTARGET_DESC"] = "输入你想要密语的玩家名字,仅可密语同服务器/同阵营的玩家."
L["ASCENDING"] = "升序"
L["ASPECT"] = "守护"
L["AURA"] = "光环"
L["BACK_IE"] = "转到上一个"
L["BACK_IE_DESC"] = [=[载入上一个编辑过的图标

%s |T%s:0|t]=]
L["Bleeding"] = "流血效果"
L["BonusStamina"] = "耐力提高"
L["BOTTOM"] = "下"
L["BOTTOMLEFT"] = "左下"
L["BOTTOMRIGHT"] = "右下"
L["BUFFCNDT_DESC"] = "只有第一个法术会被检测,其他的将全部被忽略."
L["BUFFTOCHECK"] = "要检测的增益"
L["BUFFTOCOMP1"] = "进行比较的第一个增益"
L["BUFFTOCOMP2"] = "进行比较的第二个增益"
L["BURNING_EMBERS_FRAGMENTS"] = "燃烧余烬碎片"
L["BURNING_EMBERS_FRAGMENTS_DESC"] = [=[一个完整的燃烧余烬由十个碎片所组成.

假如你有一个半的燃烧余烬(由十五个余烬碎片组成),你要监视全部的余烬碎片时,可能需要使用此条件.]=]
L["BurstManaRegen"] = "突发性法力恢复"
L["CACHING"] = [=[TellMeWhen正在缓存和筛选游戏中的所有法术.
这只需要在每次魔兽世界补丁升级之后完成一次.您可以使用下方的滑杆加快或减慢过程.]=]
L["CACHINGSPEED"] = "法术缓存速度(每帧法术):"
L["CASTERFORM"] = "施法者形态"
L["CENTER"] = "居中"
L["CHAT_FRAME"] = "聊天窗口"
L["CHAT_MSG_CHANNEL"] = "聊天频道"
L["CHAT_MSG_CHANNEL_DESC"] = "将输出到一个聊天频道,例如交易频道或是你加入的某个自定义频道."
L["CHAT_MSG_SMART"] = "智能频道"
L["CHAT_MSG_SMART_DESC"] = "此频道会自行选择最合适的输出频道.(仅限于:战场,团队,队伍,或说)"
L["CHECKORDER"] = "更新排列"
L["CHECKORDER_GROUPDESC"] = "更改此项将会按照设置来更新此分组的排序.只会在你需要使用检测 整合图标 的子元时用到.(子元指添加到整合图标列表中的整合图标)"
L["CHECKORDER_ICONDESC"] = "勾选此项将会按照设置来更新此分组中的图标的排序.只会在你需要使用检测 整合图标 的子元时用到.(子元指添加到整合图标列表中的整合图标)"
L["CHOOSEICON"] = "选择一个用于检测的图标"
L["CHOOSEICON_DESC"] = [=[|cff7fffff点击|r选择一个图标/分组.
|cff7fffff左键点击并拖放|r以滚动方式改变顺序.
|cff7fffff右键点击并拖放|r以常用方式改变顺序.

译者注:如果分不清楚区别请直接使用常用方式.]=]
L["CHOOSENAME_DIALOG"] = [=[输入你想让此图标监视的名称或ID.你可以利用';'(分号)输入多个条目(名称/ID/同类型的任意组合).

你可以|cff7fffff按住Shift再按鼠标左键点选|r法术/物品/聊天连结或者拖曳法术/物品添加到此编辑框中.]=]
L["CHOOSENAME_DIALOG_DDDEFAULT"] = "预定义的法术设置"
L["CHOOSENAME_DIALOG_MSCD"] = "输入你要此图标监视的名称或者ID,仅第一个法术/物品会被检测,使用分号分隔的列表不适用此图标类型."
L["CHOOSENAME_DIALOG_PETABILITIES"] = "|cFFFF5959宠物技能|r必须使用法术ID."
L["CLEU_"] = "任意事件"
L["CLEU_CAT_AURA"] = "增益/减益"
L["CLEU_CAT_CAST"] = "施法"
L["CLEU_CAT_MISC"] = "其他"
L["CLEU_CAT_SPELL"] = "法术"
L["CLEU_CAT_SWING"] = "近战/远程"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MASK"] = "操控者关系"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MINE"] = "操控者关系:玩家(你)"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MINE_DESC"] = "勾选以排除那些你控制的单位."
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_OUTSIDER"] = "操控者关系:外人"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_OUTSIDER_DESC"] = "勾选以排除那些与你同组的某人控制的单位."
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_PARTY"] = "操控者关系:队伍成员"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_PARTY_DESC"] = "勾选以排除那些你队伍中的玩家控制的单位."
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID"] = "操控者关系:团队成员"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID_DESC"] = "勾选以排除那些你团队中的玩家控制的单位."
L["CLEU_COMBATLOG_OBJECT_CONTROL_MASK"] = "操控者"
L["CLEU_COMBATLOG_OBJECT_CONTROL_NPC"] = "操控者:服务器"
L["CLEU_COMBATLOG_OBJECT_CONTROL_NPC_DESC"] = "勾选以排除那些服务器控制的单位(包括它们的宠物跟守卫)."
L["CLEU_COMBATLOG_OBJECT_CONTROL_PLAYER"] = "操控者:人类"
L["CLEU_COMBATLOG_OBJECT_CONTROL_PLAYER_DESC"] = "勾选以排除那些人类控制的单位(包括他们的宠物跟守卫),这里是指真正的人类,不是游戏中的人类种族,如果你教会了猴子/猩猩玩魔兽世界的话,可以加上它们."
L["CLEU_COMBATLOG_OBJECT_FOCUS"] = "其他:你的焦点目标"
L["CLEU_COMBATLOG_OBJECT_FOCUS_DESC"] = "勾选以排除那个你设置为焦点目标的单位."
L["CLEU_COMBATLOG_OBJECT_MAINASSIST"] = "其他:主助攻"
L["CLEU_COMBATLOG_OBJECT_MAINASSIST_DESC"] = "勾选以排除团队中被标记为主助攻的单位."
L["CLEU_COMBATLOG_OBJECT_MAINTANK"] = "其他:主坦克"
L["CLEU_COMBATLOG_OBJECT_MAINTANK_DESC"] = "勾选以排除团队中被标记为主坦克的单位."
L["CLEU_COMBATLOG_OBJECT_NONE"] = "其他:未知单位"
L["CLEU_COMBATLOG_OBJECT_NONE_DESC"] = "勾选以排除WoW客户端完全未知的单位.此情况很少出现,通常可以不勾选."
L["CLEU_COMBATLOG_OBJECT_REACTION_FRIENDLY"] = "单位反应:友好"
L["CLEU_COMBATLOG_OBJECT_REACTION_FRIENDLY_DESC"] = "勾选以排除那些对你反应是友好的单位."
L["CLEU_COMBATLOG_OBJECT_REACTION_HOSTILE"] = "单位反应:敌对"
L["CLEU_COMBATLOG_OBJECT_REACTION_HOSTILE_DESC"] = "勾选以排除那些对你反应是敌对的单位."
L["CLEU_COMBATLOG_OBJECT_REACTION_MASK"] = "单位反应"
L["CLEU_COMBATLOG_OBJECT_REACTION_NEUTRAL"] = "单位反应:中立"
L["CLEU_COMBATLOG_OBJECT_REACTION_NEUTRAL_DESC"] = "勾选以排除那些对你反应是中立的单位."
L["CLEU_COMBATLOG_OBJECT_TARGET"] = "其他:你的目标"
L["CLEU_COMBATLOG_OBJECT_TARGET_DESC"] = "勾选以排除你当前的目标单位."
L["CLEU_COMBATLOG_OBJECT_TYPE_GUARDIAN"] = "单位类型:守卫"
L["CLEU_COMBATLOG_OBJECT_TYPE_GUARDIAN_DESC"] = "勾选以排除守卫. 守卫是指那些会保护操控者但是不能直接被控制的单位."
L["CLEU_COMBATLOG_OBJECT_TYPE_MASK"] = "单位类型"
L["CLEU_COMBATLOG_OBJECT_TYPE_NPC"] = "单位类型:NPC"
L["CLEU_COMBATLOG_OBJECT_TYPE_NPC_DESC"] = "勾选以排除非玩家角色."
L["CLEU_COMBATLOG_OBJECT_TYPE_OBJECT"] = "单位类型:对象"
L["CLEU_COMBATLOG_OBJECT_TYPE_OBJECT_DESC"] = "勾选以排除像是陷阱,鱼点等其他没有被划分到\"单位类型\"中的其他任何东西."
L["CLEU_COMBATLOG_OBJECT_TYPE_PET"] = "单位类型:宠物"
L["CLEU_COMBATLOG_OBJECT_TYPE_PET_DESC"] = "勾选以排除宠物. 宠物是指那些会保护操控者并且可以直接被控制的单位."
L["CLEU_COMBATLOG_OBJECT_TYPE_PLAYER"] = "单位类型:玩家角色"
L["CLEU_COMBATLOG_OBJECT_TYPE_PLAYER_DESC"] = "勾选以排除玩家角色."
L["CLEU_DAMAGE_SHIELD"] = "伤害护盾"
L["CLEU_DAMAGE_SHIELD_DESC"] = "此事件在伤害护盾对一个单位造成伤害时发生. (%s,%s,等等,但是不包括%s)"
L["CLEU_DAMAGE_SHIELD_MISSED"] = "伤害护盾未命中"
L["CLEU_DAMAGE_SHIELD_MISSED_DESC"] = "此事件在伤害护盾对一个单位造成伤害失败时发生. (%s,%s,等等,但是不包括%s)"
L["CLEU_DAMAGE_SPLIT"] = "伤害分担"
L["CLEU_DAMAGE_SPLIT_DESC"] = "此事件在伤害被两个或者更多个单位分担时发生."
L["CLEU_DESTUNITS"] = "用于检测的目标单位"
L["CLEU_DESTUNITS_DESC"] = "选择你想要图标检测的事件目标单位,可以保留空白让图标检测任意的事件目标单位."
L["CLEU_DIED"] = "死亡"
L["CLEU_ENCHANT_APPLIED"] = "附魔应用"
L["CLEU_ENCHANT_APPLIED_DESC"] = "此事件所指为暂时性武器附魔,像是潜行者的毒药和萨满的武器强化."
L["CLEU_ENCHANT_REMOVED"] = "附魔消失"
L["CLEU_ENCHANT_REMOVED_DESC"] = "此事件所指为暂时性武器附魔,像是潜行者的毒药和萨满的武器强化."
L["CLEU_ENVIRONMENTAL_DAMAGE"] = "环境伤害"
L["CLEU_ENVIRONMENTAL_DAMAGE_DESC"] = "包括来自熔岩、掉落、溺水以及疲劳的伤害."
L["CLEU_EVENTS"] = "用于检测的事件"
L["CLEU_EVENTS_ALL"] = "全部事件"
L["CLEU_EVENTS_DESC"] = "选择那些你想要图标检测的战斗事件."
L["CLEU_FLAGS_DESC"] = "可以排除列表中包含的某种属性的单位使其无法触发图标.如果勾选排除某种属性的单位,图标将不会处理那个单位相关的事件."
L["CLEU_FLAGS_DEST"] = "排除"
L["CLEU_FLAGS_SOURCE"] = "排除"
L["CLEU_HEADER"] = "战斗事件过滤"
L["CLEU_NOFILTERS"] = "%s图标在%s没有定义任何过滤条件.你需要定义至少一个过滤条件,否则无法正常使用."
L["CLEU_PARTY_KILL"] = "队伍击杀"
L["CLEU_PARTY_KILL_DESC"] = "当队伍中的某人击杀某怪物时触发."
L["CLEU_RANGE_DAMAGE"] = "远程攻击伤害"
L["CLEU_RANGE_MISSED"] = "远程攻击未命中"
L["CLEU_SOURCEUNITS"] = "用于检测的来源单位"
L["CLEU_SOURCEUNITS_DESC"] = "选择你想要图标检测的事件来源单位,可以保留空白让图标检测任意的事件来源单位."
L["CLEU_SPELL_AURA_APPLIED"] = "效果获得(指目标单位获得某增益/减益,来源单位为施放者)"
L["CLEU_SPELL_AURA_APPLIED_DOSE"] = "效果叠加"
L["CLEU_SPELL_AURA_BROKEN"] = "效果被打破(物理)"
L["CLEU_SPELL_AURA_BROKEN_SPELL"] = "效果被打破(法术)"
L["CLEU_SPELL_AURA_BROKEN_SPELL_DESC"] = [=[此事件在一个效果被法术伤害打破时发生(通常是指某种控场技能).

图标会筛选出被打破的效果;在文字输出/显示时你可以使用标签[Extra]替代这个效果.]=]
L["CLEU_SPELL_AURA_REFRESH"] = "效果刷新"
L["CLEU_SPELL_AURA_REMOVED"] = "效果移除"
L["CLEU_SPELL_AURA_REMOVED_DOSE"] = "效果叠加移除"
L["CLEU_SPELL_CAST_FAILED"] = "施法失败"
L["CLEU_SPELL_CAST_START"] = "开始施法"
L["CLEU_SPELL_CAST_START_DESC"] = [=[此事件在开始施放一个法术时发生.

注意:为了防止可能出现的游戏框架滥用,暴雪禁用了此事件的目标单位,所以你不能过滤它们.]=]
L["CLEU_SPELL_CAST_SUCCESS"] = "法术施放成功"
L["CLEU_SPELL_CAST_SUCCESS_DESC"] = "此事件在法术施放成功时发生."
L["CLEU_SPELL_CREATE"] = "法术制造"
L["CLEU_SPELL_CREATE_DESC"] = "此事件在一个对像被制造时发生,例如猎人的陷阱跟法师的传送门."
L["CLEU_SPELL_DAMAGE"] = "法术伤害"
L["CLEU_SPELL_DAMAGE_CRIT"] = "法术暴击"
L["CLEU_SPELL_DAMAGE_CRIT_DESC"] = "此事件在任意法术造成暴击时发生(可能会在同一时间触发%q事件)."
L["CLEU_SPELL_DAMAGE_DESC"] = "此事件在任意法术造成伤害时发生."
L["CLEU_SPELL_DISPEL"] = "驱散"
L["CLEU_SPELL_DISPEL_DESC"] = [=[此事件在一个效果被驱散时发生.

图标会筛选出被驱散的效果;在文字输出/显示时你可以使用标签[Extra]替代这个效果.]=]
L["CLEU_SPELL_DISPEL_FAILED"] = "驱散失败"
L["CLEU_SPELL_DISPEL_FAILED_DESC"] = [=[此事件在驱散某一效果失败时发生.

图标会筛选出这个驱散失败的效果;在文字输出/显示时你可以使用标签[Extra]替代这个效果.]=]
L["CLEU_SPELL_DRAIN"] = "抽取资源"
L["CLEU_SPELL_DRAIN_DESC"] = "此事件在资源从某个单位移除时发生(资源指生命值/魔法值/怒气/能量等)."
L["CLEU_SPELL_ENERGIZE"] = "获得资源"
L["CLEU_SPELL_ENERGIZE_DESC"] = "此事件在一个单位获得资源时发生(资源指生命值/魔法值/怒气/能量等)."
L["CLEU_SPELL_EXTRA_ATTACKS"] = "获得额外攻击"
L["CLEU_SPELL_EXTRA_ATTACKS_DESC"] = "此事件在你获得额外的近战攻击时发生."
L["CLEU_SPELL_HEAL"] = "治疗"
L["CLEU_SPELL_INSTAKILL"] = "秒杀"
L["CLEU_SPELL_INTERRUPT"] = "打断 - 被打断的法术"
L["CLEU_SPELL_INTERRUPT_DESC"] = [=[此事件在施法被打断时发生.

图标会筛选出被打断施法的法术;在文字输出/显示时你可以使用标签[Extra]替代这个法术.

请注意两个打断事件的区别 - 当一个法术被打断时两个事件都会发生,但是筛选出的法术会有所不同.]=]
L["CLEU_SPELL_INTERRUPT_SPELL"] = "打断 - 造成打断的法术"
L["CLEU_SPELL_INTERRUPT_SPELL_DESC"] = [=[此事件在施法被打断时发生.

图标会筛选出造成打断施法的法术;在文字输出/显示时你可以使用标签[Extra]替代这个法术.

请注意两个打断事件的区别 - 当一个法术被打断时两个事件都会发生,但是筛选出的法术会有所不同.]=]
L["CLEU_SPELL_LEECH"] = "资源吸取"
L["CLEU_SPELL_LEECH_DESC"] = "此事件在从某个单位移除资源给另一单位时发生(资源指生命值/魔法值/怒气/能量等)."
L["CLEU_SPELL_MISSED"] = "法术未命中"
L["CLEU_SPELL_PERIODIC_DAMAGE"] = "伤害(持续性)"
L["CLEU_SPELL_PERIODIC_DRAIN"] = "抽取资源(持续性)"
L["CLEU_SPELL_PERIODIC_ENERGIZE"] = "获得资源(持续性)"
L["CLEU_SPELL_PERIODIC_HEAL"] = "治疗(持续性)"
L["CLEU_SPELL_PERIODIC_LEECH"] = "资源吸取(持续性)"
L["CLEU_SPELL_PERIODIC_MISSED"] = "伤害(持续性)未命中"
L["CLEU_SPELL_REFLECT"] = "法术反射"
L["CLEU_SPELL_REFLECT_DESC"] = [=[此事件在你反射一个对你施放的法术时发生.

来源单位是反射法术者,目标单位是法术被反射的施法者.]=]
L["CLEU_SPELL_RESURRECT"] = "复活"
L["CLEU_SPELL_RESURRECT_DESC"] = "此事件在某个单位从死亡中复活时发生."
L["CLEU_SPELL_STOLEN"] = "效果被偷取"
L["CLEU_SPELL_STOLEN_DESC"] = [=[此事件在增益被偷取时发生,很可能来自%s.

图标会筛选出那个被偷取的法术.]=]
L["CLEU_SPELL_SUMMON"] = "法术召唤"
L["CLEU_SPELL_SUMMON_DESC"] = "此事件在一个NPC被召唤或者生成时发生."
L["CLEU_SWING_DAMAGE"] = "近战攻击伤害"
L["CLEU_SWING_MISSED"] = "近战攻击未命中"
L["CLEU_TIMER"] = "设置事件的计时器"
L["CLEU_TIMER_DESC"] = [=[设置图标计时器在事件发生时的持续时间.

你也可以在%q编辑框中使用"法术:持续时间"语法设置一个持续时间,在事件处理你所筛选出的那些法术时使用.

如果法术没有指定持续时间,或者你没有筛选过滤任何法术(编辑框为空白),那将使用这个持续时间.]=]
L["CLEU_UNIT_DESTROYED"] = "单位被摧毁"
L["CLEU_UNIT_DESTROYED_DESC"] = "此事件在一个单位被摧毁时发生(比如萨满的图腾)."
L["CLEU_UNIT_DIED"] = "单位死亡"
L["CLEU_WHOLECATEGORYEXCLUDED"] = [=[你排除了%q分类中的所有条目,这将导致图标不再处理任何事件.

取消勾选至少一个条目使图标可以正常运作.]=]
L["CMD_DISABLE"] = "禁用"
L["CMD_ENABLE"] = "启用"
L["CMD_OPTIONS"] = "选项"
L["CMD_PROFILE"] = "配置文件"
L["CMD_PROFILE_INVALIDPROFILE"] = "无法找到名为 %q 的配置文件! (译者注:注意区分大小写)"
L["CMD_PROFILE_INVALIDPROFILE_SPACES"] = [=[提示: 如果配置文件名称包含空格,请在前后加上英文的引号. 

例如:
/tmw profile "打打 - 索拉丁"
或
/tmw 配置文件 "百战好哥哥 - 索拉丁"]=]
L["CMD_TOGGLE"] = "切换"
L["CNDTCAT_ARCHFRAGS"] = "考古学碎片"
L["CNDTCAT_ATTRIBUTES_PLAYER"] = "玩家属性/状态"
L["CNDTCAT_ATTRIBUTES_UNIT"] = "单位属性/状态"
L["CNDTCAT_BUFFSDEBUFFS"] = "增益/减益"
L["CNDTCAT_CURRENCIES"] = "货币"
L["CNDTCAT_FREQUENTLYUSED"] = "常用条件"
L["CNDTCAT_MISC"] = "其他"
L["CNDTCAT_RESOURCES"] = "能量类型"
L["CNDTCAT_SPELLSABILITIES"] = "法术/物品"
L["CNDTCAT_STATS"] = "战斗统计(人物属性)"
L["CNDT_ONLYFIRST"] = "仅第一个法术/物品会被检测,使用分号分隔的列表不适用此条件类型."
L["CNDT_SLIDER_DESC_CLICKSWAP_TOMANUAL"] = "|cff7fffff点击鼠标右键|r切换到手动输入模式。"
L["CNDT_SLIDER_DESC_CLICKSWAP_TOSLIDER"] = "|cff7fffff点击鼠标右键|r切换到滚动条选择模式。"
L["CNDT_SLIDER_DESC_CLICKSWAP_TOSLIDER_DISALLOWED"] = "仅允许在手动输入时输入大于%s的数值。 (较大的数值显示在暴雪滚动条会变得很奇怪)"
L["CNDT_TOTEMNAME"] = "图腾名称"
L["CNDT_TOTEMNAME_DESC"] = [=[设置为空白将检测所选类型的任意图腾.

你可以输入一个图腾名称,或者一个使用分号分隔开的名称列表,只用来检测某几个特定的图腾.]=]
L["CODESNIPPET_ADD"] = "创建新片段"
L["CODESNIPPET_CODE"] = "用于执行的Lua代码"
L["CODESNIPPET_CODE_DESC"] = "片段中编写的Lua代码在TellMeWhen加载时会自动执行."
L["CODESNIPPET_DELETE"] = "删除片段"
L["CODESNIPPET_DELETE_CONFIRM"] = "你确定要删除代码片段(%q)?"
L["CODESNIPPET_DELETE_DESC"] = [=[点击删除此代码片段.

按住|cff7fffffCtrl|r跳过确认.]=]
L["CODESNIPPET_GLOBAL"] = "共用片段"
L["CODESNIPPET_ORDER"] = "执行顺序"
L["CODESNIPPET_ORDER_DESC"] = [=[设置此代码片段的执行顺序(相对于其他的片段而言).

%s和%s都将基于这个数值来执行.

如果两个片段使用了相同的顺序,无法确认谁先执行的时候,可以使用小数.]=]
L["CODESNIPPET_PROFILE"] = "角色专用片段"
L["CODESNIPPET_RENAME"] = "代码片段名称"
L["CODESNIPPET_RENAME_DESC"] = [=[为这个片段输入一个自己容易识别的名称.

名称不是唯一,允许重复使用.]=]
L["CODESNIPPET_RUNNOW"] = "执行片段"
L["CODESNIPPET_RUNNOW_CONFIRM"] = [=[你确定需要再次执行%s?

(它在进程中已经执行过至少一次)

你可以在点击鼠标时按住|cff7fffffCtrl|r跳过%s按键的确认.]=]
L["CODESNIPPET_RUNNOW_DESC"] = [=[点击执行此代码片段.

按住|cff7fffffCtrl|r跳过片段已经执行的确认.]=]
L["CODESNIPPETS"] = "Lua代码片段"
L["CODESNIPPETS_DEFAULTNAME"] = "新片段"
L["CODESNIPPETS_DESC"] = [=[此功能允许你编写Lua代码并在TellMeWhen加载时执行.

它是一个高级功能,可以让Lua熟练工如鱼得水,也可以让完全不懂Lua的人导入其他TellMeWhen使用者分享出来的片段.

可用在像是编写一个特定的过程用于Lua条件中(必须把它们定义在TMW.CNDT.Env).

片段可被定义为角色专用或公用(共用片段会在所有角色执行).]=]
L["CODESNIPPETS_IMPORT_GLOBAL"] = "新的共用片段"
L["CODESNIPPETS_IMPORT_GLOBAL_DESC"] = "片段导入为共用片段."
L["CODESNIPPETS_IMPORT_PROFILE"] = "新的角色专用片段"
L["CODESNIPPETS_IMPORT_PROFILE_DESC"] = "片段导入为角色专用片段."
L["CODESNIPPETS_TITLE"] = "Lua片段(高玩级)"
L["CODETOEXE"] = "要执行的代码"
L["COLOR_CBC"] = "冷却条 - 完成"
L["COLOR_CBC_DESC"] = "冷却/持续时间计量条在冷却/持续时间已完成时的颜色"
L["COLOR_CBM"] = "冷却条 - 过半"
L["COLOR_CBM_DESC"] = "重叠式计量条在冷却、持续时间过半时的颜色。（此选项所指的是在图标中上下两个部分所显示的计量条）"
L["COLOR_CBS"] = "冷却条 - 开始"
L["COLOR_CBS_DESC"] = "冷却/持续时间计量条在冷却/持续时间刚开始时的颜色"
L["COLOR_COA"] = "倒数中,计时器隐藏,一直显示"
L["COLOR_COA_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已禁用
同时%q已勾选]=]
L["COLOR_COLOR"] = "颜色"
L["COLOR_COS"] = "倒数中,计时器隐藏,有时显示"
L["COLOR_COS_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已禁用
%q两个选项中仅勾选了一个]=]
L["COLOR_CTA"] = "倒数中,计时器显示,一直显示"
L["COLOR_CTA_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已启用
同时%q已勾选]=]
L["COLOR_CTS"] = "倒数中,计时器显示,有时显示"
L["COLOR_CTS_DESC"] = [=[图标在何时着色:

计时器被激活(不可用/存在时),
%q已启用
%q两个选项中仅勾选了一个]=]
L["COLOR_DEFAULT"] = "*全局颜色*"
L["COLOR_DESATURATE"] = "灰色调"
L["COLOR_DESATURATE_DESC"] = "勾选此项图标中相应的颜色将使用灰色调.(注意:需要先勾选颜色类型的'使用'选项)"
L["COLOR_HEADER"] = [=[下列这些颜色设置将使用在所有 %s 的图标上,在它们的选项 %q 已勾选的情况下.

纯白色不会对材质造成任何改变. 纯黑色会使材质完全变黑.所有介于黑白两者之间的灰色调及其他颜色全部都会对图标进行着色.]=]
L["COLOR_HEADER_DEFAULT"] = [=[在图标类型没有单独使用颜色设置的时候将使用这些颜色设置.

纯白色不会对材质造成任何改变. 纯黑色会使材质完全变黑.所有介于黑白两者之间的灰色调及其他颜色全部都会对图标进行着色.]=]
L["COLOR_IGNORE_GCD"] = "颜色忽略公共冷却"
L["COLOR_IGNORE_GCD_DESC"] = "勾选此项可以防止因公共冷却造成的图标颜色改变."
L["COLOR_MSQ_COLOR"] = "使用Masque边框颜色(整个图标)"
L["COLOR_MSQ_COLOR_DESC"] = "勾选此项将使用Masque皮肤中设置的边框颜色对图标着色(假如你在皮肤设置中有使用边框的话)."
L["COLOR_MSQ_ONLY"] = "使用Masque边框颜色(仅边框)"
L["COLOR_MSQ_ONLY_DESC"] = "勾选此项将仅对图标边框使用Masque皮肤中设置的边框颜色进行着色(假如你在皮肤设置中有使用边框的话).图标不会被着色."
L["COLOR_NA"] = "已结束,一直显示"
L["COLOR_NA_DESC"] = [=[图标在何时着色:

计时器已结束(可用/缺少时)
同时%q已勾选]=]
L["COLORNAMES"] = "名字使用职业颜色"
L["COLORNAMES_DESC"] = "检测并尝试给文字中显示的单位名字着色(绑定/标签文字和文字输出事件)."
L["COLOR_NS"] = "已结束,有时显示"
L["COLOR_NS_DESC"] = [=[图标在何时着色:

计时器已结束(可用/缺少时)
%q两个选项中仅勾选了一个]=]
L["COLOR_OOM"] = "魔法值不足"
L["COLOR_OOM_DESC"] = "当你缺少施放技能所需能量时图标的颜色."
L["COLOR_OOR"] = "超出距离"
L["COLOR_OOR_DESC"] = "当你不在技能范围内时图标的颜色."
L["COLOR_OORM"] = "超出距离又魔法值不足"
L["COLOR_OORM_DESC"] = "当你缺少施放技能所需的能量 同时 不在技能范围内时图标的颜色."
L["COLOR_OVERRIDEDEFAULT"] = "使用"
L["COLOR_OVERRIDEDEFAULT_DESC"] = "勾选此项将使用该设置替代*全局颜色*."
L["COLOR_RESET_DESC"] = "重置设置到默认值"
L["COMPARISON"] = "比较"
L["CONDITIONALPHA"] = "持续时间/叠加/条件未通过时"
L["CONDITIONALPHA_CONDITIONICON"] = "持续时间未通过时"
L["CONDITIONALPHA_CONDITIONICON_DESC"] = "该透明度设置用于持续时间的要求无法得到满足时.如果在另外两个透明度的设置下图标已经隐藏,此选项将被忽略."
L["CONDITIONALPHA_DESC"] = "该设置使用在条件未通过或持续时间/叠加数量无法得到满足时.如果在另外两个透明度的设置下图标已经隐藏,此选项将被忽略."
L["CONDITIONALPHA_METAICON"] = "条件未通过时"
L["CONDITIONALPHA_METAICON_DESC"] = [=[该透明度用于条件未通过时.

条件可在%q选项卡中设置.]=]
L["CONDITIONORMETA_CHECKINGINVALID"] = "警告!分组%d,图标%d正在检测一个无效的图标(分组%d,图标%d)"
L["CONDITIONORMETA_CHECKINGINVALID_GROUP"] = "警告!分组 %d 正在检测一个无效的图标(分组 %d, 图标 %d)"
L["CONDITIONPANEL_ABSOLUTE"] = "(非百分比/绝对值)"
L["CONDITIONPANEL_ADD"] = "添加条件"
L["CONDITIONPANEL_ADD2"] = "点击增加一个条件"
L["CONDITIONPANEL_ALIVE"] = "单位存活"
L["CONDITIONPANEL_ALIVE_DESC"] = "此条件会检测指定单位的存活情况."
L["CONDITIONPANEL_ALTPOWER"] = "特殊能量"
L["CONDITIONPANEL_ALTPOWER_DESC"] = [=[这是大地的裂变某些首领战遇到的特殊能量,像是古加尔的腐化值跟艾卓曼德斯的音波值.
]=]
L["CONDITIONPANEL_AND"] = "同时"
L["CONDITIONPANEL_ANDOR"] = "同时/或者"
L["CONDITIONPANEL_ANDOR_DESC"] = "|cff7fffff点击|r切换逻辑运算符 同时/或者(And/Or)"
L["CONDITIONPANEL_AUTOCAST"] = "宠物自动施法"
L["CONDITIONPANEL_BLIZZEQUIPSET"] = "套装已装备(自带装备管理器)"
L["CONDITIONPANEL_BLIZZEQUIPSET_DESC"] = "检测暴雪自带装备管理器中设置的套装是否已装备。"
L["CONDITIONPANEL_BLIZZEQUIPSET_INPUT"] = "套装名称"
L["CONDITIONPANEL_BLIZZEQUIPSET_INPUT_DESC"] = [=[输入你要检测的暴雪自带装备管理器中的套装名称。

只允许输入一个套装，注意|cFFFF5959区分大小写|r。

译者注：可以从右侧的提示与建议列表中直接选择套装名称。]=]
L["CONDITIONPANEL_CASTCOUNT"] = "法术施放次数"
L["CONDITIONPANEL_CASTCOUNT_DESC"] = "检测一个单位施放某个法术的次数."
L["CONDITIONPANEL_CASTTOMATCH"] = "用于匹配的法术"
L["CONDITIONPANEL_CASTTOMATCH_DESC"] = [=[输入一个法术名称使该条件只在施放的法术名称跟输入的法术名称完全匹配时才可通过.

你可以保留空白来检测任意的法术施放/引导法术(不包括瞬发法术).]=]
L["CONDITIONPANEL_CLASS"] = "单位职业"
L["CONDITIONPANEL_CLASSIFICATION"] = "单位分类"
L["CONDITIONPANEL_COMBAT"] = "单位在战斗中"
L["CONDITIONPANEL_COMBO"] = "连击点数"
L["CONDITIONPANEL_CREATURETYPE"] = "单位生物类型"
L["CONDITIONPANEL_CREATURETYPE_DESC"] = [=[你可以利用分号(;)输入多个生物类型用于匹配.

输入的生物类型必须同鼠标提示信息上所显示的完全相同.

此条件会在输入的任意一个类型与你所检查单位的生物类型相同时通过.]=]
L["CONDITIONPANEL_CREATURETYPE_LABEL"] = "生物类型"
L["CONDITIONPANEL_DEFAULT"] = "选择条件类型..."
L["CONDITIONPANEL_ECLIPSE_DESC"] = [=[蚀星蔽月的范围是-100(月蚀)到100(日蚀)
如果你想在月蚀能量80時显示图标就輸入-80

说明:蚀星蔽月是台服的翻译,大陆的翻译叫月蚀,这样不容易区分这个月蚀所对应的日蚀/月蚀,所以这里的说明文字直接用台服的翻译.]=]
L["CONDITIONPANEL_EQUALS"] = "等于"
L["CONDITIONPANEL_EXISTS"] = "单位存在"
L["CONDITIONPANEL_GREATER"] = "大于"
L["CONDITIONPANEL_GREATEREQUAL"] = "大于或等于"
L["CONDITIONPANEL_GROUPTYPE"] = "组队类型"
L["CONDITIONPANEL_ICON"] = "图标显示"
L["CONDITIONPANEL_ICON_DESC"] = [=[此条件检测指定图标的显示状态或隐藏状态.

如果你不想显示被检测的图标,请在被检测图标的图标编辑器勾选 %q.]=]
L["CONDITIONPANEL_ICON_HIDDEN"] = "隐藏"
L["CONDITIONPANEL_ICONHIDDENTIME"] = "图标隐藏时间"
L["CONDITIONPANEL_ICONHIDDENTIME_DESC"] = [=[此条件检测指定的图标已经隐藏了多久时间.

如果你不想显示被检测的图标,请在被检测图标的图标编辑器勾选 %q.]=]
L["CONDITIONPANEL_ICON_SHOWN"] = "显示"
L["CONDITIONPANEL_ICONSHOWNTIME"] = "图标显示时间"
L["CONDITIONPANEL_ICONSHOWNTIME_DESC"] = [=[此条件检测指定的图标已经显示了多久时间.

如果你不想显示被检测的图标,请在被检测图标的图标编辑器勾选 %q.]=]
L["CONDITIONPANEL_INPETBATTLE"] = "在宠物对战中"
L["CONDITIONPANEL_INSTANCETYPE"] = "副本类型"
L["CONDITIONPANEL_INTERRUPTIBLE"] = "可打断"
L["CONDITIONPANEL_ITEMRANGE"] = "单位在物品范围内"
L["CONDITIONPANEL_LESS"] = "小于"
L["CONDITIONPANEL_LESSEQUAL"] = "小于或等于"
L["CONDITIONPANEL_LEVEL"] = "单位等级"
L["CONDITIONPANEL_MANAUSABLE"] = "法术可用(魔法值/能量/等是否够用.)"
L["CONDITIONPANEL_MAX"] = "(最大值)"
L["CONDITIONPANEL_MOUNTED"] = "在坐骑上"
L["CONDITIONPANEL_NAME"] = "单位名字"
L["CONDITIONPANEL_NAMETOMATCH"] = "用于比较的名字"
L["CONDITIONPANEL_NAMETOOLTIP"] = "你可以在每个名字后面加上分号(;)以便输入多个需要比较的名字. 其中任何一个名字相符时此条件都会通过."
L["CONDITIONPANEL_NOTEQUAL"] = "不等于"
L["CONDITIONPANEL_NPCID"] = "单位NPC编号"
L["CONDITIONPANEL_NPCID_DESC"] = [=[检测指定的单位NPC编号.

NPC编号可以在Wowhead之类的魔兽世界数据库找到(例如http://www.wowhead.com/npc=62943).

玩家与某些单位没有NPC编号,在此条件中的返回值为0.]=]
L["CONDITIONPANEL_NPCIDTOMATCH"] = "用于比较的编号"
L["CONDITIONPANEL_NPCIDTOOLTIP"] = "你可以利用分号(;)输入多个NPC编号.条件会在任意一个编号相符时通过."
L["CONDITIONPANEL_OPERATOR"] = "运算符"
L["CONDITIONPANEL_OR"] = "或者"
L["CONDITIONPANEL_PERCENT"] = "(百分比)"
L["CONDITIONPANEL_PETMODE"] = "宠物攻击模式"
L["CONDITIONPANEL_PETSPEC"] = "宠物种类"
L["CONDITIONPANEL_PETTREE"] = "宠物天赋树"
L["CONDITIONPANEL_POWER"] = "基本资源(能量类型)"
L["CONDITIONPANEL_POWER_DESC"] = "如果单位是猫形态的德鲁伊将检测能量值,如果是战士则检测怒气,等等"
L["CONDITIONPANEL_PVPFLAG"] = "单位PVP开启状态"
L["CONDITIONPANEL_RAIDICON"] = "单位团队标记"
L["CONDITIONPANEL_REMOVE"] = "移除此条件"
L["CONDITIONPANEL_RESTING"] = "休息状态"
L["CONDITIONPANEL_ROLE"] = "单位角色类型"
L["CONDITIONPANEL_RUNES_CHECK"] = "强制第一行的符文仅匹配非死亡符文"
L["CONDITIONPANEL_RUNES_CHECK_DESC"] = [=[正常情况下,第一行的符文无论是不是死亡符文,在符合条件设置时都会通过.

启用这个选项强制第一行的符文仅匹配非死亡符文.]=]
L["CONDITIONPANEL_RUNES_DESC"] = [=[使用此条件类型只在选择的符文条件通过时显示图标.

每个符文都可以被标记.'V'打勾时条件需要在符文可用的情况下才能通过,'X'打叉时则条件需要在符文不可用的情况下才能通过,没有标记的符文不会被检查.

第二行符文为上面每个符文所对应的死亡符文.

说明:不要局限于只用一个符文条件,你可以添加多个符文条件灵活的设置符文的可用不可用情况来达到自己想要的效果.]=]
L["CONDITIONPANEL_SPELLRANGE"] = "单位在法术范围内"
L["CONDITIONPANEL_SWIMMING"] = "在游泳中"
L["CONDITIONPANEL_THREAT_RAW"] = "单位威胁值 - 原始"
L["CONDITIONPANEL_THREAT_RAW_DESC"] = [=[此条件用来检测你对一个单位的原始威胁值百分比.

近战玩家仇恨失控(OT)的威胁值为110%
远程玩家仇恨失控(OT)的威胁值为130%]=]
L["CONDITIONPANEL_THREAT_SCALED"] = "单位威胁值 - 比例"
L["CONDITIONPANEL_THREAT_SCALED_DESC"] = [=[此条件用来检测你对一个单位的威胁值百分比比例.

100%表示你正在坦这个单位.]=]
L["CONDITIONPANEL_TRACKING"] = "追踪"
L["CONDITIONPANEL_TYPE"] = "类型"
L["CONDITIONPANEL_UNIT"] = "单位"
L["CONDITIONPANEL_UNITISUNIT"] = "单位比较"
L["CONDITIONPANEL_UNITISUNIT_DESC"] = "此条件在两个文本框输入的单位为同一角色时通过.(例子:文本框1为'targettarget',文本框2为'player',当'目标的目标'为'玩家'时则此条件通过. )"
L["CONDITIONPANEL_UNITISUNIT_EBDESC"] = "在此文本框输入需要与所指定的第一单位进行比较的第二单位."
L["CONDITIONPANEL_VALUEN"] = "取值"
L["CONDITIONPANEL_VEHICLE"] = "单位控制载具"
L["CONDITION_QUESTCOMPLETE"] = "任务完成"
L["CONDITION_QUESTCOMPLETE_DESC"] = "检测一个任务是否已完成."
L["CONDITION_QUESTCOMPLETE_EB_DESC"] = [=[输入你想检测的任务ID.

任务ID可以在魔兽世界数据库网站获得,像是db.178.com(中文)和www.wowhead.com(英文).

例如:http://db.178.com/wow/cn/quest/32615.html<超多的巨型恐龙骨骼>任务ID为32615.]=]
L["CONDITIONS"] = "条件"
L["CONDITION_TIMEOFDAY"] = "一天中的时间"
L["CONDITION_TIMEOFDAY_DESC"] = [=[此条件将使用当前时间与设置时间进行比较.

用于比较的时间是本地时间(基于你的电脑时钟).它不会获取服务器的时间.]=]
L["CONDITION_TIMERS_FAIL_DESC"] = [=[设置条件无法通过以后图标计时器的持续时间

(译者注:图标在条件每次通过/无法通过后都会重新计时,另外在默认的情况下图标的显示只会根据条件通过情况来改变,设定的持续时间不会影响到图标的显示情况,不会在设置的持续时间倒数结束后隐藏图标,如果想要图标在计时结束后隐藏,需要勾选'仅在计时器作用时显示',这是4.5.3版本新加入的功能.)]=]
L["CONDITION_TIMERS_HEADER"] = "计时器"
L["CONDITION_TIMERS_SUCCEED_DESC"] = [=[设置条件成功通过以后图标计时器的持续时间

(译者注:图标在条件每次通过/无法通过后都会重新计时,另外在默认的情况下图标的显示只会根据条件通过情况来改变,设定的持续时间不会影响到图标的显示情况,不会在设置的持续时间倒数结束后隐藏图标,如果想要图标在计时结束后隐藏,需要勾选'仅在计时器作用时显示',这是4.5.3版本新加入的功能.)]=]
L["CONDITION_WEEKDAY"] = "星期几"
L["CONDITION_WEEKDAY_DESC"] = [=[检测今天是不是星期几.

用于检测的时间是本地时间(基于你的电脑时钟).它不会获取服务器的时间.]=]
L["CONFIGMODE"] = "TellMeWhen正处于设置模式. 在离开设置模式之前,图标无法正常使用. 输入'/tellmewhen'或'/tmw'可以开启或关闭设置模式."
L["CONFIGMODE_EXIT"] = "退出设置模式"
L["CONFIGMODE_NEVERSHOW"] = "不再显示此信息"
L["CONFIGPANEL_CBAR_HEADER"] = "计时条覆盖"
L["CONFIGPANEL_CLEU_HEADER"] = "战斗事件"
L["CONFIGPANEL_CNDTTIMERS_HEADER"] = "条件计时器"
L["CONFIGPANEL_PBAR_HEADER"] = "能量条覆盖"
L["CONFIGPANEL_TIMERBAR_BARDISPLAY_HEADER"] = "计时条"
L["CONFIGPANEL_TIMER_HEADER"] = "计时器时钟"
L["COPYGROUP"] = "复制分组"
L["COPYPOSSCALE"] = "复制位置/比例"
L["CREATURETYPE_1"] = "野兽"
L["CREATURETYPE_10"] = "未指定"
L["CREATURETYPE_11"] = "图腾"
L["CREATURETYPE_12"] = "非战斗宠物"
L["CREATURETYPE_13"] = "气体云雾"
L["CREATURETYPE_14"] = "野生宠物"
L["CREATURETYPE_2"] = "龙类"
L["CREATURETYPE_3"] = "恶魔"
L["CREATURETYPE_4"] = "元素生物"
L["CREATURETYPE_5"] = "巨人"
L["CREATURETYPE_6"] = "亡灵"
L["CREATURETYPE_7"] = "人型生物"
L["CREATURETYPE_8"] = "小动物"
L["CREATURETYPE_9"] = "机械"
L["CrowdControl"] = "控场技能"
L["Curse"] = "诅咒"
L["DamageBuffs"] = "信春哥(伤害性增益)"
L["DAMAGER"] = "伤害输出"
L["DamageShield"] = "伤害护盾"
L["DEBUFFTOCHECK"] = "要检测的减益"
L["DEBUFFTOCOMP1"] = "进行比较的第一个减益"
L["DEBUFFTOCOMP2"] = "进行比较的第二个减益"
L["DEFAULT"] = "默认值"
L["DefensiveBuffs"] = "信春哥(防御性增益)"
L["DESCENDING"] = "降序"
L["DISABLED"] = "已停用"
L["Disarmed"] = "被缴械"
L["Disease"] = "疾病"
L["Disoriented"] = "被魅惑"
L["DontMelee"] = "近战不能"
L["DR-Banish"] = "放逐术"
L["DR-BindElemental"] = "束缚元素"
L["DR-Charge"] = "冲锋"
L["DR-ControlledRoot"] = "控制定身"
L["DR-ControlledStun"] = "控制昏迷"
L["DR-Cyclone"] = "旋风"
L["DR-Disarm"] = "缴械"
L["DR-Disorient"] = "迷惑/其他"
L["DR-DragonsBreath"] = "龙息术"
L["DR-Entrapment"] = "诱捕"
L["DR-Fear"] = "恐惧"
L["DR-Horrify"] = "惊骇"
L["DR-IceWard"] = "寒冰结界"
L["DR-MindControl"] = "精神控制"
L["DR-RandomRoot"] = "随机定身"
L["DR-RandomStun"] = "随机昏迷"
L["DR-Scatter"] = "驱散射击"
L["DR-Silence"] = "沉默"
L["DR-Taunt"] = "嘲讽"
L["DT_DOC_Destination"] = "返回图标最后一次处理的战斗事件中的目标单位或名称.和[Name]标签一起使用效果更佳.(此标签仅可用于图标类型%s)"
L["DT_DOC_Duration"] = "返回图标当前的剩余持续时间.推荐你使用[TMWFormatDuration]."
L["DT_DOC_Extra"] = "返回图标最后一次处理过的战斗事件中的额外法术名称.（此标签仅可用于图标类型%s）"
L["DT_DOC_gsub"] = "提供给力的Lua函数string.gsub来处理DogTags输出的字符串。"
L["DT_DOC_IsShown"] = "返回一个图标是否显示."
L["DT_DOC_LocType"] = "返回图标所显示的失去控制的效果类型.(此标签仅可用于图标类型%s)"
L["DT_DOC_Name"] = "返回单位的名称.这是一个由DogTag提供的默认[Name]标签的加强版本."
L["DT_DOC_Opacity"] = "返回一个图标的不透明度. 返回值为0到1之间的数字."
L["DT_DOC_PreviousUnit"] = "返回图标检测过的上一个单位或单位名称(相对于与当前检查单位来讲).和[Name]标签一起使用效果更佳."
L["DT_DOC_Source"] = "返回图标最后一次处理过的战斗事件中的来源单位或名称.和[Name]标签一起使用效果更佳.(此标签仅可用于图标类型%s)"
L["DT_DOC_Spell"] = "返回图标当前显示数据的物品名称或法术名称."
L["DT_DOC_Stacks"] = "返回图标当前的叠加数量"
L["DT_DOC_strfind"] = "提供给力的Lua函数string.find来处理DogTags输出的字符串。"
L["DT_DOC_TMWFormatDuration"] = "返回一个由TellMeWhen的时间格式处理过的字符串​​.用于替代[FormatDuration]."
L["DT_DOC_Unit"] = "返回当前图标所检查的单位或单位名称.同[Name]标签一起使用效果更佳."
L["DURATION"] = "持续时间"
L["DURATIONALPHA_DESC"] = "设置在你要求的持续时间不符合时图标显示的不透明度."
L["DURATIONPANEL_TITLE2"] = "持续时间限制"
L["DURATIONPERC"] = "持续时间(百分比)"
L["EARTH"] = "大地图腾"
L["ECLIPSE_DIRECTION"] = "月蚀方向"
L["elite"] = "精英"
L["ENABLINGOPT"] = "TellMeWhen设置已禁用.重新启用中...."
L["Enraged"] = "激怒"
L["EQUIPSETTOCHECK"] = "用于检测的套装名称(|cFFFF5959区分大小写|r)"
L["ERROR_ACTION_DENIED_IN_LOCKDOWN"] = "无法在战斗中这么做,请先启用%q选项(输入'/tmw options'或'/tmw 选项')."
L["ERROR_ANCHORSELF"] = "%s尝试附着于它自己, 所以TellMeWhen会重置它的附着位置到屏幕中间以防止出现严重的错误."
L["ERROR_GAMEMENU_INTERFACE_OPTIONS_FUCKED"] = [=[虽然TellMeWhen设置已成功加载，但是某些地方还是发生了不可预知的错误，导致界面无法正常显示。

请尝试关闭界面选项（这个窗口）并重新打开它。

如果还是无法正常使用，你也可以输入'/tmw options'来访问TMW设置。

给您带来的不便深感抱歉！]=]
L["ERROR_INVALID_SPELLID"] = "%s 正在检测一个无效的法术ID: %s.  为免图标发生错误,请删除它!"
L["ERROR_MISSINGFILE"] = "TellMeWhen需要在重开魔兽世界之后才能正常使用%s (原因:无法找到 %s ). 你要马上重开魔兽世界吗?"
L["ERROR_MISSINGFILE_NOREQ"] = "TellMeWhen需要在重开魔兽世界之后才能完全正常使用%s (原因:无法找到 %s ). 你要马上重开魔兽世界吗?"
L["ERROR_MISSINGFILE_REQFILE"] = "一个必需的文件"
L["ERROR_MISSINGLAYOUT"] = "无法找到文字显示样式%s. 将使用默认文字显示样式."
L["ERROR_NO_LOCKTOGGLE_IN_LOCKDOWN"] = "无法在战斗中解锁TellMeWhen,请先启用%q选项(输入'/tmw options'或'/tmw 选项')."
L["ERROR_NOOPTIONSLOAD_INCOMBAT"] = [=[在没有勾选%q选项的情况下，TellMeWhen无法在战斗中加载设置插件。

如果在你离开战斗后此窗口依旧处于打开状态，TMW将会自动加载它们。]=]
L["ERROR_NOTINITIALIZED_INTERFACEPANEL_EXPLANATION"] = [=[TellMeWhen在初始化过程中发生了严重的错误，目前无法正常使用，也不能进行任何设置。

如果您在登陆后看到了一条要求重开魔兽世界才能正常使用TellMeWhen的信息，请照做；如果没有看到任何提示，请启用Lua错误(假如没有启用，请勾选%s的 界面>%s>%s 选项)，重新加载插件后,到Curse创建一个新的回报单，提交你得到的错误代码(英文不好无法提交，请参考最后一条)。
http://wow.curseforge.com/addons/tellmewhen/create-ticket/

给您带来的不便我们深感抱歉，这是一个及少发生的错误，你提供的任何相关的信息都会我们带来莫大的帮助，以便更快修复出现的问题。

感谢您使用TellMeWhen！

译者注:如果英文不好，可以在NGA的插件技术讨论区发帖提出相关的问题；最后说一句，我们也是人，不是神，记得在帖中附上Lua错误信息，别让我们猜好吗？]=]
L["ERROR_NOTINITIALIZED_NO_ACTION"] = "插件初始化失败,TellMeWhen不能执行该步骤."
L["ERROR_NOTINITIALIZED_NO_LOAD"] = "插件初始化失败,TellMeWhen_Options无法加载."
L["ERROR_NOTLOADED_ERROR"] = "TellMeWhen加载失败! 缺少必需的函数库!"
L["ERRORS_FRAME"] = "错误框架"
L["ERRORS_FRAME_DESC"] = "输出文字到系统的错误框架,就是显示%q那个位置."
L["EVENTCONDITIONS"] = "事件条件"
L["EVENTCONDITIONS_DESC"] = "点击进入设置用于触发此事件的条件."
L["EVENTCONDITIONS_TAB_DESC"] = "设置的条件通过时则触发此事件."
L["EVENTHANDLER_LUA_CODE"] = "用于执行的Lua代码"
L["EVENTHANDLER_LUA_CODE_DESC"] = "在此输入事件触发后需要执行的Lua代码."
L["EVENTHANDLER_LUA_LUA"] = "Lua"
L["EVENTHANDLER_LUA_TAB"] = "Lua(高玩级)"
L["EVENTS_HANDLERS_ADD"] = "添加事件处理器..."
L["EVENTS_HANDLERS_ADD_DESC"] = "|cff7fffff点击|r选择一个事件处理器添加到此图标,"
L["EVENTS_HANDLERS_GLOBAL_DESC"] = [=[|cff7fffff点击|r打开事件处理器选项.
|cff7fffff点击并拖拽|r来更改排序.]=]
L["EVENTS_HANDLERS_HEADER"] = "图标事件处理器"
L["EVENTS_HANDLERS_PLAY"] = "测试事件"
L["EVENTS_HANDLERS_PLAY_DESC"] = "|cff7fffff点击|r测试事件处理器"
L["EVENTS_INSTRUCTIONS"] = [=[在此选项卡,你可以设置此图标的额外提醒效果,包括播放音效,动画和输出文字.

所有设置的提醒效果将在你所选的事件发生时触发.

请点击左侧按钮开始设置,选择你想监视的事件跟提醒方式.]=]
L["EVENTS_SETTINGS_CNDTJUSTPASSED"] = "仅在条件刚通过时"
L["EVENTS_SETTINGS_CNDTJUSTPASSED_DESC"] = "除非上面设置的条件刚刚成功通过,否则阻止事件的触发."
L["EVENTS_SETTINGS_HEADER"] = "事件设置"
L["EVENTS_SETTINGS_ONLYSHOWN"] = "仅在图标显示时触发"
L["EVENTS_SETTINGS_ONLYSHOWN_DESC"] = "勾选此项防止图标在没有显示时触发相关事件."
L["EVENTS_SETTINGS_PASSINGCNDT"] = "仅在条件通过时触发:"
L["EVENTS_SETTINGS_PASSINGCNDT_DESC"] = "除非下面设置的条件成功通过,否则阻止事件的触发."
L["EVENTS_SETTINGS_PASSTHROUGH"] = "允许触发其他事件"
L["EVENTS_SETTINGS_PASSTHROUGH_DESC"] = [=[勾选允许在触发该事件后去触发另一个事件,如果不勾选,则在该事件触发并输出了文字/音效之后,图标将不再处理同时触发的其他任何事件.

可以有例外,详情请参阅个别事件的描述.]=]
L["EVENTS_TAB"] = "事件"
L["EVENTS_TAB_DESC"] = "设置声音/文字输出/动画的触发器."
L["EXPORT_f"] = "导出 %s"
L["EXPORT_HEADING"] = "导出"
L["EXPORT_SPECIALDESC2"] = "其他TellMeWhen使用者只能在他们所使用的版本高于或等于%s时才能导入这些数据."
L["EXPORT_TOCOMM"] = "到玩家"
L["EXPORT_TOCOMM_DESC"] = [=[输入一个玩家的名字到编辑框同时选择此选项来发送数据给他们.他们必须是你能密语的某人(同阵营,同服务器,在线),同时他们必须已经安装版本为4.0.0+的TellMeWhen.

你还可以输入"GUILD"或"RAID"发送到整个公会或整个团队(输入时请注意区分大小写,'GUILD'跟'RAID'中的英文字母全部都是大写).]=]
L["EXPORT_TOGUILD"] = "到公会"
L["EXPORT_TORAID"] = "到团队"
L["EXPORT_TOSTRING"] = "到字符串"
L["EXPORT_TOSTRING_DESC"] = "包含必要数据的字符串将导出到编辑框里,按下CTRL+C复制它,然后到任何你想分享的地方贴上它."
L["FALSE"] = "否"
L["fCODESNIPPET"] = "代码片段: %s"
L["Feared"] = "被恐惧"
L["fGROUP"] = "分组: %s"
L["fICON"] = "图标: %s"
L["FIRE"] = "火焰图腾"
L["FONTCOLOR"] = "文字颜色"
L["FONTSIZE"] = "字体大小"
L["FORWARDS_IE"] = "转到下一个"
L["FORWARDS_IE_DESC"] = [=[载入下一个编辑过的图标

%s |T%s:0|t]=]
L["fPROFILE"] = "配置文件: %s"
L["FROMNEWERVERSION"] = "你导入的数据为版本较新的TellMeWhen所创建,某些设置在更新至最新版本之前可能无法正常使用."
L["fTEXTLAYOUT"] = "文字显示样式: %s"
L["GCD"] = "公共冷却"
L["GCD_ACTIVE"] = "公共冷却作用中"
L["GENERIC_NUMREQ_CHECK_DESC"] = "勾选以启用并配置%s"
L["GENERICTOTEM"] = "图腾 %d"
L["GLYPHTOCHECK"] = "要检测的雕文"
L["GROUPADDONSETTINGS"] = "分组设置"
L["GROUPADDONSETTINGS_DESC"] = "包含分组的设置以及插件的综合设置."
L["GROUPCONDITIONS"] = "分组条件"
L["GROUPCONDITIONS_DESC"] = "设置条件进行微调,以便更好的显示这个分组."
L["GROUPICON"] = "分组:%s ，图标:%s"
L["HEALER"] = "治疗"
L["Heals"] = "玩家治疗法术"
L["HELP_ANN_LINK_INSERTED"] = [=[你插入的链接看起来很诡异,可能是因为DogTag的格式转换所引起.

如果输出到暴雪频道时链接无法正常显示,请更改颜色代码.]=]
L["HELP_CNDT_ANDOR_FIRSTSEE"] = [=[你可以选择两个条件都需要通过,还是只需要某个条件通过.

|cff7fffff点击|r此处更改条件之间的关联方式,以达到你所需的检测效果.]=]
L["HELP_CNDT_PARENTHESES_FIRSTSEE"] = [=[你可以组合多个条件执行复杂的检测功能,尤其是连同%q选项一起使用.

|cff7fffff点击|r括号将条件组合在一起,以达到你需要的检测效果(左右括号中间的条件就是一个条件组合).]=]
L["HELP_EXPORT_DOCOPY_MAC"] = "按下|cff7fffffCMD+C|r复制"
L["HELP_EXPORT_DOCOPY_WIN"] = "按下|cff7fffffCTRL+C|r复制"
L["HELP_FIRSTUCD"] = [=[这是你第一次使用一个采取特定时间语法的图标类型!
在添加法术到某些图标类型的 %q 编辑框时,必须使用下列语法在法术后面指定它们的冷却时间/持续时间:

法术:时间

例如:

"%s: 120"
"%s: 10;%s: 24"
"%s: 180"
"%s: 3:00"
"62618: 3:00"

用建议列表插入条目时会自动添加在鼠标提示信息中显示的时间(译者注:自动添加时间功能支持提示信息中有显示冷却时间的法术以及提示信息中有注明持续时间的大部分法术,如果一个法术同时存在上述两种时间,会优先选择添加冷却时间,假如自动添加的时间不正确,请自行手动更改).]=]
L["HELP_IE_TIMERTEXTHANDLER_MISSING"] = [=[TellMeWhen在所有已安装的插件中无法找到可以用于处理此设置的插件.

如果你启用了此选项,但是无法看到任何计时器的数字,请到Curse.com或WoWInterface.com下载并安装插件"OmniCC".]=]
L["HELP_IMPORT_CURRENTPROFILE"] = [=[尝试在这个配置文件中移动或复制一个图标到另外一个图标栏位吗?

你可以轻松的做到这一点,使用|cff7fffff鼠标右键点击图标并拖拽|r它到另外一个图标栏位(这个过程需要按下鼠标右键不放开). 当你放开鼠标右键时,会出现一个有很多选项的选单.

尝试拖拽一个图标到整合图标,其他分组,或在你屏幕上的其他框架以获取其他相应的选项.]=]
L["HELP_MISSINGDURS"] = [=[以下法术缺少持续时间/冷却时间:

%s

请使用下列语法添加时间:

法术:时间

例如"%s: 10"

用建议列表插入条目时会自动添加在鼠标提示信息中显示的时间(译者注:自动添加时间功能支持提示信息中有显示冷却时间的法术以及提示信息中有注明持续时间的大部分法术,如果一个法术同时存在上述两种时间,会优先选择添加冷却时间,假如自动添加的时间不正确,请自行手动更改).]=]
L["HELP_MS_NOFOUND"] = [=[无法在动作条上找到技能 %q.

请确保那个技能在你的动作条上,并且它是处于默认状态,必须要注意的是出现在动作条上的技能不能是一个宏,而是应该直接把技能放到你的动作条上.否则此图标可能无法正常使用.

上述默认状态指没有施放该技能使其出现第二个状态.]=]
L["HELP_NOUNIT"] = "你必须输入一个单位!"
L["HELP_NOUNITS"] = "你至少需要输入一个单位!"
L["HELP_ONLYONEUNIT"] = "条件只允许检测一个单位，你已经输入了%d个单位。"
L["HELP_POCKETWATCH"] = [=[|TInterface\Icons\INV_Misc_PocketWatch_01:20|t -- 关于怀表材质

此材质用于第一个检测到的有效法术在你的法术书中不存在时.

正确的材质将会在你施放过一次或者见到过一次该法术之后使用.

若要显示正确的材质,请把第一个被检测的法术名称更改为法术ID.你可以轻松的做到这一点,你只需要点击名称编辑框中的法术,再根据之后出现的建议列表中显示的正确的以及相对应的法术上点击鼠标右键即可.

(这里的法术指排在首位的法术,当你的鼠标移动到建议列表的某个法术上时,在提示信息中可以看到更为具体的鼠标左右键插入法术ID或法术名称的方法.)]=]
L["ICON"] = "图标"
L["ICONALPHAPANEL_FAKEHIDDEN"] = "始终隐藏"
L["ICONALPHAPANEL_FAKEHIDDEN_DESC"] = "使该图标一直被隐藏,但图标依然会处理并执行音效跟文字输出,而且仍然可以让包含该图标的条件或者整合图标进行检测."
L["ICONCONDITIONS_DESC"] = "设置条件进行微调,以便更好的显示图标."
L["ICONGROUP"] = "图标: %s (分组: %s)"
L["ICONMENU_ABSENT"] = "不存在"
L["ICONMENU_ABSENTONALL"] = "全都缺少"
L["ICONMENU_ABSENTONALL_DESC"] = "设置在检测的所有单位中不存在任何一个用于检测的增益/减益时的图标透明度."
L["ICONMENU_ABSENTONANY"] = "任一缺少"
L["ICONMENU_ABSENTONANY_DESC"] = "设置在检测的所有单位中只要其中之一不存在任何一个用于检测的增益/减益时的图标透明度."
L["ICONMENU_ADDMETA"] = "添加到'整合图标'"
L["ICONMENU_ALLOWGCD"] = "允许公共冷却"
L["ICONMENU_ALLOWGCD_DESC"] = "勾选此项允许冷却时钟显示公共冷却,而不是忽略它."
L["ICONMENU_ALPHA"] = "透明度"
L["ICONMENU_ANCHORTO"] = "附着到 %s"
L["ICONMENU_ANCHORTO_DESC"] = [=[附着%s到%s,无论%s如何移动,%s都会跟随它一起移动.

分组选项中有更为详细的附着设置.]=]
L["ICONMENU_ANCHORTO_UIPARENT"] = "重置附着"
L["ICONMENU_ANCHORTO_UIPARENT_DESC"] = [=[让%s重新附着到你的屏幕(UIParent).它目前附着到%s.

分组选项中有更为详细的附着设置.

分组选项中有更为详细的附着设置.]=]
L["ICONMENU_APPENDCONDT"] = "添加到'图标显示'条件"
L["ICONMENU_BAR_COLOR_COMPLETE"] = "完成颜色"
L["ICONMENU_BAR_COLOR_COMPLETE_DESC"] = "计量条在冷却、持续时间完成时的颜色。"
L["ICONMENU_BAR_COLOR_MIDDLE"] = "过半颜色"
L["ICONMENU_BAR_COLOR_MIDDLE_DESC"] = "计量条在冷却、持续时间过半时的颜色。"
L["ICONMENU_BAR_COLOR_START"] = "起始颜色"
L["ICONMENU_BAR_COLOR_START_DESC"] = "计量条在冷却、持续时间起始时的颜色。"
L["ICONMENU_BAROFFS"] = [=[此数值将会添加到计量条以便用来调整它的偏移值.

一些有用的例子:
当你开始施法时防止一个增益消失的自订指示器,或者用来指示某个法术施放所需能量的同时还剩多少时间可以打断施法.]=]
L["ICONMENU_BINDTEXT_DESC"] = "在此编辑框中的任意文字将以动作条上显示的按键绑定文字的方式显示在图标上.这并非设定TellMeWhen图标的按键绑定!它只是一个显示在图标上的文字提示的视觉效果.在本组的'分组设置'中可以更改此文字的设置."
L["ICONMENU_BOTH"] = "任意一种"
L["ICONMENU_BUFF"] = "增益"
L["ICONMENU_BUFFCHECK"] = "增益/减益检测"
L["ICONMENU_BUFFCHECK_DESC"] = [=[检测你所设置的单位是否缺少某个增益.

可使用这个图标类型来检测缺少的团队增益(像是耐力之类).

其他情况应使用图标类型%q.]=]
L["ICONMENU_BUFFDEBUFF"] = "增益/减益"
L["ICONMENU_BUFFDEBUFF_DESC"] = "检测增益或减益."
L["ICONMENU_BUFFTYPE"] = "增益或减益"
L["ICONMENU_CAST"] = "法术施放"
L["ICONMENU_CAST_DESC"] = "检测非瞬发施法跟引导法术."
L["ICONMENU_CASTS"] = "法术施放"
L["ICONMENU_CASTSHOWWHEN"] = "何时显示法术施放"
L["ICONMENU_CHECKNEXT"] = "扩展子元"
L["ICONMENU_CHECKNEXT_DESC"] = [=[选中此框该图标将检测添加在列表中的任意整合图标所包含的全部图标,它可能是任何级别的检测.

此外,该图标不会显示已经在另一个整合图标显示的任何图标.在主选项或分组设置中可以更改更新排序.

译者注:因为很多人不明白这个功能,举个例子,假设你有3个设置完全一样的整合图标(每个图标中都是图标1 图标2 图标3),全部都勾上了这个选项,如果在整合图标中图标1 图标2 图标3都可以显示,显示顺序为图标3>图标1>图标2,那么在整合图标1将会显示图标3,整合图标2则是显示图标1,整合图标3显示图标2(理论上就是这样的效果,一些细节请自行钻研).]=]
L["ICONMENU_CHECKREFRESH"] = "法术刷新侦测"
L["ICONMENU_CHECKREFRESH_DESC"] = [=[暴雪的战斗记录在涉及法术刷新和恐惧（或者某些在造成一定伤害量后才会中断的法术）存在严重缺陷，战斗记录会认为法术在造成伤害时已经刷新，尽管事实上并非如此。

取消此选项以便停用法术刷新侦测，注意：正常的刷新也将被忽略。

如果你检测的递减在造成一定伤害量后不会中断的话建议保留此选项。]=]
L["ICONMENU_CHOOSENAME2"] = "选择用于检测的法术"
L["ICONMENU_CHOOSENAME_ITEMSLOT2"] = "选择用于检测的物品"
L["ICONMENU_CHOOSENAME_ITEMSLOT_DESC"] = [=[输入你想要此图标监视的 名称/ID/装备栏编号. 你可以利用分号添加多个条目(名称/ID/装备栏编号的任意组合).

装备栏编号是已装备物品所在栏位的编号索引.即使你更换了那个装备栏的已装备物品,也不会影响图标的正常使用.

你可以|cff7fffff按住Shift再按鼠标左键点选|r物品/聊天连结 或者拖曳物品添加此编辑框中.]=]
L["ICONMENU_CHOOSENAME_MULTISTATE"] = "选择用于检测的 名称/ID"
L["ICONMENU_CHOOSENAME_ORBLANK"] = "或者保留空白检测所有"
L["ICONMENU_CHOOSENAME_WPNENCH"] = "选择用于检测的暂时性武器附魔"
L["ICONMENU_CHOOSENAME_WPNENCH_DESC"] = [=[输入你想要此图标监视的暂时性武器附魔的名称. 你可以利用分号(;)添加多个条目.

|cFFFF5959重要提示|r: 附魔名称必须使用在暂时性武器附魔激活时出现在武器的提示信息中的那个名称(例如:"%s", 而不是"%s").

译者注:大陆版魔兽世界中的部分标点符号用的是全角标点,在这里需要使用的就是全角括号.]=]
L["ICONMENU_CHOSEICONTODRAGTO"] = "选择一个图标拖拽到："
L["ICONMENU_CHOSEICONTOEDIT"] = "选择一个图标来修改:"
L["ICONMENU_CLEU"] = "战斗事件"
L["ICONMENU_CLEU_DESC"] = [=[检测战斗事件.

包括了像是法术反射,未命中,瞬发施法以及死亡等等. 
实际上图标能检测所有的战斗事件(包括上述的例子以及其他没有提到的战斗事件).]=]
L["ICONMENU_CLEU_NOREFRESH"] = "不刷新"
L["ICONMENU_CLEU_NOREFRESH_DESC"] = "勾选后在图标的计时器作用时不会再触发事件."
L["ICONMENU_CNDTIC"] = "条件图标"
L["ICONMENU_CNDTIC_DESC"] = "检测条件的状态."
L["ICONMENU_CNDTIC_ICONMENUTOOLTIP"] = "(%d个条件)"
L["ICONMENU_CNDTSHOWWHEN"] = "当条件怎样时显示"
L["ICONMENU_COMPONENTICONS"] = "组件图标&分组"
L["ICONMENU_COOLDOWNCHECK"] = "冷却检测"
L["ICONMENU_COOLDOWNCHECK_DESC"] = "勾选此项启用当可用技能在冷却中时视为不可用."
L["ICONMENU_COPYCOLORS_BARDISPLAY"] = "复制计量条颜色"
L["ICONMENU_COPYCOLORS_BARDISPLAY_DESC"] = "复制%s的三个颜色设置到%s。"
L["ICONMENU_COPYCONDITIONS"] = "复制 %d 个条件"
L["ICONMENU_COPYCONDITIONS_DESC"] = "复制%s的%d个条件到%s。"
L["ICONMENU_COPYCONDITIONS_DESC_OVERWRITE"] = "这将会覆盖已存在的%d个的条件。"
L["ICONMENU_COPYCONDITIONS_GROUP"] = "复制%d个分组条件"
L["ICONMENU_COPYEVENTHANDLERS"] = "复制 %d 个事件处理器"
L["ICONMENU_COPYEVENTHANDLERS_DESC"] = "复制%s的%d个事件处理器到%s。"
L["ICONMENU_COPYHERE"] = "复制到此"
L["ICONMENU_COUNTING"] = "倒数中"
L["ICONMENU_COUNTING_DESC"] = "当图标的计时器在倒数时显示图标."
L["ICONMENU_CUSTOMTEX"] = "自定义图标材质"
L["ICONMENU_CUSTOMTEX_DESC"] = [=[如果你要更改此图标显示的材质,输入你要使用的某个材质的法术名称或ID. 

你可以输入一个材质路径, 例如'Interface/Icons/spell_nature_healingtouch', 假如材质路径为'Interface/Icons'可以只输入'spell_nature_healingtouch'.

你可以在此编辑框输入"$"(美元符)浏览一个动态材质列表.

|cffff0000你也能使用放在WoW目录中的自定义材质(请在该字段输入材质的相对路径,像是'tmw/ccc.tga'),仅支持尺寸为2的N次方(32, 64, 128,等)并且类型为.tga和.blp的材质文件.]=]
L["ICONMENU_CUSTOMTEX_MOPAPPEND_DESC"] = "在自定义了某个材质后图标显示成绿色的话,请看看后面的两种可能性,如果你所指定的材质在WOW主目录(跟WOW.exe相同的目录)下面,请把材质移动到某个子目录(珍爱生命,远离WOW.exe)下即可正常使用(请关闭WOW之后再进行上面的操作),如果你使用的是某个特定的法术图标作为材质,那可能是因为暴雪移除或者更改了它们(它们原来的ID或名称已经不存在),请重新输入另一个你要用于自定义材质的法术名称或法术ID. "
L["ICONMENU_DEBUFF"] = "减益"
L["ICONMENU_DISPEL"] = "驱散类型"
L["ICONMENU_DONTREFRESH"] = "不刷新"
L["ICONMENU_DONTREFRESH_DESC"] = "勾选此项在图标仍然倒数的时候触发效果将强制不重置冷却时间."
L["ICONMENU_DR"] = "递减"
L["ICONMENU_DRABSENT"] = "未递减"
L["ICONMENU_DR_DESC"] = "检测递减时间跟递减程度."
L["ICONMENU_DRPRESENT"] = "已递减"
L["ICONMENU_DRS"] = "递减"
L["ICONMENU_DURATION_MAX_DESC"] = "允许图标显示的最大持续时间,高于此数值图标将被隐藏."
L["ICONMENU_DURATION_MIN_DESC"] = "显示图标所需的最小持续时间,低于此数值图标将被隐藏."
L["ICONMENU_ENABLE"] = "启用"
L["ICONMENU_ENABLECOLORS"] = "启用单独颜色"
L["ICONMENU_ENABLECOLORS_DESC"] = [=[勾选此项允许单独/设置下列三个颜色选项。

如果不勾选将直接使用TellMeWhen主选项中的颜色设置。]=]
L["ICONMENU_ENABLECOLORS_HELP"] = [=[嘿，看这边！

我只是想让你知道，你只需要|cff7fffff右键点击并拖拽|r这个图标到另一个图标就可以轻松搞定计量条之间的颜色复制。]=]
L["ICONMENU_ENABLE_DESC"] = "图标需要在启用后才会起作用."
L["ICONMENU_FAIL2"] = "条件无效"
L["ICONMENU_FAKEMAX"] = "伪最大值"
L["ICONMENU_FAKEMAX_DESC"] = [=[设置计时器的伪最大值.

你可以使用此设置让整组图标以相同的速度进行倒计时.可以让你更清楚的看到哪些计时器先结束.

设置为0则禁用此选项.

译者注:如果你设置为20, 那TellMeWhen显示的计时条的总长度将变成20秒,但是并不影响你实际的计时,事实上法术的持续时间还是10秒,只是倒计时会从那个20秒长的计时条的中间开始.]=]
L["ICONMENU_FOCUS"] = "焦点目标"
L["ICONMENU_FOCUSTARGET"] = "焦点目标的目标"
L["ICONMENU_FRIEND"] = "友好单位"
L["ICONMENU_GHOUL"] = "非永久食尸鬼(没加天赋%s)"
L["ICONMENU_GHOUL_DESC"] = "仅用于检测在没有 %s 天赋时,你召唤的食尸鬼剩余的时间."
L["ICONMENU_HIDENOUNITS"] = "无单位时隐藏"
L["ICONMENU_HIDENOUNITS_DESC"] = "勾选此项可在单位不存在时致使图标检测的所有单位都无效的情况下隐藏该图标(包括单位条件的设置在内)."
L["ICONMENU_HIDEUNEQUIPPED"] = "装备栏缺少武器时隐藏"
L["ICONMENU_HIDEUNEQUIPPED_DESC"] = "勾选此项在检测的武器栏没有装备武器时强制隐藏图标"
L["ICONMENU_HOSTILE"] = "敌对单位"
L["ICONMENU_ICD"] = "内置冷却"
L["ICONMENU_ICDAURA_DESC"] = [=[如果是在下列情况开始内置冷却,请选择此项:

|cff7fffff1)|r在你应用某个减益/获得某个增益以后(包括触发),或是
|cff7fffff2)|r某一效果造成伤害以后,或是
|cff7fffff3)|r在充能效果使你恢复法力值/怒气/等以后,或是
|cff7fffff4)|r你召唤某个东西或者NPC以后.

你需要在 %q 编辑框中输入技能/法术的名称或ID:

|cff7fffff1)|r触发内置冷却的减益/增益,或是
|cff7fffff2)|r造成伤害的某一法术/技能(请查看你的战斗记录),或是
|cff7fffff3)|r使你恢复法力值/怒气/等的充能效果(请查看你的战斗记录),或是
|cff7fffff4)|r触发内置冷却的召唤效果法术/技能(请查看你的战斗记录).

(请查看你的战斗记录或者利用插件来确认法术名称/ID)]=]
L["ICONMENU_ICDBDE"] = "增益/减益/伤害/充能/召唤"
L["ICONMENU_ICD_DESC"] = [=[检测一个触发效果或与其类似效果的冷却.

|cFFFF5959重要提示|r: 关于如何检测每个类型的内置冷却请参阅在 %q 下方选项的提示信息.]=]
L["ICONMENU_ICDTYPE"] = "何时开始冷却..."
L["ICONMENU_IGNORENOMANA"] = "忽略能量不足"
L["ICONMENU_IGNORENOMANA_DESC"] = [=[勾选此项当一个技能仅仅是因为能量不足而不可用时视该技能为可用.

对于像是%s 或者 %s这类技能很实用.]=]
L["ICONMENU_IGNORERUNES"] = "忽略符文"
L["ICONMENU_IGNORERUNES_DESC"] = [=[勾选此项,在技能冷却已结束,仅仅因为符文冷却(或公共冷却)导致无法施放技能,则视该技能为可用.

译者注:举例说明一下,比如死亡骑士的符文分流冷却时间为30秒,但是30秒冷却结束之后,在没有可用的鲜血符文或死亡符文的情况下会继续显示冷却倒数计时,如果有勾选这个选项,则图标就不会出现继续倒数,直接显示为符文分流可用.]=]
L["ICONMENU_IGNORERUNES_DESC_DISABLED"] = "\"忽略符文\"必须在\"冷却检测\"已勾选后才可使用."
L["ICONMENU_INVERTBARDISPLAYBAR_DESC"] = "勾选此项以反向的方式填充计量条,会在持续时间到0时填满整个计量条."
L["ICONMENU_INVERTBARS"] = "反转计量条"
L["ICONMENU_INVERTCBAR_DESC"] = "勾选此项使图标上的计时条在持续时间为0时才填满图标的宽度,而不是计时条从填满开始减少."
L["ICONMENU_INVERTPBAR_DESC"] = "勾选此项使图标上的能量条在有足够的能量施法时才填满图标的宽度,而不是计时条从填满开始减少."
L["ICONMENU_ISPLAYER"] = "单位是玩家"
L["ICONMENU_ITEMCOOLDOWN"] = "物品冷却"
L["ICONMENU_ITEMCOOLDOWN_DESC"] = "检测可使用物品的冷却."
L["ICONMENU_LIGHTWELL_DESC"] = "检测你施放的%s的持续时间跟可用次数."
L["ICONMENU_MANACHECK"] = "能量检测"
L["ICONMENU_MANACHECK_DESC"] = [=[勾选此项启用当你魔法值/怒气/符能等等不足时改变图标颜色(或视为不可用).

译者注:除非特別说明,本插件中的能量一般是指法术施放所需的法力/怒气/符能/集中值等等,并非指盗贼/野德鲁伊的能量值.]=]
L["ICONMENU_META"] = "整合图标"
L["ICONMENU_META_DESC"] = [=[组合多个图标到一个图标.

在整合图标中被检测的那些图标即使设置为 %q 在可以显示时同样会显示.]=]
L["ICONMENU_META_ICONMENUTOOLTIP"] = "(%d个图标)"
L["ICONMENU_META_INHERITANCEBEHAVIOR"] = "高级继承行为"
L["ICONMENU_META_INHERITANCEBEHAVIOR_CNDTALPHA"] = "继承条件无效透明度"
L["ICONMENU_META_INHERITANCEBEHAVIOR_CNDTALPHA_DESC"] = [=[默认情况下,整合图标不会继承一个图标在条件无效时的透明度(除了透明度为0,图标会被隐藏,1-99都会被显示成100).

启用此选项使整合图标可以从图标那继承条件无效时的透明度.

注意:在启用了这个选项之后,整合图标自己所检测的条件将全部失效,不再有任何的效果.]=]
L["ICONMENU_META_INHERITANCEBEHAVIOR_CNDTALPHA_HELP"] = [=[嘿,看这边!

我只是想让你知道启用了该选项之后这个整合图标的所有条件都将无效,呃,其实我还想说点什么......

好吧,说完了. 祝你设置TMW愉快!]=]
L["ICONMENU_MOUSEOVER"] = "鼠标悬停目标"
L["ICONMENU_MOUSEOVERTARGET"] = "鼠标悬停目标的目标"
L["ICONMENU_MOVEHERE"] = "移动到此"
L["ICONMENU_MULTISTATECD"] = "多重状态技能"
L["ICONMENU_MULTISTATECD_DESC"] = [=[检测一个多重状态的技能.

此选项应当在你想要检测像是 %s 或 %s 这些多重状态/材质的冷却时间时使用.]=]
L["ICONMENU_MUSHROOMS"] = "%s"
L["ICONMENU_MUSHROOMS_DESC"] = "检测%s."
L["ICONMENU_NOTCOUNTING"] = "未倒数"
L["ICONMENU_NOTCOUNTING_DESC"] = "当图标计时器没在倒数时显示图标."
L["ICONMENU_OFFS"] = "偏移"
L["ICONMENU_ONFAIL"] = "在无效时"
L["ICONMENU_ONLYBAGS"] = "只在背包中存在时"
L["ICONMENU_ONLYBAGS_DESC"] = "勾选此项当物品在背包中(或者已装备)时显示图标,如果启用'已装备的物品',此选项会被强制启用。"
L["ICONMENU_ONLYEQPPD"] = "只在已装备时"
L["ICONMENU_ONLYEQPPD_DESC"] = "勾选此项让图标只在物品已装备时显示."
L["ICONMENU_ONLYIFCOUNTING"] = "仅在计时器倒数时显示"
L["ICONMENU_ONLYIFCOUNTING_DESC"] = "勾选此项使图标仅在计时器持续时间设置大于0并且正在倒数时显示."
L["ICONMENU_ONLYIFNOTCOUNTING"] = "仅在计时器倒数完毕时显示"
L["ICONMENU_ONLYIFNOTCOUNTING_DESC"] = "勾选此项使图标仅在计时器持续时间设置大于0并且倒数完毕时显示."
L["ICONMENU_ONLYINTERRUPTIBLE"] = "仅可打断"
L["ICONMENU_ONLYINTERRUPTIBLE_DESC"] = "仅在施法可打断时显示."
L["ICONMENU_ONLYMINE"] = "仅检测自己施放的"
L["ICONMENU_ONLYMINE_DESC"] = "勾选此项让该图标只显示你施放的增益或减益"
L["ICONMENU_ONLYSEEN"] = "仅显示施放过的法术"
L["ICONMENU_ONLYSEEN_DESC"] = "选择此项可以让图标只显示某单位至少施放过一次的法术冷却.如果你想在同一个图标中检测来自不同职业的法术那么应该勾上它."
L["ICONMENU_ONSUCCEED"] = "在通过时"
L["ICONMENU_PETTARGET"] = "宠物的目标"
L["ICONMENU_PRESENT"] = "存在"
L["ICONMENU_PRESENTONALL"] = "全都存在"
L["ICONMENU_PRESENTONALL_DESC"] = "设置在检测的所有单位中至少都有一个用于检测的增益/减益时的图标透明度."
L["ICONMENU_PRESENTONANY"] = "任一存在"
L["ICONMENU_PRESENTONANY_DESC"] = "设置在检测的所有单位中至少存在一个用于检测的增益/减益时的图标透明度."
L["ICONMENU_RANGECHECK"] = "距离检测"
L["ICONMENU_RANGECHECK_DESC"] = "勾选此项启用当你超出范围时改变图标颜色(或视为不可用)"
L["ICONMENU_REACT"] = "单位反应"
L["ICONMENU_REACTIVE"] = "触发性技能"
L["ICONMENU_REACTIVE_DESC"] = [=[检测触发性技能的可用情况.

触发性的技能指类似 %s, %s 和 %s 这些只能在某种特定条件下使用的技能.]=]
L["ICONMENU_RUNEOFPOWER_DESC"] = "检测来自天赋%s中的符文."
L["ICONMENU_RUNES"] = "符文冷却"
L["ICONMENU_RUNES_CHARGES"] = "不可用符文充能"
L["ICONMENU_RUNES_CHARGES_DESC"] = "启用此项,在一个符文获得额外充能并显示为可用时,让图标依然显示成符文正在冷却状态(显示为冷却时钟)."
L["ICONMENU_RUNES_DESC"] = "检测符文冷却."
L["ICONMENU_SHOWCBAR_DESC"] = "将会在跟图标重叠的下半部份显示剩余的冷却/持续时间的计量条(或是在'反转计量条'启用的情况下显示已用的时间)"
L["ICONMENU_SHOWPBAR_DESC"] = [=[将会在跟图标重叠的上半部份方显示你施放此法术还需多少能量的能量条(或是在'反转计量条'启用的情况下显示当前的能量).

译者注:这个能量可以是盗贼的能量,战士的怒气,猎人的集中值,其他职业的法力值等等.]=]
L["ICONMENU_SHOWSTACKS"] = "显示叠加数量"
L["ICONMENU_SHOWSTACKS_DESC"] = "勾选此项显示物品的叠加数量并启用叠加数量条件."
L["ICONMENU_SHOWTIMER"] = "显示计时器"
L["ICONMENU_SHOWTIMER_DESC"] = "勾选此项让该图标的冷却时钟动画在可用时显示.(译者注:此选项仅影响图标的时钟动画,就是技能冷却时的那个转圈效果,不包括数字在内哦.)"
L["ICONMENU_SHOWTIMERTEXT"] = "显示计时器数字"
L["ICONMENU_SHOWTIMERTEXT_DESC"] = [=[勾选此项在图标上显示剩余冷却时间或持续时间的数字.

需要已安裝OmniCC或其他冷却计时插件才可使用(译者注:某些冷却计时插件可能不支持此选项).]=]
L["ICONMENU_SHOWTIMERTEXT_NOOCC"] = "显示ElvUI计时器数字"
L["ICONMENU_SHOWTIMERTEXT_NOOCC_DESC"] = [=[勾选此项使用ElvUI的冷却数字来显示图标剩余的冷却时间/持续时间.

此设置仅用于ElvUI的计时器.如果你有其他插件提供类似此种计时器的功能(像是OmniCC),你可以利用%q选项来控制那些计时器. 我们不推荐两个选项同时启用.]=]
L["ICONMENU_SHOWTTTEXT"] = "显示变量文字"
L["ICONMENU_SHOWTTTEXT_DESC"] = [=[勾选此项显示从法术效果的提示信息中找到的第一个变量(数字).比如用此监视伤害护盾的剩余吸收量等等.

该数字会替代图标原有的叠加数量的数值,如果需要显示图标的叠加数量,请不要勾选此项.

数字是由暴雪API所提供,跟你在法术效果的提示信息中看到的数字可能会不同(像是服务器已经在线修正,客户端依然显示错误的数字这种情况),在大多数情况下都能显示正确的数字.

译者注:勾选此项后要在|cff7fffff文字显示方案|r选择|cff7fffff[Stacks]|r或|cff7fffff[Stacks:Hide(0)]|r,否则变量数字无法在图标正常显示。]=]
L["ICONMENU_SHOWWHEN"] = "何时显示图标"
L["ICONMENU_SHOWWHENNONE"] = "没有结果时显示"
L["ICONMENU_SHOWWHENNONE_DESC"] = "勾选此项允许在单位没有被检测到递减时显示图标."
L["ICONMENU_SHOWWHEN_OPACITY_GENERIC_DESC"] = "设置此图标在这个图标状态下用来显示的不透明度."
L["ICONMENU_SHOWWHEN_OPACITYWHEN_WRAP"] = "在%s|r时的不透明度"
L["ICONMENU_SHOWWHEN_SHOW_GENERIC_DESC"] = "设置此图标在这个图标状态下显示."
L["ICONMENU_SHOWWHEN_SHOWWHEN_WRAP"] = "在%s|r时显示"
L["ICONMENU_SORTASC"] = "持续时间升序"
L["ICONMENU_SORTASC_DESC"] = "勾选此项优先显示持续时间最低的法术."
L["ICONMENU_SORTASC_META_DESC"] = "勾选此项优先显示持续时间最低的图标."
L["ICONMENU_SORTDESC"] = "持续时间降序"
L["ICONMENU_SORTDESC_DESC"] = "勾选该项优先显示持续时间最高的法术."
L["ICONMENU_SORTDESC_META_DESC"] = "勾选此项优先显示持续时间最高的图标."
L["ICONMENU_SORT_STACKS_ASC"] = "叠加数量升序"
L["ICONMENU_SORT_STACKS_ASC_DESC"] = "勾选此项优先显示叠加数量最低的法术。"
L["ICONMENU_SORT_STACKS_DESC"] = "叠加数量降序"
L["ICONMENU_SORT_STACKS_DESC_DESC"] = "勾选此项优先显示叠加数量最高的法术。"
L["ICONMENU_SPELLCAST_COMPLETE"] = "施法结束/瞬发施法"
L["ICONMENU_SPELLCAST_COMPLETE_DESC"] = [=[如果是在下列情况开始内置冷却,请选择此项:

|cff7fffff1)|r在你施法结束后,或是
|cff7fffff2)|r在你施放一个瞬发法术后.

你需要在 %q 编辑框中输入触发内置冷却的法术名称或ID.]=]
L["ICONMENU_SPELLCAST_START"] = "施法开始"
L["ICONMENU_SPELLCAST_START_DESC"] = [=[如果是在下列情况开始内置冷却,请选择此项:

|cff7fffff1)|r在开始施法后.

你需要在 %q 编辑框中输入触发内置冷却的法术名称或ID.]=]
L["ICONMENU_SPELLCOOLDOWN"] = "法术冷却"
L["ICONMENU_SPELLCOOLDOWN_DESC"] = "检测在你法术书中的那些法术的冷却"
L["ICONMENU_SPLIT"] = "拆分成新的分组"
L["ICONMENU_SPLIT_DESC"] = "创建一个新的分组并将这个图标移动到上面. 原分组中的许多设置会保留到新的分组."
L["ICONMENU_STACKS_MAX_DESC"] = "允许图标显示的最大叠加数量,高于此数值图标将被隐藏."
L["ICONMENU_STACKS_MIN_DESC"] = "显示图标所需的最低叠加数量,低于此数值图标将被隐藏."
L["ICONMENU_STEALABLE"] = "仅可法术吸取"
L["ICONMENU_STEALABLE_DESC"] = "勾选此项仅显示能被“法术吸取”的增益，非常适合跟驱散类型中的魔法搭配使用。"
L["ICONMENU_SUCCEED2"] = "条件通过"
L["ICONMENU_SWAPWITH"] = "交换位置"
L["ICONMENU_SWINGTIMER"] = "攻击计时器"
L["ICONMENU_SWINGTIMER_DESC"] = "检测你的主手和副手武器的自动攻击时间."
L["ICONMENU_SWINGTIMER_NOTSWINGING"] = "无攻击"
L["ICONMENU_SWINGTIMER_SWINGING"] = "攻击中"
L["ICONMENU_TARGETTARGET"] = "目标的目标"
L["ICONMENU_TOTEM"] = "图腾"
L["ICONMENU_TOTEM_DESC"] = "检测你的图腾."
L["ICONMENU_TYPE"] = "图标类型"
L["ICONMENU_UNITCOOLDOWN"] = "单位冷却"
L["ICONMENU_UNITCOOLDOWN_DESC"] = [=[检测其他单位的冷却.

%s可以使用 %q 作为名称来检测.

译者注:玩家也可以作为被检测的单位.]=]
L["ICONMENU_UNIT_DESC"] = [=[在此框输入需要监视的单位,此单位能从右边的下拉列表插入,或者你是一位高端玩家可以自行输入需要监视的单位.多个单位请用分号分隔开(;),可使用标准单位(例如:player,target,mouseover等等可用在宏里的单位),或者友好玩家的名字(像是%s,Cybeloras,百战好哥哥等.)

需要了解更多关于单位的相关信息,请访问http://www.wowpedia.org/UnitId]=]
L["ICONMENU_UNIT_DESC_CONDITIONUNIT"] = [=[在此框输入需要监视的单位,此单位能从右边的下拉列表插入,或者你是一位高端玩家可以自行输入需要监视的单位.

可使用标准单位(例如:player,target,mouseover等等可用在宏里的单位),或者友好玩家的名字(像是%s,Cybeloras,百战好哥哥等.)

需要了解更多关于单位的相关信息,请访问http://www.wowpedia.org/UnitId]=]
L["ICONMENU_UNIT_DESC_UNITCONDITIONUNIT"] = [=[在此框输入需要监视的单位,此单位能从右边的下拉列表插入.

"unit"是指当前图标正在检测的任意单位.]=]
L["ICONMENU_UNITS"] = "单位"
L["ICONMENU_UNITSTOWATCH"] = "监视的单位"
L["ICONMENU_UNUSABLE"] = "不可用"
L["ICONMENU_USABLE"] = "可用"
L["ICONMENU_USEACTIVATIONOVERLAY"] = "检测激活边框"
L["ICONMENU_USEACTIVATIONOVERLAY_DESC"] = "检测系统默认提示技能可用时的黄色发光边框."
L["ICONMENU_VEHICLE"] = "载具"
L["ICONMENU_WPNENCHANT"] = "暂时性武器附魔"
L["ICONMENU_WPNENCHANT_DESC"] = "检测暂时性的武器附魔."
L["ICONMENU_WPNENCHANTTYPE"] = "要监视的武器栏"
L["IconModule_CooldownSweepCooldown"] = "冷却时钟"
L["IconModule_IconContainer_MasqueIconContainer"] = "图标容器"
L["IconModule_IconContainer_MasqueIconContainer_DESC"] = "容纳图标的主要部份,像是材质."
L["IconModule_PowerBar_OverlayPowerBar"] = "重叠式能量条"
L["IconModule_SelfIcon"] = "图标"
L["IconModule_Texture_ColoredTexture"] = "图标材质"
L["IconModule_TimerBar_BarDisplayTimerBar"] = "计时条(计量条显示)"
L["IconModule_TimerBar_OverlayTimerBar"] = "重叠式计时条"
L["ICONTOCHECK"] = "要检测的图标"
L["ICON_TOOLTIP2NEW"] = [=[|cff7fffff点击鼠标右键|r进入图标设置.
|cff7fffff点击鼠标右键并拖拽|r 移动/复制 到另一个图标.
|cff7fffff拖拽|r法术或者物品到图标上进行快速设置.]=]
L["ICON_TOOLTIP2NEWSHORT"] = "|cff7fffff点击鼠标右键|r进入图标设置."
L["ICONTYPE_DEFAULT_HEADER"] = "提示信息"
L["ICONTYPE_DEFAULT_INSTRUCTIONS"] = [=[要开始设置该图标,请先从%q下拉式菜单中选择一个图标类型.

图标只能在锁定状态才能正常运作,当你设置结束后记得输入"/TMW".


在设置TellMeWhen时,请仔细阅读每个设置选项的提示信息,里面会有如何设置的关键信息,可以让你事半功倍!]=]
L["ICONTYPE_SWINGTIMER_TIP"] = [=[你需要检测%s的时间吗?图标类型%q拥有你想要的功能. 只需简单设置一个%s来检测%q(法术ID:%d)!

你可以点击下方的按钮自动应用设置.]=]
L["ICONTYPE_SWINGTIMER_TIP_APPLYSETTINGS"] = "应用%s设置"
L["ImmuneToMagicCC"] = "免疫魔法控制"
L["ImmuneToStun"] = "免疫昏迷"
L["IMPORTERROR_FAILEDPARSE"] = "处理字符串时发生错误.请确保你复制的字符串是完整的."
L["IMPORTERROR_INVALIDTYPE"] = "尝试导入未知类型的数据,请检查是否已安装了最新版本的TellMeWhen."
L["IMPORT_EXPORT"] = "导出/导入/还原"
L["IMPORT_EXPORT_BUTTON_DESC"] = "点击此下拉式菜单来导入或导出图标/分组/配置文件."
L["IMPORT_EXPORT_DESC"] = [=[点击这个编辑框右侧的下拉式菜单的箭头来导出图标,分组或配置文件.

导出/导入字符串或发送给其他玩家需要使用这个编辑框. 具体的使用方法请看下拉式菜单上的提示信息.]=]
L["IMPORT_EXPORT_DESC_INLINE"] = "导出配置文件/分组/图标到字符串/其他玩家/其他配置文件/个人设置备份. 或从字符串/其他玩家/其他配置文件/个人设置备份导入到配置文件/分组/图标."
L["IMPORT_FROMBACKUP"] = "来自备份"
L["IMPORT_FROMBACKUP_DESC"] = "用这个菜单可以还原设置到: %s"
L["IMPORT_FROMBACKUP_WARNING"] = "备份设置: %s"
L["IMPORT_FROMCOMM"] = "来自玩家"
L["IMPORT_FROMCOMM_DESC"] = "如果其他TellMeWhen使用者给你发送了配置数据,可以从这个子菜单导入那些数据."
L["IMPORT_FROMLOCAL"] = "来自配置文件"
L["IMPORT_FROMSTRING"] = "来自字符串"
L["IMPORT_FROMSTRING_DESC"] = [=[字符串允许你在游戏以外的地方转存TellMeWhen配置数据.(包括用来给其他人分享自己的设置,或者导入其他人分享的设置,也可用来备份你自己的设置.)

从字符串导入的方法: 当复制TMW字符串到你的剪切板后,在'导出/导入'编辑框中按下CTRL+V贴上字符串,然后返回浏览这个子菜单.]=]
L["IMPORT_HEADING"] = "导入"
L["IMPORT_ICON_DISABLED_DESC"] = "你必须在设置一个图标的时候才能导入一个图标."
L["IMPORT_PROFILE"] = "复制配置文件"
L["IMPORT_PROFILE_NEW"] = "|cff59ff59创建|r新的配置文件"
L["IMPORT_PROFILE_OVERWRITE"] = "|cFFFF5959覆盖|r %s"
L["IMPORT_SUCCESSFUL"] = "导入成功!"
L["Incapacitated"] = "被瘫痪"
L["INCHEALS"] = "单位受到的治疗量"
L["INCHEALS_DESC"] = [=[检测单位即将受到的治疗量(包括下一跳HoT和施放中的治疗法术)

仅能在友好单位使用, 敌对单位会返回0.

译者註:由于暴雪API的限制, HoT只会返回单位框架上所显示的数值.]=]
L["IncreasedAP"] = "攻击强度提高"
L["IncreasedCrit"] = "暴击几率提高"
L["IncreasedMastery"] = "精通等级提高"
L["IncreasedPhysHaste"] = "物理急速提高"
L["IncreasedSP"] = "法术强度提高"
L["IncreasedSpellHaste"] = "法术急速提高"
L["IncreasedSPsix"] = "法术强度提高 (6%)"
L["IncreasedSPten"] = "法术强度提高 (10%)"
L["IncreasedStats"] = "属性提高"
L["INRANGE"] = "在范围内"
L["ITEMCOOLDOWN"] = "物品冷却"
L["ITEMEQUIPPED"] = "已装备物品"
L["ITEMINBAGS"] = "物品计数(包含次数)"
L["ITEMTOCHECK"] = "要检测的物品"
L["ITEMTOCOMP1"] = "进行比较的第一个物品"
L["ITEMTOCOMP2"] = "进行比较的第二个物品"
L["LAYOUTDIRECTION"] = "文字显示样式方向"
L["LAYOUTDIRECTION_1"] = "由右至下"
L["LAYOUTDIRECTION_2"] = "由左至下"
L["LAYOUTDIRECTION_3"] = "由左至上"
L["LAYOUTDIRECTION_4"] = "由右至上"
L["LAYOUTDIRECTION_5"] = "由下至右"
L["LAYOUTDIRECTION_6"] = "由下至左"
L["LAYOUTDIRECTION_7"] = "由上至左"
L["LAYOUTDIRECTION_8"] = "由上至右"
L["LAYOUTDIRECTION_DESC"] = "设置图标在分组中的文字显示样式的方向."
L["LDB_TOOLTIP1"] = "|cff7fffff左键点击|r 锁定或解锁分组"
L["LDB_TOOLTIP2"] = "|cff7fffff右键点击|r 显示主选项"
L["LEFT"] = "左"
L["LOADERROR"] = "TellMeWhen设置插件无法加载:"
L["LOADINGOPT"] = "正在加载TellMeWhen设置插件."
L["LOCKED"] = "已锁定"
L["LOSECONTROL_CONTROLLOST"] = "失去控制"
L["LOSECONTROL_DROPDOWNLABEL"] = "失去控制类型"
L["LOSECONTROL_DROPDOWNLABEL_DESC"] = "选择你需要作用于图标的失去控制的类型(译者注:可多选)."
L["LOSECONTROL_ICONTYPE"] = "失去控制"
L["LOSECONTROL_ICONTYPE_DESC"] = "检测那些造成你角色失去控制权的效果."
L["LOSECONTROL_INCONTROL"] = "可控制"
L["LOSECONTROL_TYPE_ALL"] = "全部类型"
L["LOSECONTROL_TYPE_ALL_DESC"] = "让图标显示所有相关类型的信息."
L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"] = "注意:图标无法判断这个失去控制的类型是否已使用."
L["LOSECONTROL_TYPE_MAGICAL_IMMUNITY"] = "魔法免疫"
L["LOSECONTROL_TYPE_SCHOOLLOCK"] = "法术类别被锁定"
L["LUACONDITION"] = "Lua(高玩级)"
L["LUACONDITION_DESC"] = [=[此条件类型允许你使用Lua语言来评估一个条件的状态。(非高玩慎入！)

输入不能为'if..then'叙述,也不能为function closure。它可以是一个普通的叙述评估，例如：‘a and b or c’。如果需要复杂功能，可使用函数调用，例如：’CheckStuff()‘，这是一个外部函数。(也可使用Lua片段功能)。

如果需要更多的帮助(但不是关于如何去写Lua代码)，到CurseForge提交一份回报单。关于如何编写Lua代码，请自行去互联网搜索资料。

PS：Lua语言部份就不翻译了，翻译了反而觉得怪怪的。]=]
L["MACROCONDITION"] = "宏命令条件语"
L["MACROCONDITION_DESC"] = [=[此条件将会评估宏命令条件语,在宏命令条件语成立时则此条件通过.
所有的宏命令条件语都能在前面加上"no"进行逆向检测.
例子:
"[nomodifier:alt]" - 没有按住ALT键
"[@target, help][mod:ctrl]" - 目标是友好的或者按住CTRL键
"[@focus, harm, nomod:shift]" - 焦点目标是敌对的同时没有按住SHIFT键

需要更多的帮助,请访问http://www.wowpedia.org/Making_a_macro]=]
L["MACROCONDITION_EB_DESC"] = "使用单一条件时中括号是可选的,使用多个条件语时中括号是必须的.​​(说明:中括号->'[ ]')"
L["MACROTOEVAL"] = "输入需要评估的宏命令条件语(允许多个)"
L["Magic"] = "魔法"
L["MAIN"] = "主页面"
L["!!Main Addon Description"] = "为冷却、增益/减益及其他各个方面提供视觉、听觉以及文字上的通知。"
L["MAINASSIST"] = "主助攻"
L["MAIN_DESC"] = "包含这个图标的主要选项."
L["MAINTANK"] = "主坦克"
L["MAKENEWGROUP"] = "|cff59ff59创建|r新分组"
L["MELEECRIT"] = "近战暴击"
L["MELEEHASTE"] = "近战加速"
L["MESSAGERECIEVE"] = "%s给你发送了一些TellMeWhen数据!你可以使用图标编辑器中的 %q 下拉式菜单把数据导入TellMeWhen."
L["MESSAGERECIEVE_SHORT"] = "%s给你发送了一些TellMeWhen数据!"
L["META_ADDICON"] = "增加图标"
L["META_ADDICON_DESC"] = "点击新增图标到此整合图标中."
L["META_GROUP_INVALID_VIEW_DIFFERENT"] = [=[该分组的图标不能用于整合图标检测,因为它们使用不同的显示方式.

分组:%s
目标分组:%s]=]
L["METAPANEL_DOWN"] = "往下移动"
L["METAPANEL_REMOVE"] = "移除此图标"
L["METAPANEL_REMOVE_DESC"] = "点击从整合图标检测列表中移除该图标."
L["METAPANEL_UP"] = "往上移动"
L["MISCELLANEOUS"] = "其他"
L["MiscHelpfulBuffs"] = "其他增益"
L["MOON"] = "月蚀"
L["MOUSEOVERCONDITION"] = "鼠标指针悬停"
L["MOUSEOVERCONDITION_DESC"] = "此条件检测你的鼠标指针是否有悬停在此图标上,如果是分组条件则是鼠标指针是否有悬停在此分组的某个图标上."
L["MOUSEOVER_TOKEN_NOT_FOUND"] = "无鼠标悬停目标"
L["MovementSlowed"] = "移动速度降低"
L["MP5"] = "%d 5秒回蓝"
L["MUSHROOM"] = "蘑菇 %d"
L["MUSHROOMS"] = "检测蘑菇"
L["NEWVERSION"] = "检测到新版本可升级:(%s)"
L["NONE"] = "不包含任何一个"
L["normal"] = "普通"
L["NOTINRANGE"] = "不在范围内"
L["NOTYPE"] = "<无图标类型>"
L["NUMAURAS"] = "数量"
L["NUMAURAS_DESC"] = [=[此条件仅检测一个作用中的法术效果的数量- 不要与法术效果的叠加数量混淆.
像是你的两个相同的武器附魔特效同时触发并且在作用中.
请有节制的使用它,此过程需要消耗不少CPU运算来计算数量.]=]
L["ONLYCHECKMINE"] = "仅检测自己施放的"
L["ONLYCHECKMINE_DESC"] = "选择此项让该条件只检测自己施放的增益/减益"
L["OUTLINE_MONOCHORME"] = "单色"
L["OUTLINE_NO"] = "没有描边"
L["OUTLINE_THICK"] = "粗描边"
L["OUTLINE_THIN"] = "细描边"
L["OVERWRITEGROUP"] = "|cFFFF5959覆盖|r分组: %s"
L["PARENTHESIS_TYPE_("] = "左括号'('"
L["PARENTHESIS_TYPE_)"] = "右括号')'"
L["PARENTHESIS_WARNING1"] = [=[左右括号的数量不相等!

缺少%d个%s.]=]
L["PARENTHESIS_WARNING2"] = [=[一些右括号缺少左括号!

缺少%d个左括号'('.]=]
L["PERCENTAGE"] = "百分比"
L["PET_TYPE_CUNNING"] = "狡诈"
L["PET_TYPE_FEROCITY"] = "狂野"
L["PET_TYPE_TENACITY"] = "坚韧"
L["PhysicalDmgTaken"] = "受到的物理伤害提高"
L["PLAYER_DESC"] = "(你)"
L["Poison"] = "毒"
L["PRESENCE"] = "灵气(领域)"
L["PROFILE_LOADED"] = "已读取配置文件: %s"
L["PvPSpells"] = "PVP控场技能等"
L["QUESTIDTOCHECK"] = "用于检测的任务ID"
L["RAID_WARNING_FAKE"] = "团队警报 (假)"
L["RAID_WARNING_FAKE_DESC"] = "输出类似于团队警报信息的文字,此信息不会被其他人看到,你不需要团队权限,也不需要在团队中即可使用."
L["RaidWarningFrame"] = "团队警告框架"
L["RANGEDCRIT"] = "物理远程暴击"
L["RANGEDHASTE"] = "物理远程急速"
L["rare"] = "稀有"
L["rareelite"] = "稀有精英"
L["REACTIVECNDT_DESC"] = "此条件仅检测技能的触发/激活情况,并非它的冷却."
L["REDO_ICON"] = "恢复"
L["REDO_ICON_DESC"] = "恢复最近一次图标设置的撤消动作."
L["ReducedArmor"] = "降低护甲"
L["ReducedCastingSpeed"] = "降低施法速度"
L["ReducedHealing"] = "治疗效果降低"
L["ReducedPhysicalDone"] = "造成的物理伤害降低"
L["REQFAILED_ALPHA"] = "无效时的不透明度"
L["RESET_ICON"] = "重置"
L["RESIZE"] = "调整大小"
L["RESIZE_TOOLTIP"] = "|cff7fffff点击并拖拽|r以改变大小"
L["RESIZE_TOOLTIP_SCALEXY"] = [=[|cff7fffff点击同时拖曳|r快速调整尺寸
|cff7fffff按住CTRL|r微调尺寸]=]
L["RESIZE_TOOLTIP_SCALEY_SIZEX"] = "|cff7fffff点击并拖动|r来改变大小"
L["RIGHT"] = "右"
L["Rooted"] = "被缠绕"
L["RUNEOFPOWER"] = "符文%d"
L["RUNES"] = "要检测的符文"
L["RUNESOFPOWER"] = "用于检测的符文"
L["RUNSPEED"] = "单位奔跑速度"
L["SAFESETUP_COMPLETE"] = "安全&慢速设置完成."
L["SAFESETUP_FAILED"] = "安全&慢速设置失败:%s"
L["SAFESETUP_TRIGGERED"] = "正在进行安全&慢速设置..."
L["SEAL"] = "圣印"
L["SENDSUCCESSFUL"] = "已成功发送"
L["SHAPESHIFT"] = "变身"
L["Shatterable"] = "冰冻"
L["Silenced"] = "被沉默"
L["Slowed"] = "被减速"
L["SORTBY"] = "排列方式"
L["SORTBYNONE"] = "正常排列"
L["SORTBYNONE_DESC"] = [=[如果选中，法术将按照"%s"编辑框中的输入顺序来检测并排列。

如果是一个增益/减益图标，只要出现在单位框体上的法术效果数字没有超出效率阀值设定，就会被检测并排列。

(PS：如果看不懂请无视这段说明，只要知道它是按照你输入的顺序来排列就好。)]=]
L["SORTBYNONE_DURATION"] = "持续时间正常"
L["SORTBYNONE_META_DESC"] = "如果勾选,被检测的图标将使用上面的列表所设置的顺序来排列."
L["SORTBYNONE_STACKS"] = "叠加数量正常"
L["SOUND_CHANNEL"] = "音效播放频道"
L["SOUND_CHANNEL_DESC"] = [=[选择一个你想用于播放声音的频道(会直接使用在系统->音效中该频道所设置的音量跟设定来播放).

选择%q时,可以在音效关闭时播放声音.]=]
L["SOUND_CHANNEL_MASTER"] = "主声道"
L["SOUND_CUSTOM"] = "自定义音效文件"
L["SOUND_CUSTOM_DESC"] = [=[输入需要用来播放的自定义音效文件的路径.
下面是一些例子,其中"File"是你的音效文件名,"ext"是后缀名(只能用ogg或者mp3格式)

-"CustomSounds\File.ext": 一个文件放在WOW主目录一个命名为"CustomSound"的新建文件夹中(此文件夹同WOW.exe,Interface和WTF在同一位置)
-"Interface\AddOns\file.ext": 插件文件夹中的某一文件
-"file.ext": WOW主目录的某个文件

注意:魔兽世界必须在重开之后才能正常使用那些在它启动时还不存在的文件.]=]
L["SOUNDERROR1"] = "文件必须有后缀名!"
L["SOUNDERROR2"] = [=[魔兽世界4.0+不支持自定义WAV文件

(WoW自带WAV音效可以使用)]=]
L["SOUNDERROR3"] = "只支持OGG跟MP3文件!"
L["SOUND_ERROR_ALLDISABLED"] = [=[无法进行音效播放测试，原因：游戏音效已经被完全禁用。

你需要去更改暴雪音效选项的相关设置。]=]
L["SOUND_ERROR_DISABLED"] = [=[无法进行音效播放测试，原因：音效播放频道 %q 已经被禁用。

你需要去更改暴雪音效选项的相关设置，或者你也可以在TellMeWhen的主选项中更改TellMeWhen的音效播放频道('/tmw options')。]=]
L["SOUND_ERROR_MUTED"] = [=[无法进行音效播放测试，原因：音效播放频道 %q 的音量大小为0。

你需要去更改暴雪音效选项的相关设置，或者你也可以在TellMeWhen的主选项中更改TellMeWhen的音效播放频道('/tmw options')。]=]
L["SOUND_EVENT_DISABLEDFORTYPE"] = "不可用"
L["SOUND_EVENT_DISABLEDFORTYPE_DESC2"] = [=[在当前图标设置下,此事件不可用.

可能因为当前的图标类型(%s)还不支持此事件,请|cff7fffff右键点击|r更改事件类型.]=]
L["SOUND_EVENT_GLOBALDESC"] = "在此列表中的事件是按照从上到下的顺序来检测.如果一个事件触发并且播放了音效,在它之后的事件不会再播放任何音效."
L["SOUND_EVENT_ONALPHADEC"] = "在透明度百分比减少时"
L["SOUND_EVENT_ONALPHADEC_DESC"] = [=[当图标的不透明度降低时触发此事件.

注意:不透明度在降低后如果为0%不会触发此事件(如果有需要请使用"在隐藏时").]=]
L["SOUND_EVENT_ONALPHAINC"] = "在透明度百分比增加时"
L["SOUND_EVENT_ONALPHAINC_DESC"] = [=[当图标的不透明度提高时触发此事件.

注意:不透明度在提高前如果为0%不会触发此事件(如果有需要请使用"在显示时").]=]
L["SOUND_EVENT_ONCLEU"] = "在战斗事件发生时"
L["SOUND_EVENT_ONCLEU_DESC"] = "此事件在图标应当处理的战斗事件发生时触发."
L["SOUND_EVENT_ONCONDITION"] = "在设置的条件通过时"
L["SOUND_EVENT_ONCONDITION_DESC"] = "当你设置的条件通过时触发此事件."
L["SOUND_EVENT_ONDURATION"] = "在持续时间改变时"
L["SOUND_EVENT_ONDURATION_DESC"] = [=[此事件在图标计时器的持续时间改变时触发.

因为在计时器运行时每次图标更新都会触发该事件,你必须设置一个条件,使事件仅在条件的状态改变时触发.]=]
L["SOUND_EVENT_ONEVENTSRESTORED"] = "在图标设置后"
L["SOUND_EVENT_ONEVENTSRESTORED_DESC"] = [=[此事件在图标已经设置完毕后触发.

这主要发生在你退出设置模式时,同样也会发生在某些区域的进入事件或离开事件.

你可以视它为图标的"软重置".

此事件比较常用于创建一个图标的默认状态的动画.]=]
L["SOUND_EVENT_ONFINISH"] = "在结束时"
L["SOUND_EVENT_ONFINISH_DESC"] = "当冷却结束,增益/减益消失,等相似的情况下触发此事件."
L["SOUND_EVENT_ONHIDE"] = "在隐藏时"
L["SOUND_EVENT_ONHIDE_DESC"] = "当图标隐藏时触发此事件.(即使 %q 已勾选)"
L["SOUND_EVENT_ONICONHIDE"] = "在其他图标隐藏时"
L["SOUND_EVENT_ONICONHIDE_DESC"] = [=[此事件会在另一个图标隐藏时触发(不是当前你在设置的这个图标哦,是另一个).

使用下面的事件设置选项来配置那个被检测的图标.]=]
L["SOUND_EVENT_ONICONSHOW"] = "在其他图标显示时"
L["SOUND_EVENT_ONICONSHOW_DESC"] = [=[此事件会在另一个图标显示时触发(不是当前你在设置的这个图标哦,是另一个).

使用下面的事件设置选项来配置那个被检测的图标.]=]
L["SOUND_EVENT_ONLEFTCLICK"] = "在鼠标左键点击时"
L["SOUND_EVENT_ONLEFTCLICK_DESC"] = "在图标锁定的情况下,当你|cff7fffff用鼠标左键点击|r这个图标时触发此事件."
L["SOUND_EVENT_ONRIGHTCLICK"] = "在鼠标右键点击时"
L["SOUND_EVENT_ONRIGHTCLICK_DESC"] = "在图标锁定的情况下,当你|cff7fffff用鼠标右键点击|r这个图标时触发此事件."
L["SOUND_EVENT_ONSHOW"] = "在显示时"
L["SOUND_EVENT_ONSHOW_DESC"] = "当图标显示时触发此事件.(即使 %q 已勾选)"
L["SOUND_EVENT_ONSPELL"] = "在法术改变时"
L["SOUND_EVENT_ONSPELL_DESC"] = "当图标显示信息中的法术/物品/等改变时触发此事件."
L["SOUND_EVENT_ONSTACK"] = "在叠加数量改变时"
L["SOUND_EVENT_ONSTACK_DESC"] = [=[此事件在图标所检测的法术/物品等的叠加数量发生改变时触发.

包括逐渐降低的%s图标.]=]
L["SOUND_EVENT_ONSTART"] = "在开始时"
L["SOUND_EVENT_ONSTART_DESC"] = "当冷却开始,增益/减益开始作用,等相似的情况下触发此事件."
L["SOUND_EVENT_ONUNIT"] = "在单位改变时"
L["SOUND_EVENT_ONUNIT_DESC"] = "当图标显示信息中的单位改变时触发此事件."
L["SOUND_SOUNDTOPLAY"] = "要播放的音效"
L["SOUND_TAB"] = "音效"
L["SPEED"] = "单位速度"
L["SPEED_DESC"] = [=[这是指单位当前的移动速度,如果单位不移动则为0.
如果您要检测单位的最高奔跑速度,可以使用"单位奔跑速度"条件来代替.]=]
L["SPELLCHARGES"] = "法术次数"
L["SPELLCHARGES_DESC"] = "检测像是%s或%s这类法术的可用次数."
L["SPELLCHARGES_FULLYCHARGED"] = "完全恢复"
L["SPELLCHARGETIME"] = "法术次数恢复时间"
L["SPELLCHARGETIME_DESC"] = "检测像是%s或%s恢复一次充能还需要多少时间."
L["SPELLCOOLDOWN"] = "法术冷却"
L["SPELLCRIT"] = "法术暴击"
L["SpellDamageTaken"] = "受到的的法术伤害提高"
L["SPELLHASTE"] = "法术急速"
L["SPELLREACTIVITY"] = "法术反应(激活/触发/可能)"
L["SPELLTOCHECK"] = "要检测的法术"
L["SPELLTOCOMP1"] = "进行比较的第一个法术"
L["SPELLTOCOMP2"] = "进行比较的第二个法术"
L["STACKALPHA_DESC"] = "设置在你要求的叠加数量不符合时图标显示的不透明度."
L["STACKS"] = "叠加数量"
L["STACKSPANEL_TITLE2"] = "叠加数量限制"
L["STANCE"] = "姿态"
L["STANCE_DESC"] = [=[你可以利用分号(;)输入多个用于检测的姿态.

此条件会在任意一个姿态符合时通过.]=]
L["STANCE_LABEL"] = "姿态"
L["STRATA_BACKGROUND"] = "背景(最低)"
L["STRATA_DIALOG"] = "对话框"
L["STRATA_FULLSCREEN"] = "全屏幕"
L["STRATA_FULLSCREEN_DIALOG"] = "全屏幕对话框"
L["STRATA_HIGH"] = "高"
L["STRATA_LOW"] = "低"
L["STRATA_MEDIUM"] = "中"
L["STRATA_TOOLTIP"] = "提示信息(最高)"
L["Stunned"] = "被昏迷"
L["SUG_ATBEGINING"] = "提示与建议:起始文字相符"
L["SUG_ATBEGINING_DESC"] = [=[如果勾选,提示与建议列表将只显示名称开头位置与正在输入的文字完全相同的法术,否则将显示那些在任意位置含有正在输入文字的法术.

举例说明:比如你输入了一个'言'字,在勾选的情况下,提示与建议列表只会显示'言'字开头的法术,如果没有勾选,它会显示像是'暗言术:痛','真言术:盾'这样的法术.]=]
L["SUG_BUFFEQUIVS"] = "同类型增益"
L["SUG_CLASSSPELLS"] = "已知玩家/宠物的法术"
L["SUG_DEBUFFEQUIVS"] = "同类型减益"
L["SUG_DISPELTYPES"] = "驱散类型"
L["SUG_FINISHHIM"] = "马上结束缓存"
L["SUG_FINISHHIM_DESC"] = "|cff7fffff点击|r快速完成该缓存/筛选过程. 友情提示:你的电脑可能会因此卡住几秒钟的时间."
L["SUG_FIRSTHELP_DESC"] = [=[这是一个提示与建议列表，它可以显示相关的条目供你选择以加快设置速度。

如果你只需要插入名称，可以无视条目的ID是否正确，只要名称完全相同即可。

大部分情况下，用名称来检测是比较好的选择。在同个名称存在多个不同效果可能发生重叠的情况下你才需要使用ID来检测。

无论何时按下Tab键都会插入显示在第一行的条目。如果你输入的是一个名称，则右键点击条目会插入一个ID，反之亦然,你输入的是ID则点右键会插入一个名称。]=]
L["SUGGESTIONS"] = "提示与建议:"
L["SUGGESTIONS_DOGTAGS"] = "DogTags:"
L["SUG_INSERT_ANY"] = "|cff7fffff点击鼠标|r"
L["SUG_INSERTEQUIV"] = "%s 插入同类型条目"
L["SUG_INSERTID"] = "%s插入编号(ID)"
L["SUG_INSERTITEMSLOT"] = "%s插入物品对应的装备栏编号"
L["SUG_INSERT_LEFT"] = "|cff7fffff点击鼠标左键|r"
L["SUG_INSERTNAME"] = "%s插入名称"
L["SUG_INSERTNAME_INTERFERE"] = [=[%s插入名称。

|TInterface\AddOns\TellMeWhen\Textures\Alert:0:2|t|cffffa500CAUTION: |TInterface\AddOns\TellMeWhen\Textures\Alert:0:2|t|cffff1111
此法术可能有多个效果。
如果使用名称可能无法被正确的检测。
你应当使用一个ID来检测。|r]=]
L["SUG_INSERT_RIGHT"] = "|cff7fffff点击鼠标右键|r"
L["SUG_INSERT_TAB"] = "或者按|cff7fffffTab|r键"
L["SUG_INSERTTEXTSUB"] = "%s插入标签"
L["SUG_MATCH_WPNENCH_ENCH"] = "(.*)"
L["SUG_MISC"] = "杂项"
L["SUG_MSCDONBARS"] = "有效的多重状态冷却"
L["SUG_NPCAURAS"] = "已知NPC的增益/减益"
L["SUG_OTHEREQUIVS"] = "其他同类型"
L["SUG_PATTERNMATCH_FISHINGLURE"] = "鱼饵%（%+%d+钓鱼技能%）"
L["SUG_PATTERNMATCH_SHARPENINGSTONE"] = "磨快%（%+%d+伤害%）"
L["SUG_PATTERNMATCH_WEIGHTSTONE"] = "增重%（%+%d+伤害%）"
L["SUG_PLAYERAURAS"] = "已知玩家/宠物的增益/减益"
L["SUG_PLAYERSPELLS"] = "你的法术"
L["SUG_SUBSTITUTION_d"] = "剩余持续时间"
L["SUG_SUBSTITUTION_d_DESC"] = "图标计时器剩余的持续时间"
L["SUG_SUBSTITUTION_e"] = "事件目标单位"
L["SUG_SUBSTITUTION_e_DESC"] = "在图标最近一次处理的战斗事件中有接收行为的单位."
L["SUG_SUBSTITUTION_f"] = "焦点目标的名字"
L["SUG_SUBSTITUTION_f_DESC"] = "你当前的焦点目标的名字"
L["SUG_SUBSTITUTION_k"] = "当前叠加数量文字"
L["SUG_SUBSTITUTION_k_DESC"] = "图标叠加数量文字当前所显示的任何内容"
L["SUG_SUBSTITUTION_m"] = "鼠标悬停目标的名字"
L["SUG_SUBSTITUTION_m_DESC"] = "你当前鼠标指針指向的单位的名字"
L["SUG_SUBSTITUTION_o"] = "事件来源单位"
L["SUG_SUBSTITUTION_o_DESC"] = "在图标最近一次处理的战斗事件中有发起行为的单位."
L["SUG_SUBSTITUTION_p"] = "上一个单位"
L["SUG_SUBSTITUTION_p_DESC"] = "上一个的被检测的单位的名字"
L["SUG_SUBSTITUTION_s"] = "当前法术/物品/等"
L["SUG_SUBSTITUTION_s_DESC"] = "当前被检测的法术/物品/等的名字"
L["SUG_SUBSTITUTION_t"] = "目标的名字"
L["SUG_SUBSTITUTION_t_DESC"] = "你当前所选的目标单位的名字"
L["SUG_SUBSTITUTION_u"] = "当前单位"
L["SUG_SUBSTITUTION_u_DESC"] = "当前被检测的单位的名字"
L["SUG_SUBSTITUTION_x"] = "额外法术"
L["SUG_SUBSTITUTION_x_DESC"] = "在战斗事件中像是驱散,打断以及效果被破坏时,会记录造成此事件的那些技能的额外数据. 此变量可以用来代替战斗事件中的那些技能."
L["SUG_TOOLTIPTITLE"] = [=[当你输入时,TellMeWhen将会在缓存中查找并提示你最有可能输入的法术.

法术按照以下列表分类跟着色.
注意:在记录到相应的数据之前或者在你没有登陆过其他的职业的情况下不会把那些法术放入"已知"开头的分类中.

点击一个条目将其插入到编辑框.

]=]
L["SUG_TOOLTIPTITLE_TEXTSUBS"] = [=[下列的单位变量可以使用在输出显示的文字内容中.变量将会被替换成与其相应的内容后再输出显示.

点击一个条目将其插入到编辑框中.]=]
L["SUN"] = "日蚀"
L["SWINGTIMER"] = "攻击计时"
L["TANK"] = "坦克"
L["TEXTLAYOUTS"] = "文字显示样式"
L["TEXTLAYOUTS_ADDANCHOR"] = "增加描点"
L["TEXTLAYOUTS_ADDANCHOR_DESC"] = "点击增加文字描点."
L["TEXTLAYOUTS_ADDLAYOUT"] = "新增文字显示样式"
L["TEXTLAYOUTS_ADDLAYOUT_DESC"] = "创建一个你可自行配置并应用到图标的文字显示样式."
L["TEXTLAYOUTS_ADDSTRING"] = "新增文字显示方案"
L["TEXTLAYOUTS_ADDSTRING_DESC"] = "添加一个新的文字显示方案到此文字显示样式中."
L["TEXTLAYOUTS_BLANK"] = "(空白)"
L["TEXTLAYOUTS_CHOOSELAYOUT"] = "选择样式..."
L["TEXTLAYOUTS_CHOOSELAYOUT_DESC"] = "选取此图标要使用的文字显示样式."
L["TEXTLAYOUTS_CLONELAYOUT"] = "克隆显示样式"
L["TEXTLAYOUTS_CLONELAYOUT_DESC"] = "点击创建一个该显示样式的副本,你可以单独修改它."
L["TEXTLAYOUTS_DEFAULTS_BAR1"] = "计量条显示样式 1"
L["TEXTLAYOUTS_DEFAULTS_BINDINGLABEL"] = "绑定/标签"
L["TEXTLAYOUTS_DEFAULTS_CENTERNUMBER"] = "居中数字"
L["TEXTLAYOUTS_DEFAULTS_DURATION"] = "持续时间"
L["TEXTLAYOUTS_DEFAULTS_ICON1"] = "图标样式 1"
L["TEXTLAYOUTS_DEFAULTS_NOLAYOUT"] = "<无显示样式>"
L["TEXTLAYOUTS_DEFAULTS_NUMBER"] = "数字"
L["TEXTLAYOUTS_DEFAULTS_SPELL"] = "法术"
L["TEXTLAYOUTS_DEFAULTS_STACKS"] = "叠加数量"
L["TEXTLAYOUTS_DEFAULTS_WRAPPER"] = "默认: %s"
L["TEXTLAYOUTS_DEFAULTTEXT"] = "默认显示文字"
L["TEXTLAYOUTS_DEFAULTTEXT_DESC"] = "修改文字显示样式在图标上显示的默认文字."
L["TEXTLAYOUTS_DELANCHOR"] = "删除描点"
L["TEXTLAYOUTS_DELANCHOR_DESC"] = "点击删除该文字描点."
L["TEXTLAYOUTS_DELETELAYOUT"] = "删除文字显示样式"
L["TEXTLAYOUTS_DELETELAYOUT_CONFIRM_BASE"] = "确定要删除文字显示样式 %q?"
L["TEXTLAYOUTS_DELETELAYOUT_CONFIRM_NUM"] = "|cFFFF5959有%d个图标使用了此文字显示样式,将会恢复使用默认文字显示样式.|r"
L["TEXTLAYOUTS_DELETELAYOUT_DESC"] = [=[点击删除文字显示样式.

按住Ctrl键跳过确认.]=]
L["TEXTLAYOUTS_DELETESTRING"] = "删除文字显示方案"
L["TEXTLAYOUTS_DELETESTRING_DESC"] = "删除文字显示样式下的该文字显示方案."
L["TEXTLAYOUTS_DISABLEDBYSKIN"] = "如果你使用了Masque皮肤美化这个文字显示方案,将无法对此项设置做出更改."
L["TEXTLAYOUTS_ERROR_FALLBACK"] = [=[找不到此图标使用的文字显示样式.在找到相符的显示样式或选择其他的显示样式之前将使用默认文字显示样式.

(你是不是删除了相关的文字显示样式?或只有导入图标而没导入它使用的文字显示样式?)]=]
L["TEXTLAYOUTS_fLAYOUT"] = "文字显示样式: %s"
L["TEXTLAYOUTS_FONTSETTINGS"] = "字体设置"
L["TEXTLAYOUTS_fSTRING"] = "文字显示方案 %s"
L["TEXTLAYOUTS_fSTRING2"] = "文字显示方案 %d: %s"
L["TEXTLAYOUTS_fSTRING3"] = "文字显示方案:%s"
L["TEXTLAYOUTS_HEADER_LAYOUT"] = "文字显示样式"
L["TEXTLAYOUTS_IMPORT"] = "导入文字显示样式"
L["TEXTLAYOUTS_IMPORT_CREATENEW"] = "|cff59ff59新增|r"
L["TEXTLAYOUTS_IMPORT_CREATENEW_DESC"] = [=[文字显示样式中已有一个跟该显示样式相同的唯一标识.

选择此项创建一个新的唯一标识并导入这个显示样式.]=]
L["TEXTLAYOUTS_IMPORT_NORMAL_DESC"] = "点击导入文字显示样式."
L["TEXTLAYOUTS_IMPORT_OVERWRITE"] = "|cFFFF5959替换|r 现有"
L["TEXTLAYOUTS_IMPORT_OVERWRITE_DESC"] = [=[文字显示样式中已有一个跟需要导入的显示样式相同的唯一标识.

选择此项覆盖已有唯一标识的显示样式并导入新的显示样式.那些正在使用被覆盖掉的那个文字显示样式的图标都会在导入后自动作出相应的更新.]=]
L["TEXTLAYOUTS_IMPORT_OVERWRITE_DISABLED_DESC"] = "你不能覆盖默认文字显示样式."
L["TEXTLAYOUTS_LAYOUTDISPLAYS"] = [=[文字显示方案:
%s]=]
L["TEXTLAYOUTS_LAYOUT_SETDEFAULTS"] = "重置为默认"
L["TEXTLAYOUTS_LAYOUT_SETDEFAULTS_DESC"] = "重置当前文字显示样式设置中所有方案的文字为默认显示文字."
L["TEXTLAYOUTS_LAYOUTSETTINGS"] = "显示样式设置"
L["TEXTLAYOUTS_LAYOUTSETTINGS_DESC"] = "点击设置文字显示样式 %q."
L["TEXTLAYOUTS_NOEDIT_DESC"] = [=[这个文字显示样式是TellMeWhen默认的文字显示样式,你无法对其作出更改.

如果你想更改的话,请克隆一份此文字显示样式的副本.]=]
L["TEXTLAYOUTS_POINT_DESC"] = "文字显示方案将会依附于对象的位置"
L["TEXTLAYOUTS_POSITIONSETTINGS"] = "位置设定"
L["TEXTLAYOUTS_RELATIVEPOINT_DESC"] = "文字显示方案将会在对象上依附的位置"
L["TEXTLAYOUTS_RELATIVETO_DESC"] = "文字将依附的对象"
L["TEXTLAYOUTS_RENAME"] = "重命名显示样式"
L["TEXTLAYOUTS_RENAME_DESC"] = "为此文字显示样式修改一个与其用途相符的名称,让你可以轻松的找到它."
L["TEXTLAYOUTS_RENAMESTRING"] = "重命名文字显示方案"
L["TEXTLAYOUTS_RENAMESTRING_DESC"] = "为此文字显示方案修改一个与其用途相符的名称,让你可以轻松的找到它."
L["TEXTLAYOUTS_RESETSKINAS"] = "%q设置用于文字%q将被重置,以防止跟文字%q的新设置产生冲突."
L["TEXTLAYOUTS_SETGROUPLAYOUT"] = "文字显示样式"
L["TEXTLAYOUTS_SETGROUPLAYOUT_DDVALUE"] = "选择显示样式..."
L["TEXTLAYOUTS_SETGROUPLAYOUT_DESC"] = [=[设置使用于这个分组所有图标的文字显示样式.

每个图标的文字显示样式也可以自行单独设置.]=]
L["TEXTLAYOUTS_SETTEXT"] = "设置显示文字"
L["TEXTLAYOUTS_SETTEXT_DESC"] = [=[设置用于这个文字显示方案中的文字.

文字可能会被转化为DogTag标记的格式,以便动态显示信息. 关于如何使用DogTag标记,请输入'/dogtag'或'/dt'查看帮助.]=]
L["TEXTLAYOUTS_SKINAS"] = "使用皮肤"
L["TEXTLAYOUTS_SKINAS_COUNT"] = "叠加数量"
L["TEXTLAYOUTS_SKINAS_DESC"] = "选择你想让这些显示文字使用的Masque皮肤."
L["TEXTLAYOUTS_SKINAS_HOTKEY"] = "绑定/标签"
L["TEXTLAYOUTS_SKINAS_NONE"] = "无"
L["TEXTLAYOUTS_STRING_COPYMENU"] = "复制"
L["TEXTLAYOUTS_STRING_COPYMENU_DESC"] = [=[点击打开一个此配置文件中所有的已使用显示文字列表,你可以将它们加入到这个文字显示方案中.
]=]
L["TEXTLAYOUTS_STRING_SETDEFAULT"] = "重置为默认"
L["TEXTLAYOUTS_STRING_SETDEFAULT_DESC"] = [=[重置当前文字显示方案中的显示文字为下列默认显示文字,在该文字显示样式中的设置为:

%s]=]
L["TEXTLAYOUTS_STRINGUSEDBY"] = "已使用%d次."
L["TEXTLAYOUTS_TAB"] = "文字显示方案"
L["TEXTLAYOUTS_UNNAMED"] = "<未命名>"
L["TEXTMANIP"] = "文字处理"
L["Tier11Interrupts"] = "T11副本可打断的施法"
L["Tier12Interrupts"] = "T12副本可打断法术"
L["TOOLTIPSCAN"] = "法术效果变量"
L["TOOLTIPSCAN_DESC"] = "此条件类型允许你检测某一单位的某个法术效果提示信息上的第一个变量(数字).数字是由暴雪API所提供,跟你在法术效果的提示信息中看到的数字可能会不同(像是服务器已经在线修正,客户端依然显示错误的数字这种情况),同时也不保证一定能够从法术效果获取一个数字,不过在大多数实际情况下都能检测到正确的数字."
L["TOP"] = "上"
L["TOPLEFT"] = "左上"
L["TOPRIGHT"] = "右上"
L["TOTEMS"] = "检测图腾"
L["TRUE"] = "是"
L["UIPANEL_ADDGROUP"] = "+ 新增分组 +"
L["UIPANEL_ADDGROUP_DESC"] = "新分组将分配到下一个可用的分组ID"
L["UIPANEL_ALLRESET"] = "全部重置"
L["UIPANEL_ANCHORNUM"] = "描点 %d"
L["UIPANEL_BARIGNOREGCD"] = "计量条忽略公共冷却"
L["UIPANEL_BARIGNOREGCD_DESC"] = "如果选中,冷却条在公共冷却时不改变值."
L["UIPANEL_BARTEXTURE"] = "计量条材质"
L["UIPANEL_CLOCKIGNOREGCD"] = "计时器忽略公共冷却"
L["UIPANEL_CLOCKIGNOREGCD_DESC"] = "如果选中,计时器和冷却将忽略公共冷却来触发"
L["UIPANEL_COLORS"] = "颜色"
L["UIPANEL_COLORS_DESC"] = "基于图标的属性来控制如何着色以及使用的颜色的相关设置."
L["UIPANEL_COLUMNS"] = "列"
L["UIPANEL_COMBATCONFIG"] = "允许在战斗中进行设置"
L["UIPANEL_COMBATCONFIG_DESC"] = [=[启用这个选项就可以在战斗中对TellMeWhen进行设置.

注意,该选项会让插件强制加载设置模块, 内存的占用以及插件加载的时间都会随之增加.

所有角色的配置文件共同使用该选项.

|cff7fffff需要重新加载UI|cffff5959才能生效.|r]=]
L["UIPANEL_DELGROUP"] = "删除该分组"
L["UIPANEL_DELGROUP_DESC"] = [=[在此分组之后的任意分组ID将会上升1.
同时对ID上升组的图标有检测行为的所有图标的设置也将自动更新.

按住|cff7fffffCtrl|r键跳过确认.]=]
L["UIPANEL_DRAWEDGE"] = "高亮计时器指针"
L["UIPANEL_DRAWEDGE_DESC"] = "高亮冷却计时器的指针来改善可视性"
L["UIPANEL_EFFTHRESHOLD"] = "增益效率閥值"
L["UIPANEL_EFFTHRESHOLD_DESC"] = "输入增益/减益的最小时间以便在它们有很高的数值时切换到更有效的检测模式. 注意:一旦效果的数值超出所选择的数字的限定,数值较大的效果会优先显示,而不是按照设定的优先级顺序."
L["UIPANEL_ENABLEGROUP"] = "启用分组"
L["UIPANEL_FONT_CONSTRAINWIDTH"] = "限制宽度"
L["UIPANEL_FONT_CONSTRAINWIDTH_DESC"] = [=[勾选此项在位置恰当的情况下文字宽度会强制跟图标宽度进行匹配.
取消勾选将允许文字延升宽度大于图标.]=]
L["UIPANEL_FONT_DESC"] = "选择图标的叠加数量文字所使用的字体"
L["UIPANEL_FONTFACE"] = "字体"
L["UIPANEL_FONT_JUSTIFY"] = "文字对齐校准"
L["UIPANEL_FONT_JUSTIFY_DESC"] = "设置该文字显示方案中文字的对齐位置校准(左/中/右)."
L["UIPANEL_FONT_OUTLINE"] = "字体描边"
L["UIPANEL_FONT_OUTLINE_DESC"] = "设置图标叠加数量文字的轮廓样式"
L["UIPANEL_FONT_SHADOW"] = "阴影偏移"
L["UIPANEL_FONT_SHADOW_DESC"] = "更改文字阴影的偏移数值,设置为0则禁用阴影效果."
L["UIPANEL_FONT_SIZE"] = "字体大小"
L["UIPANEL_FONT_SIZE_DESC"] = "更改图标叠加数量文字的字体大小.如果已使用Masque并且所设置的皮肤的字体大小已定义将忽略此设置值."
L["UIPANEL_FONT_XOFFS"] = "X偏移"
L["UIPANEL_FONT_XOFFS_DESC"] = "描点的X轴偏移值"
L["UIPANEL_FONT_YOFFS"] = "Y偏移"
L["UIPANEL_FONT_YOFFS_DESC"] = "描点的Y轴偏移值"
L["UIPANEL_GLYPH"] = "雕文"
L["UIPANEL_GLYPH_DESC"] = "检测你是否激活了某一特定的雕文."
L["UIPANEL_GROUPALPHA"] = "分组不透明度"
L["UIPANEL_GROUPALPHA_DESC"] = [=[设置整个分组的不透明度等级.

此选项对图标原本的功能没有任何影响,仅改变这个分组所有图标的外观.

如果你要隐藏整个分组并且仍然允许此分组下的图标正常运作,请将此选项设置为0(该选项有点类似于图标设置中的%q).]=]
L["UIPANEL_GROUPMOVEDOWN"] = "往下移动"
L["UIPANEL_GROUPMOVEDOWN_DESC"] = "往下移动本组,使该分组的ID加1."
L["UIPANEL_GROUPMOVEUP"] = "往上移动"
L["UIPANEL_GROUPMOVEUP_DESC"] = "往上移动本组,使该分组的ID减少1."
L["UIPANEL_GROUPNAME"] = "重命名此分组"
L["UIPANEL_GROUPRESET"] = "重置位置"
L["UIPANEL_GROUPS"] = "分组"
L["UIPANEL_GROUPS_DESC"] = "在此配置文件中的各个分组的相关设置."
L["UIPANEL_GROUPSORT"] = "图标排列"
L["UIPANEL_GROUPSORT_alpha"] = "不透明度(无视%s)"
L["UIPANEL_GROUPSORT_alpha_DESC"] = "分组将根据图标的不透明度来排列,无论图标是否被 %s 设置所隐藏."
L["UIPANEL_GROUPSORT_DESC"] = [=[基于分组所有图标的属性并对它们的位置进行排列的相关设置.

译者注:因为是新功能,稍微讲解一下.
比如在某个分组中有3个图标[图标1(DOT-1),图标2(DOT-2),图标3(DOT-3)],你可以设置一个优先级使整个分组的图标按照剩余持续时间从低到高排列,假如3个DOT的持续时间情况为

|cff7fffffDOT-3<DOT-1<DOT-2|r,则DOT-3会显示到图标1的位置,DOT-1显示到图标2的位置,DOT-2显示到图标3的位置.

更具体的情况请自行设置并测试,遇到Bug请去Curse提交,谢谢.]=]
L["UIPANEL_GROUPSORT_duration"] = "持续时间"
L["UIPANEL_GROUPSORT_duration_DESC"] = "分组将根据图标剩余的持续时间来排列."
L["UIPANEL_GROUPSORT_id"] = "图标ID"
L["UIPANEL_GROUPSORT_id_DESC"] = "分组将根据图标ID数字来排列."
L["UIPANEL_GROUPSORT_METHODDISABLED_DESC"] = "这个排列方法已经被停用,因为上面使用的是根据图标ID进行排列,所选方法永远不会被执行和排列."
L["UIPANEL_GROUPSORT_METHODNAME"] = "图标排列优先级%d"
L["UIPANEL_GROUPSORT_METHODNAME_DESC"] = "在一个分组的图标位置进行排列时,这个将作为优先级%d来使用."
L["UIPANEL_GROUPSORT_shown"] = "显示(无视%s)"
L["UIPANEL_GROUPSORT_shown_DESC"] = "分组将根据图标是否显示来排列,无论图标是否被 %s 设置所隐藏."
L["UIPANEL_GROUPSORT_SORTASCENDING"] = "低"
L["UIPANEL_GROUPSORT_SORTASCENDING_DESC"] = "勾选此项将根据所选属性的数值从低到高来排列."
L["UIPANEL_GROUPSORT_SORTDESCENDING"] = "高"
L["UIPANEL_GROUPSORT_SORTDESCENDING_DESC"] = "勾选此项将根据所选属性的数值从高到低来排列."
L["UIPANEL_GROUPSORT_stacks"] = "叠加数量"
L["UIPANEL_GROUPSORT_stacks_DESC"] = "分组将根据每个图标的叠加数量来排列."
L["UIPANEL_GROUPSORT_visiblealpha"] = "不透明度(遵循%s)"
L["UIPANEL_GROUPSORT_visiblealpha_DESC"] = "分组将根据那些实际上可见的图标的不透明度来排列(始终隐藏的图标无论什么状态都会被视为隐藏)."
L["UIPANEL_GROUPSORT_visibleshown"] = "显示(遵循%s)"
L["UIPANEL_GROUPSORT_visibleshown_DESC"] = "分组将根据图标对你是否可见来排列(始终隐藏的图标无论什么状态都会被视为隐藏)."
L["UIPANEL_GROUPTYPE"] = "分组显示方式"
L["UIPANEL_GROUPTYPE_BAR"] = "计时条"
L["UIPANEL_GROUPTYPE_BAR_DESC"] = "分组使用图标+进度条的方式来显示."
L["UIPANEL_GROUPTYPE_DESC"] = "选择你想要的分组图标显示方式."
L["UIPANEL_GROUPTYPE_ICON"] = "图标"
L["UIPANEL_GROUPTYPE_ICON_DESC"] = "分组使用TellMeWhen传统的图标方式来显示."
L["UIPANEL_ICONS"] = "图标"
L["UIPANEL_ICONSPACING_DESC"] = "同组图标之间的间隔距离"
L["UIPANEL_ICONSPACINGX"] = "图标横向间隔"
L["UIPANEL_ICONSPACINGY"] = "图标纵向间隔"
L["UIPANEL_LEVEL"] = "框体优先级"
L["UIPANEL_LOCK"] = "锁定位置"
L["UIPANEL_LOCK_DESC"] = "锁定该组,禁止移动或改变比例."
L["UIPANEL_LOCKUNLOCK"] = "锁定/解锁插件"
L["UIPANEL_MAIN_DESC"] = "此分组的主要设置选项."
L["UIPANEL_MAINOPT"] = "主选项"
L["UIPANEL_ONLYINCOMBAT"] = "仅在战斗中显示"
L["UIPANEL_POINT"] = "附着点"
L["UIPANEL_POINT_DESC"] = "分组将会依附的位置"
L["UIPANEL_POSITION"] = "位置"
L["UIPANEL_POSITION_DESC"] = "控制此分组的屏幕位置的相关设置."
L["UIPANEL_PRIMARYSPEC"] = "主天赋"
L["UIPANEL_PTSINTAL"] = "天赋使用点数(非天赋树)"
L["UIPANEL_RELATIVEPOINT"] = "附着位置"
L["UIPANEL_RELATIVEPOINT_DESC"] = "分组将会依附到的位置"
L["UIPANEL_RELATIVETO"] = "附着框体"
L["UIPANEL_RELATIVETO_DESC"] = [=[输入'/framestack'来观察当前鼠标指针所在框体的提示信息,以便寻找需要输入文本框的框体名称.

需要更多帮助,请访问http://www.wowpedia.org/API_Region_SetPoint]=]
L["UIPANEL_ROWS"] = "行"
L["UIPANEL_SCALE"] = "比例"
L["UIPANEL_SECONDARYSPEC"] = "副天赋"
L["UIPANEL_SPEC"] = "双天赋"
L["UIPANEL_SPECIALIZATION"] = "天赋类型"
L["UIPANEL_STRATA"] = "框体层级"
L["UIPANEL_SUBTEXT2"] = [=[图标在锁定后开始工作.
在解除锁定时,你可以移动图标分组(或更改大小),右键点击图标打开设置页面.

你可以输入'/tellmewhen'或'/tmw'来锁定/解除锁定.]=]
L["UIPANEL_TALENTLEARNED"] = "已学天赋"
L["UIPANEL_TOOLTIP_ALLRESET"] = "重置所有图标和分组的数据、位置以及其他设置"
L["UIPANEL_TOOLTIP_COLUMNS"] = "设置在本组中的图标列数"
L["UIPANEL_TOOLTIP_ENABLEGROUP"] = "显示并启用该分組"
L["UIPANEL_TOOLTIP_GROUPRESET"] = "重置该组的位置跟比例"
L["UIPANEL_TOOLTIP_ONLYINCOMBAT"] = "勾选此项使该分组仅在战斗中显示"
L["UIPANEL_TOOLTIP_PRIMARYSPEC"] = "选中后当你启用主天赋时显示这个分组的图标"
L["UIPANEL_TOOLTIP_ROWS"] = "设置在本组中的图标行数"
L["UIPANEL_TOOLTIP_SECONDARYSPEC"] = "选中后当你启用副天赋时显示这个分组的图标"
L["UIPANEL_TOOLTIP_UPDATEINTERVAL"] = "设置图标显示/隐藏,透明度,条件等的更新频率(秒).0为最快.低端电脑请自重,设置数值过低会使帧数明显降低."
L["UIPANEL_TREE"] = "天赋树"
L["UIPANEL_TREE_DESC"] = "勾选来允许该组在某个天赋树激活时显示，或者不勾选让它在天赋树没激活时隐藏。"
L["UIPANEL_UPDATEINTERVAL"] = "更新间隔"
L["UIPANEL_WARNINVALIDS"] = "提示无效的图标"
L["UNDO_ICON"] = "撤消"
L["UNDO_ICON_DESC"] = "撤消最近一次图标设置的更改动作."
L["UNITCONDITIONS"] = "单位条件"
L["UNITCONDITIONS_DESC"] = [=[点击以便设置条件在上面输入的全部单位中筛选出你想用于检测的每个单位.

译者注:
单位条件可用于像是检测团队中哪几个人缺少耐力,或者像是检测团队中的某个坦克中了魔法/疾病等等,这只是我随便举的两个例子,实际应用范围更大.(两个例子的前提都有在单位框中输入了player,raid1-40,party1-4)]=]
L["UNITCONDITIONS_STATICUNIT"] = "<图标单位>"
L["UNITCONDITIONS_STATICUNIT_DESC"] = "该条件将检测正在被图标检测中的每个单位。"
L["UNITCONDITIONS_STATICUNIT_TARGET"] = "<图标单位>的目标"
L["UNITCONDITIONS_STATICUNIT_TARGET_DESC"] = "该条件将检查图标正在检测之中的每个单位的目标."
L["UNITCONDITIONS_TAB_DESC"] = "设置条件只让那些你要使用到的单位通过."
L["UNITTWO"] = "第二单位"
L["UNNAMED"] = "((未命名))"
L["WARN_DRMISMATCH"] = [=[警告!你正在检测递减的法术来自两个不同的已知分类.

在同一个递减图标中,用于检测的所有法术应当使用同一递减分类才能使图标正常运行.

检测到下列你所使用的法术及其分类:]=]
L["WATER"] = "水之图腾"
L["worldboss"] = "首领"
