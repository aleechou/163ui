local Data={}
local WatchEnable = false

local Whookfunction = function(fname,func)
	local Tempfunc = C_PetBattles[fname]
	C_PetBattles[fname] = function(...)
		if WatchEnable then
			return func(...)
		else
			return Tempfunc(...)
		end
	end
end


local SendM = function(data)
	SendAddonMessage("WatchPVP",data,"PARTY")
end

--~ C_PetBattles.GetTurnTimeInfo()


Whookfunction("GetNumPets",function(petOwner)
	local result = 0
	for petIndex = 1, 3 do
		local pets = Data[petOwner][petIndex]
		if pets and pets.SpeciesID ~= 0 then
			result = result +1
		end
	end
	return result
--~ 	return #Data[petOwner] or 0
end)

---------属性
Whookfunction("GetPetSpeciesID",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	if not pets then return 0 end
	return pets.SpeciesID or 0
end)
Whookfunction("GetIcon",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	local SpeicesID = pets.SpeciesID
	if SpeicesID ~= 0 then
		local icon = select(2,C_PetJournal.GetPetInfoBySpeciesID(SpeicesID))
		return icon
	end
end)
Whookfunction("GetPetType",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	local speicesID = pets.SpeciesID
	if speicesID ~= 0 then
		local PetType = select(3,C_PetJournal.GetPetInfoBySpeciesID(speicesID))
		return PetType
	end
end)
Whookfunction("GetName",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	local SpeicesID = pets.SpeciesID
	if SpeicesID ~= 0 then
		local name = select(1,C_PetJournal.GetPetInfoBySpeciesID(SpeicesID))
		if pets.SpeciesName=="" then
			return name ,name
		end
		return pets.SpeciesName, name
	end
end)
Whookfunction("GetBreedQuality",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	if not pets then return 0 end
	return pets.b or 0
end)
Whookfunction("GetMaxHealth",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	if not pets then return 0 end
	return pets.m or 0
end)
Whookfunction("GetHealth",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	if not pets then return 0 end
	return pets.h or 0
end)
Whookfunction("GetPower",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	if not pets then return 0 end
	return pets.p or 0
end)
Whookfunction("GetSpeed",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	if not pets then return 0 end
	return pets.s or 0
end)
Whookfunction("GetLevel",function(petOwner, petIndex)local pets = Data[petOwner][petIndex]
	if not pets then return 0 end
	return pets.l or 0
end)
Whookfunction("GetActivePet",function(petOwner)
	return Data[petOwner].ActivePet
end)
---------全局
Whookfunction("IsPlayerNPC",function(petOwner)
	return nil
end)
---------技能
Whookfunction("GetAbilityInfo",function(petOwner, petIndex, i)local pets = Data[petOwner][petIndex]
	local speicesID = pets.SpeciesID
	if speicesID == 0 then return end
	local abilities = C_PetJournal.GetPetAbilityList(speicesID)
	return C_PetBattles.GetAbilityInfoByID(pets["a"..i] or abilities[i])
end)
Whookfunction("GetAbilityState",function(petOwner, petIndex, i)local pets = Data[petOwner][petIndex]
	return true,0,0
end)
---------buff
Whookfunction("GetNumAuras",function(petOwner, petIndex, i)local pets = Data[petOwner][petIndex]
	if not pets.Auras then return end
	local result = 0
	for _,v in pairs(pets.Auras) do
		if v and v.id ~= 0 then
			result = result +1
		end
	end
	return result
--~ 	return #pets.Auras
end)

Whookfunction("GetAuraInfo",function(petOwner, petIndex, i)local pets = Data[petOwner][petIndex]
	local buffinfo = pets.Auras[i]
	if buffinfo.id and buffinfo.id~=0 then
		return buffinfo.id,buffinfo.instanceID,buffinfo.turn,buffinfo.isBuff
	else
		return nil
	end
end)



