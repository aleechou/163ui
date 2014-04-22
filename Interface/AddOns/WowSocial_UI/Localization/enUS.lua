
BuildEnv(...)

local L = LibStub('AceLocale-3.0'):NewLocale('WowSocial_UI', 'enUS')
if not L then return end

ADDON_NAME = 'WowSocial'
_G.BINDING_HEADER_NECLOUD = ADDON_NAME
_G.BINDING_NAME_NECLOUD_TOGGLE = 'Panel switch'

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

L.Human = true
L.Dwarf = true
L.NightElf = true
L.Gnome = true
L.Draenei = true
L.Worgen = true
L.Orc = true
L.Scourge = true
L.Tauren = true
L.Troll = true
L.Goblin = true
L.BloodElf = true
L.Pandaren = true

L['任务']  = [[Quest]] 
L['地下城']  = [[Dungeon]] 
L['团队副本']  = [[Raid]] 
L['PvP']  = [[PvP]] 
L['角色扮演']  = [[Role play]] 
L['发呆']  = [[Daze]] 

L['周一']  = [[Monday]] 
L['周二']  = [[Tuesday]] 
L['周三']  = [[Wensday]] 
L['周四']  = [[Thursday]] 
L['周五']  = [[Friday]] 
L['周末']  = [[Weekend]] 

L['保密']  = [[Keep secret]] 


L['群组']  = [[Group]] 
L['创建群组']  = [[Create group]] 
L['你确定要解散群组%s吗？']  = [[Are you sure to ungroup %s?]] 
L['你确定要退出群组%s吗？']  = [[Are you sure to quit the group %s?]] 
L['创建群组%s成功。']  = [[Creating group %s succeeded.]] 
L['创建群组%s失败，%s。']  = [[Creating group %s failed，%s.]] 
L['群组%s已解散。']  = [[ %s has been ungrouped.]] 
L['%s邀请你加入群组%s。']  = [[%s invited you to the group %s.]] 
L['%s加入群组%s。']  = [[%s joined the group %s.]] 
L['邀请%s加入群组%s失败，%s。']  = [[Inviting %s to the group %s failed，%s.]] 
L['%s已退出群组%s。']  = [[%s has quited the group %s.]] 
L['你确定要将%s踢出群组%s？']  = [[Are you sure you want to kick %s out the group %s? ]] 
L['%s被%s踢出群组%s。']  = [[%s has been kicked out the group %s by %s。]] 
L['邀请你加入群组：']  = [[Invite you to the group：]] 

L['查看']  = [[Check]] 
L['踢出群组']  = [[Kick out of the group]] 
L['解散群组']  = [[Ungroup]] 
L['退出群组']  = [[Quit group]] 
L['邀请']  = [[Invite]] 
L['打开']  = [[Open]] 
L['请输入想要邀请入群的玩家名字\n或者在聊天窗口中\n按住Shift点击该玩家的名字：']  = "Please input the player's name\n Or in the chat window\n press Shift and click the players name:"
L['加入群组']  = [[Accept]] 
L['请输入群组名称：']  = [[Please input the name of the group: ]] 
L['查看加入请求']  = [[View requests to join in]] 
L['加入群组%s失败，%s。']  = [[Joining in group %s faild，%s.]] 
L['已发送加入群组%s请求。']  = [[Request to join the group %s has been sent. ]] 
L['拒绝邀请']  = [[Cancel]] 

L.GROUP_EXISTS  = [[Group already exist]]
L.GROUP_NAME_INVALID  = [[Name inappropriate]]
L.GROUP_USER_NOT_EXISTS  = [[Player are not online or not using the addons]]
L.GROUP_USER_MEMBER  = [[Player is already a group member]]
L.GROUP_USER_CANCEL  = [[Player rejected]]
L.GROUP_NOT_EXISTS  = [[Group does not exist]]
L.GROUP_CREATED_MORE  = [[You have created too many groups]]
L.GROUP_AUTO_REFUSE  = [[Request to join the group rejected]]
L.GROUP_ENEMY  = [[Group is in the opposing faction]]
L.GROUP_USER_ENEMY  = [[Player is in the opposing faction]]

L.You  = [[You]]

L['头像选择器']  = [[portrait selector]] 

L['群公告']  = [[Announcement]] 
L['暂无公告']  = [[No announcement]] 
L['群成员']  = [[Member]] 
L['群活动']  = [[Event]] 

L['|cffff0000试玩账号无法发送消息。|r']  = [[|cffff0000 Starter edition is unable to send messages|r]] 

