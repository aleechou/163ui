
BuildEnv(...)

ADDON_TITLE = '集合石插件'

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
L.EVENT_ANNOUNCEMENT_CONTENT_MEMBER = '我在<' .. ADDON_TITLE .. '>参加了%s创建的活动<%s>，小伙伴们快来参加啊！'
L.ADDON_SHARE_CONTENT = '我正在用跨服组团神器<' .. ADDON_TITLE .. '>，小伙伴们快来用啊！'
L.TEAM_NOTICE_CONTENT = '<' .. ADDON_TITLE .. '>欢迎加入本活动(%s)，体验便捷的跨服组队，畅游WOW。'
L.TEAM_NOTICE_CONTENT_UNIT = '<' .. ADDON_TITLE .. '>欢迎加入本活动(%s)，您目前的职责是(%s)，体验便捷的跨服组队，畅游WOW。'

L['%s 开始推送易信（若超过推送次数上限将无法发送）'] = true
L['%s拒绝了你的活动申请'] = true
L['1.下载易信并关注公众号“|cffffd100魔兽世界|r”'] = true
L['2.向“|cffffd100魔兽世界|r”发送“|cffffd100关注%s@%s|r”即可'] = true
L['90303人气团长'] = true
L['PVE人气团长'] = true
L['PVP 等级'] = true
L['PVP人气团长'] = true
L['PVP：'] = true
L['|cff00ffff集合石：|r'] = true
L['|cff33ff99邀请入群|r'] = true
L['|cffff0000(非当前角色)|r'] = true
L['|cffff0000你创建的活动已满员将暂停招募，如有玩家离队需重新招募，请点击|cffffd100小地图按钮右键菜单|r的|cffffd100%s|r'] = true
L['|cffff0000注意：关注列表仅储存在本地配置中|r'] = true
L['|cffff0000注意：该记录仅储存在本地配置中|r'] = true
L['|cffff0000注意：黑名单仅储存在本地配置中|r'] = true
L['|cffff0000记录您最近参加的集合石活动人员名单（80名）|r'] = true
L['|cffffd100%s|r 已经在关注列表。'] = true
L['|cffffffff*战网积分价格|r'] = true
L['不区分大小写，无需输入空格或连字符。'] = true
L['举报'] = true
L['人员已满'] = true
L['人数'] = true
L['人气主播'] = true
L['仅关注'] = true
L['今日已签到'] = true
L['今日已达发送上限'] = true
L['今日签到成功'] = true
L['位置'] = true
L['你不是团长，不能邀请成员'] = true
L['你不是队长，不能创建活动'] = true
L['你创建的活动已被暂停，如需继续活动，请点击|cffffd100小地图按钮右键菜单|r内的|cffffd100%s|r。'] = true
L['你已经在一个队伍中，不能申请其它活动。'] = true
L['你想对团长说什么？'] = true
L['你正在申请加入一些活动，是否取消申请以创建自己的活动？'] = true
L['你正在组织一个活动，是否解散活动以申请其它活动？'] = true
L['你每天有3次机会向关注你的玩家发送活动通知。'] = true
L['你每天有三次发送活动通知的机会'] = true
L['你的等级、物品等级或职业不符合要求，不能选择该职责。'] = true
L['你确定将 |cffffd100%s|r 加入关注列表吗？'] = true
L['你确定将 |cffffd100%s|r 加入黑名单吗？'] = true
L['你确定将 |cffffd100%s|r 移出关注列表吗？'] = true
L['你确定将 |cffffd100%s|r 移出黑名单吗？'] = true
L['你确定要举报玩家 |cffffd100%s|r 吗？\n请填写举报原因。'] = true
L['你确定要取消申请这个活动？'] = true
L['你确定要清理战网昵称好友吗？'] = true
L['你确定要解散这个活动？'] = true
L['使用手机推送功能后，将会把本次活动信息通过易信消息发送到关注你的玩家手机上。'] = true
L['使用本功能需要具备的条件？'] = true
L['允许小地图图标被整合'] = true
L['兑换列表'] = true
L['兑换失败：兑换码已使用。'] = true
L['兑换失败：兑换码错误。'] = true
L['兑换失败：处理超时，请稍后再试。'] = true
L['兑换失败：请到战网兑换。'] = true
L['兑换失败：请稍后再试。'] = true
L['兑换失败：请输入兑换码。'] = true
L['兑换已提交，请留意邮箱。'] = true
L['兑换平台%s'] = true
L['兑换平台'] = true
L['兑换平台商品列表已更新。'] = true
L['兑换平台购买%s，%s'] = true
L['兑换码格式错误'] = true
L['兑换说明'] = true
L['兑换说明：'] = true
L['全部'] = true
L['公告'] = true
L['共 %d 人'] = true
L['共|cffffd100%d|r名成员，平均装等|cffffd100%s|r'] = true
L['关注'] = true
L['关注列表'] = true
L['关注团长的活动'] = true
L['其他'] = true
L['分享插件'] = true
L['创建/更新活动成功 %s'] = true
L['创建活动'] = true
L['创建活动失败 %s'] = true
L['创建跨服活动'] = true
L['副本经验'] = true
L['加入到黑名单'] = true
L['加入黑名单'] = true
L['加密活动'] = true
L['友团奖品兑换'] = true
L['发现新版本'] = true
L['发现新版本：%s，请及时下载更新\n下载链接：%s'] = true
L['发现新版本：%s，请及时下载更新\n下载链接：%s\n更新内容：%s\n更多更新内容请浏览论坛'] = true
L['发现集合石组团新版本，您当前的版本不兼容，请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用'] = true
L['发送'] = true
L['发送通知'] = true
L['取消关注'] = true
L['取消申请'] = true
L['可申请'] = true
L['名单信息错误'] = true
L['命中：'] = true
L['团长'] = true
L['团长副本经验'] = true
L['团长可以使用网站上的组队代码实现一键组队'] = true
L['团长查找'] = true
L['团长积分总榜'] = true
L['团长积分月榜'] = true
L['团长粉丝：'] = true
L['团长：'] = true
L['团队人数'] = true
L['图示'] = true
L['在|cff00ffff易信|r中关注Ta仅需两步：'] = true
L['坦克'] = true
L['大于5人的活动，最低等级不能低于10级'] = true
L['好友申请中'] = true
L['好团长'] = true
L['如何关注好团长?'] = true
L['如何获取积分?'] = true
L['密语'] = true
L['屏蔽日期'] = true
L['屠龙点数'] = true
L['已加入'] = true
L['已加入活动'] = true
L['已取消申请加入%s的活动。'] = true
L['已填写推荐'] = true
L['已恢复招募'] = true
L['已成功提交举报信息。'] = true
L['已提交申请加入%s的活动。'] = true
L['已暂停招募'] = true
L['广告'] = true
L['开启团队通告'] = true
L['开启活动推送'] = true
L['开启集合石聊天'] = true
L['开团'] = true
L['开团时间'] = true
L['开始体验'] = true
L['开始邀请'] = true
L['弹性'] = true
L['当前人数'] = true
L['当前正在组织活动，离开队伍将解散当前活动，是否继续？'] = true
L['当前正在组织活动，转移队长将解散当前活动，是否继续？'] = true
L['当前没有活动'] = true
L['形式'] = true
L['形式：'] = true
L['忙碌'] = true
L['快捷邀请'] = true
L['急速：'] = true
L['恢复招募'] = true
L['您当前可用积分为：%d'] = true
L['悬赏：'] = true
L['想以后继续参加这个团长的活动吗'] = true
L['意见建议'] = true
L['我的活动'] = true
L['我的队伍'] = true
L['战网昵称'] = true
L['战网昵称：'] = true
L['战网通告'] = true
L['打开/关闭集合石组团按键设置'] = true
L['打开主界面'] = true
L['批量邀请入群'] = true
L['找团'] = true
L['护甲：'] = true
L['拒绝'] = true
L['招架：'] = true
L['按键已绑定到|cffffd100%s|r，你确定要覆盖吗？'] = true
L['排名'] = true
L['排行榜'] = true
L['推荐人'] = true
L['推荐人填写成功'] = true
L['插件简介'] = true
L['操作'] = true
L['操作记录'] = true
L['收到一个|cff00ffff集合石|r预约活动请求，请验证是否合法。'] = true
L['攻强：'] = true
L['新手指引'] = true
L['易信下载二维码'] = true
L['易信推送'] = true
L['显示小地图图标'] = true
L['显示悬浮窗'] = true
L['普通'] = true
L['暂停招募'] = true
L['暂无'] = true
L['暂无活动'] = true
L['暂无详细介绍'] = true
L['暂离'] = true
L['暴击：'] = true
L['更新活动'] = true
L['最低等级不能超过最高等级'] = true
L['最近的战友'] = true
L['最近组队'] = true
L['服务器'] = true
L['未组队'] = true
L['本周悬赏'] = true
L['来自'] = true
L['查找活动'] = true
L['查看总榜'] = true
L['查看您当前账号的可用积分'] = true
L['查询中，请稍后 ...'] = true
L['查询我的积分'] = true
L['查询间隔120秒'] = true
L['格式正确，请点击[确认兑换]按钮'] = true
L['格档：'] = true
L['正在招募'] = true
L['每日签到'] = true
L['没有密码'] = true
L['治疗'] = true
L['法伤：'] = true
L['注释'] = true
L['活动人员已组满，无法继续邀请！'] = true
L['活动名称'] = true
L['活动形式'] = true
L['活动总数 %d/%d'] = true
L['活动总数'] = true
L['活动类型'] = true
L['活动说明'] = true
L['活动过滤'] = true
L['活动通告'] = true
L['添加关注'] = true
L['添加时间'] = true
L['清理集合石自动添加的战网昵称好友'] = true
L['清除记录'] = true
L['点击按键以绑定命令->集合石组团，点击ESC或者再次点击按钮取消设置。'] = true
L['点击查看详细介绍'] = true
L['点击查看详细步骤'] = true
L['点击验证活动详情'] = true
L['版本：'] = true
L['玩家名称'] = true
L['申请中 %d/%d 活动总数 %d/%d'] = true
L['申请中活动'] = true
L['申请人数'] = true
L['申请列表'] = true
L['申请加入%s的活动失败，%s'] = true
L['申请加入'] = true
L['申请密码'] = true
L['申请队列已经满员，请等待或取消之前的申请'] = true
L['确认使用兑换码？'] = true
L['确认兑换'] = true
L['确认消耗 |cff00ff00%d|r 积分购买 |cff00ff00%s|r 吗？'] = true
L['离线'] = true
L['种族'] = true
L['积分查询失败：请稍后再试。'] = true
L['立即兑换'] = true
L['符合条件'] = true
L['等级'] = true
L['等级最高不能超过%d'] = true
L['等级范围'] = true
L['等级：'] = true
L['签到'] = true
L['精准：'] = true
L['精通：'] = true
L['组队代码有误，请重试！'] = true
L['组队日期'] = true
L['组队码错误'] = true
L['组队码验证失败'] = true
L['网易官方活动'] = true
L['网站活动'] = true
L['职业'] = true
L['职业：'] = true
L['职责总人数不能小于2或大于%d'] = true
L['英雄'] = true
L['表示你愿意以其他的身份参加该活动。'] = true
L['装备和PVP等级必须符合'] = true
L['装备等级'] = true
L['装等'] = true
L['装等：'] = true
L['要求'] = true
L['角色名'] = true
L['解散活动 %s'] = true
L['解散活动'] = true
L['解除屏蔽'] = true
L['设置'] = true
L['设置集合石职责'] = true
L['该职责已满，不能选择该职责。'] = true
L['详情'] = true
L['详细介绍'] = true
L['详细介绍（加入活动后才能查看）'] = true
L['说明'] = true
L['说明：'] = true
L['请勿频繁密语'] = true
L['请在这里输入兑换码'] = true
L['请在这里输入活动说明'] = true
L['请在这里输入详细介绍，团员加入活动后可在我的队伍面板查看'] = true
L['请将网页上复制的组队代码粘贴在此'] = true
L['请确定每个职责的人数：'] = true
L['请输入兑换码'] = true
L['请输入密码'] = true
L['请输入邀请人的角色名和服务器，格式如下：|cffffd100%s-%s|r'] = true
L['请选择你的职责：'] = true
L['请选择活动形式'] = true
L['请选择活动类型'] = true
L['请选择活动类型及活动形式'] = true
L['请验证请求是否合法'] = true
L['购买失败：操作超时，请稍后再试。'] = true
L['跳转到创建活动页面创建游戏内团队'] = true
L['躲闪：'] = true
L['转到'] = true
L['输入兑换码：'] = true
L['输出'] = true
L['这个活动等级最低不能低于%d'] = true
L['这项设置将在下次载入插件时生效。'] = true
L['邀请'] = true
L['邀请团长：'] = true
L['邀请时间：'] = true
L['邀请状态'] = true
L['邀请组队中'] = true
L['邀请角色：'] = true
L['金币：'] = true
L['锁定悬浮窗'] = true
L['队列中'] = true
L['阵营'] = true
L['随机'] = true
L['集合石'] = true
L['集合石人气团长'] = true
L['集合石开发团队'] = true
L['集合石总榜团长'] = true
L['集合石月榜团长'] = true
L['集合石组团'] = true
L['集合石网站预约活动请求'] = true
L['集合石聊天'] = true
L['集合石聊天模块服务器调试中'] = true
L['集合石自动添加的好友'] = true
L['魔兽世界公众号'] = true
L['黑名单'] = true

