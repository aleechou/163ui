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
� cmd3dcode_main_showlog(a,t)
� a==� � a="verbose"�
� t==� � t=� �
e[a]=t
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
� o=0
� s=�
� e=GetNumAddOns()
� i=0
� e=1,GetNumAddOns()�
� a,a,a,t,a,a,a=GetAddOnInfo(e)
� t � � IsAddOnLoadOnDemand(e)�
i=i+1
�
�
� � a(o,a,e,t,i)
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
� � e(...)
print("_",...)
�
� Toggle3DCodeCmdChatFrameBtnShown()
� � Cmd3DCode_Emoticon_ChatFrameButton � � Cmd3DCode_Screenshot_ChatFrameButton �
�
�
� e=� �(U1DB � U1DB.configs � U1DB.configs["!!!163ui!!!/displayScrshotEmoticonBtn"]=="_NIL")
� e �
Cmd3DCode_Emoticon_ChatFrameButton:Hide()
Cmd3DCode_Screenshot_ChatFrameButton:Hide()
� e=1,10 �
� t,i,o,n,a=_G["ChatFrame"..e.."EditBox"]:GetPoint()
� t=="TOPLEFT"�
_G["ChatFrame"..e.."EditBox"]:SetPoint(t,i,o,-5,a)
�
�
�
Cmd3DCode_Emoticon_ChatFrameButton:Show()
Cmd3DCode_Screenshot_ChatFrameButton:Show()
� e=1,10 �
� t,i,o,n,a=_G["ChatFrame"..e.."EditBox"]:GetPoint()
_G["ChatFrame"..e.."EditBox"]:SetPoint(t,i,o,13,a)
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
� � l()
� e=a("表","Cmd3DCode_Emoticon_ChatFrameButton","Cmd3DCode_Emoticon_ChatFrameButtonTemplate")
� e=a("图","Cmd3DCode_Screenshot_ChatFrameButton","Cmd3DCode_Screenshot_ChatFrameButtonTemplate",e,-6)
Toggle3DCodeCmdChatFrameBtnShown()
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
� d=time()
� e=CreateFrame("frame","3DCodeCmdInit",UIParent)
e:SetFrameStrata("TOOLTIP")
e:SetFrameLevel(128)
e:EnableKeyboard(�)
e:SetPropagateKeyboardInput(�);
e.PropagateKeyboardInput=�
e:SetScript("OnKeyDown",�(a,t,...)
� IsControlKeyDown()� IsAltKeyDown()�(t=="PAGEUP"� t=="PAGEDOWN")�
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
� � n()
a=�
r=time()
e:SetScript("OnEvent",null)
� � s �
threeDimensionsCodeFrames_create()
s=�
t("创建 threeDimensionsCodeFrames_create()")
�
l()
�
e:RegisterEvent("ADDON_LOADED")
e:SetScript("OnEvent",�(h,s,e)
� s=="ADDON_LOADED"� e:sub(1,9)~="Blizzard_"�
o=o+1
�
t(s,e,e:sub(1,9),o,i)
� o>=i � � a �
n()
�
�)
e:SetScript("OnUpdate",�(o,o)
� h �
t("proccessed")
�
�
� time()-d>=3 � � a �
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