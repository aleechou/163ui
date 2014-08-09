



function SetOrHookScript(target,eventName,func)
	if target:GetScript(eventName) then
		return target:HookScript(eventName,func)
	else
		return target:SetScript(eventName,func)
	end
end

-- CoreUIEnableTooltip 在 !!!163UI!!! 中定义，如果没有加载 !!!163UI!!! ，则在此定义
if not CoreUIEnableTooltip then
	local EnableTooltip_OnLeave
	function CoreUIEnableTooltip(frame, title, content, update)
	    frame:EnableMouse(true);
	    frame.tooltipTitle=title;
	    frame.tooltipText=content;
	    CoreHookScript(frame, "OnEnter",CoreUIShowTooltip);
	    if update then frame.UpdateTooltip = CoreUIShowTooltip end

	    EnableTooltip_OnLeave = EnableTooltip_OnLeave or function(self) GameTooltip:Hide(); end
	    SetOrHookScript(frame, "OnLeave", EnableTooltip_OnLeave);
	end
end


function SlashCmdList_AddSlashCommand(name, func, ...)
    SlashCmdList[name] = func
    local command = ''
    for i = 1, select('#', ...) do
        command = select(i, ...)
        if strsub(command, 1, 1) ~= '/' then
            command = '/' .. command
        end
        _G['SLASH_'..name..i] = command
    end
end