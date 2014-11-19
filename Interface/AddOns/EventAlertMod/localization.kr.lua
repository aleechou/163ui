if GetLocale() ~= "koKR" then return end

EA_TTIP_DOALERTSOUND = "주문 발동시 효과음을 재생합니다.";
EA_TTIP_ALERTSOUNDSELECT = "이벤트 발동시 들려줄 효과음을 선택합니다.";
EA_TTIP_LOCKFRAME = "경보 창이 움직이지 않도록 잠급니다.";
EA_TTIP_SHARESETTINGS = "All classes share the same settings for alert frame positions.";
EA_TTIP_SHOWFRAME = "애드온을 사용하거나 사용하지 않습니다.";
EA_TTIP_SHOWNAME = "주문 발동시 주문의 이름을 표시합니다.";
EA_TTIP_SHOWFLASH = "주문 발동시 전체 화면 반짝임 효과를 표시합니다.";
EA_TTIP_SHOWTIMER = "주문 발동시 주문 지속시간을 표시합니다.";
EA_TTIP_CHANGETIMER = "글꼴과 남은 시간의 위치를 변경합니다.";
EA_TTIP_ICONSIZE = "경보 아이콘의 크기를 변경합니다.";
-- EA_TTIP_ICONSPACE = "경보 아이콘의 특성을 변경합니다.";
-- EA_TTIP_ICONDROPDOWN = "아이콘의 방향을 변경합니다.";
EA_TTIP_ALLOWESC = "경보 창을 ESC 키로 닫을 수 있도록 변경합니다. (노트: UI 재시작이 필요합니다.)";
EA_TTIP_ALTALERTS = "활성화류 버프 경보를 표시합니다.";

EA_TTIP_ICONXOFFSET = "경보 아이콘의 수평 간격을 변경합니다.";
EA_TTIP_ICONYOFFSET = "경보 아이콘의 수직 간격을 변경합니다.";
EA_TTIP_ICONREDDEBUFF = "붉은색의 디버프 아이콘의 밝기를 변경합니다.";
EA_TTIP_ICONGREENDEBUFF = "녹색의 대상 디버프 아이콘의 밝기를 변경합니다.";
EA_TTIP_ICONEXECUTION = "경보 실행을 위한 우두머리 생명력 백분율을 변경합니다.";
EA_TTIP_PLAYERLV2BOSS = "대상의 레벨이 플레이어보다 2레벨 높다면, 우두머리 실행으로 전환합니다.";
EA_TTIP_SCD_USECOOLDOWN = "Skill Cooldown frames can use cooldown style or normal style (must reload UI to take effect).";
EA_TTIP_TAR_NEWLINE = "새로운 라인에 대상의 디버프 표시 상태를 전환합니다.";
EA_TTIP_TAR_ICONXOFFSET = "경보 창과의 수평 간격을 조절합니다.";
EA_TTIP_TAR_ICONYOFFSET = "경보 창과의 수직 간격을 조절합니다.";
EA_TTIP_TARGET_MYDEBUFF = "플레이어가 대상에 시전한 디버프만 표시합니다.";
EA_TTIP_SPELLCOND_STACK = "중첩이 >= n (최소:2) 일때 주문 경고를 표시합니다.";
EA_TTIP_SPELLCOND_SELF = "자신이 시전한 주문을 표시합니다.";
EA_TTIP_SPELLCOND_OVERGROW = "중첩이 >= n (최소:1) 일때 주문 경고를 강조합니다.";
EA_TTIP_SPELLCOND_REDSECTEXT = "재사용 대기시간이 <= n (최소:1) 일때 붉은색 문자로 초단위를 표시합니다.";
EA_TTIP_SPELLCOND_ORDERWTD = "아이콘의 순서(1-20)를 설정합니다. 큰 숫자의 위치는 내부입니다."

