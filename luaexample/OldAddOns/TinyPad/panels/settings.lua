-- savedvar TinyPadSettings for window behavior settings; see TinyPadPages in misc\pages.lua for pages savedvar

local _,t = ...
t.settings = CreateFrame("Frame",nil,t.main,BackdropTemplateMixin and "BackdropTemplate")

t.init:Register("settings")

TinyPadSettings = {} -- savedvar

t.settings.defaults = {
    Lock = false,
    LargerScale = false,
    Transparency = false,
    ShowMinimapButton = false,
    FontFamily = 1, -- Serif
    FontSize = 2, -- Medium
    PinBookmarks = false,
    NoFade = false,
    AllowCtrlKeys = false,
    HideTooltips = false,
}

-- you can edit this table to add your own fonts in this format: {"Font Name","FontFile",size1,size2,size3}.
-- in theory any number of font choices are possible--they'll all be added to the settings panel--but they must have three sizes
t.settings.fonts = {
    {"Frizt Quadrata","Fonts\\FRIZQT__.TTF",10,12,16}, -- keep this here for a fallback
    {"Arial","Fonts\\ARIALN.TTF",12,16,20},
    {"Inconsolatas","Interface\\AddOns\\TinyPad\\media\\Inconsolata.otf",11,12,14},
    {"Morpheus","Fonts\\MORPHEUS.ttf",12,14,18},
    {"Skurri","Fonts\\skurri.ttf",11,14,18},
}

-- options definitions can be one of these:
-- {"check","var","label","tooltip text"} or {"radio","var",index,"label","tooltip text"} or {"header","label"} or {"spacer",height}
t.settings.optionsInfo = {
    {"spacer",8},
    {"check","Lock","Lock Window","Prevent TinyPad from being dismissed with the Escape key or moved unless Shift is held."},
    {"check","LargerScale","Larger Scale","Make TinyPad larger by increasing the scale slightly."},
    {"check","Transparency","Transparency","Add a transparency effect to see things behind TinyPad."},
    {"check","ShowMinimapButton","Minimap Button","Show a minimap button to summon and dismiss TinyPad."},
    {"check","NoFade","No Fadeout","When the mouse leaves TinyPad, and no panel is open (like this settings panel), and the addon doesn't have focus, don't fade out the background."},
    {"check","AllowCtrlKeys","Allow Ctrl Keys","Allow the use of Ctrl+F (Find), Ctrl+N (New), Ctrl+Z (Undo) or Ctrl+Y (Redo) while TinyPad is on screen, regardless whether it has the blinking cursor active.\n\nThis will only override any bindings you have for those keys while TinyPad is on screen."},
    {"check","HideTooltips","Hide Tooltips","Hide tooltips within TinyPad like the one you're reading now."},
    {"spacer",8},
    {"header","Font Typeface"},
    {"spacer",8},
    {"header","Font Size"},
    {"radio","FontSize",1,"Small","Use a small font size."},
    {"radio","FontSize",2,"Medium","Use a medium font size."},
    {"radio","FontSize",3,"Large","Use a large font size."},
    {"spacer",8},
}
-- insert font family options to the above table from available fonts (inserting backwards starting at line 11)
for i=#t.settings.fonts,1,-1 do
    local info = t.settings.fonts[i]
    tinsert(t.settings.optionsInfo,11,{"radio","FontFamily",i,info[1],format("Use the %s font.",info[1])})
end


t.init:Register("settings")

