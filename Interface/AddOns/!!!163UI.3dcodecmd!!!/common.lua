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
� CoreUIEnableTooltip(e,o,a,i)
e:EnableMouse(�);
e.tooltipTitle=o;
e.tooltipText=a;
CoreHookScript(e,"OnEnter",CoreUIShowTooltip);
� i � e.UpdateTooltip=CoreUIShowTooltip �
t=t � �(e)GameTooltip:Hide();�
SetOrHookScript(e,"OnLeave",t);
�
�]==], '@../!!!163UI.3dcodecmd!!!/common.lua'))()