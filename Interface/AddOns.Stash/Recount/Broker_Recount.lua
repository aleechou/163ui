

if not Recount then return end
local L = LibStub("AceLocale-3.0"):GetLocale("Recount")
local LibDataBroker = LibStub"LibDataBroker-1.1"
local LibDBIcon = LibStub'LibDBIcon-1.0'

function Recount:SetupLDB()
    local dataobj = LibDataBroker:NewDataObject('Recount', {
        type = "launcher",
        label = "Recount",
        OnClick = function(_, msg)
            if msg == "LeftButton" then
                if Recount.MainWindow:IsVisible() then
                    Recount.MainWindow:Hide()
                else
                    Recount.MainWindow:Show()
                    Recount:RefreshMainWindow()
                end
            elseif msg == "RightButton" then
                if not Recount.ConfigWindow or not Recount.ConfigWindow:IsVisible() then
                    Recount:ShowConfig()
                else
                    Recount.ConfigWindow:Hide()
                end
            end
        end,
        icon = "Interface\\AddOns\\Recount\\icon",
        OnTooltipShow = function(tooltip)
            if not tooltip or not tooltip.AddLine then return end
            tooltip:AddLine("Recount")
            tooltip:AddLine("|cffffff00" .. L["Click|r to toggle the Recount window"])
            tooltip:AddLine("|cffffff00" .. L["Right-click|r to open the options menu"])
        end,
    })

    BrokerRecountDBIconDB = BrokerRecountDBIconDB or {}
    LibDBIcon:Register('Recount', dataobj, BrokerRecountDBIconDB)
end