EA_TTIP_SPECFLAG_CHECK_HOLYPOWER = "자기 버프의 왼쪽 첫번째 위치에 성스러운 힘을 표시합니다.";
EA_TTIP_SPECFLAG_CHECK_RUNICPOWER = "자기 버프의 왼쪽 첫번째 위치에 룬 파워를 표시합니다";
EA_TTIP_SPECFLAG_CHECK_SOULSHARDS = "자기 버프의 왼쪽 첫번째 위치에 영혼석을 표시합니다";
EA_TTIP_SPECFLAG_CHECK_ECLIPSE = "자기 버프의 왼쪽 첫번째 위치에 월식을 표시합니다";
EA_TTIP_SPECFLAG_CHECK_COMBOPOINT = "대상의 디버프 왼쪽 첫번째 위치에 연계포인트를 표시합니다.";
EA_TTIP_SPECFLAG_CHECK_LIFEBLOOM = "자기 버프의 왼쪽 첫번째 위치에 피어나는 생명 지속시간과 중첩을 표시합니다."
EA_TTIP_SPECFLAG_CHECK_RAGE = "Show Rage in the left 1st position of Slef-Buffs";				-- 支援怒氣(戰士,熊D)
EA_TTIP_SPECFLAG_CHECK_FOCUS = "Show Focus in the left 1st position of Slef-Buffs";				--  支援集中值(獵人)
EA_TTIP_SPECFLAG_CHECK_ENERGY = "Show Energy in the left 1st position of Slef-Buffs";			--  支援能量(賊,貓D,武僧)
EA_TTIP_SPECFLAG_CHECK_LIGHTFORCE = "Show Chi of Monk in the left 1st position of Self-Buffs";	--  支援武僧真氣
EA_TTIP_SPECFLAG_CHECK_SHADOWORBS = "Show Shadow Orbs in the left 1st position of Slef-Buffs";	--  支援暗影寶珠(暗牧)
EA_TTIP_SPECFLAG_CHECK_DEMONICFURY = "Show Demonic Fury in the left 1st position of Slef-Buffs";	--  支援惡魔之怒
EA_TTIP_SPECFLAG_CHECK_BURNINGEMBERS = "Show Burning Embers in the left 1st position of Slef-Buffs";--  支援燃火餘燼

EA_TTIP_GRPCFG_ICONALPHA = "이 아이콘의 투명도를 변경합니다.";
EA_TTIP_GRPCFG_TALENT = "이 특성에만 활성화 합니다.";
EA_TTIP_GRPCFG_HIDEONLEAVECOMBAT = "비 전투 상태일때 숨깁니다.";
EA_TTIP_GRPCFG_HIDEONLOSTTARGET = "대상이 없을때 숨깁니다.";

EA_CLASS_DK = "DEATHKNIGHT";
EA_CLASS_DRUID = "DRUID";
EA_CLASS_HUNTER = "HUNTER";
EA_CLASS_MAGE = "MAGE";
EA_CLASS_PALADIN = "PALADIN";
EA_CLASS_PRIEST = "PRIEST";
EA_CLASS_ROGUE = "ROGUE";
EA_CLASS_SHAMAN = "SHAMAN";
EA_CLASS_WARLOCK = "WARLOCK";
EA_CLASS_WARRIOR = "WARRIOR";
EA_CLASS_MONK = "MONK";
EA_CLASS_FUNKY = "FUNKY";
EA_CLASS_OTHER = "OTHER";

