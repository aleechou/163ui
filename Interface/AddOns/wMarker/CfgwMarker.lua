U1RegisterAddon("wMarker", {
    title = "全能标记助手",
    defaultEnable = 1,
    load = "NORMAL",
    secure = 1,
nopic = 1,
    tags = { TAG_RAID },
    icon = [[Interface\Icons\INV_Sigil_UlduarAll]],
    desc = "wMarker漂亮的团队标记插件，显示一个各种团队标记的框体以供快速标记，问号为就绪检查，X为清除标记。",

{
		var = "Raidshown",
		text = "团队标记",
		type = "checklist",
		cols = 2,
		options = {"显示框体", 'shown', "垂直显示", 'vertical',},
		
        getvalue = function()
            raid = {}
            raid['shown'] = wMarkerDB.shown;
			raid['vertical'] = wMarkerDB.vertical;
            return raid
        end,
		
		callback = function(cfg, v,loading)
			wMarkerDB.shown = v.shown;
			wMarker:visibility()
			
			wMarkerDB.vertical = v.vertical;
			wMarker:orien()
		end,
},	
{
		var = "worldRaido",
		text = "世界标记",
		type = "checklist",
		cols = 2,
		options = {"显示框体", 'shown', "垂直显示", 'vertical',},
		
        getvalue = function()
            raid = {}
            raid['shown'] = wFlaresDB.shown;
			raid['vertical'] = wFlaresDB.vertical;
            return raid
        end,
		
		callback = function(cfg, v,loading)
			wFlaresDB.shown = v.shown;
			wMarker:visibility()
			
			wFlaresDB.vertical = v.vertical;
			wFlares:orien()
		end,
},

})