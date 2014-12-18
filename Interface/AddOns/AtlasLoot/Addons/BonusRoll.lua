local AtlasLoot = _G.AtlasLoot
local BonusRoll = {}
AtlasLoot.Addons.BonusRoll = BonusRoll
local QLF = AtlasLoot.GUI.QuickLootFrame
local AL = AtlasLoot.Locales

-- lua
local match = string.match

-- DB
-- /run BonusRollFrame_StartBonusRoll(145917, "", 180, 738)
-- [BonusRollID] = "tierID:instanceID:encounterID"		<- new
local BONUS_ROLL_IDS = {
	-- ### MoP
	-- Mogu
	[125144] = "5:317:679",		-- The Stone Guard
	[132189] = "5:317:689",		-- Feng
	[132190] = "5:317:685",		-- Garajal
	[132191] = "5:317:687",		-- Spirit Kings
	[132192] = "5:317:726",		-- Elegon
	[132193] = "5:317:677",		-- Will of the Emperor
	-- HoF
	[132194] = "5:330:745",		-- Zorlok
	[132195] = "5:330:744",		-- Tayak
	[132196] = "5:330:713",		-- Garalon
	[132197] = "5:330:741",		-- Meljarak
	[132198] = "5:330:737",		-- Unsok
	[132199] = "5:330:743",		-- Shekzeer
	-- ToES
	[132200] = "5:320:683",		-- Protectors
	[132201] = "5:320:742",		-- Tsulong
	[132202] = "5:320:729",		-- LeiShi
	[132203] = "5:320:709",		-- ShaofFear
	-- ToT
	[139674] = "5:362:827",		-- Jinrokh
	[139677] = "5:362:819",		-- Horridon
	[139679] = "5:362:816",		-- Council
	[139680] = "5:362:825",		-- Tortos
	[139682] = "5:362:821",		-- Megaera
	[139684] = "5:362:828",		-- JiKun
	[139686] = "5:362:818",		-- Durumu
	[139687] = "5:362:820",		-- Primordius
	[139688] = "5:362:824",		-- Dark Animus
	[139689] = "5:362:817",		-- Iron Qon
	[139690] = "5:362:829",		-- Twin Consorts
	[139691] = "5:362:832",		-- Lei Shen
	[139692] = "5:362:831",		-- Raden
	-- SoO
	[145909] = "5:369:852",		-- Immerseus
	[145910] = "5:369:849",		-- Fallen Protectors
	[145911] = "5:369:866",		-- Norushen
	[145912] = "5:369:867",		-- Sha of Pride
	[145913] = "5:369:868",		-- Galakras
	[145914] = "5:369:864",		-- Iron Juggernaut
	[145915] = "5:369:856",		-- Dark Shaman
	[145916] = "5:369:850",		-- General Nazgrim
	[145917] = "5:369:846",		-- Malkorok
	[145918] = "5:369:865",		-- Siegecrafter Blackfuse
	[145919] = "5:369:870",		-- Spoils of Pandaria
	[145920] = "5:369:851",		-- Thok the Bloodthirsty
	[145921] = "5:369:853",		-- Klaxxi Paragons
	[145922] = "5:369:869",		-- Garrosh Hellscream
	-- Pandaria
	[132205] = "5:322:858",		-- Sha of Anger
	[132206] = "5:322:725",		-- Galleon
	[136381] = "5:322:814",		-- Nalak
	[137554] = "5:322:826",		-- Oondasta
	[148316] = "5:322:861",		-- Ordos
	[148317] = "5:322:857",		-- Celestials	( 857 - ChiJi, 858 - YuLon, 859 - NioZao, 859 - Xuen )
	
	-- ### WoD
	-- BlackrockFoundry
	[177529] = "6:457:1161",		-- Gruul
	[177530] = "6:457:1202",		-- Oregorger
	[177536] = "6:457:1122",		-- Beastlord Darmac
	[177534] = "6:457:1123",		-- Flamebender Ka'graz
	[177533] = "6:457:1155",		-- Hans'gar & Franzok
	[177537] = "6:457:1147",		-- Operator Thogar
	[177531] = "6:457:1154",		-- Blast Furnace
	[177535] = "6:457:1162",		-- Kromog
	[177538] = "6:457:1203",		-- The Iron Maidens
	[177539] = "6:457:959",			-- Blackhand
	-- Highmaul
	[177521] = "6:477:1128",		-- Kargath Bladefist
	[177522] = "6:477:971",			-- Butcher
	[177523] = "6:477:1195",		-- Tectus
	[177524] = "6:477:1196",		-- Brackenspore
	[177525] = "6:477:1148",		-- Twin Ogron
	[177526] = "6:477:1153",		-- Ko'ragh
	[177528] = "6:477:1197",		-- Imperator Mar'gok
	-- Draenor
	[178847] = "6:557:1291",		-- Drov the Ruiner
	[178851] = "6:557:1262",		-- Rukhmar
	[178849] = "6:557:1211",		-- Tarlna the Ageless
	
}

