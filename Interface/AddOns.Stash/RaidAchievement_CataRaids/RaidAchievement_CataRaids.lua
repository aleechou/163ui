raoldmodules=1
function crraonload()

SetMapToCurrentZone()
if GetCurrentMapAreaID()==754 or GetCurrentMapAreaID()==758 or GetCurrentMapAreaID()==800 or GetCurrentMapAreaID()==824 then
	RaidAchievement_crra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_crra:RegisterEvent("UNIT_POWER")
	RaidAchievement_crra:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end
	RaidAchievement_crra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_crra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_crra:RegisterEvent("ADDON_LOADED")
	
	local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if select(3,GetInstanceInfo())==7 then
		lfrenable=1
  else
    lfrenable=nil
  end

raultrax={} --только для ультраксиона
rarainbow={{2,3},{1,5},{2,4},{3,6}} --радуга
raspinetab={1,2,1,2}--spine of dw

crraspisokach25={
5306,
5307,
5308,
5309,
5312,

5810,
5813,
5830,
5799,
5855,--

6174,--
6128,
6129,
6105,
6133,

}



if (crraspisokon==nil) then
crraspisokon={}
end


end


function crra_OnUpdate(crracurtime)

if ratrackdistmor and crracurtime>ratrackdistmor then
ratrackdistmor=nil
end

--morchok
if ratrackdistmor and crracurtime<ratrackdistmor then
	if crracurtime>ratrackdelay then
		ratrackdelay=crracurtime+0.4
		--тут весь трекер ачивки для сложностей и вывод инфо если мы в бою с боссом
		if morch25 then
			--25ка
			if UnitName("boss1") and GetCurrentMapAreaID()==824 then
				local i=1
				local tab1={} --имена
				local tab2={} --со сколькими рядом был
				local tab3={} --с кем был рядом
				for o=1,GetNumGroupMembers() do
					if UnitAffectingCombat("raid"..o) then
						local nam=UnitName("raid"..o)
						table.insert(tab1,nam)
						table.insert(tab2,0)
						table.insert(tab3,{})
					end
				end
				if #tab1>1 then
				while i<#tab1 do
					local j=i+1
						local x2,y2=GetPlayerMapPosition(tab1[i])
						if x2 and y2 and x2>0 then
							while j<=#tab1 do
									local x,y=GetPlayerMapPosition(tab1[j])
									if x and y and x>0 then
										local dist=math.sqrt(math.pow((x-x2),2)+math.pow((y-y2),2))
										if dist<0.0022675181113097 then
											--меньше 5 ярдов:
											tab2[i]=tab2[i]+1
											tab2[j]=tab2[j]+1
											table.insert(tab3[i],tab1[j])
											table.insert(tab3[j],tab1[i])
										end
									end
								j=j+1
							end
						end
					i=i+1
				end
				end
				local bil=0
				for z=1,#tab2 do
					if tab2[z]>1 then
						bil=bil+1
					end
				end
				if bil>0 then
					local failn=ramanyplayers
					if bil<7 then
						local tabf={}
						for i=1,#tab2 do
							if tab2[i]>1 then
								for j=1,#tab3[i] do
									local nash=0
									if #tabf>0 then
										for k=1,#tabf do
											if tabf[k]==tab3[i][j] then
												nash=1
											end
										end
									end
									if nash==0 then
										table.insert(tabf,tab3[i][j])
									end
								end
							end
						end
						if #tabf<8 then
							failn=""
							for i=1,#tabf do
								failn=failn..tabf[i]
								if i~=#tabf then
									failn=failn..", "
								end
							end
						end
					end
					if crraspisokon[11]==1 and raachdone1 and GetCurrentMapAreaID()==824 then
						crrafailnoreason(11,failn.." - "..ranotsure)
						ratrackdistmor=nil
					end
				end
			end
		else
			if UnitName("boss1") and GetCurrentMapAreaID()==824 then
				local i=1
				local minr=6
				local failn=""
				while i<GetNumGroupMembers() do
					local j=i+1
					if UnitAffectingCombat("raid"..i) then
						local x2,y2=GetPlayerMapPosition(UnitName("raid"..i))
						if x2 and y2 and x2>0 then
							while j<=GetNumGroupMembers() do
								if UnitAffectingCombat("raid"..j) then
									local x,y=GetPlayerMapPosition(UnitName("raid"..j))
									if x and y and x>0 then
										local dist=math.sqrt(math.pow((x-x2),2)+math.pow((y-y2),2))
										if dist<0.0022675181113097 then
											--меньше 5 ярдов:
											local yard=dist/0.00045350362226194
											if yard<minr then
												minr=yard
												failn=UnitName("raid"..i).." - "..UnitName("raid"..j)
											end
										end
									end
								end
								j=j+1
							end
						end
					end
					i=i+1
				end
				if minr<=5 then
					minr=math.ceil(minr*10)/10
					if crraspisokon[11]==1 and raachdone1 and GetCurrentMapAreaID()==824 then
						crrafailnoreason(11,failn..", "..minr.." "..rayard..", "..ranotsure)
						ratrackdistmor=nil
					end
				end
			end
		end
	end
