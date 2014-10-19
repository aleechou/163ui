﻿-- DBM_Core
-- Diablohu(diablohudream@gmail.com)
-- yleaf(yaroot@gmail.com)
-- Mini_Dragon(projecteurs@gmail.com)
-- Last update: Oct 6, 2014

if GetLocale() ~= "zhCN" then return end

DBM_CORE_NEED_SUPPORT				= "如果你会编程并且英语不错，请来帮助我们完善DBM中文翻译。请访问 http://forums.elitistjerks.com/topic/132449-dbm-localizers-needed/ 获取更多消息。"
DBM_CORE_NEED_LOGS					= "DBM 需要战斗记录器 (http://www.wowace.com/addons/transcriptor/) 的日志来使得技能判断更准确. 如果你想帮忙，请用 transcriptor 记录并上传日志文件到 http://forums.elitistjerks.com/topic/132677-deadly-boss-mods-60-testing/ (请压缩他们). 我们现在只对团本数据感兴趣."
DBM_HOW_TO_USE_MOD					= "欢迎使用DBM。在聊天框输入 /dbm help 以获取可用命令的帮助。输入 /dbm 可打开设置窗口。手动打开指定区域的模组即可开始针对各个模块进行设置，也可以浏览首领击杀记录。DBM 会在你首次尝试首领战时自动进行扫描，但是有些设置需要手动开启。"

DBM_FORUMS_MESSAGE					= "发现BUG或错误的计时器?你希望要让某些模组有新的警告，计时器或是特别功能?\n拜访新的Deadly Boss Mods |HDBM:论坛|h|cff3588ffhttp://www.deadlybossmods.com|r (你可以点击链接复制网址)"
DBM_FORUMS_COPY_URL_DIALOG			= "拜访我们的讨论与支持论坛\r\n(hosted by Elitist Jerks!)"

DBM_CORE_LOAD_MOD_ERROR				= "读取%s模块时发生错误：%s"
DBM_CORE_LOAD_MOD_SUCCESS			= "成功读取%s模块。在聊天框输入 /dbm 或 /dbm help 可进行更多设置。"
DBM_CORE_LOAD_MOD_COMBAT			= "延迟读取模块 '%s' 直到你脱离战斗"
DBM_CORE_LOAD_GUI_ERROR				= "无法读取图形界面：%s"
DBM_CORE_LOAD_GUI_COMBAT			= "DBM无法在战斗中初始化图形界面。请先在非战斗状态打开图形设置界面，之后的战斗中就可以自由打开和关闭该界面了。"
DBM_CORE_LOAD_SKIN_COMBAT			= "DBM无法在战斗中更换皮肤。请先在非战斗状态更换好皮肤，并重载界面。"
DBM_CORE_BAD_LOAD					= "DBM检测到由于你在战斗过程中载入模块，有些计时器可能会错误。请在离开战斗后马上重载界面。"

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "由于玩家数量不足，DBM 无法开启动态距离检测。"
DBM_CORE_DYNAMIC_ADD_COUNT			= "由于玩家数量不足，DBM 无法开启倒计时。"
DBM_CORE_DYNAMIC_MULTIPLE			= "由于玩家数量不足，DBM 禁用了多个功能。"

DBM_CORE_LOOT_SPEC_REMINDER			= "你当前的人物专精为 %s. 你当前的拾取选择为 %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM检测到你同时开启了Bigwigs,请关闭自动标记以避免冲突"

DBM_CORE_PROVINGGROUNDS_AD			= "6.0 版本的 DBM-ProvingGrounds （白虎寺挑战模块） 已经上线了. 旧的模块 DBM-ProvingGrounds-MoP 已经被禁用. 你可以删除旧版本并且在 deadlybossmods.com 或 Curse 上找到新版本. 本消息只显示一次. "

