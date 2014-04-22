
local GUI = LibStub('NetEaseGUI-1.0')
local CloudUI = LibStub('AceAddon-3.0'):GetAddon('WowSocial_UI')
local JoinButton = CloudUI:NewClass('JoinButton', GUI:GetClass('ItemButton'))

function JoinButton:Constructor(parent)
    self:SetParent(parent)
    self:SetNormalFontObject('GameFontNormalLeft')

    local cancel = CreateFrame('Button', nil, self)
    cancel:SetNormalTexture([[INTERFACE\RAIDFRAME\ReadyCheck-NotReady]])
    cancel:SetSize(32, 32)
    cancel:SetPoint('RIGHT')
    cancel:SetScript('OnClick', function(self)
        self:GetParent():FireHandler('OnItemCancel')
    end)

    local accept = CreateFrame('Button', nil, self)
    accept:SetNormalTexture([[INTERFACE\RAIDFRAME\ReadyCheck-Ready]])
    accept:SetSize(32, 32)
    accept:SetPoint('RIGHT', cancel, 'LEFT')
    accept:SetScript('OnClick', function(self)
        self:GetParent():FireHandler('OnItemAccept')
    end)
end