end


if rarainbowtab1 and crracurtime>rarainbowtab1 then
rarainbowtab1=nil
        --проверка таблиц
        local i=0
        local ok=0
        while i<5 do
          local bil=0
          if rarainbow[i] and rarainbow[i][1] then
            for j=1,#rarainbowtab2 do
              if rarainbowtab2[j]==rarainbow[i][1] then
                bil=bil+1
              end
              if rarainbowtab2[j]==rarainbow[i][2] then
                bil=bil+1
              end
            end
          end
          if bil==2 then
            table.remove(rarainbow,i)
            ok=1
            i=i-1
          end
          i=i+1
        end
        if #rarainbow==0 then
          crraachcompl(13)
        elseif #rarainbow==1 and ok==1 then
          --ыытест тут сообщ о том что требуется еще 1 скрещение!
          --rarainbow={{2,3},{1,5},{2,4},{3,6}}
          local txt=""
          if rarainbow[1][1]==2 and rarainbow[1][2]==3 then
            txt=racolor2..", "..racolor3
          elseif rarainbow[1][1]==1 then
            txt=racolor1..", "..racolor5
          elseif rarainbow[1][1]==2 then
            txt=racolor2..", "..racolor4
          elseif rarainbow[1][1]==3 then
            txt=racolor3..", "..racolor6
          end
          
          
          raplaysound(3,crraspisokach25[13])
          
if (wherereportraidach=="sebe") then
DEFAULT_CHAT_FRAME:AddMessage("- "..achlinnk.." "..racolorcomb..": "..txt)
else
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "{rt1} "..achlinnk.." "..racolorcomb..": "..txt)
else
razapuskanonsa(wherereportraidach, "{rt1} "..achlinnk.." "..racolorcomb..": "..txt)
end
end


        end

        rarainbowtab2=nil
end









if racrtimerbossrecheck and crracurtime>racrtimerbossrecheck then
racrtimerbossrecheck=nil
	if UnitGUID("boss1") and UnitName("boss1")~="" then
		local id2=UnitGUID("boss1")
		local id=tonumber(string.sub(id2,6,10),16)
		if id==43296 then
			racrcheckdeadth43296=0
		end
		if id==41442 then
			racrzvukcheck=1
		end
		if id==43324 then
			racrzvukcheck2=1
		end
	end
end

if rcradelayzonech and crracurtime>rcradelayzonech then
rcradelayzonech=nil
SetMapToCurrentZone()
if GetCurrentMapAreaID()==754 or GetCurrentMapAreaID()==758 or GetCurrentMapAreaID()==800 or GetCurrentMapAreaID()==824 then
RaidAchievement_crra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RaidAchievement_crra:RegisterEvent("UNIT_POWER")
RaidAchievement_crra:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
else
RaidAchievement_crra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RaidAchievement_crra:UnregisterEvent("UNIT_POWER")
RaidAchievement_crra:UnregisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end
end