EA_XOPT_ICONPOSOPT = "아이콘 위치 옵션";
EA_XOPT_SHOW_ALTFRAME = "경보 창 표시";
EA_XOPT_SHOW_BUFFNAME = "버프 이름 표시";
EA_XOPT_SHOW_TIMER = "타이머 표시";
EA_XOPT_SHOW_OMNICC = "창에 타이머 표시";
EA_XOPT_SHOW_FULLFLASH = "전체 화면 반짝임 경보 표시";
EA_XOPT_PLAY_SOUNDALERT = "효과음 사용";
EA_XOPT_ESC_CLOSEALERT = "ESC 키로 경보 창 닫기";
EA_XOPT_SHOW_ALTERALERT = "활성화류 버프 경보 사용";
EA_XOPT_SHOW_CHECKLISTALERT = "사용";
EA_XOPT_SHOW_CLASSALERT = "직업 경보 표시";
EA_XOPT_SHOW_OTHERALERT = "기타 경보 표시";
EA_XOPT_SHOW_TARGETALERT = "대상 경보 표시";
EA_XOPT_SHOW_SCDALERT = "대기시간 경보 표시";
EA_XOPT_SHOW_GROUPALERT = "그룹 경보 표시";
EA_XOPT_OKAY = "확인";
EA_XOPT_SAVE = "저장";
EA_XOPT_CANCEL = "취소";
EA_XOPT_VERURLTEXT = "EAM 업데이트 사이트:";
EA_XOPT_VERBTN1 = "Gamer";
EA_XOPT_VERURL1 = "http://forum.gamer.com.tw/Co.php?bsn=05219&sn=5125122&subbsn=0";
EA_XOPT_SPELLCOND_STACK = "중첩일때 주문 표시 (중첩 >=)";
EA_XOPT_SPELLCOND_SELF = "자신의 주문 시전";
EA_XOPT_SPELLCOND_OVERGROW = "주문 강조 (중첩 >=)"
EA_XOPT_SPELLCOND_REDSECTEXT = "붉은색 재사용 대기시간 문자 (초<=)"
EA_XOPT_SPELLCOND_ORDERWTD = "우선 순위 (1-20):"

EA_XICON_LOCKFRAME = "창 잠금";
EA_XICON_LOCKFRAMETIP = "창의 위치를 이동하려면 창 잠금을 해제하셔야 합니다.";
EA_XICON_SHARESETTING = "Share alert frame positions";
EA_XICON_ICONSIZE = "아이콘 크기";
-- EA_XICON_ICONSIZE2 = "대상 아이콘 크기";
-- EA_XICON_ICONSIZE3 = "재사용 대기시간 아이콘 크기";
EA_XICON_LARGE = "크게";
EA_XICON_SMALL = "작게";
EA_XICON_HORSPACE = "수평 간격";
EA_XICON_VERSPACE = "수직 간격";
-- EA_XICON_ICONSPACE1 = "자신 아이콘 간격";
-- EA_XICON_ICONSPACE2 = "대상 아이콘 간격";
-- EA_XICON_ICONSPACE3 = "재사용 대기시간 아이콘 간격";
EA_XICON_MORE = "넓게";
EA_XICON_LESS = "좁게";
EA_XICON_REDDEBUFF = "붉은색의 디버프 아이콘";
EA_XICON_GREENDEBUFF = "녹색의 대상 디버프 아이콘";
EA_XICON_DEEP = "어둡게";
EA_XICON_LIGHT = "밟게";
-- EA_XICON_DIRECTION = "방향";
-- EA_XICON_DIRUP = "위";
-- EA_XICON_DIRDOWN = "아래";
-- EA_XICON_DIRLEFT = "왼쪽";
-- EA_XICON_DIRRIGHT = "오른쪽";
EA_XICON_TAR_NEWLINE = "새로운 라인에 대상의 디버프";
EA_XICON_TAR_HORSPACE = "경보 창과의 수평 간격";
EA_XICON_TAR_VERSPACE = "경보 창과의 수직 간격";
EA_XICON_TOGGLE_ALERTFRAME = "경보 샘플 표시";
EA_XICON_RESET_FRAMEPOS = "창 위치 초기화";
EA_XICON_SELF_BUFF = "자신의 버프";
EA_XICON_SELF_SPBUFF = "자신의 디버프(1)\n또는 특성 창";
EA_XICON_SELF_DEBUFF = "자신의 디버프";
EA_XICON_TARGET_BUFF = "대상의 버프";
EA_XICON_TARGET_SPBUFF = "대상의 버프(1)\n또는 특성 창";
EA_XICON_TARGET_DEBUFF = "대상의 디버프";
EA_XICON_SCD = "지속시간";
EA_XICON_EXECUTION = "실행을 위한 우두머리 생명력 백분율";
EA_XICON_EXEFULL = "50%";
EA_XICON_EXECLOSE = "닫기";
EA_TTIP_SCD_USECOOLDOWN = "Use cooldown countdown (must reload UI).";

