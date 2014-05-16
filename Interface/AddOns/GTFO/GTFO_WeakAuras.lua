--------------------------------------------------------------------------
-- GTFO_WeakAuras.lua 
--------------------------------------------------------------------------
--[[
GTFO & WeakAuras Integration
Author: Zensunim of Malygos
]]--

function GTFO_DisplayAura_WeakAuras(iType)
  if (WeakAuras and WeakAuras.loaded_events) then
	  local event_list = WeakAuras.loaded_events["GTFO_DISPLAY"];
	  if (event_list) then
		  for id, triggers in pairs(event_list) do
		    for triggerNumber, data in pairs(triggers) do
			    if (data.trigger) then
			      if (data.trigger("GTFO_DISPLAY", iType)) then
			        WeakAuras.ActivateEvent(id, triggerNumber, data);
			      end
			    end
		    end
		  end
		end
	end
end