end


function crraonevent(self,event,...)

local arg1, arg2, arg3,arg4,arg5,arg6 = ...



if event == "PLAYER_REGEN_DISABLED" then
if (rabilresnut and GetTime()<rabilresnut+3) or racheckbossincombat then
else
--обнулять все данные при начале боя тут:

raultrax={}
rarainbow={{2,3},{1,5},{2,4},{3,6}}
raspinetab={1,2,1,2}
rarainbowtab1=nil
rarainbowtab2=nil
racrcheckdeadth43296=nil
racrzvukcheck=nil
racrzvukcheck2=nil
rabaleroc1=nil
rabaleroc2=nil

if GetCurrentMapAreaID()==800 and rarhydied==nil then
	raambitun=1
else
	raambitun=nil
end

	if UnitGUID("boss1") and UnitName("boss1")~="" then
		local id2=UnitGUID("boss1")
		local id=tonumber(string.sub(id2,6,10),16)
		if id==43296 then
			racrcheckdeadth43296=0
		end
		if id==41442 then
			racrzvukcheck=1
		end
		if id==43324 then
			racrzvukcheck2=1
		end
		--ыытест тут прописать все ид еще раз
		if id~=43296 and id~=41442 and id~=43324 then
			racrtimerbossrecheck=GetTime()+3
		end
	else
		racrtimerbossrecheck=GetTime()+3
	end
end

end


if event == "CHAT_MSG_RAID_BOSS_EMOTE" then


if string.find(arg1, radeathwingemote1) and lfrenable==nil and GetCurrentMapAreaID()==824 then
--raspinetab={1,2,1,2}
	if crraspisokon[15]==1 and raachdone1 then
		if raspinetab and raspinetab[1] then
			if raspinetab[1]~=1 then
				crrafailnoreason(15)
			elseif raspinetab[1]==1 then
				table.remove(raspinetab,1)
				if #raspinetab==0 then
					crraachcompl(15)
				end
			end
		end
	end
end

if string.find(arg1, radeathwingemote2) and lfrenable==nil and GetCurrentMapAreaID()==824 then
	if crraspisokon[15]==1 and raachdone1 then
		if raspinetab and raspinetab[1] then
			if raspinetab[1]~=2 then
				crrafailnoreason(15)
			elseif raspinetab[1]==2 then
				table.remove(raspinetab,1)
				if #raspinetab==0 then
					crraachcompl(15)
				end
			end
		end
	end
end

end


if event == "ZONE_CHANGED_NEW_AREA" then

ratrackdistmor=nil
rcradelayzonech=GetTime()+2
racrcheckdeadth43296=nil

	local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if select(3,GetInstanceInfo())==7 then
		lfrenable=1
  else
    lfrenable=nil
  end

end

if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_CataRaids" then

for i=1,#crraspisokach25 do
if crraspisokon[i]==nil then crraspisokon[i]=1 end
end
	end
end


if event == "UNIT_POWER" then
if UnitName("boss1") and UnitName("boss1")~="" then

if racrzvukcheck then
--SetMapToCurrentZone()
--if GetCurrentMapAreaID()==754 then
if arg2=="ALTERNATE" and arg1 then
	local power = UnitPower(arg1, 10)
	if power>50 then
		local aa1=UnitName(arg1)
			if crraspisokon[3]==1 and raachdone1 then
				crrafailnoreason(3,aa1..", "..power.."%")
			end
	end
end
--end
end





if racrzvukcheck2 then
--SetMapToCurrentZone()
--if GetCurrentMapAreaID()==758 then
if arg2=="ALTERNATE" and arg1 then
	local power = UnitPower(arg1, 10)
	if power>30 then
		local aa1=UnitName(arg1)
			if crraspisokon[5]==1 and raachdone1 then
				crrafailnoreason(5,aa1..", "..power.."%")
			end
	end
end
--end
end

