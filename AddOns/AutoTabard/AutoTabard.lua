--[[

**************************************************************************
AutoTabard
by evil.oz (blackoz@shadowsong.eu)


v1.971
-----
minor fixes for zhTW localisation, thanks again to zhTW

v1.97
-----
added zhTW localisation, thanks to.. erm.. user zhTW

v1.96
-----
now addon checks for special bags (enchanting, herbalism, mining... ) before storing tabard

v1.95
-----
added non heroic instances names (thanks to seaquake for some testing)
added german and french localization (need to test em all)
still have to check bahaviour in pre-cata instances

v1.94alpha
-----
lvl85 factions added (miss translation, instance names and check trigger mechanics)

v1.93
-----
french localization added (thanks to Ekhurr)

v1.92
-----
tabard id fix

v1.91 (unreleased)
-----
added Bilgewater Cartel and Gilneas (thanks to TonDef) 

v1.9
----
added 4.03 factions (miss all localization, need horde check)
removed icons from configuration

v1.83
----
fixed self/this syntax
4.01 compatible (hopefully)

v1.821
----
added french and german totc (untested)

v1.82
-----
added panel slash command (thx to networkerror)
added Trial of the Champion non-heroic instance (need translations)

v1.81
-----
toc update
minor bug on no rep found
replaced GetDungeonDifficultyID() function

v1.8
----
removed commandline and added ui-addon panel
added xp bar restore

v1.73
-----
added xp bar to track currently equipped tabard's faction

v1.72
-----
added french localisation - factions only, output is still english (thanks to sarcophilius)

v1.71
-----
localization fixes

v1.7 (unreleased beta)
----
added general localization system
added german localization. big thanks to Horelia@Teldrassil

v1.61
-----
added battleground raid check, should no more spam in bg group

v1.6
----
added exalted check, fixed bars 4 and 5 colors

v1.5
----
added non heroic lvl 80 dungeons
replaced ENTERING_WORLD with ZONE_CHANGED_NEW_AREA, check will occour more times, but more reliable

v1.4
----
fixed proper action when usual tabard is none

v1.3
----
restyle of the graphic frame

v1.2
----
bugfix when saved tabard status is lost during a ghost-run after dead in instance

v1.1
----
after exit from heroic, previous tabard is restored
bugfix for error msg when entering heroic with no tabard

v1.0
----
initial release


AutoTabard_RestoreHighlighFaction, AutoTabard_SavedHighlightFaction



**************************************************************************

]]--


-- #########################################################################################################
-- onload handler
-- #########################################################################################################
function AutoTabard_OnLoad(this)


	this:RegisterEvent("UPDATE_FACTION");
	this:RegisterEvent("PLAYER_LOGIN");
	this:RegisterEvent("PLAYER_REGEN_ENABLED");
	this:RegisterEvent("PLAYER_UNGHOST");
	this:RegisterEvent("ZONE_CHANGED_NEW_AREA");


	-- add the slash commands 
	
	SlashCmdList["AUTOTABARD"] = function(msg)
		AutoTabard_cmd(msg);
	end
	SLASH_AUTOTABARD1 = "/autotabard";
	
	AutoTabard_TabardNum = table.getn(AutoTabard_AllianceRepFactions)
	AutoTabard_InitWindow()


	AutoTabard_ExpandFactions()


	AutoTabard_panel=AutoTabard_Frame

        AutoTabard_panel.name = "自动战袍切换"
       
	AutoTabard_panel.okay = AutoTabard_PanelOk
        AutoTabard_panel.cancel =  AutoTabard_PanelCancel

	InterfaceOptions_AddCategory(AutoTabard_panel)


end

function AutoTabard_OnShow()
	
	AutoTabard_RedrawWindow()

end

