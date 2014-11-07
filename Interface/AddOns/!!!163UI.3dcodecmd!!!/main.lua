local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� e={
verbose=�,
info=�,
errro=�,
}
� � t(...)
� e.verbose � print("[verbose]",...)�
�
� � a(...)
� e.info � print("[verbose]",...)�
�
� � a(...)
� e.errro � print("[verbose]",...)�
�
� cmd3dcode_main_showlog(t,a)
� t==� � t="verbose"�
� a==� � a=� �
e[t]=a
�
�(LoggingChat())�
�
LoggingChat(1);
�
� e="3dcodecmd$Yin2"
� e="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yin()"
� e="3dcodecmd$Yang2"
� e="##########################\n"
.."# 这是由网易有爱自动创建的宏 #\n"
.."#                请勿删除 :)                   #\n"
.."##########################\n"
.."/run ThreeDimensionsCode_Savepipe_Yang()"
� � e(e,a,o)
� � GetMacroBody(e)�
CreateMacro(e,"INV_MISC_QUESTIONMARK",a,�)
t("create macro",e)
�
t("macro has already exists",e)
�
SetOverrideBindingMacro(ThreeDimensionsCode_Blackboard,�,o,e)
�
� i=0
� s=�
� e=GetNumAddOns()
� o=0
� e=1,GetNumAddOns()�
� a,a,a,t,a,a,a=GetAddOnInfo(e)
� t � � IsAddOnLoadOnDemand(e)�
o=o+1
�
�
� � n(o,a,e,t,i)
� e=CreateFrame("Frame",a,UIParent,e)
� t �
e:SetPoint("LEFT",t,"RIGHT",i,0)
�
e:SetFrameStrata("DIALOG")
e.t=e:CreateTexture()
e.t:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
e.t:SetAllPoints(e)
e.fontstring=e:CreateFontString()
e.fontstring:SetFontObject(GameFontNormalSmall)
e.fontstring:SetText(o)
e.fontstring:SetAllPoints(e)
e:Show()
� GetCVar("chatStyle")~="classic"�
e:SetAlpha(.35)
hooksecurefunc("ChatEdit_DeactivateChat",�(t)
e:SetAlpha(.35)
�)
hooksecurefunc("ChatEdit_ActivateChat",�(t)
e:SetAlpha(1)
�)
�
� e
�
� � e(...)
�
� Toggle3DCodeCmdChatFrameBtnShown()
� � Cmd3DCode_Emoticon_ChatFrameButton � � Cmd3DCode_Screenshot_ChatFrameButton �
�
�
� e=�
� U1DB � U1DB.configs �
� U1DB.configs["!!!163ui!!!/displayScrshotEmoticonBtn"]=="_NIL"� U1DB.configs["!!!163ui!!!/displayScrshotEmoticonBtn"]==� �
e=�
�
�
� � e �
Cmd3DCode_Emoticon_ChatFrameButton:Hide()
Cmd3DCode_Screenshot_ChatFrameButton:Hide()
� e=1,10 �
� a,o,i,n,t=_G["ChatFrame"..e.."EditBox"]:GetPoint()
_G["ChatFrame"..e.."EditBox"]:SetPoint(a,o,i,-5,t)
�
�
Cmd3DCode_Emoticon_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:Show()
� e
� t=1,10 �
� a,i,n,o
e,a,i,n,o=_G["ChatFrame"..t.."EditBox"]:GetPoint()
_G["ChatFrame"..t.."EditBox"]:SetPoint(e,a,i,13,o)
�
Cmd3DCode_Emoticon_ChatFrameButton:SetWidth(32)
Cmd3DCode_Emoticon_ChatFrameButton:SetHeight(32)
Cmd3DCode_Screenshot_ChatFrameButton:SetWidth(32)
Cmd3DCode_Screenshot_ChatFrameButton:SetHeight(32)
Cmd3DCode_Emoticon_ChatFrameButton:ClearAllPoints()
Cmd3DCode_Emoticon_ChatFrameButton:SetPoint("RIGHT",ChatFrame1EditBox,"LEFT",8.4,0)
Cmd3DCode_Screenshot_ChatFrameButton:ClearAllPoints()
Cmd3DCode_Screenshot_ChatFrameButton:SetPoint("RIGHT",Cmd3DCode_Emoticon_ChatFrameButton,"LEFT",8,0)
�
�
� � d()
� e=n("表","Cmd3DCode_Emoticon_ChatFrameButton","Cmd3DCode_Emoticon_ChatFrameButtonTemplate")
� t=n("图","Cmd3DCode_Screenshot_ChatFrameButton","Cmd3DCode_Screenshot_ChatFrameButtonTemplate",e,-6)
Toggle3DCodeCmdChatFrameBtnShown()
CoreUIEnableTooltip(e,"自定义表情","导入你的专属表情包")
CoreUIEnableTooltip(t,"有爱截图","在游戏内截图并发送到聊天频道")
� dwChannelMuteButton �
SetOrHookScript(dwChannelMuteButton,"OnShow",Toggle3DCodeCmdChatFrameBtnShown)
SetOrHookScript(dwChannelMuteButton,"OnHide",Toggle3DCodeCmdChatFrameBtnShown)
�
� DWCChatTab18 �
SetOrHookScript(DWCChatTab18,"OnShow",Toggle3DCodeCmdChatFrameBtnShown)
SetOrHookScript(DWCChatTab18,"OnHide",Toggle3DCodeCmdChatFrameBtnShown)
�
�
� h=�
� a=�
� r=0
� l=time()
� e=CreateFrame("frame","3DCodeCmdInit",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(128)
e:EnableKeyboard(�)
e:SetPropagateKeyboardInput(�);
e.PropagateKeyboardInput=�
e:SetScript("OnKeyDown",�(a,t,...)
� IsAltKeyDown()�(t=="PAGEUP"� t=="PAGEDOWN")�
� t=="PAGEDOWN"�
ThreeDimensionsCode_Savepipe_Yin()
� t=="PAGEUP"�
ThreeDimensionsCode_Savepipe_Yang()
�
� IsControlKeyDown()� t=="PRINTSCREEN"�
Cmd3DCode_Screenshot_Start()
�
� � e.PropagateKeyboardInput �
a:SetPropagateKeyboardInput(�)
�
�
�
e.PropagateKeyboardInput=�
a:SetPropagateKeyboardInput(�)
� �
�)
� u={}
� � n()
a=�
r=time()
e:SetScript("OnEvent",null)
� � s �
threeDimensionsCodeFrames_create()
s=�
t("创建 threeDimensionsCodeFrames_create()")
�
d()
� e=1,GetNumBindings()�
� e={select(2,GetBinding(e))}
� t,e � pairs(e)�
u[e]=1
�
�
�
e:RegisterEvent("ADDON_LOADED")
e:SetScript("OnEvent",�(h,s,e)
� s=="ADDON_LOADED"� e:sub(1,9)~="Blizzard_"�
i=i+1
�
t(s,e,e:sub(1,9),i,o)
� i>=o � � a �
n()
�
�)
e:SetScript("OnUpdate",�(o,o)
� h �
t("proccessed")
�
�
� time()-l>=3 � � a �
t("等待所有插件加载完成超时")
n()
�
� � a �
�
�
� UnitAffectingCombat("player")�
t("in combat, wait over")
�
�
� time()-r>=0 �
DeleteMacro("3dcodecmd$Yin")
DeleteMacro("3dcodecmd$Yin2")
DeleteMacro("3dcodecmd$Yang")
DeleteMacro("3dcodecmd$Yang2")
ThreeDimensionsCode_SignalLamp.desireWidth();
h=�
e:SetScript("OnUpdate",�)
�
�)
� cmd3dcode_test()
bigdatasendtest()
�
� bigdatasendtest()
� e=GetTime()
� t=string.rep("1",GetScreenWidth()*3+12)
print('make string:',GetTime()-e,#t)
e=GetTime()
ThreeDimensionsCode_Send("hi",t);
print('make frames',GetTime()-e)
�
� ThreeDimensionsCode_IsFramesCreated()
� s
�
� ThreeDimensionsCode_Tell_AllAddOnsLoaded()
� n()
�]===], '@../!!!163UI.3dcodecmd!!!/main.lua'))()