if raambitun then
	if UnitGUID("boss1") then
		local id2=UnitGUID("boss1")
		local id=tonumber(string.sub(id2,6,10),16)
		if (id==52558 or id==52577 or id==53087) then

	local bar, min_power = UnitAlternatePowerInfo("player")
	if bar then
		local curpower = UnitPower("player", 10)
		if min_power > curpower then
			curpower = min_power
		end
		local value = curpower/UnitPowerMax("player",10)
		if value < 0.50 then
			if crraspisokon[6]==1 and raachdone2 then
				crrafailnoreason(6,nil,nil,2)
				raambitun=nil
			end
		end
	end

		end
	end
end


end
end




if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2, arg3,arg4,arg5,arg6,argNEW1,arg7,arg8,arg9,argNEW2,arg10,arg11,arg12,arg13,arg14, arg15,arg16,arg17,arg18 = ...


--ТУТ АЧИВЫ


--Blackwing Descent
if GetCurrentMapAreaID()==754 then

if arg2=="SPELL_AURA_APPLIED" and (arg10==78941 or arg10==91913 or arg10==94678 or arg10==94679) then
	if crraspisokon[1]==1 and raachdone1 then
		crrafailnoreason(1,arg8)
	end
end

--2
if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==79912 or arg10==91458 or arg10==91457 or arg10==91456) then
	if crraspisokon[2]==1 and raachdone1 then
		crratronpartfail(arg7,arg8,1,crraraidpartachloc1)
	end
end

if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==80092 or arg10==91498 or arg10==91499 or arg10==91500) then
	if crraspisokon[2]==1 and raachdone2 then
		crratronpartfail(arg7,arg8,2,crraraidpartachloc2)
	end
end

if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==79710 or arg10==91540 or arg10==91541 or arg10==91542) then
	if crraspisokon[2]==1 and raachdone3 then
		crratronpartfail(arg7,arg8,3,crraraidpartachloc3)
	end
end

if arg2=="SPELL_AURA_APPLIED" and (arg10==79505 or arg10==91531 or arg10==91532 or arg10==91533) and raachdone4 and crraspisokon[2]==1 then
rallatrontemp1=GetTime()
rallatrontemp2=arg8
end

if rallatrontemp1 and (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==79504 or arg10==91535 or arg10==91536 or arg10==91537) and GetTime()<rallatrontemp1+10 and rallatrontemp2 and arg8~=rallatrontemp2 then
	if crraspisokon[2]==1 and raachdone4 then
		crratronpartfail(arg7,arg8,4,crraraidpartachloc4)
	end
end

--4
if arg2=="UNIT_DIED" and racrcheckdeadth43296 and UnitGUID("boss1") and UnitName("boss1")~="" then

	if crraspisokon[4]==1 and raachdone1 then
		raunitisplayer(arg7,arg8)
		if raunitplayertrue and UnitIsFeignDeath(arg8)==nil and UnitIsDeadOrGhost(arg8) then
			racrcheckdeadth43296=racrcheckdeadth43296+1
			if racrcheckdeadth43296==3 then
				crrafailnoreason(4,arg8)
				racrcheckdeadth43296=nil
			end
		end
	end
end



end
--


--Firelands
if GetCurrentMapAreaID()==800 then

--rhyolit die
if arg2=="UNIT_DIED" and arg7 then
	local id=tonumber(string.sub(arg7,6,10),16)
	if id==52558 then
		rarhydied=1
	end
end


--alystrazor 4 criteria
if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==98885 or arg10==100715 or arg10==100716 or arg10==100717) then
	if crraspisokon[7]==1 and raachdone1 then
		crraalypartfail(arg7,arg8,1,arg11.."!")
	end
end
if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==99336 or arg10==100725 or arg10==100726 or arg10==100727) then
	if crraspisokon[7]==1 and raachdone2 then
		crraalypartfail(arg7,arg8,2,arg11.."!")
	end
end
if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==99427 or arg10==100729 or arg10==100730 or arg10==100731) then
	if crraspisokon[7]==1 and raachdone3 then
		crraalypartfail(arg7,arg8,3,arg11.."!")
	end