function AutoTabard_OnEvent(event)
  
	if event=="PLAYER_LOGIN" then

		local englishFaction = UnitFactionGroup("player")
		local factionData
		
		if englishFaction=="Alliance" then
	                factionData = AutoTabard_AllianceRepFactions
		else
		        factionData = AutoTabard_HordeRepFactions
		end
		
		AutoTabard_RepFactions={}
		AutoTabard_RepTabards={}
		
		for n=1, table.getn(factionData) do
			table.insert (AutoTabard_RepFactions, factionData[n][1])
			table.insert (AutoTabard_RepTabards, factionData[n][2])
		end
			
	end

	if event=="UPDATE_FACTION" then
		if AutoTabard_Frame:IsVisible() then
			AutoTabard_RedrawWindow()
		end
	end

	if (event=="PLAYER_UNGHOST") or (event == "ZONE_CHANGED_NEW_AREA") then

		local inInstance, instanceType = IsInInstance()
		-- instanceType: "none" "pvp" "arena" "party" "raid"

		AutoTabard_inInstance =  inInstance and (instanceType  == "party") --and (AutoTabard_IsRepInstance())
		
		if UnitIsGhost("player") ~= 1 then
			if AutoTabard_inInstance then
				AutoTabard_Print(AutoTabard_ENTERINGLVL80DUNGEON);
				AutoTabard_CheckTabard()
			else
				--restore / remove tabard
				if AutoTabard_SavedTabard then
					-- there is a saved status , created upon autoequip of tabard
					if (AutoTabard_SavedTabard=="EMPTY SLOT") then
						AutoTabard_Print(AutoTabard_REMOVINGTABARD);
						AutoTabard_RemoveTabard()
						AutoTabard_SavedTabard=nil
					else
						AutoTabard_Print(string.format(AutoTabard_REEQUIPPING,AutoTabard_SavedTabard));
						EquipItemByName(AutoTabard_SavedTabard) 
						AutoTabard_SavedTabard=nil
					end
				end

				--restore / remove rep tracking
				if AutoTabard_RestoreHighlightFaction and AutoTabard_SavedHighlightFaction then
					SetWatchedFactionIndex(AutoTabard_SavedHighlightFaction)
					AutoTabard_SavedHighlightFaction=nil
				end
			end
		end
	end

	if (event == "PLAYER_REGEN_ENABLED") then
		if AutoTabard_inInstance then
			AutoTabard_CheckTabard()	
		end
	end

end

function AutoTabard_IsRepInstance()

	if (GetDungeonDifficultyID() == 2)  then
		--heroic
		return true
	else
		local n, value
		local z=GetRealZoneText()

		value=false
		for n=1, table.getn(AutoTabard_ValidNonHeroics) do
			if (AutoTabard_ValidNonHeroics[n]==z) then
				value=true
				break
			end
		end
		return value
	end
end


function AutoTabard_CheckTabard()

	--AutoTabard_ExpandFactions()

	local itemname, itemId
	local equippedTabard=GetInventoryItemLink("player",GetInventorySlotInfo("TabardSlot"))
	
	if equippedTabard then
		local linkType, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId 
		linkType, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":", equippedTabard)
		itemName = GetItemInfo(equippedTabard) 
	else
		itemId=0
		itemName = "EMPTY SLOT"
	end
	
	local n

	if AutoTabard_DesiredFaction then
		for n=1,AutoTabard_TabardNum-1 do
			if (AutoTabard_DesiredFaction==AutoTabard_RepFactions[n]) then
				-- n is the name of the FACTION selected for farming

				--check if exalted

				local desiredfactionIndex
				local isExalted=false
				local watchedFaction

				for factionIndex = 1, GetNumFactions() do
					local name, _, _, _, _, earnedValue = GetFactionInfo(factionIndex)						
					if name==AutoTabard_DesiredFaction then
						desiredfactionIndex=factionIndex
						if earnedValue==42999 then
							AutoTabard_Print(string.format(AutoTabard_FULLYEXALTED , name))
							isExalted=true
						end
						break
					end
				end

				if AutoTabard_HighlightFaction and desiredfactionIndex then
					--we choosed to set this as our new watched rep
					

					-- save the currently watched info 
					AutoTabard_SavedHighlightFaction = 0
					watchedFaction = GetWatchedFactionInfo()

					-- recover ID and save ID instead
					for factionIndex = 1, GetNumFactions() do
						local name = GetFactionInfo(factionIndex)						
						if name==watchedFaction then
							AutoTabard_SavedHighlightFaction=factionIndex 						
							break
						end
					end

					SetWatchedFactionIndex(desiredfactionIndex)
				end
				
				if (itemId==AutoTabard_RepTabards[n]) then
					--equipped tabard is the one we need

				else
					--equipped tabard is NOT the one we need
					--equip only if not yet exalted 
					if not isExalted then
						local TabardName = GetItemInfo(AutoTabard_RepTabards[n]);

                        if TabardName then
                            if GetItemCount(TabardName)==0 then
                                AutoTabard_Print(string.format(AutoTabard_TABARDNOTFOUND, TabardName ))
                            else
                                AutoTabard_Print(string.format(AutoTabard_EQUIPPING, TabardName))
                                EquipItemByName(TabardName)
                                AutoTabard_SavedTabard=itemName
                            end
                        end
					end
				end
				break
			end
		end

	end

