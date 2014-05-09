
BuildEnv(...)

ADDON_TITLE = '魔兽友团插件'
ADDON_NAME = '友团组团'
_G.BINDING_HEADER_RAIDBUILDER = ADDON_NAME
_G.BINDING_NAME_RAIDBUILDER_TOGGLE = '打开主界面'

local L = LibStub('AceLocale-3.0'):NewLocale('RaidBuilder', 'zhCN', true)
if not L then return end

L.RaidBuilderChannel = '友团组团通信'

L.EVENT_ERROR_BLOCK = '团长已将你屏蔽'
L.EVENT_ERROR_ITEMLEVEL = '装备等级不符合要求'
L.EVENT_ERROR_LEVEL = '角色等级不符合要求'
L.EVENT_ERROR_NULL = '该活动不存在'
L.EVENT_ERROR_PASSWORD = '密码错误'
L.EVENT_ERROR_PVPRATING = 'PVP等级不符合要求'

L.EVENT_ANNOUNCEMENT_CONTENT = '我在<' .. ADDON_TITLE .. '>创建了活动<%s-%s>，小伙伴们快来参加啊！'
L.ADDON_SHARE_CONTENT = '我正在用跨服组团神器<' .. ADDON_TITLE .. '>，小伙伴们快来用啊！'
L.TEAM_NOTICE_CONTENT = '<友团插件>欢迎加入本团队(%s)，体验便捷的跨服组队，畅游WOW。'