EX_XCLSALERT_SELALL = "모두 선택";
EX_XCLSALERT_CLRALL = "모두 제거";
EX_XCLSALERT_LOADDEFAULT = "기본값 불려오기";
EX_XCLSALERT_REMOVEALL = "Del All";
EX_XCLSALERT_SPELL = "주문ID:";
EX_XCLSALERT_ADDSPELL = "추가";
EX_XCLSALERT_DELSPELL = "삭제";
EX_XCLSALERT_HELP1 = "주문은 ID 순서로 정렬됩니다.";
EX_XCLSALERT_HELP2 = "주문 ID 는 [] 기호 안쪽에 표시됩니다.";
EX_XCLSALERT_HELP3 = "주문 ID를 찾으려면 아래 주소를 참고하세요:";
EX_XCLSALERT_HELP4 = "특정 조건 만족시";
EX_XCLSALERT_HELP5 = "활성화 되는 주문입니다.";
EX_XCLSALERT_HELP6 = "예: 적의 낮은 생명력, 회피...기타.";
EX_XCLSALERT_SPELLURL = "http://thottbot.com/spell=SPELLIDHERE";

EA_XTARALERT_TARGET_MYDEBUFF = "자신이 시전한 디버프만";

EA_XGRPALERT_ICONALPHA = "아이콘 투명도";
EA_XGRPALERT_GRPID = "그룹ID:";
EA_XGRPALERT_TALENT1 = "1특성";
EA_XGRPALERT_TALENT2 = "2특성";
EA_XGRPALERT_HIDEONLEAVECOMBAT = "비 전투시 숨김"
EA_XGRPALERT_HIDEONLOSTTARGET = "대상 없을때 숨김"
EA_XGRPALERT_TALENTS = "모든 특성";
EA_XGRPALERT_NEWSPELLBTN = "주문 추가";
EA_XGRPALERT_NEWCHECKBTN = "체크 추가";
EA_XGRPALERT_NEWSUBCHECKBTN = "하위 체크 추가";
EA_XGRPALERT_SPELLNAME = "주문 이름:";
EA_XGRPALERT_SPELLICON = "주문 아이콘:";
EA_XGRPALERT_TITLECHECK = "체크:";
EA_XGRPALERT_TITLESUBCHECK = "하위 체크:";
EA_XGRPALERT_TITLEORDERUP = "순서 위로";
EA_XGRPALERT_TITLEORDERDOWN = "순서 아래로";
EA_XGRPALERT_LOGICS = {
	[1]={text="그리고", value=1},
	[2]={text="또는", value=0}, };
EA_XGRPALERT_EVENTTYPE = "이벤트 형태:";
EA_XGRPALERT_EVENTTYPES = {
	[1]={text="유닛 파워 변경", value="UNIT_POWER"},
	[2]={text="유닛 생명력 변경", value="UNIT_HEALTH"},
	[3]={text="유닛 오라 변경", value="UNIT_AURA"},
	[4]={text="연계 포인트 변경", value="UNIT_COMBO_POINTS"}, };
EA_XGRPALERT_UNITTYPE = "유닛 형태:";
EA_XGRPALERT_UNITTYPES = {
	[1]={text="플레이어", value="player"},
	[2]={text="대상", value="target"},
	[3]={text="주시 대상", value="focus"},
	[4]={text="소환수", value="pet"},
	[5]={text="보스 1", value="boss1"},
	[6]={text="보스 2", value="boss2"},
	[7]={text="보스 3", value="boss3"},
	[8]={text="보스 4", value="boss4"},
	[9]={text="파티원 1", value="party1"},
	[10]={text="파티원 2", value="party2"},
	[11]={text="파티원 3", value="party3"},
	[12]={text="파티원 4", value="party4"},
	[13]={text="Raid 1", value="raid1"},
	[14]={text="Raid 2", value="raid2"},
	[15]={text="Raid 3", value="raid3"},
	[16]={text="Raid 4", value="raid4"},
	[17]={text="Raid 5", value="raid5"},
	[18]={text="Raid 6", value="raid6"},
	[19]={text="Raid 7", value="raid7"},
	[20]={text="Raid 8", value="raid8"},
	[21]={text="Raid 9", value="raid9"},
};