L['基本信息']  = [[Information]] 
L['入群申请']  = [[Join in]] 
L['查找']  = [[Search]] 
L['结果']  = [[Result]] 
L['个人设置']  = [[Personal settings]] 
L['群组查找器']  = [[Group finder]] 
L['个人设置']  = [[Personal settings]] 

L['正在登陆...']  = [[Logging...]] 
L['登陆成功']  = [[Login successful]] 
L['未读消息：%s']  = [[Unread message: %s]] 
L['未读消息：%s']  = [[Unread message: %s]] 

L['推荐群组']  = [[Recommended group]] 
L['这是官方推荐的群组']  = [[This is the official recommended group]] 
L['我的群组']  = [[My group]] 
L['这是我加入的群组']  = [[This is my group]] 

L['打开']  = [[Open]] 
L['加入']  = [[Join]] 
L['邀请']  = [[Invite]] 
L['请输入玩家名称：']  = [[Please input the player's name: ]] 
L['管理']  = [[Administration]] 
L['退出群组']  = [[Quit group]] 
L['你确定要退出群组%s吗？']  = [[Are you sure to quit the group %s? ]] 
L['解散群组']  = [[Ungroup]] 
L['你确定要解散群组%s吗？']  = [[Are you sure to ungroup %s? ]] 
L['查看资料']  = [[Check profiles]] 
L['加为好友']  = [[Add to friends]] 
L['屏蔽']  = [[Block]] 
L['设为管理员']  = [[Set Administrator]] 
L['取消管理员']  = [[Remove Administrator]] 
L['踢出群组']  = [[Kick out of group]] 
L['确定要将 %s 踢出群组 %s 吗？']  = [[Are you sure to kick %s out of the group %s? ]] 
L['悄悄话']  = [[Whisper]] 
L['邀请组队']  = [[Invite to the party]] 
L['举报']  = [[Report]] 

L['%s将%s提升为群组%s的管理员。']  = [[%s promte %s as the administrator of the group %s.]] 
L['%s将%s降职为群组%s的普通成员。']  = [[%s demote %s as ordinary member of the group %s.]] 

L['暂无群活动\n点击创建'] = true
L['全部拒绝']  = [[Reject all]] 
L['群邀请']  = [[Group invitation]] 
L['请选择群：']  = [[Please select the group: ]] 
L['请选择成员：']  = [[Please choose the member: ]] 
L['全选']  = [[Select all]] 
L['取消']  = [[Cancel]] 
L['邀请']  = [[Invite]] 
L['邀请中，请稍候 ']  = [[Sending the invitation, pleas wait ]]
L['你已退出这个群组']  = [[You have quit the group]] 

L['点击这里输入群组公告']  = [[Click here to enter the group announcement]] 
L['点击这里输入群组说明']  = [[Click here to enter a group description]] 
L['游戏兴趣']  = [[Interest in the game]] 
L['活动时间']  = [[Activity time]] 
L['保存']  = [[Save]] 

L['群组名称（或关注号）']  = [[Group name (Or Public number)]] 
L['游戏兴趣']  = [[Interest in the game]] 
L['活动时间']  = [[Event schedule]] 
L['查找']  = [[Search]] 
L['申请加入']  = [[Apply]] 
L['%d名成员']  = [[%d members]] 
L['%d个粉丝']  = [[%d fans]] 

L['未读消息']  = [[Unread msg]] 
L['群组兴趣']  = [[Interest of the group]] 
L['活动时间']  = [[Activity time]] 

L['请输入群组名称：']  = [[Please input the group name: ]] 
L['查找群组']  = [[Search group]] 

L['签名']  = [[Signature]] 
L['点击这里输入个人签名']  = [[Click here to enter personal signature]] 
L['城市']  = [[City]] 
L['游戏兴趣']  = [[Interest in the game]] 
L['活动时间']  = [[Activity time]] 
L['保存']  = [[Save]] 

L['群组公告']  = [[Group announcement]] 
L['群组说明']  = [[Group discreption]] 
L['暂无']  = [[Null]] 

L['没有找到符合条件的群组。']  = [[Could not find qualified group.]] 

L['最近联系人']  = [[Recent contacts]] 
L['这里是我最近联系的群组']  = [[This is my contact group recently]] 

L['处理完毕']  = [[Processed]] 
L['发送']  = [[Send]] 
L['点击这里输入内容']  = [[Click here to enter contents]] 
L['感谢您留下宝贵的意见：']  = [[Thank you for your valuable opinions: ]] 
L['如有更多意见，可以发送电邮：wow_social@163.com']  = [[If you have more suggestions,send email to: wow_social@163.com]] 
L['提交完成，感谢反馈！']  = [[Submit completed, thanks for feedback！]] 
L['意见建议']  = [[Advices and suggestions]] 
L['填写反馈']  = [[Fill in feedback]] 
L['勿扰模式']  = [[Do Not Disturb]] 

L['需要验证']  = [[Authorization Required]] 
L['全部允许']  = [[Allow all]] 

L['入群申请方式']  = [[Way into the group]] 

L['发现新版本']  = [[New version discovered]] 
L['%s：发现新版本 %s，请及时下载更新\n%s']  = "%s: New version discovered %s, please download the update\n%s"
L['必需升级新版本，以继续使用插件']  = [[Must upgrade the new version to continue to use the addon]] 
L['你没有加入群组%s，是否申请加入？']  = [[You have no groups %s，Would you like to join in one?]] 
L['群组信息保存成功']  = [[Group information saved successfully]] 

L['发现友团插件新版本，您当前的版本不兼容，请按<|cff00ff00Ctrl+C|r>复制下载链接更新新版本以继续使用']  = [[A new version of WoW social addons discovered, your current version is not compatible with the latest version, please press <|cff00ff00Ctrl+C|r> to copy the download link and update the addons to the latest version]] 
L['高端']  = [[High-end]] 
L['成为高端玩家！']  = [[ High-end player!]] 
L['牛']  = ''

L['关于']  = [[About]] 
L['本插件目前仍处于测试阶段，期间可能出现部分不稳定情况，请及时更新最新版本。'] = true

L['当前版本：']  = [[Current version: ]] 
L['最新版本：']  = [[Latess version: ]] 
L['下载链接：']  = [[Download link: ]] 
L['当前已经是最新版本']  = [[This is the latest version]] 
L['使用指南']  = [[User Guide]] 
L['请搜索“|cff00ff00%d|r”打开插件使用指南']  = [[Please search“|cff00ff00%d|r” to open the user guide of the addons]] 

L['推送通知']  = [[Tweet]] 
L['群组：%s  关注号：%s']  = [[Group: %s  Public number: %s]] 
L['每个群每周有五次发送活动通知的机会']  = [[Five times a week to send a notifications.]] 
L['关注号']  = [[Public number]] 

L['我的好友']  = [[My friends]] 
L['这是我的好友列表']  = [[This is my friends list]] 
L['友团聊天']  = [[Social]] 
L['公告']  = [[Announcement]] 
L['角色名错误，请重试。']  = [[Wrong character name, please try again]] 
L['点击查看详情']  = [[Click here for details]] 

L['消息推送']  = [[Tweet]] 
L['易信下载二维码']  = [[Download QR code from Easy Chat]] 
L['魔兽世界公众号']  = [[World of warcraft public account]] 
L['使用手机推送功能后，将会把本次活动信息通过易信消息发送到关注此群的玩家手机上。']  = [[After using mobile tweet, it will send the activity notifications to the players' mobile who have followed the group through Easy Chat.]] 
L['发送通知']  = [[Send notifications]] 
L['使用本功能需要具备的条件？']  = [[Conditions requires to use this function]] 
L['这不是一个群活动']  = [[This is not a group event]] 
L['你不是该群的群主']  = [[You are not the group owner]] 
L['这个活动已经过期']  = [[This event has expired]] 
L['你还没有创建完成这个活动']  = [[You have not completed creating this activity]] 

L.YixinSummary = [[
|cffffd100 Conditions to use Easy Chat group notifications: |r

|cffffd100 Group owner:|r
1. The group owner need to create a activity.
2. Click group invitation, choose the group you want to invite. Click Invite.
3. Then open the activity panel, click|TInterface\Icons\INV_Letter_15:14|t at bottom right to send the notification.
|cffffd100 Group member: |r
1. Install Easy Chat on your mobile phone.
2. Follow "|cffffd100 World of warcraft |r" public account.
3. Input commands within the public account to complete the subscription of group activities notification.
|cff33ff99Subscribe: "DY#" + "Public Number"
Unsubscribe: "TD#" + "Public Number"
Query the subscription: "CXDY"
Note: Public number can be viewed at group profiles. |r

EasyChat download link: |cffffd100http://yixin.im|r
Also available for download in various software download platform.
]]

L['魔兽组团助手']  = [[World of Warcraft raid assemble assistant]] 
L['这里是跨服组团助手，开发中，敬请期待']  = [[This is cross-realm raid assemble assistant, developing, coming soon]] 
