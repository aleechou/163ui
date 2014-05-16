  local clickme2 = function()
  if PSFeamain1:IsShown() then PSFea_buttonsaveexit()
  else PHOENIXSTYLEEASYACH_Command("") end end

  local ldb = LibStub:GetLibrary("LibDataBroker-1.1")

  local dataobj = ldb:NewDataObject("RaidAchievement",{ 
    type = "launcher",
    text = "RA",
    --icon = "interface\\ICONS\\inv_misc_summerfest_brazierorange",
    icon = "interface\\AddOns\\RaidAchievement\\ra_button_e",
    label = Raidach,	
    OnClick = clickme2,
      OnTooltipShow = function(tooltip)
        tooltip:AddLine(pseachatlistldb1)
        if psdatabrokervart then
          tooltip:AddLine(radatabrokervart)
        else
          tooltip:AddLine(pseachatlistldb2)
        end

      end
  })