EA_XGRPALERT_CHECKCD = "대기시간 체크:";

EA_XGRPALERT_HEALTH = "생명력:";
EA_XGRPALERT_COMPARES = {
	[1]={text="<", value=1},
	[2]={text="<=", value=2},
	[3]={text="=", value=3},
	[4]={text=">=", value=4},
	[5]={text=">", value=5}, 
};
EA_XGRPALERT_COMPARETYPES = {
	[1]={text="값", value=1},
	[2]={text="백분율", value=2},
};
EA_XGRPALERT_CHECKAURA = "오라:";
EA_XGRPALERT_CHECKAURAS = {
	[1]={text="존재", value=1},
	[2]={text="존재 하지 않음", value=2},
};
EA_XGRPALERT_AURATIME = "시간:";
EA_XGRPALERT_AURASTACK = "중첩:";
EA_XGRPALERT_CASTBYPLAYER = "자신의 시전";
EA_XGRPALERT_COMBOPOINT = "연계 포인트:";

EA_XLOOKUP_START1 = "주문 이름 검색";
EA_XLOOKUP_START2 = "전체 검색";
EA_XLOOKUP_RESULT1 = "검색 결과";
EA_XLOOKUP_RESULT2 = "개 검색";
EA_XLOAD_LOAD = "\124cffFFFF00EventAlertMod\124r:특정 이벤트 경보기를 불려옵니다. 버전:\124cff00FFFF";

EA_XLOAD_FIRST_LOAD = "\124cffFF0000EventAlertMod first load detected. Load the default settings.\124r\n\n"..
"Use \124cffFFFF00/eam opt\124r to set all settings for your using.\n\n";

EA_XLOAD_NEWVERSION_LOAD = "Use \124cffFFFF00/eam help\124r to read the command usages.\n\n\n"..
"\124cff00FFFF- Update New Features -\124r\n\n"..
"1.Five Alert-Types: Class, Target, Other(X-Class), Spell CD, and Group Alerts. "..
	"Players can adjust all spell-list of all alert-types in the WOW. "..
	"All adjusts will be apply immediately when you save. Needn't to relogin WOW. "..
	"The Group Alerts can provide you multi-spells show in one frame. "..
	"And each spells can set it's own conditions to determine show/hide.\n\n"..
"2.More Commands: For players to find out self buff/debuff, target's buff/debuff, "..
	"boss skills...etc in game. And also can use Spell-Name to find out the spells. "..
	"Please use [/eam help] to read more helps about EAM commands.\n\n"..
"3.Class Special Alert: Combo Points, Holy Power, Eclipse, Soul Shards, Runic Power. "..
	"These Special Alert will auto-display for the class in the WOW. "..
	"You can toggle this on or off in the Icon Position Setting.\n\n"..
"4.Colours: The debuffs of self/target will display in red/green color. "..
	"Player can change it dynamically in [/eam opt].\n\n"..
""; -- END OF NEWVERSION

EA_XCMD_VER = " \124cff00FFFFBy ACDACD@TW-REALM\124r 버전: ";
EA_XCMD_DEBUG = " 디버그 모드: ";
EA_XCMD_SELFLIST = " 플레이어 버프 및 디버프 표시: ";
EA_XCMD_TARGETLIST = " 대상의 디버프 표시: ";
EA_XCMD_CASTSPELL = " 시전한 주문 ID 표시: ";
EA_XCMD_AUTOADD_SELFLIST = " 자동으로 모든 플레이어의 버프 및 디버프 추가: ";
EA_XCMD_ENVADD_SELFLIST = " 자동으로 모든 플레이어의 버프 및 디버프 추가 (공격대 제외): ";
EA_XCMD_DEBUG_P0 = "경보 주문 목록";
EA_XCMD_DEBUG_P1 = "주문";
EA_XCMD_DEBUG_P2 = "주문-ID";
EA_XCMD_DEBUG_P3 = "중첩";
EA_XCMD_DEBUG_P4 = "지속시간";

