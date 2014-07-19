local base_char,keywords=128,{"and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while",}; function prettify(code) return code:gsub("["..string.char(base_char).."-"..string.char(base_char+#keywords).."]", 
  function (c) return keywords[c:byte()-base_char]; end) end return assert(loadstring(prettify[==[â SetOrHookScript(e,t,a)
ä e:GetScript(t)í
ë e:HookScript(t,a)
Ñ
ë e:SetScript(t,a)
Ü
Ü
ä é CoreUIEnableTooltip í
å t
â CoreUIEnableTooltip(e,o,a,i)
e:EnableMouse(ì);
e.tooltipTitle=o;
e.tooltipText=a;
CoreHookScript(e,"OnEnter",CoreUIShowTooltip);
ä i í e.UpdateTooltip=CoreUIShowTooltip Ü
t=t è â(e)GameTooltip:Hide();Ü
SetOrHookScript(e,"OnLeave",t);
Ü
Ü]==], '@../!!!163UI.3dcodecmd!!!/common.lua'))()