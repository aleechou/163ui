TDCOOLDOWN2_LACALE = {}
COOLLINE_UNLOCK_TEXT = "CoolLine - drag frame to reposition or drag red corner to resize"
local L = TDCOOLDOWN2_LACALE;

L.Rank = "^Rank (%d+)$";
L.Move = "Move";
L.CDOver = "%s cooldown complete!";
L.Updated = "Updated to v%s";
L.UpdatedIncompatible = "Updating from an incompatible version. Default settings loaded";
L.NewUser = "New user detected, default settings loaded";
L.ErrorFont = "Error font file %s, %s loaded.";
L.Title = "tdCooldown2 Options";
L["Options loaded !"] = true; 
L["options load failed!!"] = true;
L["RightClick to locked"] = true;
L["Loaded Default Settings"] = true;
L.Subtitle = [[



About:

    Name: tdCooldown2
    Author: Taiduo£¨ldz5£©
    Version: %s


Tips:

     1.
     2.
     3.
     4.
     5.
     6.
]];

for i, v in pairs(L) do
	L[i] = type(v) == "string" and v or i;
end