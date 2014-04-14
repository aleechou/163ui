-- Trainer.lua

local addonName, private = ...
local LA = private.LA

function LA:CreateTrainAllButton()
  if not self.trainAllButton then
    local button = CreateFrame("Button", "LearningAid_TrainAllButton", ClassTrainerTrainButton, "MagicButtonTemplate")
    button:SetPoint("RIGHT", ClassTrainerTrainButton, "LEFT")
    button:SetText(self:GetText("trainAllButton"))
    button:SetScript("OnClick", function() StaticPopup_Show("LEARNING_AID_TRAINER_BUY_ALL") end)
    --button:SetScript("OnShow", function(thisButton) self:GetAvailableTrainerServices() end)
    --button:SetScript("OnHide", function() wipe(self.availableServices) end)
    button:Show()
    self.trainAllButton = button
    StaticPopupDialogs.LEARNING_AID_TRAINER_BUY_ALL = {preferredIndex = 3,
       text = self:GetText("trainAllPopup"), -- "Train all skills for"
       button1 = ACCEPT,
       button2 = CANCEL,
       OnAccept = function()
          self:BuyAllTrainerServices(LA.CONFIRM_TRAINER_BUY_ALL)
          button:Disable()
       end,
       OnShow = function(dialog)
         MoneyFrame_Update(dialog.moneyFrame, self.availableServices.cost)
       end,
       hasMoneyFrame = 1,
       --showAlert = 1,
       timeout = 0,
       exclusive = 1,
       hideOnEscape = 1,
       whileDead = false
    }
    hooksecurefunc("ClassTrainerFrame_Update", function() LearningAid:GetAvailableTrainerServices() end)
    return button
  end
end

function LA:GetAvailableTrainerServices()
  local copper = 0
  local services = self.availableServices
  wipe(services)
  for i = 1, GetNumTrainerServices() do
    local t = {} -- omg junk table
    --name (String), subType (String), category (String), texture (String), requiredLevel (Number), topServiceLine (Number)
    t.name, t.subType, t.category, t.texture, t.level, t.topServiceLine = GetTrainerServiceInfo(i)
    t.copper, t.isProfession = GetTrainerServiceCost(i)
    --t.skillLine = GetTrainerServiceSkillLine(i)
    t.index = i
    --t.link = GetTrainerServiceItemLink(i)
    if (t.category == "available") and not t.isProfession then
      copper = copper + t.copper
      table.insert(services, t)
    end
  end
  services.cost = copper
  --self:DebugPrint("Total cost of available services: "..GetCoinText(copper))
  if #services > 0 and copper <= GetMoney() then
    self.trainAllButton:Enable()
  else
    self.trainAllButton:Disable()
  end
  return services
end

function LA:BuyAllTrainerServices(really)
  local services = self.availableServices
  if services and really == LA.CONFIRM_TRAINER_BUY_ALL then
    self.pendingBuyCount = #services
    self:DebugPrint("Buying all "..self.pendingBuyCount.." service(s) for "..services.cost.." copper")
    for i, t in ipairs(services) do
      --if t.category == "available" then
        BuyTrainerService(t.index)
      --end
    end
    --[[
    wipe(services)
    self.learning = false
    local learned = self:FormatSpells(self.spellsLearned)
    if learned then self:SystemPrint(self:GetText("youHaveLearned", learned)) end
    wipe (self.spellsLearned)
    --]]
  end
end