local function LoadQuickLootFrame(self)
	if AtlasLoot.db.Addons.BonusRoll.enabled and self.spellID and BONUS_ROLL_IDS[self.spellID] then
		local tierID, instanceID, encounterID = string.split(":", BONUS_ROLL_IDS[self.spellID])
		QLF:SetEncounterJournalBonusRoll(tonumber(tierID), GetRaidDifficultyID() or 1, tonumber(instanceID), tonumber(encounterID))
	end
end
--/run LoadQuickLootFrame({spellID = 145909})
local function ClearQuickLootFrame(self)
	if AtlasLoot.db.Addons.BonusRoll.enabled then
		QLF:Clear()
		QLF:Hide()
	end
end
BonusRollFrame:HookScript("OnShow", LoadQuickLootFrame)
BonusRollFrame:HookScript("OnHide", ClearQuickLootFrame)

function BonusRoll:Test()
	QLF:SetEncounterJournalBonusRoll(tonumber(tierID), GetRaidDifficultyID() or 1, tonumber(instanceID), tonumber(encounterID))
end
--[[
/run BonusRollFrame_StartBonusRoll(145922, "", 180)
function BonusRollFrame_OnEvent(self, event, ...)
	if ( event == "BONUS_ROLL_FAILED" ) then
		self.state = "finishing";
		self.rewardType = nil;
		self.rewardLink = nil;
		self.rewardQuantity = nil;
		self.rewardSpecID = nil;
		self.RollingFrame.LootSpinner:Hide();
		self.RollingFrame.LootSpinnerFinal:Hide();
		self.FinishRollAnim:Play();
	elseif ( event == "BONUS_ROLL_STARTED" ) then
		self.state = "rolling";
		self.animFrame = 0;
		self.animTime = 0;
		PlaySoundKitID(31579);	--UI_BonusLootRoll_Start
		--Make sure we don't keep playing the sound ad infinitum.
		if ( self.rollSound ) then
			StopSound(self.rollSound);
		end
		local _, soundHandle = PlaySoundKitID(31580);	--UI_BonusLootRoll_Loop
		self.rollSound = soundHandle;
		self.RollingFrame.LootSpinner:Show();
		self.RollingFrame.LootSpinnerFinal:Hide();
		self.StartRollAnim:Play();
	elseif ( event == "BONUS_ROLL_RESULT" ) then
		local rewardType, rewardLink, rewardQuantity, rewardSpecID = ...;
		self.state = "slowing";
		self.rewardType = rewardType;
		self.rewardLink = rewardLink;
		self.rewardQuantity = rewardQuantity;
		self.rewardSpecID = rewardSpecID;
		self.StartRollAnim:Finish();
	elseif ( event == "PLAYER_LOOT_SPEC_UPDATED" ) then
		local specID = GetLootSpecialization();
		if ( specID and specID > 0 ) then
			local id, name, description, texture, background, role, class = GetSpecializationInfoByID(specID);
			self.SpecIcon:SetTexture(texture);
			self.SpecIcon:Show();
			self.SpecRing:Show();
		else
			self.SpecIcon:Hide();
			self.SpecRing:Hide();
		end
	elseif ( event == "BONUS_ROLL_DEACTIVATE" ) then
		self.PromptFrame.RollButton:Disable();
	elseif ( event == "BONUS_ROLL_ACTIVATE" ) then
		if ( self.state == "prompt" ) then
			self.PromptFrame.RollButton:Enable();
		end
	end
end




eventFrame:RegisterEvent("SPELL_CONFIRMATION_PROMPT")		-- Bonus roll startet 		( SPELL_CONFIRMATION_PROMPT 145910 1  180 776 )

spellID 
Number - Spell ID for the Confirmation Prompt Spell. These are very specific spells that only appear during this event.
confirmType 
Number - The possible values for this are not entirely known, however, 1 does seem to be the confirmType when the prompt triggers a bonus roll.
text 
String - So far, I've only seen this value be a blank string of "". Presumably, it will contain text if text is needed, but with bonus rolls, it is not needed.
duration 
Number - This number is in seconds. Typically, it is 180 seconds.
currencyID 
Number - The ID of the currency required if the prompt requires a currency (it does for bonus rolls).

eventFrame:RegisterEvent("SPELL_CONFIRMATION_TIMEOUT")		-- Bonus roll pass/timeout	( SPELL_CONFIRMATION_TIMEOUT 145910 1 )
eventFrame:RegisterEvent("BONUS_ROLL_STARTED")
eventFrame:RegisterEvent("BONUS_ROLL_FAILED")
eventFrame:RegisterEvent("BONUS_ROLL_RESULT")
]]