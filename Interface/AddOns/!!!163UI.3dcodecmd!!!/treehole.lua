local base_char,keywords=161,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[« bit==® ¢ bit32~=® ³
bit=bit32
§
­ ª t(...)
§
­ ª u(...)
print(...)
§
­ ª w(...)
print("[ERROR]",...)
§
­ f=.3
­ e=1
­ s={
["0"]=0,["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,
["A"]=10,["B"]=11,["C"]=12,["D"]=13,["E"]=14,["F"]=15,["G"]=16,["H"]=17,["I"]=18,["J"]=19,["K"]=20,["L"]=21,["M"]=22,["N"]=23,["O"]=24,["P"]=25,["Q"]=26,["R"]=27,["S"]=28,["T"]=29,["U"]=30,["V"]=31,["W"]=32,["X"]=33,["Y"]=34,["Z"]=35,
[";"]=36,["'"]=37,[","]=38,["."]=39,["RIGHT"]=40,["["]=41,["]"]=42,["`"]=43,["-"]=44,["="]=45,
["F1"]=46,["F2"]=47,["F3"]=48,["F4"]=49,["F5"]=50,["F6"]=51,["F7"]=52,["F8"]=53,["F9"]=54,["F10"]=55,["F11"]=56,["F12"]=57,
["SPACE"]=58,["LEFT"]=59,["BACKSPACE"]=60,["DELETE"]=61,["UP"]=62,["DOWN"]=63
}
­ y=0
­ e=0
ª ThreeDimensionsCode_Treehole_Hello()
e=0;
ThreeDimensionsCode_SignalLamp.receiving()
print("ThreeDimensionsCode_Treehole_Hello")
­ a=""
­ i=1
­ c=0
­ n=0
­ e={0,0,0,0}
­ d=-1;
­ h=-1;
­ r=-1;
­ m=GetTime();
threeDimensionsCodePad:SetScript("OnKeyUp",ª(l,o)
t(">>",o)
« o=="ESCAPE"³
ThreeDimensionsCode_Treehole_Close()
²;
§
­ l=GetTime()-m;
« l>f ³
ThreeDimensionsCode_Treehole_Close()
w("tree hole timeout, force close it .",l)
²
§
« s[o]==nul ³
t("æ— æ•ˆçš„key",o)
²
§
« h<0 ³
h=s[o]
t("datalen high bit byte",h)
²;
§
« r<0 ³
r=s[o]
t("datalen low bit byte",r)
d=bit.bor(bit.lshift(h,6),r)
t("datalen",d)
c=ceil(d/3)
n=0;
t("--")
²;
§
e[i]=s[o]
t("segment idx:",i,o,s[o])
i=i+1
« i>4 ³
n=n+1
t("reseive",n.."th","segments:",e[1],e[2],e[3],e[4])
­ h=bit.bor(bit.lshift(e[1],2),bit.rshift(e[2],4))
­ s=bit.bor(bit.lshift(bit.band(e[2],15),4),bit.rshift(e[3],2))
­ o=bit.bor(bit.lshift(bit.band(e[3],3),6),bit.band(e[4],63))
t("unpack to 3 byte:",h,s,o)
t("to char:",string.char(h),string.char(s),string.char(o))
a=a..string.char(h)..string.char(s)..string.char(o)
i=1
e={0,0,0,0}
t("")
« n>=c ³
a=string.sub(a,1,d)
u("receive over:",#a,a)
u("tree hole time:",GetTime()-m)
ThreeDimensionsCode_Treehole_Close()
­ e=a:find(":")
« e ³
­ t=a:sub(1,e-1)
« ThreeDimensionsCode_TreeHole_CmdHandles[t]³
ThreeDimensionsCode_TreeHole_CmdHandles[t](a:sub(e+1))
§
§
²;
§
§
§)
§
ª ThreeDimensionsCode_Treehole_Close()
y=0
threeDimensionsCodePad:SetScript("OnKeyUp",nui)
ThreeDimensionsCode_SignalLamp.keepAlive()
§
ThreeDimensionsCode_TreeHole_CmdHandles={
newsize=ª(e)
­ t=e:find("x")
« t ³
­ e=e:sub(1,t-1)
e=tonumber(e)
« e ³
threeDimensionsCodePad.setReadScreenWidth(e)
§
§
§
}
]===], '@../!!!163UI.3dcodecmd!!!/treehole.lua'))()