local tempdata={
	doing = "",
	buffinfo="",
	petinfoA="",
	petinfoE="",
}
---更新数据		--后面接上 PetBattleFrame_Display(PetBattleFrame) 来刷新界面.
local WUpdate=function(data)
	if not WatchEnable then return end
	if data:sub(10,12) ~= "End" then
		if data:sub(1,8) == "petinfoA" or tempdata.doing == "petinfoA" then
			tempdata.doing = "petinfoA"
			tempdata.petinfoA = tempdata.petinfoA..data
		end
		if data:sub(1,8) == "petinfoE" or tempdata.doing == "petinfoE" then
			tempdata.doing = "petinfoE"
			tempdata.petinfoE = tempdata.petinfoE..data
		end
		return
	end
	local ActivePet,pet1,pet2,pet3 = 3,4,5,6
	if tempdata.doing:find("petinfoA") then
		local e=tempdata[tempdata.doing]
		e=e:gsub(tempdata.doing..":","")
		local tempet = {e:find("(.*)-(.*)-(.*)-(.*)")}
		Data[1].ActivePet = tonumber(tempet[ActivePet])
		for i=1+3,3+3 do
			if tempet[i] and tempet[i]~="" then
				local s=Data[1][i-3]
				s.SpeciesID,s.m,s.h,s.p,s.s,s.l,s.b,s.SpeciesName,s.a1,s.a2,s.a3 = strsplit(":",tempet[i])
				s.m = tonumber(s.m);s.h = tonumber(s.h);s.p = tonumber(s.p)
				s.s = tonumber(s.s);s.l = tonumber(s.l);s.b = tonumber(s.b)
			end
		end
		if PetBattleFrame:IsShown() then
			PetBattleFrame_Display(PetBattleFrame)
		end
	end
	if tempdata.doing:find("petinfoE") then
		local e=tempdata[tempdata.doing]
		e=e:gsub(tempdata.doing..":","")
		local tempet = {e:find("(.*)-(.*)-(.*)-(.*)")}
		Data[2].ActivePet = tonumber(tempet[ActivePet])
		for i=1+3,3+3 do
			if tempet[i] and tempet[i]~="" then
				local s=Data[2][i-3]
				s.SpeciesID,s.m,s.h,s.p,s.s,s.l,s.b,s.SpeciesName,s.a1,s.a2,s.a3 = strsplit(":",tempet[i])
				s.m = tonumber(s.m);s.h = tonumber(s.h);s.p = tonumber(s.p)
				s.s = tonumber(s.s);s.l = tonumber(s.l);s.b = tonumber(s.b)
			end
		end
		if PetBattleFrame:IsShown() then
			PetBattleFrame_Display(PetBattleFrame)
		end
	end
	tempdata[tempdata.doing]=""
	tempdata.doing=""
--[[
--~ 	if str == "buffinfo" then
--~ 		for key,values in string.gmatch(datas, "([%w+,]+):([%w+,]+)") do
--~ 			local _,_,v1,v2,v3 = string.find(key,"(%w+),(%w+),(%w+)")

--~ 			local _,_,k1,k2,k3,k4,k5,k6,k7,k8 = string.find(values,"(%w+),(%w+),(%w+),(%w+)")
--~ 			Data[v1][v2]["Auras"][v3]={
--~ 				id = k1, instanceID = k2, turn = k3, isBuff = k4,
--~ 			}
--~ 		end
--~ 	end

--~ 	if str == "petinfoA" then
--~ 		local _,_,frame,values = string.find(datas,"(%w+)|(.+)")
--~ 		datas[1].Frame=frame
--~ 		for key,value in string.gmatch(values,"([%w+,]+):([%w+,]+)") do
--~ 			local _,_,v1,v2 = string.find(key,"(%w+),(%w+)")
--~ 			local _,_,k1,k2,k3,k4,k5,k6,k7,k8,k9,k10,k11 = string.find(values,"(%w+),(%w+),(%w+),(%w+),(%w+),(%w+),(%w+),(%w+),(%w+),(%w+),(%w+)")
--~ 			local s=Data[v1][v2]
--~ 			s.m,s.h,s.p,s.s,s.l,s.b,s.Species,s.SpeciesName,s.a=k1,k2,k3,k4,k5,k6,k7,k8,{k9,k10,k11}
--~ 		end
--~ 	end
--]]
end




