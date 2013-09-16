local e if(LibStub)then
	local t='Carbonite'
	e=LibStub('LibDataBroker-1.1'):NewDataObject(
		t,
		{
			icon=[[Interface\Icons\ACHIEVEMENT_GUILDPERK_MRPOPULARITY_RANK2]],
			iconR=.8,
			iconG=.8,
			iconB=.8,
			iconD=true,
			type='launcher',
			OnTooltipShow=function(e)
				e:AddLine("五星任务采集插件");
				e:AddLine("快速启用/关闭五星任务采集插件，关闭后不占用任何CPU资源。建议做任务、采集时即时加载，打副本时即时关闭。",nil,nil,nil,1);
			end,
		}
	)
	e.OnClick=function(a,e)
		if e=="RightButton"then
			UUI.OpenToAddon("Carbonite",true)
		else
			U1ToggleAddon(t:lower(),not U1IsAddonEnabled(t))
			end
		end
	end
	U1RegisterAddon("Carbonite",{
		title="五星任务采集",
		tags={TAG_MAPQUEST,TAG_BIG,},
		optionsAfterVar=1,
		load="LOGIN",
		secure=1,
		ignoreLoadAll=1,
		defaultEnable=0,
		desc={
			"|cff00d100简体版为网易有爱独家发布|r",
			" ",
			"国外著名的任务插件，曾经因为收费使用迫使暴雪制定插件协议。其功能强到无以复加，主要有以下功能：",
			"|cffffffff - 任务目标路径|r","|cffffffff - 全部任务给予人|r",
			"|cffffffff - 玩家经验或资金统计|r",
			"|cffffffff - 敌对目标|r",
			"|cffffffff - 草点矿点及采集路径|r",
			"|cffffffff - 职业专业训练师位置(指南)|r",
			" ",
			"网易有爱特别将选项精简，并改为随需加载，随用随开，不再担心占用。",
			" ",
			"现在，请享用吧！",
		},
		icon=[[Interface\Icons\ACHIEVEMENT_GUILDPERK_MRPOPULARITY_RANK2]],
		author="国外公司",
		modifier="<银月>雨悠悠 汉化",
		minimap="NXMiniMapBut",
		children={
			"CarboniteItems",
			"CarboniteNodes",
			"CarboniteTransfer",
		},
		toggle=function(o,o,t,a)
			if not a then
				if ToggleCarbonite then
					ToggleCarbonite(not not t)
				else
					return true
				end
			end

			if(e)then
				if(t)then
					e.iconR=1
					e.iconG=1
					e.iconB=1
					e.iconD=false
				else
					e.iconR=.8
					e.iconG=.8
					e.iconB=.8
					e.iconD=true
				end
			end
		end,
		{
			text="打开百科指南",
			tip="说明`可以查看各种训练师、任务起始点、副本入口、港口以及城中地点的位置，功能强大不容错过",
			callback=function(e,e,e)
				Nx:NXGuideKeyToggleShow()
			end,
		},
		{text="打开资产中心",tip="说明`可以查看角色的各种信息，包括经验获取速度、金钱收入，背包，银行等等。",callback=function(e,e,e)Nx:NXWarehouseKeyToggleShow()end,},
		{text="重置窗口位置",tip="说明`当找不到小地图或者任务追踪窗口时使用。",callback=function(e,e,e)Nx.Opts:NXCmdResetWinLayouts()end,},
		{var="PunkTWinHide",text="切换敌对玩家框体",tip="说明`战斗中不可用",default=false,getvalue=function()return not select(2,Nx.Win:GetAttribute("NxPunkHUD","H"))end,callback=function(t,e,t)if not InCombatLockdown()then Nx.Opts:SetVar("PunkTWinHide",not e)end end,},
		{var="showtut",text="显示地图右上的介绍按钮",default=1,alwaysEnable=1,callback=function(t,e,t)if CarboniteTutorialButton then CoreUIShowOrHide(CarboniteTutorialButton,e)end end,},
		{
			text="地图显示",type="text",
			{var="MapMaxOverride",text="替换大地图",default=1,tip="说明`是否用Carbonite的无级缩放地图替换原来按M键打开的世界地图。` `(按ALT+M可以随时打开原有地图)",getvalue=function()return Nx.Opts:GetVar("MapMaxOverride")end,callback=function(t,e,t)Nx.Opts:SetVar("MapMaxOverride",e)end,},
			{var="MapPlayerColored",default=true,text="队友图标职业颜色",tip="说明`开启后，队友图标会用其职业颜色来显示，而不是默认的统一蓝色。",getvalue=function()return Nx.Map.GOpts["MapPlayerColored"]end,callback=function(t,e,t)Nx.Map.GOpts["MapPlayerColored"]=not not e;end,},
			{text="切换浮动小地图窗口",lower=false,callback=function(e,e,e)Nx:NXMapKeyTogNoneNormal()end,},
			{var="throttle",default=1,text="限制地图重绘频率",tip="说明`此插件频繁重绘地图，会严重影响帧数，我们特意增加此选项，限制重绘频率，可以提高20%左右的帧数，老爷机也能用Carbonite了。",callback=function(t,e,a)Nx._MapUpdateThrottle=not not e;U1CfgCallSub(t,"interval",true);end,{var="interval",default=40,text="重绘间隔(毫秒)",type="spin",range={0,100,10},callback=function(t,e,t)Nx._MapUpdateInterval=e/1e3 end,}},
		},
		{
			text="任务辅助",type="text",
			{var="QBroadcastQChanges",default=1,text="小队通告任务进度",getvalue=function()return Nx.Opts:GetVar("QBroadcastQChanges")end,callback=function(t,e,t)Nx.Opts:SetVar("QBroadcastQChanges",e)end,},
			{var="QWHide",default=true,text="显示/隐藏任务跟踪窗口",getvalue=function()return not Nx.Opts:GetVar("QWHide")end,callback=function(t,e,t)Nx.Opts:SetVar("QWHide",not e)end,},
			{var="QMapShowQuestGivers3",text="显示任务委托人",type="radio",default=2,tip="说明`可以显示所有本角色未完成的任务。",options={"无",1,"全部",2,"每日",3},cols=3,getvalue=function()return Nx.CharOpts["QMapShowQuestGivers3"]end,callback=function(a,e,t)Nx.CharOpts["QMapShowQuestGivers3"]=e;if not t then Nx.Map:GetMap(1).Guide:UpdateGatherFolders()end end,},
			{var="QAutoAccept",text="自动接受任务",default=false,tip="说明`跟NPC对话时自动接受任务,就是省了点'确认'的步骤。(如果按住SHIFT+CTRL则跟设置相反)",getvalue=function()return Nx.Opts:GetVar("QAutoAccept")end,callback=function(t,e,t)Nx.Opts:SetVar("QAutoAccept",e)end,},
			{var="QAutoTurnIn",text="自动交还任务",default=false,tip="说明`跟NPC对话时自动交还已经完成的任务，需要选奖励的时候无效。(如果按住SHIFT+CTRL则跟设置相反)",getvalue=function()return Nx.Opts:GetVar("QAutoTurnIn")end,callback=function(t,e,t)Nx.Opts:SetVar("QAutoTurnIn",e)end,},
		},
		{
			text="采集助手",type="text",
			{var="MapMMNodeGD",default=false,text="草药和矿物点闪烁",tip="说明`开启后，采集点图标会闪烁，但是有可能造成其他图标的闪烁，所以默认关闭。",getvalue=function()return Nx.Map.GOpts["MapMMNodeGD"]>0 end,callback=function(t,e,t)Nx.Map.GOpts["MapMMNodeGD"]=e and e~=0 and .4 or 0;Nx.Map:MinimapNodeGlowInit(true)end,},
			{var="MapShowGatherH",default=false,text="显示草药采集点",tip="说明`开启了此选项记住导入默认的草药采集点, 这样做是为了节省内存, 因为不是每个角色都需要所有的草药矿物数据。",getvalue=function()return Nx.CharOpts["MapShowGatherH"]end,callback=function(a,e,t)Nx.CharOpts["MapShowGatherH"]=e;local e=Nx.Map:GetMap(1)e.MenuIShowHerb:SetChecked(Nx.CharOpts,"MapShowGatherH");if not t then e.Guide:UpdateGatherFolders();end end,{text="导入草药采集点",lower=false,callback=function(e,e,e)Nx.Opts:NXCmdImportCarbHerb()end,}},
			{var="MapShowGatherM",default=false,text="显示矿物采集点",tip="说明`开启了此选项记住导入默认的矿物采集点, 这样做是为了节省内存, 因为不是每个角色都需要所有的草药矿物数据。",getvalue=function()return Nx.CharOpts["MapShowGatherM"]end,callback=function(a,e,t)Nx.CharOpts["MapShowGatherM"]=e;local e=Nx.Map:GetMap(1)e.MenuIShowMine:SetChecked(Nx.CharOpts,"MapShowGatherM");if not t then e.Guide:UpdateGatherFolders();end end,{text="导入矿物采集点",lower=false,callback=function(e,e,e)Nx.Opts:NXCmdImportCarbMine()end,}},
			{
				var="MapShowGatherA",
				default=true,
				text="显示其他采集点",
				tip="说明`包括考古圣物、气矿等的采集点。",
				getvalue=function()
					return Nx.CharOpts["MapShowGatherA"]
				end,
				callback=function(a,e,t)
					Nx.CharOpts["MapShowGatherA"]=e;
					local e=Nx.Map:GetMap(1)
					e.MenuIShowArt:SetChecked(Nx.CharOpts,"MapShowGatherA");
					if not t then
						e.Guide:UpdateGatherFolders();
					end
				end,
				{
					text="导入其他采集点",
					lower=false,
					callback=function(e,e,e)
						Nx.Opts:NXCmdImportCarbMisc()
					end,
				}
			},
		},
		{
			text="高级",type="text",
			{text="其他配置选项",tip="详细设置`Carbonite的功能远不止默认这些，但设置起来比较复杂。喜欢研究的玩家可以看看",callback=function()if NxOpts and NxOpts:IsVisible()then NxOpts:Hide()else Nx.NXMiniMapBut:Menu_OnOptions()end end},
			{text="恢复默认设置",confirm="本插件的所有设置将清空并无法恢复，您是否确定？",callback=function()NxData,NxCombatOpts,NxMapOpts,NxCData=nil ReloadUI()end},
		},
	}
);

