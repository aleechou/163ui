local base_char,keywords=161,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[« bit==® ¢ bit32~=® ³
bit=bit32
§
­ o=-1
­ ª i(...)
§
­ ª t(...)
§
­ n=GetScreenWidth()
­ e=10
ª threeDimensionsCodeFrames_create()
ThreeDimensionsCode_Blackboard=CreateFrame("frame","ThreeDimensionsCode",®)
ThreeDimensionsCode_Blackboard:SetPoint("TOPLEFT",0,0)
ThreeDimensionsCode_Blackboard:SetWidth(n)
ThreeDimensionsCode_Blackboard:SetHeight(e)
ThreeDimensionsCode_Blackboard:SetFrameStrata("FULLSCREEN_DIALOG")
ThreeDimensionsCode_Blackboard:SetFrameLevel(128)
ThreeDimensionsCode_Blackboard:Show()
i("mode:",GetScreenWidth()*UIParent:GetEffectiveScale(),GetScreenHeight()*UIParent:GetEffectiveScale())
ThreeDimensionsCode_Blackboard.setReadScreenWidth=ª(e)
o=e
ThreeDimensionsCode_Blackboard:SetScale((GetScreenWidth()*UIParent:GetEffectiveScale())/o)
ThreeDimensionsCode_SignalLamp.keepAlive()
t("new width:",(GetScreenWidth()*UIParent:GetEffectiveScale()),"/",o)
§
­ a={
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
­ ª t(e,t)
­ e=CreateFrame("frame",e,®)
e:SetWidth(2)
e:SetHeight(2)
e:SetPoint(t,0,0)
e.texture=e:CreateTexture(®,"BACKGROUND")
² e
§
­ e=t("ThreeDimensionsCode_SignalLampA","BOTTOMLEFT")
­ t=t("ThreeDimensionsCode_SignalLampB","BOTTOMRIGHT")
e:SetFrameLevel(128)
t:SetFrameLevel(128)
ThreeDimensionsCode_SignalLamp={
keepAlive=ª()
« o<0 ³
ThreeDimensionsCode_SignalLamp.desireWidth()
¥
e.texture:SetTexture(unpack(a.keepAlive))
e.texture:SetAllPoints(e)
t.texture:SetTexture(unpack(a.keepAlive))
t.texture:SetAllPoints(t)
§
§,
desireWidth=ª()
e.texture:SetTexture(unpack(a.desireWidth))
e.texture:SetAllPoints(e)
t.texture:SetTexture(unpack(a.desireWidth))
t.texture:SetAllPoints(t)
§,
receiving=ª()
e.texture:SetTexture(unpack(a.receiving))
e.texture:SetAllPoints(e)
t.texture:SetTexture(unpack(a.receiving))
t.texture:SetAllPoints(t)
§,
}
§
­ s=bit.bor(bit.lshift(255,8),255)
­ t=0;
­ a=math.random(0,1e3)
i("commandID",a)
­ o={}
ª o:new()
­ e={}
setmetatable(e,{__index=self})
² e
§
ª o:pushchar(e)
self:pushbyte(string.byte(e))
§
ª o:pushbyte(e)
table.insert(self,e)
«#self>=3 ³
self:flush();
§
§
ª o:flush()
­ e;
­ a={ThreeDimensionsCode_Blackboard:GetChildren()}
«#a<=t ³
e=CreateFrame("frame","ThreeDimensionsCode_Pixel",ThreeDimensionsCode_Blackboard)
e:SetWidth(1)
e:SetHeight(1)
­ a=t%n
­ t=floor(t/n)
e:SetPoint("TOPLEFT",a,t)
e:Show()
e.texture=e:CreateTexture(®,"BACKGROUND")
¥
e=a[t+1];
§
e.texture:SetTexture(self:color(1),self:color(2),self:color(3),1)
e.texture:SetAllPoints(e)
t=t+1
­ ª e(e)
² e ¢ string.char(e)°""
§
i("chars:",e(self[1]),e(self[2]),e(self[3]))
i("bytes:",self[1],self[2],self[3])
i("colors:",self:color(1),self:color(2),self:color(3))
© e,t ¬ pairs(self)¤
self[e]=®
§
§
ª o:color(e)
« self[e]==® ³
² 0
¥
² self[e]/255
§
§
ª send(n)
t=0;
n=string.sub(n,1,s)
­ e=o:new()
­ t=#n
­ o=bit.band(t,255)
­ s=bit.rshift(t,8)
i("the data length",t)
e:pushbyte(bit.rshift(a,8))
e:pushchar("1")
e:pushbyte(bit.band(a,255))
e:pushbyte(o)
e:pushchar("9")
e:pushbyte(s)
© t=1,#n ¤
­ t=string.sub(n,t,t)
e:pushchar(t)
§
e:pushchar("8")
e:pushchar("2")
e:flush()
a=a+1
« a>65535 ³
a=0
§
§
ThreeDimensionsCode_Send=ª(t,e)
« e==® ³ e=""§
send(t..":"..e)
§
SLASH_3DCODECMD1="/cmd3d"
SlashCmdList["3DCODECMD"]=ª(t)
­ e=t:find(":")
print(e)
« e==® ³
print("æ ¼å¼æ— æ•ˆï¼› <cmd>:<args>")
²;
§
­ a=t:sub(1,e-1)
­ e=t:sub(e+1)
ThreeDimensionsCode_Send(a,e)
§
SLASH_URL1="/url"
SlashCmdList["URL"]=ª(e,t)
«#e<1 ³
e="http://www.baidu.com/"
§
ThreeDimensionsCode_Send("innerbrowser",e)
§
SLASH_BAIDU1="/baidu"
SlashCmdList["BAIDU"]=ª(e,t)
ThreeDimensionsCode_Send("innerbrowser","http://www.baidu.com/#wd="..e)
§
SLASH_OPEN1="/open"
SlashCmdList["OPEN"]=ª(e,t)
ThreeDimensionsCode_Send("openurl",e)
§
]===], '@../!!!163UI.3dcodecmd!!!/threeDimensionsCode.lua'))()