DBM_CORE_COMBAT_STARTED				= "%s作战开始，祝你走运 :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "已进行的战斗-%s正在作战。祝你走运 :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "工会版%s作战开始"
DBM_CORE_SCENARIO_STARTED			= "场景战役-%s作战开始。祝你走运 :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "已进行的场景战役-%s正在作战。祝你走运 :)"
DBM_CORE_BOSS_DOWN					= "%s战斗胜利！用时%s！"
DBM_CORE_BOSS_DOWN_I				= "%s战斗胜利！总计%d次胜利。"
DBM_CORE_BOSS_DOWN_L				= "%s战斗胜利！用时%s！上次用时%s，最快用时%s。总计%d次胜利。"
DBM_CORE_BOSS_DOWN_NR				= "%s战斗胜利！用时%s！新的纪录诞生了！原纪录为%s。总计%d次胜利。"
DBM_CORE_GUILD_BOSS_DOWN			= "工会版%s战斗胜利！用时%s！"
DBM_CORE_SCENARIO_COMPLETE			= "场景战役-%s战斗胜利！用时%s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "场景战役-%s战斗胜利！总计%d次胜利。"
DBM_CORE_SCENARIO_COMPLETE_L		= "场景战役-%s战斗胜利！用时%s！上次用时%s，最快用时%s。总计%d次胜利。"
DBM_CORE_SCENARIO_COMPLETE_NR		= "场景战役-%s战斗胜利！用时%s！新的纪录诞生了！原纪录为%s。总计%d次胜利。"
DBM_CORE_COMBAT_ENDED_AT			= "%s （%s）作战结束，用时%s。"
DBM_CORE_COMBAT_ENDED_AT_LONG		= "%s （%s）作战结束，用时%s。该难度下总计失败%d次。"
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "工会版%s （%s）作战结束，用时%s。"
DBM_CORE_SCENARIO_ENDED_AT			= "场景战役-%s作战结束，用时%s。"
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "场景战役-%s作战结束，用时%s。该难度下总计失败%d次。"
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s作战%s前开始，正在恢复计时条……"
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Transcriptor logging started."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Transcriptor logging ended."

DBM_CORE_WORLDBOSS_ENGAGED			= "世界Boss-%s可能正在作战。当前还有%s的生命值。 (由%s的DBM发送)"
DBM_CORE_WORLDBOSS_DEFEATED			= "世界Boss-%s可能战斗结束了。 (由%s的DBM发送)"

DBM_CORE_TIMER_FORMAT_SECS			= "%d秒"
DBM_CORE_TIMER_FORMAT_MINS			= "%d分钟"
DBM_CORE_TIMER_FORMAT				= "%d分%d秒"

DBM_CORE_MIN						= "分"
DBM_CORE_MIN_FMT					= "%d分"
DBM_CORE_SEC						= "秒"
DBM_CORE_SEC_FMT					= "%d秒"
DBM_CORE_DEAD						= "死亡"
DBM_CORE_OK							= "确定"

DBM_CORE_GENERIC_WARNING_OTHERS		= "和另外一个"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "和另外%d个"
DBM_CORE_GENERIC_WARNING_BERSERK	= "%s%s后狂暴"
DBM_CORE_GENERIC_TIMER_BERSERK		= "狂暴"
DBM_CORE_OPTION_TIMER_BERSERK		= "计时条：$spell:26662"
DBM_CORE_GENERIC_TIMER_COMBAT		= "战斗开始"
DBM_CORE_OPTION_TIMER_COMBAT		= "显示战斗开始倒计时"
DBM_CORE_OPTION_HEALTH_FRAME		= "首领生命值窗口"

DBM_CORE_OPTION_CATEGORY_TIMERS		= "计时条"
DBM_CORE_OPTION_CATEGORY_WARNINGS	= "警报"
DBM_CORE_OPTION_CATEGORY_MISC		= "其它"

DBM_CORE_AUTO_RESPONDED						= "已自动回复."
DBM_CORE_STATUS_WHISPER						= "%s：%s，%d/%d存活"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s正在与%s交战，（当前%s，%d/%d存活）"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s已在%s的战斗中取得胜利！"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s已在%s的战斗中取得胜利！总计%d次胜利。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s在%s（%s）的战斗中灭团了。"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s在%s（%s）的战斗中灭团了。该难度下总共失败%d次。"
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s正在与场景战役-%s交战，（当前%s，%d/%d存活）"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s已在场景战役-%s的战斗中取得胜利！"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s已在场景战役-%s的战斗中取得胜利！总计%d次胜利。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s在场景战役-%s的战斗中灭团了。"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s在场景战役-%s的战斗中灭团了。该难度下总共失败%d次。"

DBM_CORE_VERSIONCHECK_HEADER		= "DBM - 版本检测"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (r%d)"--One Boss mod
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (r%d) & %s (r%d)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s：未安装DBM"
DBM_CORE_VERSIONCHECK_FOOTER		= "团队中有%d名成员正在使用DBM"
DBM_CORE_YOUR_VERSION_OUTDATED		= "你的DBM已经过期。请访问 http://dev.deadlybossmods.com 下载最新版本。"
DBM_CORE_OUTDATED_PVP_MODS			= "你当前使用的DBM-PVP模块已经过期。PVP模块现在需要单独下载。请访问 http://www.deadlybossmods.com"
DBM_BIG_WIGS						= "BigWigs"
DBM_BIG_WIGS_ALPHA					= "BigWigs Alpha"

