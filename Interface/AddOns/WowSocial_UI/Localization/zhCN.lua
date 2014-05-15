
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):NewLocale('WowSocial_UI', 'zhCN', true)
if not L then return end

ADDON_NAME = '友团聊天'
_G.BINDING_HEADER_NECLOUD = ADDON_NAME
_G.BINDING_NAME_NECLOUD_TOGGLE = '切换面板'

L.Angel     = '天使'
L.Angry     = '生气'
L.Biglaugh  = '大笑'
L.Clap      = '鼓掌'
L.Cool      = '酷'
L.Cry       = '哭'
L.Cute      = '可爱'
L.Despise   = '鄙视'
L.Dreamsmile= '美梦'
L.Embarras  = '尴尬'
L.Evil      = '邪恶'
L.Excited   = '兴奋'
L.Faint     = '晕'
L.Fight     = '打架'
L.Flu       = '流感'
L.Freeze    = '呆'
L.Frown     = '皱眉'
L.Greet     = '致敬'
L.Grimace   = '鬼脸'
L.Growl     = '龇牙'
L.Happy     = '开心'
L.Heart     = '心'
L.Horror    = '恐惧'
L.Ill       = '生病'
L.Innocent  = '无辜'
L.Kongfu    = '功夫'
L.Love      = '花痴'
L.Mail      = '邮件'
L.Makeup    = '化妆'
L.Mario     = '马里奥'
L.Meditate  = '沉思'
L.Miserable = '可怜'
L.Okay      = '好'
L.Pretty    = '漂亮'
L.Puke      = '吐'
L.Shake     = '握手'
L.Shout     = '喊'
L.Silent    = '闭嘴'
L.Shy       = '害羞'
L.Sleep     = '睡觉'
L.Smile     = '微笑'
L.Suprise   = '吃惊'
L.Surrender = '失败'
L.Sweat     = '流汗'
L.Tear      = '流泪'
L.Tears     = '悲剧'
L.Think     = '想'
L.Titter    = '偷笑'
L.Ugly      = '猥琐'
L.Victory   = '胜利'
L.Volunteer = '雷锋'
L.Wronged   = '委屈'

L.BloodElf = '血精灵'
L.Draenei = '德莱尼'
L.Dwarf = '矮人'
L.Gnome = '侏儒'
L.Goblin = '地精'
L.GROUP_AUTO_REFUSE = '群组拒绝加入请求'
L.GROUP_CREATED_MORE = '你已经创建了太多群组'
L.GROUP_ENEMY = '对立阵营群组'
L.GROUP_EXISTS = '群组已存在'
L.GROUP_NAME_INVALID = '名称不合适'
L.GROUP_NOT_EXISTS = '群组不存在'
L.GROUP_USER_CANCEL = '玩家拒绝'
L.GROUP_USER_ENEMY = '玩家不同阵营'
L.GROUP_USER_MEMBER = '玩家已经是群组成员'
L.GROUP_USER_NOT_EXISTS = '玩家不在线或未使用插件'
L.Human = '人类'
L.NightElf = '暗夜精灵'
L.Orc = '兽人'
L.Pandaren = '熊猫人'
L.Scourge = '亡灵'
L.Tauren = '牛头人'
L.Troll = '巨魔'
L.Worgen = '狼人'
L.You = '你'

