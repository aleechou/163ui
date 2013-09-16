--[[------------------------------------------------------------
小地图目标简化
---------------------------------------------------------------]]
local minimapBlips = {
    ["SetBlipTexture"] = {"interface\\minimap\\objecticons", "Interface\\AddOns\\!!!163UI!!!\\Textures\\MMB_OBJECTICONS"},
    ["SetClassBlipTexture"] = {"interface\\minimap\\partyraidblips", "Interface\\AddOns\\!!!163UI!!!\\Textures\\MMB_PartyRaidBlips"},
}
function ToggleMinimapBlips(enable)
    for k,v in pairs(minimapBlips) do
        local origin = Minimap[k.."Ori"] or Minimap[k]
        Minimap[k.."Ori"] = origin
        origin(Minimap, enable and v[2] or v[1])
        if enable then
            Minimap[k] = function(self, tex, ...)
                if tex and tex:lower()==v[1]:lower() then tex = v[2] end
                origin(Minimap, tex, ...)
            end
        else
            Minimap[k] = origin
        end
    end
end