-- Author      : Justajoke
-- Create Date : 11/25/2013 3:44:08 PM

SLASH_YOBUFF1 = "/yobuff"
SlashCmdList["YOBUFF"] = function()
    if(yobuffFrame:IsShown() ~= 1) then
        yobuffFrame:Show() 
    end
end

showInfo:SetScrollChild(infoFrame)
infoFont = infoFrame:CreateFontString()
infoFont:SetPoint("TOPLEFT",infoFrame,"TOPLEFT",10,-10)
infoFont:SetFontObject(GameFontNormal)
infoFont:SetJustifyH("LEFT")

global_table = {}

function closeButton_OnClick()
	yobuffFrame:Hide() 
end

function query_OnClick()
    infoFont:SetText("")
    global_table = {}
	str_undeal = yobuffString:GetText()
	while(string.len(str_undeal) >0) do
	  i,j = string.find(str_undeal,"|")
		if(i ~= nil) then 
		str = string.sub(str_undeal,0,i-1)
		str_undeal = string.sub(str_undeal,j+2,string.len(str_undeal))
		else
		str = str_undeal
		str_undeal = ""
		end
	  data_table = json_decode(str)
	  table.insert(global_table,data_table)
		for key,value in pairs(data_table) do
			   font_text = infoFont:GetText()
			   if (font_text ~=nil) then
			   infoFont:SetText(font_text.."\n"..key.." : "..value)
			   else
			   infoFont:SetText(key.." : "..value)
			   end
		end
		infoFont:SetText(infoFont:GetText().."\n")
	end
end


function clear_OnClick()
      yobuffString:SetText("")
end

function invite_OnClick()
	for key,value in pairs(global_table) do
	   for k,v in pairs(value) do
		   if(k == "battleTag") then		
			   invmsg = "我正在使用YOBUFF对您发起好友请求"
			   BNSendFriendInvite(v, invmsg)
			   font_text = infoFont:GetText()
			   if (font_text ~=nil) then
				 infoFont:SetText(font_text.."\n".."您向"..v.."发起了好友请求")
			   else
				 infoFont:SetText("您向"..v.."发起了好友请求")
			   end
		   end
	   end
	end
end

function inviteToGroup_OnClick()
    num = BNGetNumFriends()
    for i=1,num do
	   local ID, realname, battleTag, _, _, toonID, _, isOnline = BNGetFriendInfo(i)
	   for key,value in pairs(global_table) do
	       for k,v in pairs(value) do 
		      if(k == "battleTag") then
					if(battleTag == v) then
					  BNInviteFriend(toonID)
					  font_text = infoFont:GetText()
					  if (font_text ~=nil) then
				         infoFont:SetText(font_text.."\n".."您已向"..v.."发送了组队邀请")
					  else
					     infoFont:SetText("您已向"..v.."发送了组队邀请")
				      end
					end
			  end
		   end
	   end
    end
end

function remove_OnClick()
   num = BNGetNumFriends()
    for i=1,num do
	   local ID, realname, battleTag, _, _, toonID, _, isOnline = BNGetFriendInfo(i)
	   for key,value in pairs(global_table) do
	       for k,v in pairs(value) do 
		      if(k == "battleTag") then
					if(battleTag == v) then
					  BNRemoveFriend(ID)
					  font_text = infoFont:GetText()
					  if (font_text ~=nil) then
				         infoFont:SetText(font_text.."\n".."您已将"..v.."从好友列表中移除")
					  else
					     infoFont:SetText("您已将"..v.."从好友列表中移除")
				      end
					end
			  end
		   end
	   end
    end
end

function json_decode(json)
	local j=string.gsub(json,'\"([^\"]-)\":','%1=')
	local j=string.gsub(j,'%b\[\]','')
	local j='t='..j
	loadstring(j)()
	return t
end