L['%d个粉丝'] = true
L['%d名成员'] = true
L['%s加入群组%s。'] = true
L['%s将%s提升为群组%s的管理员。'] = true
L['%s将%s降职为群组%s的普通成员。'] = true
L['%s已退出群组%s。'] = true
L['%s被%s踢出群组%s。'] = true
L['%s邀请你加入群组%s。'] = true
L['%s：发现新版本 %s，请及时下载更新\n%s'] = true
L['<html><body><h3>%s</h3><p><br />%s</p></body></html>'] = true
L['PvP'] = true
L['|cffff0000试玩账号无法发送消息。|r'] = true
L['下载链接：'] = true
L['个人设置'] = true
L['中立阵营不能使用友团聊天'] = true
L['举报'] = true
L['任务'] = true
L['你不是该群的群主'] = true
L['你已退出这个群组'] = true
L['你没有加入群组%s，是否申请加入？'] = true
L['你确定要将%s踢出群组%s？'] = true
L['你确定要解散群组%s吗？'] = true
L['你确定要退出群组%s吗？'] = true
L['你还没有创建完成这个活动'] = true
L['使用手机推送功能后，将会把本次活动信息通过易信消息发送到关注此群的玩家手机上。'] = true
L['使用指南'] = true
L['使用本功能需要具备的条件？'] = true
L['保存'] = true
L['保密'] = true
L['入群申请'] = true
L['入群申请方式'] = true
L['全选'] = true
L['全部允许'] = true
L['全部拒绝'] = true
L['公告'] = true
L['关于'] = true
L['关注号'] = true
L['创建群组%s失败，%s。'] = true
L['创建群组%s成功。'] = true
L['创建群组'] = true
L['加为好友'] = true
L['加入'] = true
L['加入群组%s失败，%s。'] = true
L['加入群组'] = true
L['勿扰模式'] = true
L['友团组团'] = true
L['友团聊天'] = true
L['发呆'] = true
L['发现友团聊天新版本，您当前的版本不兼容，请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用'] = true
L['发现新版本'] = true
L['发送'] = true
L['发送通知'] = true
L['取消'] = true
L['取消管理员'] = true
L['周一'] = true
L['周三'] = true
L['周二'] = true
L['周五'] = true
L['周四'] = true
L['周末'] = true
L['团队副本'] = true
L['地下城'] = true
L['城市'] = true
L['基本信息'] = true
L['处理完毕'] = true
L['头像选择器'] = true
L['如有更多意见，可以发送电邮：wow_social@163.com'] = true
L['屏蔽'] = true
L['已发送加入群组%s请求。'] = true
L['当前已经是最新版本'] = true
L['当前版本：'] = true
L['必需升级新版本，以继续使用插件'] = true
L['悄悄话'] = true
L['意见建议'] = true
L['感谢您使用'] = true
L['成为高端玩家！'] = true
L['我的好友'] = true
L['我的群组'] = true
L['打开'] = true
L['拒绝邀请'] = true
L['推荐群组'] = true
L['推送通知'] = true
L['提交完成，感谢反馈！'] = true
L['易信下载二维码'] = true
L['易信推送'] = true
L['暂无'] = true
L['暂无公告'] = true
L['暂无群活动\n点击创建'] = true
L['最新版本：'] = true
L['最近联系人'] = true
L['未读消息'] = true
L['未读消息：%s'] = true
L['本插件目前仍处于测试阶段，期间可能出现部分不稳定情况，请及时更新最新版本。'] = true
L['查找'] = true
L['查找群组'] = true
L['查看'] = true
L['查看加入请求'] = true
L['查看资料'] = true
L['正在登陆...'] = true
L['每个群每周有五次发送活动通知的机会'] = true
L['没有找到符合条件的群组。'] = true
L['活动时间'] = true
L['游戏兴趣'] = true
L['点击查看详情'] = true
L['点击这里输入个人签名'] = true
L['点击这里输入群组公告'] = true
L['点击这里输入群组说明'] = true
L['牛'] = true
L['申请加入'] = true
L['登陆成功'] = true
L['确定要将 %s 踢出群组 %s 吗？'] = true
L['签名'] = true
L['管理'] = true
L['结果'] = true
L['群公告'] = true
L['群成员'] = true
L['群活动'] = true
L['群组%s已解散。'] = true
L['群组'] = true
L['群组信息保存成功'] = true
L['群组公告'] = true
L['群组兴趣'] = true
L['群组名称（或关注号）'] = true
L['群组查找器'] = true
L['群组说明'] = true
L['群组：%s  关注号：%s'] = true
L['群邀请'] = true
L['角色名错误，请重试。'] = true
L['角色扮演'] = true
L['解散群组'] = true
L['设为管理员'] = true
L['请在这里输入反馈内容'] = true
L['请搜索“|cff00ff00%d|r”打开插件使用指南'] = true
L['请输入想要邀请入群的玩家名字\n或者在聊天窗口中\n按住Shift点击该玩家的名字：'] = true
L['请输入玩家名称：'] = true
L['请输入群组名称：'] = true
L['请选择成员：'] = true
L['请选择群：'] = true
L['踢出群组'] = true
L['这不是一个群活动'] = true
L['这个活动已经过期'] = true
L['这是官方推荐的群组'] = true
L['这是我加入的群组'] = true
L['这是我的好友列表'] = true
L['这里是我最近联系的群组'] = true
L['退出群组'] = true
L['邀请%s加入群组%s失败，%s。'] = true
L['邀请'] = true
L['邀请中，请稍候 '] = true
L['邀请你加入群组：'] = true
L['邀请好友'] = true
L['邀请组队'] = true
L['需要验证'] = true
L['高端'] = true
L['魔兽世界公众号'] = true

L.YixinSummary = [[
<html>
<body>
<h3 align="center">|cffffd100使用易信群通知功能的条件|r</h3>
<h1><br />群主篇：</h1>
<p>1、首先群主需要创建一个群活动。</p>
<p>2、点击群邀请，并选择要邀请的群，进行邀请，点击创建。</p>
<p>3、完成后再次打开活动面板，点击右下|TInterface\AddOns\WowSocial_UI\Media\YiXin:16|t进行通知。</p>
<h1><br />群员篇：</h1>
<p>1、在手机上需要安装易信通讯软件。</p>
<p>2、关注“|cffffd100魔兽世界|r”公众号。</p>
<p>3、在公众号内输入对应命令完成订阅群活动信息。</p>
<p><br />|cff33ff99订阅群信息：“关注”+“群关注号”|r</p>
<p>|cff33ff99退订群信息：“取消关注”+“群关注号”|r</p>
<p>|cff33ff99查询订阅：“查询关注”|r</p>
<p>|cff33ff99注：群关注号在群资料中查看。|r</p>
<p><br />易信下载地址 |Hurl:http://yixin.im|h|cff00ffff[http://yixin.im]|r|h </p>
<p>或各大手机应用市场</p>
</body>
</html>
]]

L.FeedbackSummary = [[
<html>
<body>
<p>感谢您使用 |cffffd100%s v%s|r</p>
<p>您的支持就是我们最大的动力！</p>
<br />
<h1>论坛地址：</h1>
<p>|Hurl:http://www.battlenet.com.cn/wow/zh/forum/12507946/|h|cff00ffff[http://www.battlenet.com.cn/wow/zh/forum/12507946/]|r|h</p>
<h1>专题：</h1>
<p>|Hurl:http://w.163.com/special/wowsocial/|h|cff00ffff[http://w.163.com/special/wowsocial/]|r|h</p>
</body>
</html>
]]