L['点击按键以绑定命令->友团组团，点击ESC或者再次点击按钮取消设置。'] = true
L['%s 开始推送易信（若超过推送次数上限将无法发送）'] = true
L['%s拒绝了你的活动申请'] = true
L['1.下载易信并关注公众号“|cffffd100友团插件|r”'] = true
L['2.向“|cffffd100友团插件|r”发送“|cffffd100关注%s@%s|r”即可'] = true
L['2v2'] = true
L['3v3'] = true
L['5v5'] = true
L['Bug!!!'] = true
L['PVP 等级'] = true
L['PvP'] = true
L['PVP：'] = true
L['Roll'] = true
L['Roll团'] = true
L['|cff00ffff组团助手：|r'] = true
L['|cff00ffff魔兽友团：|r'] = true
L['|cff33ff99邀请入群|r'] = true
L['|cffff0000你创建的活动已满员将暂停招募，如有玩家离队需重新招募，可以点击申请列表内的恢复活动|r'] = true
L['|cffff0000注意：该记录仅储存在本地配置中|r'] = true
L['|cffff0000注意：黑名单仅储存在本地配置中|r'] = true
L['|cffffd100        亲爱的朋友，还在苦恼没人一起陪你畅游艾泽拉斯吗？那就快来这里吧，每天从扭曲虚空会发布三个主题活动来到艾泽拉斯，您可以快速的创建或加入指定的活动，与同样喜欢这些活动的玩家一起活动，希望能给大家带来不同的游戏感受！|r'] = true
L['|cffffd100%d|r'] = true
L['|cffffd100全部主题活动|r'] = true
L['世界Boss一波流'] = true
L['主题活动'] = true
L['人员已满'] = true
L['人数'] = true
L['今天投过了'] = true
L['今天活动'] = true
L['今日已签到'] = true
L['今日已达发送上限'] = true
L['今日活动'] = true
L['今日热门主题活动'] = true
L['今日签到成功'] = true
L['位置'] = true
L['你不是团长，不能邀请成员'] = true
L['你不是队长，不能创建活动'] = true
L['你创建的活动已满员，已暂停招募。'] = true
L['你创建的活动已被暂停，如需继续活动，请点击|cffffd100%s|r内的|cffffd100%s|r。'] = true
L['你已经在一个队伍中，不能申请其它活动。'] = true
L['你正在申请加入一些活动，是否取消申请以创建自己的活动？'] = true
L['你正在组织一个活动，不能申请其它活动'] = true
L['你每周有N次机会向关注你的玩家发送活动通知。'] = true
L['你每天有3次机会向关注你的玩家发送活动通知。'] = true
L['你每天有三次发送活动通知的机会'] = true
L['你的等级、物品等级或职业不符合要求，不能选择该职责。'] = true
L['你确定将 |cffffd100%s|r 加入黑名单吗？'] = true
L['你确定将 |cffffd100%s|r 移出黑名单吗？'] = true
L['你确定要取消申请这个活动？'] = true
L['你确定要解散这个活动？'] = true
L['使用手机推送功能后，将会把本次活动信息通过易信消息发送到关注你的玩家手机上。'] = true
L['使用本功能需要具备的条件？'] = true
L['允许小地图图标被整合'] = true
L['全部'] = true
L['公告'] = true
L['共 %d 人'] = true
L['共|cffffd100%d|r名成员，平均装等|cffffd100%s|r'] = true
L['其他'] = true
L['冰冠堡垒'] = true
L['冲分'] = true
L['决战奥格瑞玛-10人'] = true
L['决战奥格瑞玛-25人'] = true
L['决战奥格瑞玛-弹性'] = true
L['分享插件'] = true
L['创建活动'] = true
L['创建活动失败 %s'] = true
L['创建活动成功 %s'] = true
L['创建活动成功'] = true
L['创建跨服活动'] = true
L['刷勇气'] = true
L['刷征服'] = true
L['刷正义'] = true
L['刷荣誉'] = true
L['副本名称'] = true
L['副本经验'] = true
L['加入到黑名单'] = true
L['加入黑名单'] = true
L['加密'] = true
L['十字军的试炼'] = true
L['千里传音！'] = true
L['友团插件公众号'] = true
L['友团聊天'] = true
L['双子峰'] = true
L['发现友团组团新版本，您当前的版本不兼容，请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用'] = true
L['发现新版本'] = true
L['发现新版本: %s，请及时下载更新\n%s'] = true
L['发送'] = true
L['发送通知'] = true
L['取消申请'] = true
L['吉尔尼斯之战'] = true
L['名单信息错误'] = true
L['命中'] = true
L['命中：'] = true
L['四大天神'] = true
L['团长'] = true
L['团长副本经验'] = true
L['团长可以使用网站上的组队代码实现一键组队'] = true
L['团长查找'] = true
L['团长积分总榜'] = true
L['团长积分月榜'] = true
L['团长等级'] = true
L['团长装等'] = true
L['团长评分'] = true
L['团长进度'] = true
L['团长：'] = true
L['团队人数'] = true
L['团队副本'] = true
L['在|cff00ffff易信|r中关注Ta仅需两步：'] = true
L['在团'] = true
L['地下城'] = true
L['场景战役'] = true
L['坦克'] = true
L['大于5人的活动，最低等级不能低于10级'] = true
L['大地的裂变'] = true
L['奥杜尔'] = true
L['奥特兰克山谷'] = true
L['好友申请中'] = true
L['如何关注好团长?'] = true
L['如何创建战网昵称？'] = true
L['寇魔古寺'] = true
L['屏蔽日期'] = true
L['屠城'] = true
L['屠龙点数'] = true
L['巨龙之魂'] = true
L['巫妖王之怒'] = true
L['已加入'] = true
L['已取消申请加入%s的活动。'] = true
L['已填写推荐'] = true
L['已拒绝'] = true
L['已提交申请加入%s的活动。'] = true
L['已提交申请加入|cffffd100%s|r的活动。'] = true
L['已确认'] = true
L['巴拉丁监狱'] = true
L['幻化'] = true
L['广告'] = true
L['开启团队通告'] = true
L['开团'] = true
L['开团次数：%d次'] = true
L['开始邀请'] = true
L['开荒'] = true
L['开荒团'] = true
L['弹性'] = true
L['弹性：%d/%d'] = true
L['当前人数'] = true
L['当前正在组织活动，不能离开队伍。'] = true
L['当前正在组织活动，不能离开队伍，请先解散活动。'] = true
L['当前正在组织活动，不能转移队长。'] = true
L['当前没有活动'] = true
L['形式'] = true
L['形式：'] = true
L['征服之岛'] = true
L['待确认'] = true
L['忙碌'] = true
L['快捷邀请'] = true
L['急速'] = true
L['急速：'] = true
L['恐惧之心'] = true
L['恢复活动'] = true
L['想以后继续参加这个团长的活动吗'] = true
L['意见建议'] = true
L['感谢参与'] = true
L['成就'] = true
L['成就团'] = true
L['我的'] = true
L['我的队伍'] = true
L['战场'] = true
L['战歌峡谷'] = true
L['战网不可用或你没有创建战网昵称，你不能使用魔兽友团插件。'] = true
L['战网不可用，你不能使用组团插件。'] = true
L['战网昵称'] = true
L['战网昵称：'] = true
L['战网通告'] = true
L['所在地图'] = true
L['打开/关闭友团组团按键设置'] = true
L['批量邀请入群'] = true
L['找团'] = true
L['护甲：'] = true
L['拒绝'] = true
L['招架：'] = true
L['按键已绑定到|cffffd100%s|r，你确定要覆盖吗？'] = true
L['挑战'] = true
L['排名'] = true
L['排行榜'] = true
L['推荐人'] = true
L['推荐人填写成功'] = true
L['提交'] = true
L['操作'] = true
L['操作记录'] = true
L['攻强：'] = true
L['斡耳朵斯'] = true
L['易信下载二维码'] = true
L['易信关注度：'] = true
L['易信推送'] = true
L['易信通知'] = true
L['显示小地图图标'] = true
L['显示悬浮窗'] = true
L['普通'] = true
L['普通：%d/%d'] = true
L['暂无'] = true
L['暂无活动'] = true
L['暂离'] = true
L['暮光堡垒'] = true
L['暴击：'] = true
L['最低等级不能超过最高等级'] = true
L['最小等级错误'] = true
L['服务器'] = true
L['未组队'] = true
L['查找活动'] = true
L['查看总榜'] = true
L['格档：'] = true
L['正在招募'] = true
L['正在邀请'] = true
L['每个群每周有五次发送活动通知的机会'] = true
L['每日活动'] = true
L['每日签到'] = true
L['永恒之眼'] = true
L['永春台'] = true
L['没有密码'] = true
L['治疗'] = true
L['法伤：'] = true
L['注释'] = true
L['活动人员已组满，无法继续邀请！'] = true
L['活动形式'] = true
L['活动总数 %d/%d'] = true
L['活动总数'] = true
L['活动类型'] = true
L['活动说明'] = true
L['活动通告'] = true
L['活动须知：'] = true
L['深风峡谷'] = true
L['混分'] = true
L['清除记录'] = true
L['火焰之地'] = true
L['点击查看详细步骤'] = true
L['熊猫人之谜'] = true
L['牛'] = true
L['玩家名称'] = true
L['申请'] = true
L['申请中 %d/%d 活动总数 %d/%d'] = true
L['申请中'] = true
L['申请中活动'] = true
L['申请人数'] = true
L['申请列表'] = true
L['申请列表：'] = true
L['申请加入%s的活动失败，%s'] = true
L['申请加入'] = true
L['申请加入|cffffd100%s|r的活动失败，%s'] = true
L['申请密码'] = true
L['申请队列已经满员，请等待或取消之前的申请'] = true
L['确定需要发送易信通知？'] = true
L['碎银矿脉'] = true
L['离线'] = true
L['符合条件'] = true
L['等级'] = true
L['等级最高不能超过%d'] = true
L['等级最高不能超过90'] = true
L['等级范围'] = true
L['等级范围错误'] = true
L['等级：'] = true
L['签到'] = true
L['精准：'] = true
L['精通'] = true
L['精通：'] = true
L['红玉圣殿'] = true
L['组队代码有误，请重试！'] = true
L['组队插件'] = true
L['组队码错误'] = true
L['组队码验证失败'] = true
L['网站活动'] = '集合石'
L['职业'] = true
L['职业：'] = true
L['职责总人数不能小于1或大于%d'] = true
L['职责总人数不能小于2或大于%d'] = true
L['自强'] = true
L['自强团'] = true
L['英雄'] = true
L['英雄：%d/%d'] = true
L['表示你愿意以其他的身份参加该活动。'] = true
L['表示你愿意以参与者的身份参加该活动。'] = true
L['装备等级'] = true
L['装备等级和PVP等级必须符合要求'] = true
L['装等'] = true
L['装等：%d'] = true
L['装等：'] = true
L['要求'] = true
L['角色名'] = true
L['解散活动 %s'] = true
L['解散活动'] = true
L['解除屏蔽'] = true
L['设置'] = true
L['设置友团职责'] = true
L['评级战场'] = true
L['该职责已满，不能选择该职责。'] = true
L['说明'] = true
L['说明：'] = true
L['请在这里输入活动说明'] = true
L['请将网页上复制的组队代码粘贴在此'] = true
L['请投票'] = true
L['请搜索“|cff00ff00%d|r”打开插件使用指南'] = true
L['请搜索“|cff00ff002528|r”，查看如何创建战网昵称。'] = true
L['请确定每个职责的人数：'] = true
L['请输入密码'] = true
L['请输入邀请人的角色名和服务器，格式如下：|cffffd100%s-%s|r'] = true
L['请选择你的职责：'] = true
L['请选择活动形式'] = true
L['请选择活动类型'] = true
L['请选择活动类型及活动形式'] = true
L['跳转到创建活动页面创建游戏内团队'] = true
L['躲闪：'] = true
L['输出'] = true
L['这个活动等级最低不能低于%d'] = true
L['这项设置将在下次载入插件时生效。'] = true
L['远古海滩'] = true
L['退出队伍'] = true
L['邀请'] = true
L['邀请状态'] = true
L['邀请组队中'] = true
L['金团'] = '带新'
L['金币：'] = true
L['锁定悬浮窗'] = true
L['队列中'] = true
L['阿尔卡冯的宝库'] = true
L['阿拉希盆地'] = true
L['随机'] = true
L['随机战场 '] = true
L['随机战场'] = true
L['雷电王座'] = true
L['风暴之眼'] = true
L['风神王座'] = true
L['高端'] = true
L['魔兽友团'] = true
L['魔兽组团助手'] = true
L['魔古山宝库'] = true
L['黑名单'] = true
L['黑曜石圣殿'] = true
L['黑翼血环'] = true