end







function AutoTabard_RemoveTabard()

	-- slots=GetContainerNumFreeSlots(n)
	-- where n is
	-- 0 - Backpack
	-- 1 - Bag 1
	-- 2 - Bag 2
	-- 3 - Bag 3
	-- 4 - Bag 4


	local n
	local found=false

	for n=4,0,-1 do

		if not found then
			local slots,bagType=GetContainerNumFreeSlots(n) 

			--AutoTabard_Print("bag "..n..": "..slots.." free slots")
			if (slots >0) and (bagType==0) then
	
				ClearCursor()
				local slotId= GetInventorySlotInfo("TabardSlot")
				PickupInventoryItem(slotId) 
	
				if n==0 then
					--AutoTabard_Print("bag "..n..": storing in backpack")
					PutItemInBackpack()
				else
					--AutoTabard_Print("bag "..n..": storing in slot "..19+n)
					PutItemInBag(19+n) 
				end
				found=true
			end
		end
	end

	if not found then
		AutoTabard_Print(AutoTabard_NOSPACE)
	end

end

function AutoTabard_Click(b1, b2)

	local ButtonNumber=tonumber(string.sub(b1:GetName(), 17))
      
	if ButtonNumber==AutoTabard_TabardNum then

		AutoTabard_DesiredFaction=nil
		AutoTabard_Print(string.format(AutoTabard_NOWCONFIGUREDFORAV, AutoTabard_RepFactions[AutoTabard_TabardNum]))
	else
		AutoTabard_DesiredFaction=AutoTabard_RepFactions[ButtonNumber]
		AutoTabard_Print(string.format(AutoTabard_NOWCONFIGUREDFOR, AutoTabard_DesiredFaction))
		
		local TabardName = GetItemInfo(AutoTabard_RepTabards[ButtonNumber]);
		
		if TabardName then
			if GetItemCount(TabardName)==0 then
				AutoTabard_Print("|CFFFF0000"..string.format(AutoTabard_TABARDNOTFOUND2, TabardName))
			end
		else
			AutoTabard_Print("|CFFFF0000"..string.format(AutoTabard_TABARDNOTFOUND2, "战袍<"..AutoTabard_RepFactions[ButtonNumber]..">"))
		end
	end
	
	AutoTabard_RedrawWindow()
end


function AutoTabard_HighlightClick(obj)

	AutoTabard_HighlightFaction = (obj:GetChecked()==1)
	AutoTabard_RedrawWindow()

end

function AutoTabard_RestoreHighlightClick(obj)

	AutoTabard_RestoreHighlightFaction = (obj:GetChecked()==1)
	AutoTabard_RedrawWindow()

end
	
function AutoTabard_ShowTooltip(obj)
	
	local a
	a=obj:GetName()

	if a=="AutoTabard_Highlight" then
		GameTooltip:SetOwner(obj, "ANCHOR_RIGHT");
		GameTooltip:SetText(AutoTabard_TOOLTIPTEXT1, 1, 1, 1, 1, 1);
		GameTooltip:Show();
	end

	if a=="AutoTabard_RestoreHighlight" then
		GameTooltip:SetOwner(obj, "ANCHOR_RIGHT");
		GameTooltip:SetText(AutoTabard_TOOLTIPTEXT2, 1, 1, 1, 1, 1);
		GameTooltip:Show();
	end

end

function AutoTabard_HideTooltip(obj)

		GameTooltip:Hide();
end


function AutoTabard_cmd(msg)

	
	InterfaceOptionsFrame_OpenToCategory(AutoTabard_panel)

end

function AutoTabard_InitWindow()
	
	local relativeTo=AutoTabard_OptionsTitle
	
	for n = 1, AutoTabard_TabardNum do
		
		local name="AutoTabard_Frame"..n
			
		local newFrame = CreateFrame("Frame", name, AutoTabard_Frame, "AutoTabard_FrameTemplate" );
		newFrame:SetPoint("TOPLEFT", relativeTo, 0, -20);

		relativeTo=newFrame
	end		
	
end

