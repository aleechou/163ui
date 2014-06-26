local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[¢ bit==¥ ™ bit32~=¥ ª
bitfunc=bit32
œ
bitfunc=bit
ž
¤ e={
verbose=Ÿ,
info=Ÿ,
errro=«,
}
¤ ¡ u(...)
¢ e.verbose ª print("[verbose]",...)ž
ž
¤ ¡ c(...)
¢ e.info ª print("[verbose]",...)ž
ž
¤ ¡ t(...)
¢ e.errro ª print("[verbose]",...)ž
ž
¡ cmd3dcode_pipe_showlog(a,t)
¢ a==¥ ª a="verbose"ž
¢ t==¥ ª t=« ž
e[a]=t
ž
¤ f=3
¤ e=""
¤ l=-1
¤ d=-1
¤ i=-1
¤ t=0
¤ n=0
¤ o=0
¤ a=0
¤ s=0
¤ r=0
¤ ¡ m()
o=0
a=0
ž
¤ ¡ h()
e=""
l=-1
d=-1
i=-1
t=0
n=0
r=0
s=0
m()
ž
h()
¤ ¡ w(a)
u("receive",(n+1).."/"..t,"byte",a,string.char(a))
¢ l<0 ª
l=a
©
 d<0 ª
d=a
i=l
t=d
c("cmd id",i,"data len",t)
¢ t<1 ª
h()
ž
©
ž
e=e..string.char(a)
n=n+1
¢ n>=t ª
¤ t=string.byte(e:sub(1,1))
¤ t=ThreeDimensionsCode_SafePipe_CmdHandles[t]
¤ a
¢ t ª
a=e:sub(2)
t=ThreeDimensionsCode_SafePipe_CmdHandles[t]
œ
¤ o=e:find(":")
¢ o ª
¤ i=e:sub(1,o-1)
a=e:sub(o+1)
t=ThreeDimensionsCode_SafePipe_CmdHandles[i]
ž
ž
¢ t ª
t(i,a)
ž
c("receive over, time",GetTime()-s,"cmd id",i)
c(e)
h()
©
ž
ž
¤ ¡ i(t)
¤ e=GetTime()
¢ r==0 ª
s=e
u("first bit come in")
œ
¢ e-r>f ª
u("safe pipe è¶…æ—¶å…³é—­")
h()
s=e
ž
ž
r=e
¢ t>0 ª
o=bitfunc.bor(o,bitfunc.lshift(t,7-a))
ž
a=a+1
¢ a>=8 ª
w(o)
m(o)
ž
ž
¡ ThreeDimensionsCode_Savepipe_Yin()
i(0)
ž
¡ ThreeDimensionsCode_Savepipe_Yang()
i(1)
ž
ThreeDimensionsCode_SafePipe_CmdHandles={
"newsize",
"script",
"ping",
"ir",
"iu",
"id",
newsize=¡(e,t)
¤ e=t:find("x")
¢ e ª
¤ e=t:sub(1,e-1)
e=tonumber(e)
¢ e ª
¢ ThreeDimensionsCode_Blackboard ª
ThreeDimensionsCode_Blackboard.setReadScreenWidth(e)
ž
ž
ž
ž,
script=¡(t,e)
loadstring(e)()
ž,
}
]===], '@../!!!163UI.3dcodecmd!!!/savepipe.lua'))()