local GetBuffInfo=function(petOwner,petIndex)
	local result
	local tabs = {C_PetBattles.GetAuraInfo(0,0,1)}
	result = table.concat(tabs,",")	----0,0,0:1115,1111,10,true
	for k=1,2 do
		for j=0,3 do
			for i=1, C_PetBattles.GetNumAuras(k,j) do
				result = result.."|"..table.concat({C_PetBattles.GetAuraInfo(1,0,i)})
			end
		end
	end

	for i = 0, ceil(#result/235) - 1 do
		SendM("buffinfo:"..string.sub(SendStringS, i*235 + 1, 235))
	end
	SendM("buffinfo:End")
end

local D={}
D[1]="Ally";D[2]="Enemy";

local GetPetInfoA=function()
	if not C_PetBattles.IsInBattle() then return end
	for j = 1, 2 do
		local result = C_PetBattles.GetActivePet(j)
		for i = 1, 3 do
			local speciesid = C_PetBattles.GetPetSpeciesID(j,i)
				result = result.."-"..(speciesid or "")
			if speciesid then
				result = result..":"..C_PetBattles.GetMaxHealth(j,i) or ""
				result = result..":"..C_PetBattles.GetHealth(j,i) or ""
				result = result..":"..C_PetBattles.GetPower(j,i) or ""
				result = result..":"..C_PetBattles.GetSpeed(j,i) or ""
				result = result..":"..C_PetBattles.GetLevel(j,i) or ""
				result = result..":"..C_PetBattles.GetBreedQuality(j,i) or ""
				local name1,name2 = C_PetBattles.GetName(j,i)
				result = result..":"..(name1~=name2 and name1 or "")
				result = result..":"..(C_PetBattles.GetAbilityInfo(j,i,1) or 0)
				result = result..":"..(C_PetBattles.GetAbilityInfo(j,i,2) or 0)
				result = result..":"..(C_PetBattles.GetAbilityInfo(j,i,3) or 0)
			end
		end

		for i = 0, ceil(#result/235) - 1 do
			SendM("petinfo"..string.sub(D[j],1,1)..":"..string.sub(result, i*235 + 1, 235))
		end
		SendM("petinfo"..string.sub(D[j],1,1)..":End")
	end
end



---接收
local Request=function(datas)
	local _,_,str=string.find(datas,"(%w+:)")
	local data=string.sub(datas,#str+1)
	if data ~= "End" then
		tempdata[str]=tempdata[str]..data
	else
		WUpdate(str,tempdata[str])
		tempdata[str]=""
	end

end

---------Hook C_PetBattles



Data={
	[0]={
		[0]={
			Auras={
				[1]={
					id=0,
					instanceID=0,
					turn=0,
					isBuff=0,
				}
			},
		--...
		}
	},
	[1]={	--Ally
		ActivePet=1,
		[0]={
			Auras={
				[1]={
					id=0,
					instanceID=0,
					turn=0,
					isBuff=0,
				},
			--...
			}
		},
		[1]={
			m = 1263,
			h = 860,
			p = 276,
			s = 276,
			l = 25,
			b = 4,
			SpeciesID = 316,
			SpeciesName = "测试1号宠物",
			a1 = 123,
			a2 = 112,
			a3 = 234,
			Auras={
			},
		},
		[2]={
			m = 1800,
			b = 4,
			h = 0,
			p = 276,
			s = 276,
			l = 25,
			SpeciesID = 1152,
			SpeciesName = "测试宠物2号",
			Auras={
			},
		},
		[3]={
			b = 0,
			h = 0,
			p = 0,
			s = 0,
			l = 0,
			SpeciesID = 0,
			SpeciesName = "测试宠物不存在??",
			Auras={
			},
		},
	},
	[2]={	--Enemy
		ActivePet=1,
		[0]={
			Auras={
				[1]={
					id=0,
					instanceID=0,
					turn=0,
					isBuff=0,
				},
			--...
			}
		},
		[1]={
			m = 153,
			h = 100,
			p = 10,
			s = 10,
			l = 1,
			b = 3,
			SpeciesID = 106,
			SpeciesName = "E测试1号宠物",
			Auras={
			},
		},
	},
}


local IsSender = false
RegisterAddonMessagePrefix("WatchPVP")
local f=CreateFrame("frame")
f:SetScript("OnEvent", function(self,event, prefix, data, channel, sender)
	if event=="PET_BATTLE_OPENING_START" then
		WatchEnable = false
	end
	if event=="CHAT_MSG_ADDON" then
		if prefix == "WatchPVP" and sender ~= UnitName("player") then
			WUpdate(data)
--~ 			print(data)
		end
	elseif IsSender then
		GetPetInfoA()
	end
end);
f:RegisterEvent("CHAT_MSG_ADDON")
f:RegisterEvent("PET_BATTLE_OPENING_START")
--~ f:RegisterEvent("PET_BATTLE_OPENING_DONE")
f:RegisterEvent("PET_BATTLE_TURN_STARTED")
f:RegisterEvent("PET_BATTLE_PET_ROUND_PLAYBACK_COMPLETE")
f:RegisterEvent("PET_BATTLE_PET_CHANGED")
--~ f:RegisterEvent("PET_BATTLE_OVER")
--~ f:RegisterEvent("PET_BATTLE_CLOSE")
--~ f:RegisterEvent("PET_BATTLE_ACTION_SELECTED")


-------斜杠		-------
SLASH_WATCHPETBATTLE1 = "/watchpetbattle";
SLASH_WATCHPETBATTLE2 = "/wpb";
SlashCmdList["WATCHPETBATTLE"] = function(msg)
	local comm, rest = msg:match("^(%S*)%s*(.-)$")
	local command = string.lower(comm)
	if command == "t" or command == "toggle" then
		PetBattleFrame_Display(PetBattleFrame)
		WatchEnable = true
		print("作为观看者,已经"..(WatchEnable and "开启" or "关闭"))
	end
	if command == "e" or command == "enable" then
		IsSender = not IsSender
		print("作为发送者,已经"..(IsSender and "开启" or "关闭"))
	end
end