L.YiXinSummary = [[
<html>
<body>
<h3 align="center">|cffffd100易信组团活动通知功能介绍</h3>
<p>遇到好的团长后，只要在易信中关注他，便可以在该团长发布开团信息后，收到该信息。</p>
<h1><br />使用方法：</h1>
<p>1、在手机上需要安装易信通讯软件。</p>
<p>2、关注“|cffffd100友团插件|r”公众号。</p>
<p>3、在公众号内输入对应命令完成订阅组团活动信息。</p>
<h1><br />订阅组团活动信息：</h1>
<p>1、在“|cffffd100友团插件|r”中输入：</p>
<p>“|cffffd100关注|r”+“|cffffd100角色名@服务器|r”</p>
<p>例：|cffffd100关注fgbx@提瑞斯法|r</p>
<p>2、获得提示：|cffffd100关注【角色名@服务器】成功|r即可。</p>
<p>3、退订团长信息：</p>
<p>“|cffffd100取消关注|r”+“|cffffd100角色名@服务器|r”</p>
<p>例：|cffffd100取消关注fgbx@提瑞斯法|r</p>
<p>4、查询关注：“|cffffd100查询关注|r”</p>
<h1><br />团长篇：</h1>
<p>1、首先团长需要创建一个活动。</p>
<p>2、点击|TInterface\AddOns\RaidBuilder\Media\YiXin:16|t|cffffd100易信推送|r按钮推送活动。</p>
<p>易信下载地址 |Hurl:http://yixin.im|h|cff00ffff[http://yixin.im]|r|h 或各大手机应用市场</p>
</body>
</html>
]]