function AutoTabard_RedrawWindow()

	AutoTabard_ExpandFactions()

	local factionIndex, rep
	local barWidth


	barWidth = 177 -- 180-3


        for n=1,AutoTabard_TabardNum do
		
		getglobal("AutoTabard_Frame"..n.."Label"):SetText("|CFFFFFFFF"..AutoTabard_RepFactions[n])
                getglobal("AutoTabard_Frame"..n.."BarLabel"):SetText(AutoTabard_NOTFOUND)
        	
		for factionIndex = 1, GetNumFactions() do

			local name, _, _, _, _, earnedValue = GetFactionInfo(factionIndex)
	        
			if (name==AutoTabard_RepFactions[n]) then
			
				local text, rep, max, verboseName, color = AutoTabard_ConvertRep(earnedValue)
				
				getglobal("AutoTabard_Frame"..n.."BarTexture"):SetWidth(barWidth*(rep/max))
				getglobal("AutoTabard_Frame"..n.."BarTexture"):SetTexture(AutoTabard_HexToRGB(color))
				getglobal("AutoTabard_Frame"..n.."BarLabel"):SetText(text)
			end
		end

		local control=getglobal("AutoTabard_Frame"..n)
		local background=getglobal("AutoTabard_Frame"..n.."Color")

		if (AutoTabard_DesiredFaction) and (AutoTabard_RepFactions[n]==AutoTabard_DesiredFaction) then
			background:SetTexture(0.1,0.1,0.1,1)
			control:SetBackdropBorderColor(1,1,1,1)
			control:SetAlpha(1)
		else 
			background:SetTexture(0,0,0,1)
			control:SetBackdropBorderColor(0.8,0.8,0.8,0.5)
			control:SetAlpha(0.4)
		end
			
	end

	local control=getglobal("AutoTabard_Frame"..AutoTabard_TabardNum)
	local background=getglobal("AutoTabard_Frame"..AutoTabard_TabardNum.."Color")

	if (not AutoTabard_DesiredFaction) then
		background:SetTexture(0.1,0.1,0.1,1)
		control:SetBackdropBorderColor(1,1,1,1)
		control:SetAlpha(1)
	else 
		background:SetTexture(0,0,0,0)
		control:SetBackdropBorderColor(0.8,0.8,0.8,0.5)
		control:SetAlpha(0.4)
	end

	AutoTabard_Highlight:SetChecked(AutoTabard_HighlightFaction)
	AutoTabard_RestoreHighlight:SetChecked(AutoTabard_RestoreHighlightFaction)

	AutoTabard_HighlightLabel:SetText(AutoTabard_CHECK1TEXT)

	if AutoTabard_HighlightFaction then
		AutoTabard_RestoreHighlight:Enable()
		AutoTabard_RestoreHighlightLabel:SetText(AutoTabard_CHECK2TEXT)
	else
		AutoTabard_RestoreHighlight:Disable()
		AutoTabard_RestoreHighlightLabel:SetText("|C40404040"..AutoTabard_CHECK2TEXT)
	end

end

function AutoTabard_ExpandFactions()

	for factionIndex = 1, GetNumFactions() do
		local name, _, _, _, _, _, _, _, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)

		if isHeader and isCollapsed then
			ExpandFactionHeader(factionIndex)
		end
	end

end

function AutoTabard_ConvertRep(value)

	local text, rep, max, verboseName, color

	rep=0
	max=0
	verboseName="无"
	color="808080"

	
	if (value>1) and (value<3000) then 
		rep=value
		max=3000
		verboseName="中立"
		color="A68818"
	end
	if (value>2999) and (value<9000) then 
		rep=value-3000
		max=6000
		verboseName="友善"
		color="777601"
	end
	if (value>8999) and (value<21000) then 
		rep=value-9000
		max=12000
		verboseName="尊敬"
		color="567601"
	end
	if (value>20999) and (value<42000) then 
		rep=value-21000
		max=21000
		verboseName="崇敬"
		color="237801"
	end
	if (value>41999) then 
		rep=value-42000
		max=1000
		verboseName="崇拜"
		color="007662"
	end

	text="|cFFFFFFFF"..verboseName.." ("..rep.."/"..max..")" 

	

	return text, rep, max, verboseName, color

end

function AutoTabard_HexToRGB(hex)
	local rhex, ghex, bhex = string.sub(hex, 1, 2), string.sub(hex, 3, 4), string.sub(hex, 5, 6)
	return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255
end



-- #########################################################################################################
-- misc service functions
-- #########################################################################################################
function AutoTabard_Print(str)

	if str then
		str="[自动战袍] |CFFFFFFFF"..str
	end

	DEFAULT_CHAT_FRAME:AddMessage(str, 1.0, 1.0, 0.0);

end



function AutoTabard_Message(msg)
	UIErrorsFrame:AddMessage(msg, 1.0, 0, 0, 1.0, 1);
end