DBM_CORE_UPDATEREMINDER_HEADER			= "你的Deadly Boss Mods版本已过期。\n你可以在如下地址下载到新版本%s（r%d）："
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "Your alpha version of Deadly Boss Mods is out-of-date.\n You are at least %d test versions behind. It is recommended that DBM users use the latest alpha or latest stable version. Out of date alphas can lead to poor or incomplete functionality."
DBM_CORE_UPDATEREMINDER_FOOTER			= (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  "Ctrl+C：复制下载地址到剪切板。"
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "按下 " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  " 复制下载地址到剪切板。"
DBM_CORE_UPDATEREMINDER_NOTAGAIN		= "检测到新版本后弹出提示框"
DBM_CORE_UPDATEREMINDER_DISABLE			= "警告：你的DBM已经过时相当多的版本（%d个版本），它已被禁用，直到你更新。这是为了确保它不会导致你或其他团队成员出错。"
DBM_CORE_UPDATEREMINDER_HOTFIX			= "你的DBM版本会在这首领战斗有不准确的计时器或警告。这问题已被修正在下次正式版更新，或可以更新至最新的alpha版本立即修正此问题。"
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "警告：你使用了不正确版本的DBM。请确保DBM版本和游戏版本一致。"

DBM_CORE_MOVABLE_BAR				= "拖动我！"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h向你发送了一个DBM计时条：'%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[取消该计时]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[忽略来自%1$s的计时条]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "是否要在该次游戏连接中屏蔽来自%s的计时条？"
DBM_PIZZA_ERROR_USAGE				= "命令：/dbm [broadcast] timer <时间（秒）> <文本>"

DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+拖动 / 右键拖动：拖动\nAlt+Shift+拖动：自由拖动"

DBM_CORE_RANGECHECK_HEADER			= "距离监视（%d码）"
DBM_CORE_RANGECHECK_SETRANGE		= "设置距离"
DBM_CORE_RANGECHECK_SOUNDS			= "声音"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "声音提示：当有玩家接近时"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "声音提示：多名玩家接近时"
DBM_CORE_RANGECHECK_SOUND_0			= "无"
DBM_CORE_RANGECHECK_SOUND_1			= "默认声音"
DBM_CORE_RANGECHECK_SOUND_2			= "蜂鸣"
DBM_CORE_RANGECHECK_HIDE			= "隐藏"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d码"
DBM_CORE_RANGECHECK_LOCK			= "锁定框体"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "框体"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "显示雷达框体"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "显示文本框体"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "同时显示2个框体"
DBM_CORE_RANGERADAR_HEADER			= "距离雷达（%d码）"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d人在监视距离内"

DBM_CORE_INFOFRAME_SHOW_SELF		= "总是显示你的能量"		-- Always show your own power value even if you are below the threshold

DBM_LFG_INVITE						= "随机副本确认"

DBM_CORE_SLASHCMD_HELP				= {
	"可用命令：",
	"/dbm version:进行团队范围的DBM版本检测（也可使用：ver）",
--	"/dbm version2: 进行团队范围的DBM版本检测并密语给那些使用过期版本的玩家（也可使用：ver2）",
	"/dbm unlock:显示一个可移动的计时条，可通过对它来移动所有DBM计时条的位置（也可使用：move）",
	"/dbm timer/ctimer/ltimer/cltimer <x> <text>: 启动一个 <x> 秒的计时器。文本内容为 <text>. 去 http://tinyurl.com/kwsfl59 查阅每种函数用法",
	"/dbm broadcast timer <x> <文本>:向团队广播一个以<文本>为名称的时间为<x>秒的倒计时（需要团队领袖或助理权限）",
	"/dbm timer endloop: 停止所有的 ltimer 和 cltimer.",
	"/dbm break <分钟>: 开始一个<分钟>时间的休息计时条。并向所有团队成员发送这个DBM休息计时条（需开启团队广播及助理权限）。",
	"/dbm pull <秒>: 开始一个<秒>时间的开怪计时条。 并向所有团队成员发送这个DBM开怪计时条（需开启团队广播及助理权限）。",
	"/dbm arrow: 显示DBM箭头，输入/dbm arrow查询 更多信息。",
	"/dbm lockout: 查询团队成员当前的副本锁定状态（也可使用：lockouts, ids）（需要团队领袖或助理权限）。",
	"/dbm lag: 检测全团延时。",
	"/dbm help: 显示可用命令的说明， 也就是你现在看到的东西。"
}

DBM_ERROR_NO_PERMISSION				= "你无权进行该操作。"

DBM_CORE_BOSSHEALTH_HIDE_FRAME		= "隐藏生命值框体"

DBM_CORE_ALLIANCE					= "联盟"
DBM_CORE_HORDE						= "部落"

DBM_CORE_UNKNOWN					= "未知"
DBM_CORE_LEFT						= "左"
DBM_CORE_RIGHT						= "右"
DBM_CORE_BACK						= "后"
DBM_CORE_FRONT						= "前"

DBM_CORE_BREAK_START				= "开始休息 - %s分钟！（由 %s 发送）"
DBM_CORE_BREAK_MIN					= "%s分钟后休息结束！"
DBM_CORE_BREAK_SEC					= "%s秒后休息结束！"
DBM_CORE_TIMER_BREAK				= "休息时间！"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "休息已结束"

DBM_CORE_TIMER_PULL					= "开怪倒计时"
DBM_CORE_ANNOUNCE_PULL				= "%d秒后开怪 （由 %s 发送）"
DBM_CORE_ANNOUNCE_PULL_NOW			= "开怪！"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "成就：限时击杀"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target				= "%s -> >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount		= "%s (%%d) -> >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell				= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends 				= "%s 结束"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades				= "%s 消失"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds				= "%s剩余：%%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast				= "正在施放 %s：%.1f秒"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon				= "即将 %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn			= "%2$s后 %1$s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.phase				= "第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prephase			= "第%s阶段 即将到来"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count				= "%s (%%d)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack				= "%s -> >%%s< (%%d)"

local prewarnOption			= "预警：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target			= "警报：$spell:%s的目标"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount		= "警报：$spell:%s的目标"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell			= "警报：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends				= "警报：$spell:%s结束"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget		= "警报：$spell:%s结束"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades			= "警报：$spell:%s消失"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds				= "警报：$spell:%s剩余数量"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast				= "警报：$spell:%s的施放"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon				= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn			= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.phase			= "警报：第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prephase			= "预警：第%s阶段"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count			= "警报：$spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack			= "警报：$spell:%s叠加层数"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends				= "%s 结束"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s 消失"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "%s 即将到来"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s 于 %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel			= ">%%s<中了%s - 快驱散"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - 快打断"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you				= "你中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target			= ">%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= ">%%s<中了%s - 快嘲讽"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close				= "你附近的>%%s<中了%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move				= "%s - 快躲开"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - 离开人群"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - 靠近 >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run				= "%s - 快跑"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast				= "%s - 停止施法"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect			= ">%%s<中了%s - 快停手"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count				= "%s! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack				= "你叠加了%%d层%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch			= ">%s< - 转换目标"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell			= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends			= "特殊警报：$spell:%s结束"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades			= "特殊警报：$spell:%s消失"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon			= "特殊警报：$spell:%s即将到来"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel			= "特殊警报：需要驱散或偷取$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 		= "特殊警报：$spell:%s需要停止攻击"--Spell Reflect
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt		= "特殊警报：需要打断$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you				= "特殊警报：当你受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target			= "特殊警报：当他人受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 			= "特殊警报：当另外一个T中了$spell:%s并需要你嘲讽时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close			= "特殊警报：当你附近有人受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move			= "特殊警报：当你受到$spell:%s影响时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway		= "特殊警报：当你受到$spell:%s影响并需要跑开人群时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto			= "特殊警报：当他人中了$spell:%s并需要你去靠近时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run				= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast			= "特殊警报：$spell:%s的施放（用于打断）"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 		= "特殊警报：$spell:%s需要停止攻击"--Spell Reflect
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 			= "特殊警报：$spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack			= "特殊警报：当叠加了>=%d层$spell:%s时"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch 			= "特殊警报：针对$spell:%s需要转换目标"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target				= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast					= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.active				= "%s结束"--Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades					= "%s消失"--Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.cd					= "%s冷却"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount				= "%s冷却（%%d）"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource				= "%s冷却: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.next 					= "下一次%s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount				= "下一次%s（%%d）"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource			= "下一次%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.achievement 			= "%s"

DBM_CORE_AUTO_TIMER_OPTIONS.target				= "计时条：$spell:%s减益效果持续时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cast				= "计时条：$spell:%s施法时间"
DBM_CORE_AUTO_TIMER_OPTIONS.active				= "计时条：$spell:%s效果持续时间"
DBM_CORE_AUTO_TIMER_OPTIONS.fades				= "计时条：$spell:%s何时从玩家身上消失"
DBM_CORE_AUTO_TIMER_OPTIONS.cd					= "计时条：$spell:%s冷却时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount				= "计时条：$spell:%s冷却时间"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource			= "计时条：$spell:%s冷却时间以及来源"
DBM_CORE_AUTO_TIMER_OPTIONS.next				= "计时条：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount			= "计时条：下一次$spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource			= "计时条：下一次$spell:%s以及来源"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement			= "计时条：成就%s"

DBM_CORE_AUTO_ICONS_OPTION_TEXT				= "为$spell:%s的目标添加团队标记"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2			= "为$spell:%s添加团队标记"
DBM_CORE_AUTO_ARROW_OPTION_TEXT				= "为$spell:%s的目标添加箭头"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2			= "为$spell:%s的目标添加远离箭头"
DBM_CORE_AUTO_SOUND_OPTION_TEXT				= "声音警报（快跑啊，小姑娘）：$spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT			= "声音警报：$spell:%s的冷却时间倒计时"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2		= "声音警报：$spell:%s消失时"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT			= "声音警报：$spell:%s的持续时间正计时"
DBM_CORE_AUTO_YELL_OPTION_TEXT				= "当你受到$spell:%s影响时时大喊"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT			= UnitName("player") .. " 中了 %s!!!"
DBM_CORE_AUTO_RANGE_OPTION_TEXT				= "距离监视(%s)：$spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT		= "距离监视(%s)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT		= "信息框：$spell:%s"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT		= "当首领开打时拨放准备检查的音效（即使没有选定目标）"

-- New special warnings
DBM_CORE_MOVE_SPECIAL_WARNING_BAR		= "可拖动的特别警报"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT		= "特别警报"

DBM_CORE_RANGE_CHECK_ZONE_UNSUPPORTED	= "此区域不支持%d码的距离检查。\n已支持的距离有10，11，15及28码。"

DBM_ARROW_MOVABLE				= "可移动箭头"
DBM_ARROW_ERROR_USAGE	= {
	"DBM-Arrow 可用命令：",
	"/dbm arrow <x> <y>  新建一个箭头到指定位置(使用世界坐标系)",
	"/dbm arrow map <x> <y>  新建一个箭头到指定位置 (使用区域地图坐标系)",
	"/dbm arrow <玩家名字>  新建一个箭头并指向你队伍或团队中特定的玩家。请区分大小写。",
	"/dbm arrow hide  隐藏箭头",
	"/dbm arrow move  移动或锁定箭头"
}

DBM_SPEED_KILL_TIMER_TEXT	= "击杀记录"
DBM_SPEED_KILL_TIMER_OPTION	= "计时条：最速击杀记录"
DBM_SPEED_CLEAR_TIMER_TEXT	= "最速清除"
DBM_COMBAT_RES_TIMER_TEXT	= "Next CR Charge"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s请求获取你现在副本的存档ID与进度。是否愿意向&s提交进度？\n\n注意：在接受后，他可以随时查看您当前的进度情况，直到您下线、掉线或重载用户界面。"
DBM_ERROR_NO_RAID					= "使用该功能需要身处一个团队中。"
DBM_INSTANCE_INFO_REQUESTED			= "已发送团队副本进度查看请求。\n请注意，团员会根据需要选择接受或拒绝该请求。请求时间约一分钟，请等待。"
DBM_INSTANCE_INFO_STATUS_UPDATE		= "已收到%d名团员的进度回复（已安装DBM的团员有%d名）：%d人接受请求，%d人拒绝。生成数据需要约%d秒，请等待。"
DBM_INSTANCE_INFO_ALL_RESPONSES		= "所有团员接受请求。"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "发送者：%s 结果类型：%s 副本名：%s 副本ID：%s 难度：%d 规模：%d 进度：%s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s（%d），难度%d："
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, 进度%d：%s"
DBM_INSTANCE_INFO_STATS_DENIED		= "拒绝请求：%s"
DBM_INSTANCE_INFO_STATS_AWAY		= "暂离：%s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "未安装DBM：%s"
DBM_INSTANCE_INFO_RESULTS			= "副本进度扫描结果。" --Note that instances might show up more than once if there are players with localized WoW clients in your raid.
DBM_INSTANCE_INFO_SHOW_RESULTS		= "回复请求的玩家：%s\n|HDBM:showRaidIdResults|h|cff3588ff[点击显示结果]|r|h"

DBM_CORE_LAG_CHECKING				= "延时检测请稍后..."
DBM_CORE_LAG_HEADER					= "DBM - 延时检测"
DBM_CORE_LAG_ENTRY					= "%s：世界延时[%d毫秒] / 本地延时[%d毫秒]"
DBM_CORE_LAG_FOOTER					= "未反馈此次检测的团员:%s"
