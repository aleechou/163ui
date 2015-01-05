
BuildEnv(...)

ADDON_TITLE = '集合石插件'

local L = LibStub('AceLocale-3.0'):NewLocale('MeetingStone', 'zhCN', true)
if not L then return end

L.CreateHelpRefresh = '点击刷新下方的申请列表'
L.CreateHelpList = '在此列出所有申请信息，团长或团队助理可以进行邀请等操作'
L.CreateHelpOptions = '创建活动时必选项，设置活动所属的类别、形式和拾取方式'
L.CreateHelpSummary = '创建活动时选填项，设置活动的最低装等、语音聊天、角色等级、PVP 等级和活动说明'
L.CreateHelpButtons = '团长可在此进行创建、更新或解散活动等操作'
L.ViewboardHelpOptions = '团员可以在此看到活动的类别、形式和拾取方式等信息'
L.ViewboardHelpSummary = '团员可以在此看到活动的队伍配置和队伍需求等信息'

L['副本进度/经验：'] = true
L['PVP 等级'] = true
L['PvP 等级：'] = true
L['PvP'] = true
L['|cff00ffff集合石：|r'] = true
L['|cffffffff*战网积分价格|r'] = true
L['不区分大小写，无需输入空格或连字符。'] = true
L['不当的说明'] = true
L['你的邀请已满。'] = true
L['使用集合石插件'] = true
L['使用预创建队伍'] = true
L['兑换列表'] = true
L['兑换失败：处理超时，请稍后再试。'] = true
L['兑换平台%s'] = true
L['兑换平台'] = true
L['兑换平台商品列表已更新。'] = true
L['兑换平台购买%s，%s'] = true
L['兑换码格式错误'] = true
L['兑换说明'] = true
L['兑换说明：'] = true
L['全部'] = true
L['公告'] = true
L['创建活动'] = true
L['刷新'] = true
L['副本经验：'] = true
L['发现新版本'] = true
L['只有团长才能预创建队伍'] = true
L['团长'] = true
L['图示'] = true
L['好友或公会成员参与的活动'] = true
L['如何获取积分?'] = true
L['已加入活动'] = true
L['开始体验'] = true
L['形式'] = true
L['您当前可用积分为：%d'] = true
L['意见建议'] = true
L['成员'] = true
L['我的活动'] = true
L['我知道了'] = true
L['打开主界面'] = true
L['拾取'] = true
L['拾取方式'] = true
L['描述'] = true
L['插件简介'] = true
L['操作'] = true
L['操作超时，请|cff00ff00查询积分|r，如果积分|cffff0000已经扣除|r，请留意当前角色游戏邮箱，如果|cff00ff00积分未扣除|r，请稍后再尝试购买。'] = true
L['新手指引'] = true
L['是否禁用集合石插件，使用预创建队伍？\n这项操作将重载插件。'] = true
L['暂无公告'] = true
L['更新日志'] = true
L['最低装等'] = true
L['最低装等：'] = true
L['服务器连线中，请稍后'] = true
L['未指定'] = true
L['查找活动'] = true
L['查看您当前账号的可用积分'] = true
L['查询中，请稍后 ...'] = true
L['查询我的积分'] = true
L['查询间隔120秒'] = true
L['格式正确，请点击[确认兑换]按钮'] = true
L['活动创建失败，请重试。'] = true
L['活动总数'] = true
L['活动总数：%d/%d'] = true
L['活动类型'] = true
L['活动说明'] = true
L['申请中活动'] = true
L['申请中活动'] = true
L['申请人数'] = true
L['申请加入'] = true
L['确认使用兑换码？'] = true
L['确认兑换'] = true
L['确认消耗 |cff00ff00%d|r 积分购买 |cff00ff00%s|r 吗？'] = true
L['积分查询失败：请稍后再试。'] = true
L['立即兑换'] = true
L['等级'] = true
L['管理活动'] = true
L['职业'] = true
L['职责'] = true
L['装等'] = true
L['要求'] = true
L['角色名'] = true
L['角色等级'] = true
L['角色等级：'] = true
L['解散活动'] = true
L['语音聊天'] = true
L['语音聊天：'] = true
L['语音聊天：|cffffffff%s|r'] = true
L['说明'] = true
L['请创建活动'] = true
L['请在这里输入兑换码'] = true
L['请在这里输入活动说明'] = true
L['请填写活动信息'] = true
L['请选择分配方式'] = true
L['请选择活动属性'] = true
L['请选择活动形式'] = true
L['请选择活动类型'] = true
L['购买失败：未选择商品，请重试。'] = true
L['输入兑换码：'] = true
L['队伍配置'] = true
L['队伍需求'] = true
L['队长PvP 等级：|cffffffff%s|r'] = true
L['队长物品等级：|cffffffff%s|r'] = true
L['集合石'] = true
L['集合石插件接管了预创建队伍'] = true

