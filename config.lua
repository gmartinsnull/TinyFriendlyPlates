local frame = CreateFrame("Frame", "ConfigFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")
local fsTitle = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
local box = CreateFrame("EditBox", "EditBoxWidth", frame, "InputBoxTemplate")
local b = CreateFrame("Button", "ButtonClose", frame, "UIPanelButtonTemplate")
local s = CreateFrame("Slider", "SliderWidth", frame, "OptionsSliderTemplate")

local currentWidth = 30

-- function that sets friendly nameplates
function SetFriendlyNameplates(newWidth)
	C_NamePlate.SetNamePlateFriendlySize(newWidth, 64.125)
end

-- function to open config interface menu
SLASH_CONFIG1 = "/tfp"
SlashCmdList["CONFIG"] = function(msg)
	frame:Show()
	print("config")
end

-- main frame
frame:SetBackdrop({
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Glues\\Common\\TextPanel-Border",
	tile = true,
	tileEdge = true,
	tileSize = 32,
	edgeSize = 32,
	insets = { left = 8, right = 4, top = 4, bottom = 8 },
})
frame:SetWidth(200)
frame:SetHeight(150)
frame:SetPoint("CENTER",0,0)

-- title
frame.text = fsTitle
frame.text:SetPoint("TOP",0,16)
frame.text:SetText("TinyFriendlyPlates")

-- slider
s:SetWidth(144)
s:SetHeight(17)
s:SetOrientation("HORIZONTAL")
s:SetPoint("TOP",0,-16)
s:SetMinMaxValues(40,154)
s:SetValueStep(1)
s:SetValue(60)
s:SetObeyStepOnDrag(1)
s:SetScript("OnValueChanged", function(self,value)
	local result = floor(value/1) * 1
	box:SetText(result)
	currentWidth = result
	SetFriendlyNameplates(result)
end)
s:Show()

-- edit box
box:SetSize(30,17)
box:SetPoint("CENTER")
box:SetAutoFocus(false)
box:SetMaxLetters(3)
box:SetText("60")
box:SetScript("OnEscapePressed", function()
	box:ClearFocus()
end)
box:SetScript("OnEnterPressed", function()
	local width = box:GetNumber()
	print(currentWidth)
	if(width >= 40 and width <= 154) 
	then
		s:SetValue(width)
		SetFriendlyNameplates(width)
	else
		box:SetText(currentWidth)
	end
	box:ClearFocus()
end)

-- close button
b:SetSize(80 ,22)
b:SetText("Close")
b:SetPoint("BOTTOM",0,16)
b:SetScript("OnClick", function()
    frame:Hide()
end)

-- onload
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent",function(self,event,...)
	-- print(C_NamePlate.GetNamePlateFriendlySize())
	-- SetFriendlyNameplates(154.00001525879, 64.125) -- default nameplate size
	SetFriendlyNameplates(60)
end)