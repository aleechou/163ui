local base_char,keywords=161,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[´ bit==Æ ¢ bit32~=Æ ≥
bit=bit32
ß
≠ o=-1
≠ ™ i(...)
ß
≠ ™ t(...)
ß
≠ n=GetScreenWidth()
≠ e=10
™ threeDimensionsCodeFrames_create()
ThreeDimensionsCode_Blackboard=CreateFrame("frame","ThreeDimensionsCode",Æ)
ThreeDimensionsCode_Blackboard:SetPoint("TOPLEFT",0,0)
ThreeDimensionsCode_Blackboard:SetWidth(n)
ThreeDimensionsCode_Blackboard:SetHeight(e)
ThreeDimensionsCode_Blackboard:SetFrameStrata("FULLSCREEN_DIALOG")
ThreeDimensionsCode_Blackboard:SetFrameLevel(128)
ThreeDimensionsCode_Blackboard:Show()
i("mode:",GetScreenWidth()*UIParent:GetEffectiveScale(),GetScreenHeight()*UIParent:GetEffectiveScale())
ThreeDimensionsCode_Blackboard.setReadScreenWidth=™(e)
o=e
ThreeDimensionsCode_Blackboard:SetScale((GetScreenWidth()*UIParent:GetEffectiveScale())/o)
ThreeDimensionsCode_SignalLamp.keepAlive()
t("new width:",(GetScreenWidth()*UIParent:GetEffectiveScale()),"/",o)
ß
≠ a={
keepAlive={
20/255,
14/255,
63/255,
1
},
desireWidth={
198/255,
210/255,
11/255,
1
},
receiving={
198/255,
31/255,
112/255,
1
},
}
≠ ™ t(e,t)
≠ e=CreateFrame("frame",e,Æ)
e:SetWidth(2)
e:SetHeight(2)
e:SetPoint(t,0,0)
e.texture=e:CreateTexture(Æ,"BACKGROUND")
≤ e
ß
≠ e=t("ThreeDimensionsCode_SignalLampA","BOTTOMLEFT")
≠ t=t("ThreeDimensionsCode_SignalLampB","BOTTOMRIGHT")
e:SetFrameLevel(128)
t:SetFrameLevel(128)
ThreeDimensionsCode_SignalLamp={
keepAlive=™()
´ o<0 ≥
ThreeDimensionsCode_SignalLamp.desireWidth()
•
e.texture:SetTexture(unpack(a.keepAlive))
e.texture:SetAllPoints(e)
t.texture:SetTexture(unpack(a.keepAlive))
t.texture:SetAllPoints(t)
ß
ß,
desireWidth=™()
e.texture:SetTexture(unpack(a.desireWidth))
e.texture:SetAllPoints(e)
t.texture:SetTexture(unpack(a.desireWidth))
t.texture:SetAllPoints(t)
ß,
receiving=™()
e.texture:SetTexture(unpack(a.receiving))
e.texture:SetAllPoints(e)
t.texture:SetTexture(unpack(a.receiving))
t.texture:SetAllPoints(t)
ß,
}
ß
≠ s=bit.bor(bit.lshift(255,8),255)
≠ a=0;
≠ t=math.random(0,1e3)
i("commandID",t)
≠ o=GetScreenWidth()
≠ e=CreateFrame("FRAME");
e:RegisterEvent("ADDON_LOADED");
™ e:OnEvent(t,a)
´ t=="ADDON_LOADED"¢ a=="3dcodecmd"≥
´ DesktopWidth ≥
o=DesktopWidth
ThreeDimensionsCode_Blackboard:SetScale(GetScreenWidth()/o)
ß
ß
ß
e:SetScript("OnEvent",e.OnEvent);
≠ o={}
™ o:new()
≠ e={}
setmetatable(e,{__index=self})
≤ e
ß
™ o:pushchar(e)
self:pushbyte(string.byte(e))
ß
™ o:pushbyte(e)
table.insert(self,e)
´#self>=3 ≥
self:flush();
ß
ß
™ o:flush()
≠ e;
≠ t={ThreeDimensionsCode_Blackboard:GetChildren()}
´#t<=a ≥
e=CreateFrame("frame","ThreeDimensionsCode_Pixel",ThreeDimensionsCode_Blackboard)
e:SetWidth(1)
e:SetHeight(1)
≠ t=a%(n-1)
≠ a=floor(a/n)
e:SetPoint("TOPLEFT",t,a)
e:Show()
e.texture=e:CreateTexture(Æ,"BACKGROUND")
•
e=t[a+1];
ß
e.texture:SetTexture(self:color(1),self:color(2),self:color(3),1)
e.texture:SetAllPoints(e)
a=a+1
≠ ™ e(e)
≤ e ¢ string.char(e)∞""
ß
i("chars:",e(self[1]),e(self[2]),e(self[3]))
i("bytes:",self[1],self[2],self[3])
i("colors:",self:color(1),self:color(2),self:color(3))
© e,t ¨ pairs(self)§
self[e]=Æ
ß
ß
™ o:color(e)
´ self[e]==Æ ≥
≤ 0
•
≤ self[e]/255
ß
ß
™ send(i)
a=0;
i=string.sub(i,1,s)
≠ e=o:new()
≠ a=#i
≠ n=bit.band(a,255)
≠ o=bit.rshift(a,8)
print("the data length",a)
e:pushbyte(bit.rshift(t,8))
e:pushchar("1")
e:pushbyte(bit.band(t,255))
e:pushbyte(n)
e:pushchar("9")
e:pushbyte(o)
© t=1,#i §
≠ t=string.sub(i,t,t)
e:pushchar(t)
ß
e:pushchar("8")
e:pushchar("2")
e:flush()
t=t+1
´ t>65535 ≥
t=0
ß
ß
ThreeDimensionsCode_Send=™(t,e)
send(t..":"..e)
ß
SLASH_3DCODECMD1="/cmd3d"
SlashCmdList["3DCODECMD"]=™(t)
≠ e=t:find(":")
print(e)
´ e==Æ ≥
print("Ê†ºÂºèÊó†ÊïàÔºõ <cmd>:<args>")
≤;
ß
≠ a=t:sub(1,e-1)
≠ e=t:sub(e+1)
ThreeDimensionsCode_Send(a,e)
ß
SLASH_URL1="/url"
SlashCmdList["URL"]=™(e,t)
ThreeDimensionsCode_Send("innerbrowser",e)
ß
SLASH_OPEN1="/open"
SlashCmdList["OPEN"]=™(e,t)
ThreeDimensionsCode_Send("openurl",e)
ß
]===], '@../!!!163UI.3dcodecmd!!!/threeDimensionsCode.lua'))()