-- on player login, load defaults if they're undefined
function t.settings:LoginInit()
    t.settings.saved = TinyPadSettings
    -- load default settings for undefined settings
    for setting,value in pairs(t.settings.defaults) do
        if t.settings.saved[setting]==nil then
            t.settings.saved[setting] = value
        end
    end
    -- in case a font is removed, fallback to default
    if type(t.settings.saved.FontFamily)~="number" or type(t.settings.saved.FontSize)~="number" or (t.settings.saved.FontFamily<1 or t.settings.saved.FontFamily>#t.settings.fonts) or (t.settings.saved.FontSize<1 or t.settings.saved.FontSize>3) then
        t.settings.saved.FontFamily = t.settings.defaults.FontFamily
        t.settings.saved.FontSize = t.settings.defaults.FontSize
    end
end

-- this stuff runs on the first summoning of the window; savedvar stuff should be established by now from above LoginInit
function t.settings:Init()
    t.settings:SetPoint("TOPRIGHT",t.toolbar,"BOTTOMRIGHT",2,0)
    t.settings:SetPoint("BOTTOMRIGHT",t.main,"BOTTOMRIGHT",-4,4)
    t.settings:SetWidth(t.constants.BOOKMARKS_PANEL_WIDTH)

    t.settings:SetBackdrop({bgFile="Interface\\ChatFrame\\ChatFrameBackground",tileSize=16,tile=true,insets={left=4,right=4,top=4,bottom=4},edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",edgeSize=16})
    t.settings:SetBackdropBorderColor(0.5,0.5,0.5)
    t.settings:SetBackdropColor(0.175,0.175,0.175)

    -- line beneath the addRemoveButton to form a border around the scrollFrame
    t.settings.border = t.settings:CreateTexture(nil,"ARTWORK")
    t.settings.border:SetHeight(7)
    t.settings.border:SetPoint("TOPLEFT",4,-16)
    t.settings.border:SetPoint("TOPRIGHT",-4,-16)
    t.settings.border:SetTexture("Interface\\Tooltips\\UI-Tooltip-Border")
    t.settings.border:SetTexCoord(0.5625,0.6875,0,0.4375)
    t.settings.border:SetVertexColor(0.35,0.35,0.35)

    t.settings.title = t.settings:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall")
    t.settings.title:SetPoint("TOPLEFT",8,-6)
    t.settings.title:SetPoint("BOTTOMRIGHT",t.settings,"TOPRIGHT",-8,-16)
    t.settings.title:SetText("Settings")

    -- the scrollframe that takes up most of the panel
    t.settings.scrollFrame = t.scrollFrame:Create(t.settings)
    t.settings.scrollFrame:SetPoint("TOPLEFT",5,-22)
    t.settings.scrollFrame:SetPoint("BOTTOMRIGHT",-6,6)
    t.settings.scrollFrame.scrollChild.buttons = {}

    -- build option buttons from optionsInfo, attached to the scrollchild
    local lastButton
    for index,optionInfo in ipairs(t.settings.optionsInfo) do
        local button = t.settings:CreateOptionButton(t.settings.scrollFrame.scrollChild,index)
        button:SetPoint("TOPLEFT",lastButton or t.settings.scrollFrame.scrollChild,lastButton and "BOTTOMLEFT" or "TOPLEFT",0,0)
        button:SetPoint("TOPRIGHT",lastButton or t.settings.scrollFrame.scrollChild,lastButton and "BOTTOMRIGHT" or "TOPRIGHT",0,0)
        if button.optionType=="check" or button.optionType=="radio" then -- only need to add check and radio buttons to scrollChild.buttons
            tinsert(t.settings.scrollFrame.scrollChild.buttons,button)
        end
        lastButton = button
    end

end

-- goes through each scrollchild button and updates its checked/selected state
function t.settings:Update()
    for _,button in ipairs(t.settings.scrollFrame.scrollChild.buttons) do
        if button.checkButton then
            if button.optionType=="check" then -- check buttons use 6,1 checked; 6,3 unchecked
                t.buttons:SetTexturesByNormalCoords(button.checkButton,6,t.settings.saved[button.var] and 1 or 3)
            elseif button.optionType=="radio" then -- radio buttons use 6,6 selected; 6,3 unselected
                t.buttons:SetTexturesByNormalCoords(button.checkButton,6,t.settings.saved[button.var]==button.value and 6 or 3)
            end
        end
    end
end

-- created an options button attached to parent, from an index into t.settings.optionsInfo
function t.settings:CreateOptionButton(parent,index)
    local optionInfo = t.settings.optionsInfo[index]
    local optionType = optionInfo[1]

    local button = CreateFrame("Button",nil,parent)
    button:SetHeight(t.constants.OPTION_BUTTON_HEIGHT)

    button.optionType = optionType

    if optionType=="check" or optionType=="radio" then
        button.checkButton = t.buttons:Create(button,t.constants.OPTION_BUTTON_HEIGHT-2,t.constants.OPTION_BUTTON_HEIGHT-2,6,3,t.settings.ButtonOnClick,{anchorPoint="LEFT",relativeTo=button,relativePoint="LEFT",xoff=2,yoff=0})
        button.checkButton:SetHitRectInsets(0,-80,0,0)
        button.label = button:CreateFontString(nil,"ARTWORK","SystemFont_Tiny")
        button.label:SetPoint("LEFT",button.checkButton,"RIGHT",2,0)
        button.label:SetPoint("RIGHT",-2,0)
        button.label:SetJustifyH("LEFT")
        button.label:SetWordWrap(false)
        button.var = optionInfo[2] -- savedvar name, eg Lock, NoFade, etc.
        if optionType=="check" then
            button.label:SetText(optionInfo[3]) -- short name, eg Lock Window
            button.checkButton.tooltipTitle = optionInfo[3]
            button.checkButton.tooltipBody = optionInfo[4]
        elseif optionType=="radio" then
            button.label:SetText(optionInfo[4]) -- short name for radio buttons
            button.value = optionInfo[3] -- radio index within var
            button.checkButton.tooltipTitle = optionInfo[4]
            button.checkButton.tooltipBody = optionInfo[5]
        end
    elseif optionType=="header" then
        button.label = button:CreateFontString(nil,"ARTWORK","SystemFont_Tiny")
        button.label:SetPoint("LEFT",2+t.constants.OPTION_BUTTON_HEIGHT,0)
        button.label:SetPoint("RIGHT",-2,0)
        button.label:SetJustifyH("LEFT")
        button.label:SetWordWrap(false)
        button.label:SetTextColor(0.7,0.7,0.7)
        button.label:SetText(optionInfo[2])
        button:EnableMouse(false)
    elseif optionType=="spacer" then
        button:SetHeight(optionInfo[2])
        button:EnableMouse(false)
    end

    return button

end


-- click of any check/radio button
function t.settings:ButtonOnClick()
    local parent = self:GetParent() -- self is the checkButton, parent has details of setting
    local var = parent.var
    if var then
        if parent.optionType=="radio" then -- font radio button clicked
            t.settings.saved[var] = parent.value
        elseif parent.optionType=="check" then
            t.settings.saved[var] = not t.settings.saved[var]
        end
        t.settings:Update()
        if t.settings.changeFuncs[var] then
            t.settings.changeFuncs[var](t.settings)
        end
    end
end

function t.settings:Toggle()
    t.layout:Toggle("settings")
end

--[[ changeFuncs are functions to run when an option changes ]]

t.settings.changeFuncs = {} -- indexed by the name of the option

function t.settings.changeFuncs:Lock()
    t.main:UpdateLock()
end

function t.settings.changeFuncs:LargerScale()
    t.main:UpdateScale()
end

function t.settings.changeFuncs:Transparency()
    t.main:UpdateTransparency()
end

function t.settings.changeFuncs:ShowMinimapButton()
    t.minimap:SetShown(t.settings.saved.ShowMinimapButton)
end

function t.settings.changeFuncs:NoFade()
    t.main:UpdateFadeBehavior()
end

function t.settings.changeFuncs:HideTooltips()
    if t.settings.saved.HideTooltips then -- if hiding tooltips, hide tooltip right away
        GameTooltip:Hide()
    else -- if mouse is over the Hide Tooltips button, then show tooltip by runnings its OnEnter
        local focus = GetMouseFocus()
        if focus and focus:GetParent():GetParent()==t.settings.scrollFrame.scrollChild and focus:GetParent().var=="HideTooltips" then
            focus:GetScript("OnEnter")(focus)
        end
    end
end

function t.settings.changeFuncs:FontFamily()
    t.editor:UpdateFont()
end

function t.settings.changeFuncs:FontSize()
    t.editor:UpdateFont()
end
