-- $Id: BossTooltip.lua 4208 2013-05-08 09:12:06Z Bahnak $
function AtlasLoot_hook(tooltip)
	if not ALtooltipName then
		ALtooltipName = tooltip:GetUnit()
		local ALGUID = UnitGUID("mouseover")
		if ALGUID then
			ALunitID = tonumber((ALGUID):sub(6, 10), 16)
		end
	end

	if not UnitIsPlayer(ALtooltipName) and not UnitAffectingCombat("player") and AtlasLoot_Data and AtlasLoot.db.profile.ShowBossTooltip then

		if AtlasLoot_BossTooltipMatch[ALunitID] then
			ALtooltipName = AtlasLoot_BossTooltipMatch[ALunitID]
		elseif AtlasLoot_BossTooltipMatch[ALtooltipName] then
			ALtooltipName = AtlasLoot_BossTooltipMatch[ALtooltipName]
		end

		for ALindexBoss,ALvalueBoss in pairs(AtlasLoot_Data) do
			if ALvalueBoss.info then
				if ALvalueBoss.info.name == ALtooltipName then
					for ALindexWishlist,ALvalueWishlist in pairs(AtlasLootDB["namespaces"]["WishList"]["global"]["data"]["Normal"][GetRealmName()][GetUnitName("player")]) do
						local ALwishlistName = ALvalueWishlist["info"]["name"]
						if ALwishlistName == "" then
							ALwishlistName = "Default"
						end
						for ALindexWishlistItem,ALvalueWishlistItem in pairs(ALvalueWishlist[1]) do
							local ALbossHandle, ALitemDifficulty = strsplit("#", ALvalueWishlistItem[6])
							local _, _, ALdifficultyIndex = GetInstanceInfo()
							local ALinstanceDifficulty = "Normal"
							if ALdifficultyIndex == 2 or ALdifficultyIndex == 5 or ALdifficultyIndex == 6 then
								ALinstanceDifficulty = "Heroic"
							elseif ALdifficultyIndex == 7 then
								ALinstanceDifficulty = "RaidFinder"
							end
							if ALindexBoss == ALbossHandle and ALinstanceDifficulty == ALitemDifficulty then
								local ALitemName, _, ALitemQuality, _, _, _, _, _, ALequipSlot = GetItemInfo(ALvalueWishlistItem[2])
								if ALitemName and ALitemQuality and ALequipSlot then
									local _, _, _, ALhex = GetItemQualityColor(ALitemQuality)
									if ALequipSlot == "" then
										tooltip:AddLine(string.format("%s: |c%s%s|r", ALwishlistName, ALhex, ALitemName))
									else
										tooltip:AddLine(string.format("%s: |c%s%s|r (%s)", ALwishlistName, ALhex, ALitemName, _G[ALequipSlot]))
									end
								else
									tooltip:AddLine("|cffff0000Item not cached, try again|r")
								end
							end
						end
					end
					tooltip:Show()
					break
				end
			end
		end
	end
end


function AtlasLoot_update(tooltip)
	if not tooltip:GetUnit() and not tooltip:GetSpell() and not tooltip:GetItem() then
		local ALobjectName = getfenv(0)[tooltip:GetName()..'TextLeft1']:GetText()
		if ALlastTooltip == ALobjectName then
			ALtooltipName = nil
			return
		end
		ALlastTooltip = ALobjectName

		if AtlasLoot_BossTooltipMatch[ALobjectName] then
			ALtooltipName = AtlasLoot_BossTooltipMatch[ALobjectName]
			AtlasLoot_hook(tooltip)
		end
	end
end


function AtlasLoot_show(tooltip)
	ALlastTooltip = nil
	ALtooltipName = nil
end


if GameTooltip:GetScript("OnTooltipSetUnit") then
	GameTooltip:HookScript("OnTooltipSetUnit", AtlasLoot_hook)
	GameTooltip:HookScript("OnUpdate", AtlasLoot_update)
	GameTooltip:HookScript("OnShow", AtlasLoot_show)
	ALlastTooltip = nil
	ALtooltipName = nil
else
	GameTooltip:SetScript("OnTooltipSetUnit", AtlasLoot_hook)
	GameTooltip:SetScript("OnUpdate", AtlasLoot_update)
	GameTooltip:SetScript("OnUpdate", AtlasLoot_show)
	ALlastTooltip = nil
	ALtooltipName = nil
end