L.RewardSummary = [[
<html>
<body>
<p>1.本平台供您兑换暴雪游戏虚拟物品。</p>
<p>2.虚拟物品奖励一经兑换即不可退换。</p>
<p>3.兑换角色默认为您当前服务器和角色（即您当前使用兑换的角色）。</p>
<p>4.兑换后，会以邮件的形式通知您。如果没有马上收到，还请耐心等待。</p>
<p>5.如果您在24小时之内没收到相应的物品，请您联系客服。</p>
</body>
</html>
]]

L.MallSummary = [[
<html>
<body>
<p>兑换成功系统会在1个工作日内将虚拟物品发送到您当前角色的游戏邮箱内，请注意查收。如果出现积分扣除，但未收到物品，可以|Hurl:http://bnet.163.com/dj/exchange/query/wow|h|cff00ffff[点击这里]|r|h查询兑换码后，手动进行兑换。</p>
<p>查看详细积分变更信息及兑换记录请|Hurl:http://reward.battlenet.com.cn|h|cff00ffff[访问这里]|r|h</p>
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
<p>如果您刚上线，将在十五分钟内读取到商品数据。</p>
<br/>
<p>如果长时间无法收到商品数据，请检查插件版本或者联系集合石官方QQ群|Hurl:317548615|h|cff00ffff[317548615]|r|h。</p>
</body>
</html>
]]

L.BrowseHelpFilter = [[
活动类型：下拉菜单选择你需要参与活动的类型

拾取方式：下拉菜单选择你需要参与活动的拾取方式
]]

L.BrowseHelpRefresh = [[
刷新按钮：刷新当前的活动信息
]]

L.BrowseHelpList = [[
活动展示页：你可以在这里挑选你自己喜欢的活动。

鼠标悬停后会出现活动及队长的具体信息
]]

L.BrowseHelpMisc = [[
图示：活动当前的状态图示
]]

L.BrowseHelpApply = [[
申请加入：选择你要加入的活动，点击该按钮申请加入
]]

L.BrowseHelpStatus = [[
当前活动的总数以及你申请的活动总数
]]

L.NotSupportVersionWithChangeLog = [[
|cffff1919发现集合石新版本，你当前的版本不兼容。|r

更新日志：%s

请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用
]]

L.NotSupportVersion = [[
|cffff1919发现集合石新版本，你当前的版本不兼容。|r

请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用
]]

L.FoundRaidBuilder = [[
发现你正在使用老版本集合石插件，

请尽快删除 |cff00ffffInterface\AddOns\RaidBuilder|r 文件夹，

点击“确定”|cffff0000重载插件|r以禁用老版本集合石。
]]

L.NewVersionWithChangeLog = [[
发现新版本：%s，请及时下载更新
下载链接：%s
更新内容：%s
更多更新内容请浏览论坛
]]

L.NewVersion = [[
发现新版本：%s，请及时下载更新
下载链接：%s
]]
