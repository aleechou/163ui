-- Author      : s1172
-- Create Date : 2013/5/1 17:10:23

local L = ElfintipApi.Localization
local first = true

local DISPLAY_DATA={
	start = L["welcome"],
	stop = L["bye bye."],
	L["TipsText1"],
	L["TipsText2"],
	L["TipsText3"],
	L["TipsText4"],
	L["TipsText5"],
	L["TipsText6"],
	L["TipsText7"],
	L["TipsText8"],
	L["TipsText9"],
	L["TipsText10"],
	L["TipsText11"],
	L["TipsText12"],
	L["TipsText13"],
	L["TipsText14"],
	L["TipsText15"],
	L["TipsText16"],
	L["TipsText17"],
	L["TipsText18"],
	L["TipsText19"],
	L["TipsText20"],
	L["TipsText21"],
	L["TipsText22"],
	L["TipsText23"],
	L["TipsText24"],
	L["TipsText25"],
	L["TipsText26"],
	L["TipsText27"],
	L["TipsText28"],
	L["TipsText29"],
	L["TipsText30"],
	L["TipsText31"],
	L["TipsText32"],
	L["TipsText33"],
	L["TipsText34"],
	L["TipsText35"],
	L["TipsText36"],
	L["TipsText37"],
	L["TipsText38"],
	L["TipsText39"],
	L["TipsText40"],
	L["TipsText41"],
	L["TipsText42"],
	L["TipsText43"],
	L["TipsText44"],
	L["TipsText45"],
	L["TipsText46"],
	L["TipsText47"],
	L["TipsText48"],
	L["TipsText49"],
	L["TipsText50"],
	L["TipsText51"],
	L["TipsText52"],
	L["TipsText53"],
	L["TipsText54"],
	L["TipsText55"],
	L["TipsText56"],
	L["TipsText57"],
	L["TipsText58"],
	L["TipsText59"],
	L["TipsText60"],
	L["TipsText61"],
	L["TipsText62"],
	L["TipsText63"],
	L["TipsText64"],
	L["TipsText65"],
	L["TipsText66"],
	L["TipsText67"],
	L["TipsText68"],
	L["TipsText69"],
	L["TipsText70"],
	L["TipsText71"],
	L["TipsText72"],
	L["TipsText73"],
	L["TipsText74"],
	L["TipsText75"],
	L["TipsText76"],
	L["TipsText77"],
	L["TipsText78"],
	L["TipsText79"],
	L["TipsText80"],
	L["TipsText81"],
	L["TipsText82"],
	L["TipsText83"],
	L["TipsText84"],
	L["TipsText85"],
	L["TipsText86"],
	L["TipsText87"],
	L["TipsText88"],
	L["TipsText89"],
	L["TipsText90"],
	L["TipsText91"],
	L["TipsText92"],
	L["TipsText93"],
	L["TipsText94"],
	L["TipsText95"],
	L["TipsText96"],
	L["TipsText97"],
	L["TipsText98"],
	L["TipsText99"],
	L["TipsText100"],
	L["TipsText101"],
	L["TipsText102"],
	L["TipsText103"],
	L["TipsText104"],
	L["TipsText105"],
	L["TipsText106"],
	L["TipsText107"],
	L["TipsText108"],
	L["TipsText109"],
	L["TipsText110"],
	L["TipsText111"],
	L["TipsText112"],
	L["TipsText113"],
	L["TipsText114"],
	L["TipsText115"],
	L["TipsText116"],
	L["TipsText117"],
	L["TipsText118"],
}


local frame = CreateFrame("frame", "NewbieAssistantElfintipFrameTimer")

function NewbieAssistantElfintipFrame_OnEvent(self)
	if NAApi:GetLvl("player")<=20 then
		local ToturialTipsDisplayId = 1
		self.OldTime=GetTime()+10

		frame:SetScript("OnUpdate", function(frame)
			if GetTime()-self.OldTime>0 then
				local lvl = NAApi:GetLvl("player")

				if ToturialTipsDisplayId > #DISPLAY_DATA then
					ToturialTipsDisplayId=1
				end

				if not self:IsShown() then
					if NAApi:GetLvl("player") == 20 then
						self.Description:SetText(DISPLAY_DATA.stop)
						frame:SetScript("OnUpdate",nil)
					elseif first then
						self.Description:SetText(DISPLAY_DATA.start)
						first = nil
					else
						self.Description:SetText(DISPLAY_DATA[ToturialTipsDisplayId])
						ToturialTipsDisplayId=ToturialTipsDisplayId+1
					end
					self:Show()
					self.ShowAnim:Play()
					self.OldTime=GetTime()+20
				else
					self.HideAnim:Play()
					self.OldTime=GetTime()+60
				end
			end
		end)
	end
end