end
if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_MISSED") and (arg10==99816 or arg10==100733 or arg10==100734 or arg10==100735) then
	if crraspisokon[7]==1 and raachdone4 then
		crraalypartfail(arg7,arg8,4,arg11.."!")
	end
end


--if arg2=="SPELL_AURA_APPLIED" and (arg10==99256 or arg10==100230 or arg10==100231 or arg10==100232) then
if arg2=="SPELL_AURA_APPLIED" and (arg10==99403 or arg10==99257 or arg10==99402 or arg10==99404) then
	if crraspisokon[8]==1 and raachdone1 then
		if rabaleroc1==nil then
			rabaleroc1={}
			rabaleroc2={}
		end
		local bil=0
		if #rabaleroc1>0 then
			for i=1,#rabaleroc1 do
				if rabaleroc1[i] and rabaleroc1[i]==arg8 then
					bil=1
					rabaleroc2[i]=rabaleroc2[i]+1
					if rabaleroc2[i]>3 then
						crrafailnoreason(8,arg8)
					end
				end
			end
		end
		if bil==0 then
			table.insert(rabaleroc1,arg8)
			table.insert(rabaleroc2,1)
		end
	end
end


--majo
if arg2=="SPELL_DAMAGE" and (arg10==99705 or arg10==100101) then
	if crraspisokon[9]==1 and rafailonlyonetrymaj==nil then
		crrafailnoreason(9,arg8)
		rafailonlyonetrymaj=1
	end
end


