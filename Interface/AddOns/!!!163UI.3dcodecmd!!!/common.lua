local base_char,keywords=128,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[==[� SetOrHookScript(e,t,a)
� e:GetScript(t)�
� e:HookScript(t,a)
�
� e:SetScript(t,a)
�
�
� � CoreUIEnableTooltip �
� t
� CoreUIEnableTooltip(e,a,i,o)
e:EnableMouse(�);
e.tooltipTitle=a;
e.tooltipText=i;
CoreHookScript(e,"OnEnter",CoreUIShowTooltip);
� o � e.UpdateTooltip=CoreUIShowTooltip �
t=t � �(e)GameTooltip:Hide();�
SetOrHookScript(e,"OnLeave",t);
�
�
� SlashCmdList_AddSlashCommand(t,e,...)
SlashCmdList[t]=e
� e=''
� a=1,select('#',...)�
e=select(a,...)
� strsub(e,1,1)~='/'�
e='/'..e
�
_G['SLASH_'..t..a]=e
�
�]==], '@../!!!163UI.3dcodecmd!!!/common.lua'))()