EA_XCMD_CMDHELP = {
	["TITLE"] = "\124cffFFFF00EventAlertMod\124r \124cff00FF00명령어\124r(/eventalertmod 또는 /eam):",
	["OPT"] = "\124cff00FF00/eam options(/eam opt)\124r - 옵션 창을 열거나 닫습니다.",
	["HELP"] = "\124cff00FF00/eam help\124r - 고급 명령어 도움말을 표시합니다.",
	["SHOW"] = {
		"\124cff00FF00/eam show [초]\124r -",
		"모드를 켜거나 끕니다. 플레이어에게 시전된 지속시간[초]이 있는 모든 버프 및 디버프의 목록을 표시합니다.",
	},
	["SHOWT"] = {
		"\124cff00FF00/eam showtarget(/eam showt) [초]\124r -",
		"모드를 켜거나 끕니다. 대상에게 시전된 지속시간[초]이 있는 모든 디버프의 목록을 표시합니다.",
	},
	["SHOWC"] = {
		"\124cff00FF00/eam showcast(/eam showc)\124r -",
		"모드를 켜거나 끕니다. 성공적으로 시전한 주문 ID|1을;를; 표시합니다.",
	},
	["SHOWA"] = {
		"\124cff00FF00/eam showautoadd(/eam showa) [초]\124r -",
		"모드를 켜거나 끕니다. 자동으로 지속시간[초(기본 60)]이 있는 플레이어의 모든 버프 및 디버프를 추가합니다.",
	},
	["SHOWE"] = {
		"\124cff00FF00/eam showenvadd(/eam showe) [초]\124r -",
		"모드를 켜거나 끕니다. 자동으로 지속시간[초(기본 60)]이 있는 플레이어의 모든 버프 및 디버프를 추가합니다. (파티 및 공격대 버프 및 디버프 제외)",
	},
	["LIST"] = {
		"\124cff00FF00/eam list\124r - EA의 명령 출력을 표시합니다.",
		"다음 명령어의 목록을 표시하거나 숨깁니다: showc, showt, lookup, lookupfull.",
	},
	["LOOKUP"] = {
		"\124cff00FF00/eam lookup(/eam l) 주문이름\124r - 주문 이름 검색이 부분 일치하면 표시합니다.",
		"WOW의 모든 주문을 검색합니다. 주문 이름이 부분 일치하면 주문 목록을 표시합니다.",
	},
	["LOOKUPFULL"] = {
		"\124cff00FF00/eam lookupfull(/eam lf) 주문이름\124r - 주문 이름 검색이 모두 일치하면 표시합니다.",
		"WOW의 모든 주문을 검색합니다. 주문 이름이 모두 일치하면 주문 목록을 표시합니다.",
	},
}

-- Class Mana/Power and special power definitions
EA_SPELL_POWER_MANA = 0;				-- Mana (Mage, Warlock, Shaman, Paladin, Priest, Druids)
EA_SPELL_POWER_RAGE = 1;				-- Rage (Warrior, Druid in bear form)
EA_SPELL_POWER_FOCUS = 2;				-- Focus (Hunter)
EA_SPELL_POWER_ENERGY = 3;				-- Energy (Rogue, Druid in cat form, Monk)
EA_SPELL_POWER_RUNES = 5;				-- Rune (Death Knight)
EA_SPELL_POWER_RUNIC_POWER = 6;			-- Runic Power (Death Knight)
EA_SPELL_POWER_SOUL_SHARDS = 7;			-- Soul Shards (Affliction Warlock)
EA_SPELL_POWER_ECLIPSE = 8;				-- Eclipse (Druid in moonkin form)
EA_SPELL_POWER_HOLY_POWER = 9;			-- Holy Power (Paladin)
EA_SPELL_POWER_LIGHT_FORCE = 12;		-- Chi (Monk)
EA_SPELL_POWER_SHADOW_ORBS = 13;		-- Shadow Orbs (Shadow Priest)
EA_SPELL_POWER_BURNING_EMBERS = 14;		-- Burning Embers (Destruction Warlock)
EA_SPELL_POWER_DEMONIC_FURY = 15;		-- Demonic Fury (Demonology Warlock)