--ragna
if (arg2=="SPELL_AURA_APPLIED" or arg2=="SPELL_AURA_APPLIED_DOSE") and (arg10==101088 or arg10==101102) then
	local _, instanceType, pppl = GetInstanceInfo()
	if crraspisokon[10]==1 and (pppl==1 or pppl==2) then
		if raragnatab1==nil then
			raragnatab1={} --ид метеоров
			raragnatab2={} --время окончания бафа?!
		end
		local bil=0
		if #raragnatab1>0 then
			for i=1,#raragnatab1 do
				if raragnatab1[i]==arg8 then
					bil=1
					local tm=GetTime()+60
					raragnatab2[i]=tm
				end
			end
		end
		if bil==0 then
			table.insert(raragnatab1,arg8)
			local tm=GetTime()+60
			table.insert(raragnatab2,tm)
		end
		if #raragnatab1>2 then
			local tab={}
			local i=1
			while i<=#raragnatab2 do
				if raragnatab2[i] and GetTime()>=raragnatab2[i]-6 then
					table.remove(raragnatab1,i)
					table.remove(raragnatab2,i)
					i=i-1
				elseif raragnatab2[i] then
					local tm=raragnatab2[i]-GetTime()
					table.insert(tab,tm)
				end
				i=i+1
			end
			if #tab>2 then
				table.sort(tab)
				if tab[#tab-2] and tab[#tab-2]>6 then
					--проверяем нет ли уже запущеного таймера, если есть, то новое сообщ мы скажем если таймер больше предыдущего на 5 сек, но бары обновим если более чем на 3 сек
					if ratimerragnafin==nil or (ratimerragnafin and tab[#tab-2]>ratimerragnafin-GetTime()+3) then
						--сначало обновим таймеры:
						local _, crraName = GetAchievementInfo(5855)
						local se=tab[#tab-2]
						se=math.ceil(se*10)/10
						raragnatimeron(crraName.." - "..raragnaachtxt1,se)
					end
					if ratimerragnafin==nil or (ratimerragnafin and tab[#tab-2]>ratimerragnafin-GetTime()+7) then
						--сообщение
						local se=tab[#tab-2]-1.5
						raplaysound(2,5855)
						se=math.ceil(se*10)/10
						if (wherereportraidach=="sebe") then
							out("- "..achlinnk.." "..format(raragnaachtxt2,se))
						else
							if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
								razapuskanonsa("raid", "RA: {rt1} "..achlinnk.." "..format(raragnaachtxt2,se))
							else
								razapuskanonsa(wherereportraidach, "RA: {rt1} "..achlinnk.." "..format(raragnaachtxt2,se))
							end
						end
						ratimerragnafin=GetTime()+tab[#tab-2]
					end
				end
			end
		end
	end
end

if arg2=="SPELL_AURA_REMOVED" and (arg10==101088 or arg10==101102) then
	if raragnatab1 and #raragnatab1>0 then
		for i=1,#raragnatab1 do
			if raragnatab1[i] and raragnatab1[i]==arg8 then
				table.remove(raragnatab1,i)
				table.remove(raragnatab2,i)
			end
		end
	end
end



end
--


--Dragon Soul
if GetCurrentMapAreaID()==824 and lfrenable==nil then --проверка что не ЛФР

--активация чека дистанции
if arg2=="SPELL_AURA_APPLIED" and arg10==103851 then
if crraspisokon[11]==1 and raachdone1 then
	SetMapToCurrentZone()
	local _, _, pppl = GetInstanceInfo()
	if pppl==2 or pppl==4 then
		morch25=1
	else
		morch25=nil
	end
	ratrackdelay=GetTime()+0.5
	ratrackdistmor=GetTime()+25
end
end

if arg2=="SPELL_AURA_REMOVED" and arg10==103851 then
	ratrackdistmor=nil
end


if arg2=="SPELL_AURA_APPLIED_DOSE" and arg10==106836 and arg14>9 then
	if crraspisokon[12]==1 and raachdone1 then
		crraachcompl(12)
	end
end

--радуга
--rarainbow={{2,3},{1,5},{2,4},{3,6}}
if arg2=="SPELL_AURA_APPLIED" and (arg10==104897 or arg10==104894 or arg10==104901 or arg10==105027 or arg10==104898 or arg10==104896) then
	if crraspisokon[13]==1 and raachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==55312 then
      if rarainbowtab1==nil then
        rarainbowtab1=GetTime()+4 --таймер резета
        rarainbowtab2={}--цвета
      end
      if arg10==104897 then
        table.insert(rarainbowtab2,1)
      end
      if arg10==104894 then
        table.insert(rarainbowtab2,2)
      end
      if arg10==104901 then
        table.insert(rarainbowtab2,3)
      end
      if arg10==105027 then
        table.insert(rarainbowtab2,4)
      end
      if arg10==104898 then
        table.insert(rarainbowtab2,5)
      end
      if arg10==104896 then
        table.insert(rarainbowtab2,6)
      end
      local _, _, pppl = GetInstanceInfo()
      if pppl and (((pppl==3 or pppl==4) and #rarainbowtab2==4) or ((pppl==1 or pppl==2) and #rarainbowtab2==3)) then
        --проверка таблиц
        local i=0
        local ok=0
        while i<5 do
          local bil=0
          if rarainbow[1] and rarainbow[1][1] then
            for j=1,#rarainbowtab2 do
              if rarainbowtab2[j]==rarainbow[1][1] then
                bil=bil+1
              end
              if rarainbowtab2[j]==rarainbow[1][2] then
                bil=bil+1
              end
            end
          end
          if bil==2 then
            table.remove(rarainbow,1)
            ok=1
            i=i-1
          end
          i=i+1
        end
        if #rarainbow==0 then
          crraachcompl(13)
        elseif #rarainbow==1 and ok==1 then
          --ыытест тут сообщ о том что требуется еще 1 скрещение!
          --rarainbow={{2,3},{1,5},{2,4},{3,6}}
          local txt=""
          if rarainbow[1][1]==2 and rarainbow[1][2]==3 then
            txt=racolor2..", "..racolor3
          elseif rarainbow[1][1]==1 then
            txt=racolor1..", "..racolor5
          elseif rarainbow[1][1]==2 then
            txt=racolor2..", "..racolor4
          elseif rarainbow[1][1]==3 then
            txt=racolor3..", "..racolor6
          end
          
          
          raplaysound(3,crraspisokach25[13])
          
if (wherereportraidach=="sebe") then
DEFAULT_CHAT_FRAME:AddMessage("- "..achlinnk.." "..racolorcomb..": "..txt)
else
if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
razapuskanonsa("raid", "{rt1} "..achlinnk.." "..racolorcomb..": "..txt)
else
razapuskanonsa(wherereportraidach, "{rt1} "..achlinnk.." "..racolorcomb..": "..txt)
end
end
        end
        rarainbowtab1=nil
        rarainbowtab2=nil
      end
    end
  end
end




--if arg2=="SPELL_DAMAGE" and arg10==103327 then
--	if crraspisokon[12]==1 and raachdone1 then
--		local bil=0
--		if #raultrax>0 then
--			for i=1,#raultrax do
--				if raultrax[i]==arg8 then
--					bil=1
--				end
--			end
--		end
--		if bil==0 then
--			table.insert(raultrax,arg8)
--		end
--		if bil==1 then
--			crrafailnoreason(12,arg8)
--			table.wipe(raultrax)
--		end
--	end
--end

if arg2=="SPELL_DAMAGE" and (arg10==107501 or arg10==107287) then
	if crraspisokon[14]==1 and raachdone1 then
		local id=tonumber(string.sub(arg7,6,10),16)
		if id==56598 then
			crrafailnoreason(14)
		end
	end
end






end
--




end
end --КОНЕЦ ОНЕВЕНТ

function crra_closeallpr()
crramain6:Hide()
end


function crra_button2()
PSFea_closeallpr()
crramain6:Show()
openmenureportcrra()



if (crranespamit==nil) then

crraspislun= # crraspisokach25
crracbset={}

for i=1,crraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(crraspisokach25[i]) then

local _, crraName, _, completed, _, _, _, Description, _, crraImage = GetAchievementInfo(crraspisokach25[i])

if completed then
crraName="|cff00ff00"..crraName.."|r"
else
--no more red
end



--текст
local f = CreateFrame("Frame",nil,crramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)


if i==2 or i==7 or i==13 then
if GetAchievementNumCriteria(crraspisokach25[i])>1 then
local maxcrit=GetAchievementNumCriteria(crraspisokach25[i])
for q=1,maxcrit do
	local a1,_,a3=GetAchievementCriteriaInfo(crraspisokach25[i],q)
	if a1==nil then
		q=11
	else
		if a3 then
			Description=Description.."\n|cff00ff00"..a1.."|r"
		else
			Description=Description.."\n"..a1
		end
	end
end
end
end


f:SetScript("OnEnter", function(self) Raiccshowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Raiccshowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(crraspisokach25[i])) else ChatFrame_OpenChat(GetAchievementLink(crraspisokach25[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(crraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(248)
t:SetText(crraName)
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, crramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) crragalka(i) end )
table.insert(crracbset, c)


end --for i
crranespamit=1
end --nespam


crragalochki()




end --конец бутон2

function Raiccshowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Raiccshowtxt2(i)
GameTooltip:Hide()
end


function crragalochki()
for i=1,#crraspisokach25 do
if(crraspisokon[i]==1)then crracbset[i]:SetChecked() else crracbset[i]:SetChecked(false) end
end
end

function crragalka(nomersmeni)
if crraspisokon[nomersmeni]==1 then crraspisokon[nomersmeni]=0 else crraspisokon[nomersmeni]=1 end
end

function crra_buttonchangeyn(yesno)
crraspislun= # crraspisokach25
for i=1,crraspislun do
crraspisokon[i]=yesno
end
crragalochki()
end

function crra_button1()
crraspislun= # crraspisokach25
for i=1,crraspislun do
if crraspisokon[i]==1 then crraspisokon[i]=0 else crraspisokon[i]=1 end
end
crragalochki()
end


function openmenureportcrra()
if not DropDownMenureportcrra then
CreateFrame("Frame", "DropDownMenureportcrra", crramain6, "UIDropDownMenuTemplate")
end
rachatdropm(DropDownMenureportcrra,5,7)
end