L.YiXinSummary = [[
<html>
<body>
<h3 align="center">|cffffd100易信组团活动通知功能介绍</h3>
<p>遇到好的团长后，只要在易信中关注他，便可以在该团长发布开团信息后，收到该信息。</p>
<h1><br />使用方法：</h1>
<p>1、在手机上需要安装易信通讯软件。</p>
<p>2、关注“|cffffd100魔兽世界|r”公众号。</p>
<p>3、在公众号内输入对应命令完成订阅组团活动信息。</p>
<h1><br />订阅组团活动信息：</h1>
<p>1、在“|cffffd100魔兽世界|r”公众号中输入：</p>
<p>“|cffffd100关注|r”+“|cffffd100角色名@服务器|r”</p>
<p>例：|cffffd100关注{1}@{2}|r</p>
<p>2、获得提示：|cffffd100关注【{1}@{2}】成功|r即可。</p>
<p>3、退订团长信息：</p>
<p>“|cffffd100取消关注|r”+“|cffffd100角色名@服务器|r”</p>
<p>例：|cffffd100取消关注{1}@{2}|r</p>
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
<h3>战网或战网昵称不可用|Hurl:http://bbs.game.163.com/thread-179707322-1-1.html|h|cff00ffff[解决方案]|r|h</h3>
<br/>
<p>]] .. ADDON_TITLE .. [[未读取到您的战网昵称。</p>
<p>请确保您已启用战网|cff00ff00实名好友|r功能，并创建过一个有效的|cff00ff00战网昵称|r。</p>
<br/>
<p>如果您无法解决这个问题，请尝试重新登录或前往论坛寻求帮助。</p>
<br/>
<h1>论坛：</h1>
<p>|Hurl:http://www.battlenet.com.cn/wow/zh/forum/12507946/|h|cff00ffff[http://www.battlenet.com.cn/wow/zh/forum/12507946/]|r|h</p>
<br/>
<h1>如何启用实名好友？</h1>
<p>|Hurl:https://www.battlenet.com.cn/support/zh/article/新手专题：实名好友|h|cff00ffff[https://www.battlenet.com.cn/support/zh/article/新手专题：实名好友]|r|h</p>
<br/>
<h1>如何创建战网昵称？</h1>
<p>|Hurl:https://www.battlenet.com.cn/support/zh/article/如何创建战网昵称？|h|cff00ffff[https://www.battlenet.com.cn/support/zh/article/如何创建战网昵称？]|r|h</p>
</body>
</html>
]]