EA_XOPT_SPECFLAG_HOLYPOWER = "성스러운 힘";
EA_XOPT_SPECFLAG_RUNICPOWER = "룬 파워";
EA_XOPT_SPECFLAG_SOULSHARDS = "영혼석";
EA_XOPT_SPECFLAG_ECLIPSE = "월식";
EA_XOPT_SPECFLAG_COMBOPOINT = "연계 포인트";
EA_XOPT_SPECFLAG_LIFEBLOOM = "피어나는 생명";
EA_XOPT_SPECFLAG_SHADOWORBS = "ShadowOrbs";	--5.1 By ZYF: support display texts for Shadow Orbs, Energy, Rage, Focus.
EA_XOPT_SPECFLAG_RAGE = "Rage";
EA_XOPT_SPECFLAG_ENERGY = "Energy";
EA_XOPT_SPECFLAG_FOCUS = "Focus";
EA_XOPT_SPECFLAG_LIGHTFORCE = "Chi";		--5.1   support display texts for Chi of Monk
EA_XOPT_SPECFLAG_BURNINGEMBERS = "Burning Embers";
EA_XOPT_SPECFLAG_DEMONICFURY = "Demonic Fury";

EA_XGRPALERT_POWERTYPE = "파워 형태:";
EA_XGRPALERT_POWERTYPES = {
	[1]={text="마나", value=EA_SPELL_POWER_MANA},
	[2]={text="분노", value=EA_SPELL_POWER_RAGE},
	[3]={text="집중", value=EA_SPELL_POWER_FOCUS},
	[4]={text="기력", value=EA_SPELL_POWER_ENERGY},
	[5]={text="Rune", value=EA_SPELL_POWER_RUNES},
	[6]={text="룬 파워", value=EA_SPELL_POWER_RUNIC_POWER},
	[7]={text="영혼석", value=EA_SPELL_POWER_SOUL_SHARDS},
	[8]={text="월식", value=EA_SPELL_POWER_ECLIPSE},
	[9]={text="성스러운 힘", value=EA_SPELL_POWER_HOLY_POWER},
	[10]={text="Chi", value=EA_SPELL_POWER_LIGHT_FORCE},				--5.1   support Chi of Monk.
	[11]={text="Shadow Orbs", value=EA_SPELL_POWER_SHADOW_ORBS},		--5.1 By ZYF: support Shadow Orbs. 
	[12]={text="Burning Embers", value=EA_SPELL_POWER_BURNING_EMBERS},
	[13]={text="Demonic Fury", value=EA_SPELL_POWER_DEMONIC_FURY},
};

EA_XSPECINFO_COMBOPOINT = "연계 포인트";
EA_XSPECINFO_RUNICPOWER = "룬 파워";
EA_XSPECINFO_SOULSHARDS = "영혼석";
EA_XSPECINFO_ECLIPSE = "월식(달)";
EA_XSPECINFO_ECLIPSEORG = "월식(태양)";
EA_XSPECINFO_HOLYPOWER = "성스러운 힘";
EA_XSPECINFO_SHADOWORBS= "Shadow Orbs";		--5.1 By ZYF: support Shadow Orbs, Energy, Rage, Focus.
EA_XSPECINFO_ENERGY= "Energy";
EA_XSPECINFO_RAGE= "Rage";
EA_XSPECINFO_FOCUS= "Focus";
EA_XSPECINFO_LIGHTFORCE= "Chi";				--5.1   support Chi of Monk.