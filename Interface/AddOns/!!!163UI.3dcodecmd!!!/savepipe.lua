local base_char,keywords=152,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[===[� bit==� � bit32~=� �
bitfunc=bit32
�
bitfunc=bit
�
� � c(...)
�
� � u(...)
print("[info]",...)
�
� � e(...)
print("[ERROR]",...)
�
� f=3
� e=""
� d=-1
� r=-1
� l=-1
� t=0
� i=0
� o=0
� a=0
� h=0
� n=0
� � m()
o=0
a=0
�
� � s()
e=""
d=-1
r=-1
l=-1
t=0
i=0
n=0
h=0
m()
�
s()
� � w(a)
c("receive",(i+1).."/"..t,"byte",a,string.char(a))
� d<0 �
d=a
�
� r<0 �
r=a
l=d
t=r
u("cmd id",l,"data len",t)
� t<1 �
s()
�
�
�
e=e..string.char(a)
i=i+1
� i>=t �
� t=e:find(":")
� t �
� a=e:sub(1,t-1)
� ThreeDimensionsCode_SafePipe_CmdHandles[a]�
ThreeDimensionsCode_SafePipe_CmdHandles[a](e:sub(t+1))
�
�
u("receive over, time",GetTime()-h,"cmd id",l)
u(e)
s()
�
�
�
� � i(t)
� e=GetTime()
� n==0 �
h=e
c("first bit come in")
�
� e-n>f �
c("safe pipe 超时关闭")
s()
h=e
�
�
n=e
� t>0 �
o=bitfunc.bor(o,bitfunc.lshift(t,7-a))
�
a=a+1
� a>=8 �
w(o)
m(o)
�
�
� ThreeDimensionsCode_Savepipe_Yin()
i(0)
�
� ThreeDimensionsCode_Savepipe_Yang()
i(1)
�
ThreeDimensionsCode_SafePipe_CmdHandles={
newsize=�(t)
� e=t:find("x")
� e �
� e=t:sub(1,e-1)
e=tonumber(e)
� e �
threeDimensionsCodePad.setReadScreenWidth(e)
�
�
�
}
]===], '@../!!!163UI.3dcodecmd!!!/savepipe.lua'))()