L.TrialAccountSummary = [[
<html>
<body>
<h3>试玩帐号不可用</h3>
<br/>
<p>试玩帐号不能使用战网相关功能。</p>
<p>]] .. ADDON_TITLE .. [[依赖战网昵称好友功能。</p>
<br/>
<h2>|HurlIndex:2|h[点击此处升级你的账号]|h</h2>
<br/>
<p>如果您无法解决这个问题，请尝试重新登录或前往论坛寻求帮助。</p>
<br/>
<h1>论坛：</h1>
<p>|Hurl:http://www.battlenet.com.cn/wow/zh/forum/12507946/|h|cff00ffff[http://www.battlenet.com.cn/wow/zh/forum/12507946/]|r|h</p>
<br/>
</body>
</html>
]]

L.NeutralDisabled = [[
<html>
<body>
<h3>中立阵营不可用</h3>
<br/>
<p>中立阵营不可使用]] .. ADDON_TITLE .. [[</p>
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

L.WebInviteSummaryHtml = [[
<html>
<body>
<p>
团长可以在 |Hurl:http://z.wowchina.com/|h|cff00ffff[http://z.wowchina.com/]|r|h 上复制组队代码，<br/>
粘贴在下面的对话框中快速组队。</p>
</body>
</html>
]]

L.EmptySummary = [[
<html>
<body>
<h3>活动数据收集中...</h3>
<br/>
<p>如果您刚上线，将在五分钟内收集到全部活动数据。</p>
<br/>
<p>团长若未解散活动下线，将在十五分钟后清除活动数据。</p>
</body>
</html>
]]

L.RecommendSummary = [[
<html>
<body>
<h1>活动详情：</h1>
<p>在集合石网站活动页|Hurl:http://z.wowchina.com/official|h|cff00ffff[http://z.wowchina.com/official]|r|h报名并通过]] .. ADDON_TITLE .. [[组团，</p>
<p>在当周进度内击杀指定boss的所有玩家，即可参加当周抽奖；</p>
<h1>每周我们将送出：</h1>
<p>- 100张15元点卡；</p>
<p>- 100份游戏小道具：快干塑像底座</p>
<p>此外，在每周的所有中奖玩家中，我们将额外抽出一名玩家获得《魔兽世界：熊猫人之谜》典藏版一份。</p>
</body>
</html>
]]

L.BrowseHelp1 = [[
活动类型：下拉列表选择你想要参加的活动

团长查找：输入团长名字精确查找

复选框：辅助你筛选所有的活动
]]

L.BrowseHelp2 = [[
活动呈现界面，可以在这里寻找自己喜欢的活动。

鼠标悬停：可以查看活动队长的具体信息。
]]

L.BrowseHelp3 = [[
鼠标悬浮：活动当前的状态图示
]]

L.BrowseHelp4 = [[
选择你要加入的队伍后，单击申请加入按钮。
]]

L.BrowseHelp5 = [[
你申请的活动数量以及当前团队总数量
]]

L.RewardSummary = [[
<html>
<body>
<h2>1.本平台供您兑换暴雪游戏虚拟物品。</h2>
<h2>2.虚拟物品奖励一经兑换即不可退换。</h2>
<h2>3.兑换角色默认为您当前服务器和角色（即您当前使用兑换的角色）。</h2>
<h2>4.兑换后，会以邮件的形式通知您。如果没有马上收到，还请耐心等待。</h2>
<h2>5.如果您在24小时之内没收到相应的物品，请您联系客服。</h2>
</body>
</html>
]]

L.MallSummary = [[
<html>
<body>
<p>请您选择所需要的虚拟物品进行操作，一旦兑换成功，积分被扣除后将无法返还。</p>
<p>兑换成功后，系统会在1个工作日内将虚拟物品发送到您当前角色的游戏邮箱内，请注意查收。您可以在 |Hurl:http://reward.battlenet.com.cn|h|cff00ffff[http://reward.battlenet.com.cn]|r|h 查看详细积分变更信息及兑换记录。</p>
</body>
</html>
]]

L.MallPurchaseSummary = [[
<html>
<body>
<h3>购买中，请稍候 ...</h3>
<br/>
<p>您购买的物品为：|cff00ff00%s|r</p>
<p>所需积分：|cff00ff00%d|r</p>
<br />
<h2>购买成功后会通过游戏内邮件发送给您当前的角色，请您留意。</h2>
<p>如果您在24小时之内没有收到相应的物品，请您联系客服。</p>
</body>
</html>
]]

L.RewardPurchaseSummary = [[
<html>
<body>
<h3>兑换中，请稍候 ...</h3>
<br/>
<h2>兑换成功后会通过游戏内邮件发送给您当前的角色，请您留意。</h2>
<p>如果您在24小时之内没有收到相应的物品，请您联系客服。</p>
</body>
</html>
]]

L.HowToGetPoints = [[
当您购买任意战网产品（包括游戏时间、战网点数、虚拟宠物坐骑、角色增值服务）时使用|cffffd100战网在线支付（网易宝）|r功能进行付款，即可按照1:1比例获得积分！

|cff00ffff详情请复制以下网址查看：
]]

L.GoodsLoadingSummary = [[
<html>
<body>
<h3>商品数据读取中，请稍后 ...</h3>
<br/>
<p>如果您刚上线，将在十分钟内读取到商品数据。</p>
<br/>
<p>如果长时间无法收到商品数据，请检查插件版本或者联系集合石官方QQ群|Hurl:317548615|h|cff00ffff[317548615]|r|h。</p>
</body>
</html>
]]
