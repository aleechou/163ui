local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bitfunc=bit32
�
bitfunc=bit
�
� e={
verbose=�,
info=�,
errro=�,
}
� � m(...)
� e.verbose � print("[verbose]",...)�
�
� � c(...)
� e.info � print("[verbose]",...)�
�
� � t(...)
� e.errro � print("[verbose]",...)�
�
� cmd3dcode_pipe_showlog(t,a)
� t==� � t="verbose"�
� a==� � a=� �
e[t]=a
�
� w=3
� e=""
� l=-1
� u=-1
� a=-1
� t=0
� i=0
� n=0
� s=0
� d=0
� h=0
� � f()
n=0
s=0
�
� � r()
e=""
l=-1
u=-1
a=-1
t=0
i=0
h=0
d=0
f()
�
r()
� � y(o)
m("receive",(i+1).."/"..t,"byte",o,string.char(o))
� l<0 �
l=o
�
� u<0 �
u=o
a=l
t=u
c("cmd id",a,"data len",t)
� t<1 �
r()
�
�
�
e=e..string.char(o)
i=i+1
� i>=t �
� t=e:find(":")
� t �
� o=e:sub(1,t-1)
� ThreeDimensionsCode_SafePipe_CmdHandles[o]�
ThreeDimensionsCode_SafePipe_CmdHandles[o](a,e:sub(t+1))
�
�
c("receive over, time",GetTime()-d,"cmd id",a)
c(e)
r()
�
�
�
� � a(t)
� e=GetTime()
� h==0 �
d=e
m("first bit come in")
�
� e-h>w �
m("safe pipe 超时关闭")
r()
d=e
�
�
h=e
� t>0 �
n=bitfunc.bor(n,bitfunc.lshift(t,7-s))
�
s=s+1
� s>=8 �
y(n)
f(n)
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