local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bitfunc=bit32
�
bitfunc=bit
�
� � u(...)
�
� � c(...)
�
� � e(...)
print("[ERROR]",...)
�
� w=3
� e=""
� r=-1
� s=-1
� n=-1
� t=0
� a=0
� i=0
� o=0
� h=0
� l=0
� � m()
i=0
o=0
�
� � d()
e=""
r=-1
s=-1
n=-1
t=0
a=0
l=0
h=0
m()
�
d()
� � f(o)
u("receive",(a+1).."/"..t,"byte",o,string.char(o))
� r<0 �
r=o
�
� s<0 �
s=o
n=r
t=s
c("cmd id",n,"data len",t)
� t<1 �
d()
�
�
�
e=e..string.char(o)
a=a+1
� a>=t �
� t=e:find(":")
� t �
� a=e:sub(1,t-1)
� ThreeDimensionsCode_SafePipe_CmdHandles[a]�
ThreeDimensionsCode_SafePipe_CmdHandles[a](n,e:sub(t+1))
�
�
c("receive over, time",GetTime()-h,"cmd id",n)
c(e)
d()
�
�
�
� � a(t)
� e=GetTime()
� l==0 �
h=e
u("first bit come in")
�
� e-l>w �
u("safe pipe 超时关闭")
d()
h=e
�
�
l=e
� t>0 �
i=bitfunc.bor(i,bitfunc.lshift(t,7-o))
�
o=o+1
� o>=8 �
f(i)
m(i)
�
�
� ThreeDimensionsCode_Savepipe_Yin()
a(0)
�
� ThreeDimensionsCode_Savepipe_Yang()
a(1)
�
ThreeDimensionsCode_SafePipe_CmdHandles={
newsize=�(t,e)
� t=e:find("x")
� t �
� e=e:sub(1,t-1)
e=tonumber(e)
� e �
� ThreeDimensionsCode_Blackboard �
ThreeDimensionsCode_Blackboard.setReadScreenWidth(e)
�
�
�
�,
script=�(t,e)
loadstring(e)()
�
}
]===], '@../!!!163UI.3dcodecmd!!!/savepipe.lua'))()