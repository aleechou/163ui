local base_char,keywords=192,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� h="!!!163UI.3dcodecmd!!!"
� createChatLeftBtn(o,e,a,t,i)
� e=CreateFrame("Frame",e,t,a)
e:SetPoint("BOTTOM",t,"TOP",0,i)
e.t=e:CreateTexture()
e.t:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
e.t:SetAllPoints(e)
e.fontstring=e:CreateFontString()
e.fontstring:SetFontObject(GameFontNormalSmall)
e.fontstring:SetText(o)
e.fontstring:SetAllPoints(e)
e:Show()
� e
�
createChatLeftBtn("表","Cmd3DCode_Emoticon_ChatFrameButton","Cmd3DCode_Emoticon_ChatFrameButtonTemplate",ChatFrameMenuButton,5)
createChatLeftBtn("图","Cmd3DCode_Screenshot_ChatFrameButton","Cmd3DCode_Screenshot_ChatFrameButtonTemplate",Cmd3DCode_Emoticon_ChatFrameButton,-2)
� o=Cmd3DCode_CustomEmoticonsDB
� � o � o={}�
� � o.emoticons � o.emoticons={}�
� e=6
� t=3
� r=8
� s=8
� n=14
� i=35
� � a(o,t)
� a="Cmd3DCode_Emoticon_Thumb"..o
� � _G[a]� � t �
� t=CreateFrame("Frame",a,Cmd3DCode_EmoticonFrame,"Cmd3DCode_Emoticon_PictureTemplate")
� a=o%e*(s+t:GetWidth())+n
� e=-floor(o/e)*(r+t:GetHeight())-i
t:SetPoint("TOPLEFT",a,e)
t.texture=_G[t:GetName().."_Texture"]
t.checkbutton=_G[t:GetName().."_ChkBtn"]
�
� _G[a]
�
� Cmd3DCode_Emoticon_ShowPage(n)
� e=0,t*e-1 �
� e=a(e,�)
� e �
e.checkbutton:SetChecked(�)
e:Hide()
�
�
� d=(n-1)*t*e
� r=n*t*e-1
� i=0
� s=0
� o,e � pairs(o.emoticons)�
� � e.type �
e.texture="Interface\\AddOns\\"..h.."\\External\\Emoticons\\"..e.filename
e.picid=o
e.type="emoticon"
�
� i>=d � i<=r �
� t=a(s)
� i,a=calExternalPictureSize(e,64,64)
t.texture:SetTexture(e.texture)
t.texture:SetWidth(i)
t.texture:SetHeight(a)
t.picid=o
t:Show()
s=s+1
�
i=i+1
�
� e=ceil(i/(t*e))
� e<1 � e=1 �
Cmd3DCode_EmoticonFrame_TxtPageNum.pagenum=n
Cmd3DCode_EmoticonFrame_TxtPageNum.totalpages=e
Cmd3DCode_EmoticonFrame_TxtPageNum:SetText(n.."/"..e)
�
Cmd3DCode_Emoticon_ShowPage(1)
Cmd3DCode_EmoticonFrame_BtnAllCheck:SetScript("OnClick",�()
� e=0,t*e-1 �
� e=a(e,�)
� e � e:IsVisible()�
e.checkbutton:SetChecked(�)
�
�
�)
Cmd3DCode_EmoticonFrame_BtnAllRevert:SetScript("OnClick",�()
� e=0,t*e-1 �
� e=a(e,�)
� e � e:IsVisible()�
e.checkbutton:SetChecked(� e.checkbutton:GetChecked())
�
�
�)
Cmd3DCode_EmoticonFrame_BtnRemove:SetScript("OnClick",�()
� o={}
� e=0,t*e-1 �
� e=a(e)
� e.checkbutton:GetChecked()�
tinsert(o,e.picid)
�
�
�#o<1 �
�
�
StaticPopup_Show("163UI-Emoticon:RemoveConfirm")
.data={
addonName=h,
piclst=o,
}
�)
StaticPopupDialogs["163UI-Emoticon:RemoveConfirm"]={
text="确定要删除选中的表情图片吗？",
button1="删除",
button2="取消",
whileDead=�,
hideOnEscape=�,
preferredIndex=3,
OnAccept=�(t,e)
ThreeDimensionsCode_Send("emoticon/remove",json_encode(e))
Cmd3DCode_CheckoutClientAndPrompt()
�,
}
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/start-upload"]=�(t,e)
� t,e=strsplit(",",e)
print("正在上传表情图片",(t+1).."/"..e,"...")
�
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/upload-error"]=�()
print("表情图片上传遇到错误")
�
StaticPopupDialogs["163UI-Emoticon:ImportDone"]={
text="表情图片已经导入到WOW中，需要重载界面(Reload UI)后生效",
button1="立即重载界面",
button2="稍后再说",
whileDead=�,
hideOnEscape=�,
preferredIndex=3,
OnAccept=ReloadUI,
}
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/changed"]=�(t,e)
� e=tonumber(e)
� e==0 �
�
� e>0 �
StaticPopupDialogs["163UI-Emoticon:ImportDone"].text="表情图片已经导入到WOW中，需要重载界面(Reload UI)后生效"
�
StaticPopupDialogs["163UI-Emoticon:ImportDone"].text="表情图片已经从WOW中删除，需要重载界面(Reload UI)后生效"
�
StaticPopup_Show("163UI-Emoticon:ImportDone")
�
ThreeDimensionsCode_SafePipe_CmdHandles["emoticon/not-start/another-working"]=�()
print("另一个表情导入任务正在进行中，请等待完成")
�
]===], '@../!!!163UI.3dcodecmd!!!/emoticon.lua'))()