U1RegisterAddon(
	"CarboniteItems",
	{toggle=noop,secure=1,hide=1,protected=1}
);

U1RegisterAddon(
	"CarboniteNodes",
	{toggle=noop,secure=1,hide=1,protected=1}
);

U1RegisterAddon(
	"CarboniteTransfer",
	{toggle=noop,secure=1,hide=1,protected=1}
);

--[[U1RegisterAddon(
	"CarboniteQuestData",
	{
		parent="Carbonite",
		title="任务数据库",
		desc="加载任务数据库会占用较多内存，但可以提供更便利的任务功能，例如可接任务，所有任务查询等。(关闭此功能需重新加载界面)",
		toggle=noop,
		load="LOGIN",
		defaultEnable=1,
	}
);]]

if(CoreOnEvent)then
	CoreOnEvent(
		"ADDON_LOADED",
		function()
			if TplPanelButton then
				local e=TplPanelButton(WorldMapDetailFrame,"CarboniteTutorialButton",19):SetText("可接任务及采集助手"):AutoWidth():TR(4,2):SetFrameStrata("DIALOG"):un()
				e:SetAlpha(.5)
				e:SetNormalFontObject(GameFontHighlight)
				e:SetScript(
					"OnEnter",
					function(e)
						UIFrameFadeIn(e,.2,.5,1)
					end
				)
				e:SetScript(
					"OnLeave",
					function(e)
						UIFrameFadeOut(e,.2,1,.2)
					end
				)
				e:SetScript(
					"OnClick",
					function()
						if WorldMapFrame:IsVisible()and UIPanelWindows["WorldMapFrame"]and UIPanelWindows["WorldMapFrame"].area=="full"then
							HideUIPanel(WorldMapFrame)
						end
						TutorialU1Frame_SetTutorial(
							{
								[201]={
									tileHeight=25,
									text="网易有爱的可接任务和采集助手是|cffffd200五星任务采集|r(Carbonite)的功能。可以从上方信息条\124TInterface\\Icons\\ACHIEVEMENT_GUILDPERK_MRPOPULARITY_RANK2:0\124t按钮，或者有爱控制台启用插件。注意|cffffd200任务数据库|r一定要开启。",
									title="可接任务功能说明",
									textBox={
										topLeft_xOff=33,
										topLeft_yOff=-250,
										bottomRight_xOff=-29,
										bottomRight_yOff=35
									},
									imageData1={"Interface\\AddOns\\Carbonite\\TutorialCarbonite",0,1,0,300/2048,w=348,h=300/512*348,},
								},
								[202]={tileHeight=25,text="启用插件后，在屏幕右侧可以看到|cffffd200任务追踪列表|r，点击其顶部的|cffffd200黄色圆点|r就是开启和关闭可接任务的显示（蓝色表示只显示每日任务）。同时点击左上的\124TInterface\\AddOns\\Carbonite\\Gfx\\Skin\\ButWatchMenu:0\124t|cffffd200按钮|r，可以在菜单中调整要显示任务的等级范围，还可以从服务器上获取已完成的任务。",title="可接任务功能说明",textBox={topLeft_xOff=33,topLeft_yOff=-250,bottomRight_xOff=-29,bottomRight_yOff=35},imageData1={"Interface\\AddOns\\Carbonite\\TutorialCarbonite",0,1,400/2048,(400+300)/2048,w=348,h=300/512*348,},},
								[203]={tileHeight=25,text="注意，启用插件后，默认的大地图将被五星任务采集的无级缩放卫星地图|cffffd200替换|r，但您随时可以按|cffffd200ALT+M|r打开默认的地图界面。在选项中也可以设置为不替换默认大地图。五星任务插件占用较大，但网易有爱特别提供了|cffffd200即时开关|r的功能，只要点击信息条上的\124TInterface\\Icons\\ACHIEVEMENT_GUILDPERK_MRPOPULARITY_RANK2:0\124t按钮（或是在控制台中开关），就可以完全不占用任何CPU，所以您在打副本时轻轻一点，就不会带来卡顿。需要做任务或采集时，再点一下，就可以开启使用。",title="可接任务功能说明",textBox={topLeft_xOff=33,topLeft_yOff=-80,bottomRight_xOff=-29,bottomRight_yOff=35},},
								[204]={tileHeight=25,text="要使用采集助手，需要先在控制台中加载采集点数据。例如图中先选中|cffffd200'显示草药采集点'|r然后点击|cffffd200'导入草药采集点'|r，确定。此时卫星地图上就可以显示出已知的草药点了。",title="采集助手功能说明",textBox={topLeft_xOff=33,topLeft_yOff=-220,bottomRight_xOff=-29,bottomRight_yOff=35},imageData1={"Interface\\AddOns\\Carbonite\\TutorialCarbonite",0,1,800/2048,(800+255)/2048,w=348,h=255/512*348,},},
								[205]={tileHeight=25,text="五星任务采集也提供了|cffffd200'采集路径'|r功能，具体使用方法是，右键点击地图，菜单中选择|cffffd200'路径'|r，再选择|cffffd200'当前显示的采集点'|r，就可以规划出比较合理的采集路径了。",title="采集助手功能说明",textBox={topLeft_xOff=33,topLeft_yOff=-220,bottomRight_xOff=-29,bottomRight_yOff=35},imageData1={"Interface\\AddOns\\Carbonite\\TutorialCarbonite",0,1,1200/2048,(1200+260)/2048,w=348,h=260/512*348,},},
							}
						)
					end
				)
			end
			return true
		end
	)
end 