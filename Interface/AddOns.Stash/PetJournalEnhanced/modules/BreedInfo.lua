BreedInfo = PetJournalEnhanced:NewModule("BreedInfo")
local BreedData = PetJournalEnhanced:GetModule("BreedData")
local _
local EMPTY_PET = "0x0000000000000000"

function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

local function clamp(num,minVal,maxVal)
	return math.min(math.max(num,minVal),maxVal)
end

--/run BreedInfo:GetBreed(PetJournalPetCard.petID)
function BreedInfo:GetBreed(petID)
	if not petID or petID == EMPTY_PET then return 0,10 end
	
	local speciesID, _, level, _, _, _,_ ,_, _, _, _, _, _, _, canBattle = C_PetJournal.GetPetInfoByPetID(petID)
	
	if not canBattle then return 0,10 end
	local health, _, power, speed, rarity = C_PetJournal.GetPetStats(petID)
	
	local baseStatsIndex = BreedData.speciesToBaseStatProfile[speciesID]
	if not baseStatsIndex then return -1,10 end
	
	local baseStats = BreedData.baseStatsProfiles[baseStatsIndex]

	local breedBonusPerLevel = {
		clamp(round((((health-100)/5) / BreedData.qualityMultiplier[rarity]) - level*baseStats[1],1)/level,0,2),
		clamp(round((power / BreedData.qualityMultiplier[rarity]) - level*baseStats[2],1)/level,0,2),
		clamp(round((speed / BreedData.qualityMultiplier[rarity]) - level*baseStats[3],1)/level,0,2),
	}

	local minDiff = {100000,100000,100000}
	local index = 0
	for i=1, #BreedData.breeds do
		local diff = {math.abs(breedBonusPerLevel[1] - BreedData.breeds[i][1]),math.abs(breedBonusPerLevel[2] - BreedData.breeds[i][2]),math.abs(breedBonusPerLevel[3] - BreedData.breeds[i][3])}
		--print("a",unpack(a))
		if minDiff[1] >= diff[1] and minDiff[2] >= diff[2] and minDiff[3]>= diff[3] then
			minDiff = diff
			index = i
		end
	end

	local confidence = round(minDiff[1] + minDiff[2]+ minDiff[3],2)
	
	return index,confidence
end

function BreedInfo:GetName(index,confidence)
	assert(type(index)=="number" and type(confidence)=="number")
	
	local color = self:GetColor(confidence)
	
	if index >= 1 and index <= #BreedData.breeds then return color..tostring(BreedData.breeds[index][4]).."|r" end
	if index == -1 then return "|cff888888No Data|r" end
	return ""
	
end

function BreedInfo:GetColor(confidence)
	assert(type(confidence)=="number")
	
	local color = "|cffffcc00"
	if confidence > .15 then
		color = "|cff888888"
	end
	return color
end

--/run print(BreedInfo:Extrapolate(PetJournalPetCard.petID,10))
function BreedInfo:Extrapolate(petID,targetLevel)
	if not petID or petID == EMPTY_PET then return 0,0,0,10 end
	local breedIndex, confidence = self:GetBreed(petID)
	if breedIndex <= 0 then return 0,0,0,0,breedIndex,confidence end
	
	local speciesID = C_PetJournal.GetPetInfoByPetID(petID)
	local _, _, _, _, rarity = C_PetJournal.GetPetStats(petID)
	local baseStatsIndex = BreedData.speciesToBaseStatProfile[speciesID]
	local baseStats = BreedData.baseStatsProfiles[baseStatsIndex]
	
	local multiplier = BreedData.qualityMultiplier[rarity]
	local breedStatus = BreedData.breeds[breedIndex]
	
	local health = round(100 + ((baseStats[1] + breedStatus[1]) * 5 * multiplier) * targetLevel)
	local power = round( (baseStats[2] + breedStatus[2])  * multiplier * targetLevel) 
	local speed = round( (baseStats[3] + breedStatus[3])  * multiplier * targetLevel)
	
	return health, power , speed, breedIndex,confidence
end