L.MissBattleTagSummary = [[
<html>
<body>
<h3>战网或战网昵称不可用</h3>
<br/>
<p>友团插件未读取到您的战网昵称。</p>
<p>请确保您已创建过一个有效的战网昵称。</p>
<br/>
<p>如果您无法解决这个问题，请尝试重新登录或前往论坛寻求帮助。</p>
<br/>
<h1>论坛：</h1>
<p>|Hurl:http://www.battlenet.com.cn/wow/zh/forum/12507946/|h|cff00ffff[http://www.battlenet.com.cn/wow/zh/forum/12507946/]|r|h</p>
<br/>
<h1>如何创建战网昵称？</h1>
<p>|Hurl:https://www.battlenet.com.cn/support/zh/article/如何创建战网昵称？|h|cff00ffff[https://www.battlenet.com.cn/support/zh/article/如何创建战网昵称？]|r|h</p>
</body>
</html>
]]

L.NeutralDisabled = [[
<html>
<body>
<h3>中立阵营不可用</h3>
<br/>
<p>中立阵营不可使用友团插件</p>
<p>你必需选择阵营。</p>
<br/>
<p>如果您无法解决这个问题，请尝试重新登录或前往论坛寻求帮助。</p>
<br/>
<h1>论坛：</h1>
<p>|Hurl:http://www.battlenet.com.cn/wow/zh/forum/12507946/|h|cff00ffff[http://www.battlenet.com.cn/wow/zh/forum/12507946/]|r|h</p>
<br/>
</body>
</html>
]]

L.LeaderboardUrl = [[
<html>
<body>
<p>更多排名请点击|Hurl:http://app.game.163.com/zoo/wow/rankinglist|h|cff00ffff[这里]|r|h查看积分榜</p>
</body>
</html>
]]

L.WebInviteEventSummary = [[
<html>
<body>
<h1>%s %s |Hurl:%s|h|cff00ffff[来源]|r|h</h1>
</body>
</html>
]]

L.WebInviteSummaryHtml = '团长可以在 http://www.网址.com 上复制组队代码，粘贴在下面的对话框中快速组队。'

L.EmptySummary = [[
<html>
<body>
<h3>团队数据收集中...</h3>
<br/>
<p>如果您刚上线，将在五分钟内收集到全部活动数据。</p>
<br/>
<p>团长若未解散活动下线，将在十五分钟后清除活动数据。</p>
</body>
</html>
]]
