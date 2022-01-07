--------------------------------------------------------------------------------------------------
-- Local variables
--------------------------------------------------------------------------------------------------

local lWarned;

--------------------------------------------------------------------------------------------------
-- Internal functions
--------------------------------------------------------------------------------------------------

local function lSetTimeText(button, time)
	if( time <= 0 ) then
		button:SetText("");
	elseif( time < 60 ) then
		local d, h, m, s = ChatFrame_TimeBreakDown(time);
		button:SetFormattedText("|c00FF0000%.1f|r", s);
		button:SetFont("Fonts\\ARHei.TTF", 13)  -- 小于1分钟的字体及大小
	elseif( time < 600 ) then
		local d, h, m, s = ChatFrame_TimeBreakDown(time);
		button:SetFormattedText("|c00FF9B00%d:%02d|r", m, s);
		button:SetFont("Fonts\\ARHei.TTF", 13)  -- 1-10分钟的字体及大小
	elseif( time <= 3600 ) then
		local d, h, m, s = ChatFrame_TimeBreakDown(time);
		button:SetFormattedText("|c0000FF00%dm|r", m);
		button:SetFont("Fonts\\ARHei.TTF", 12)  -- 大于10分钟的字体及大小
	else
		local d, h, m, s = ChatFrame_TimeBreakDown(time);
		button:SetFormattedText("|c0000FF00%1dH:%02d|r", h, m);
		button:SetFont("Fonts\\ARHei.TTF", 12)  --大于1小时的字体及大小
	end
end


--------------------------------------------------------------------------------------------------
-- OnFoo functions
--------------------------------------------------------------------------------------------------

function BuffTimers_OnLoad(self)
	-- Hook the functions we need to override
	hooksecurefunc("AuraButton_Update", BT_AuraButton_Update);
	hooksecurefunc("AuraButton_UpdateDuration", BT_AuraButton_UpdateDuration);
end

function BT_AuraButton_Update(buttonName, index, filter)
	local unit = PlayerFrame.unit;
	local name, rank, texture, count, debuffType, duration, expirationTime = UnitAura(unit, index, filter);
 
	local buffName = buttonName..index;
	local buffDuration = getglobal(buffName.."Duration");
 
	if ( duration == 0 ) then
		buffDuration:SetText("|cff00ff00N/A|r");
		buffDuration:SetFont("Fonts\\ARHei.TTF", 12) -- 没有持续时间显示N/A的字体及大小
		buffDuration:Show();
	end
end

function BT_AuraButton_UpdateDuration(buffButton, timeLeft)
	if( SHOW_BUFF_DURATIONS == "1" ) then
		local duration = getglobal(buffButton:GetName().."Duration");
		if( timeLeft ) then
			lSetTimeText(duration, timeLeft);
			duration:Show();
		else
			duration:Hide();
		end
	elseif( not lWarned ) then
		lWarned = true;
	end
end

--------------------------------------------------------------------------------------------------
-- Halo Come from
--------------------------------------------------------------------------------------------------

local classColors = {}
do
    for class, c in pairs(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
        classColors[class] = format('|cff%02x%02x%02x', c.r * 255, c.g * 255, c.b * 255)
    end
end

local function SetCaster(self, unit, index, filter)
    local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitBuff(unit, index, filter)
    if unitCaster then
        local uname, urealm = UnitName(unitCaster)
        local _, uclass = UnitClass(unitCaster)
        if urealm then uname = uname .. '-' .. urealm end
           self:AddLine('|cff00ff00注：|r这个光环来自   ' .. '|cff00ff00[ |r' .. (classColors[uclass]) .. uname .. '|cff00ff00 ]|r')
        self:Show()
    end
end

hooksecurefunc(GameTooltip, 'SetUnitAura', SetCaster)
hooksecurefunc(GameTooltip, 'SetUnitBuff', function(self, unit, index, filter)
    filter = filter and ('HELPFUL ' .. filter) or 'HELPFUL'
    SetCaster(self, unit, index, filter)
end)
hooksecurefunc(GameTooltip, 'SetUnitDebuff', function(self, unit, index, filter)
    filter = filter and ('HARMFUL ' .. filter) or 'HARMFUL'
    SetCaster(self, unit, index, filter)
end)
local n,w,h="CompactUnitFrameProfilesGeneralOptionsFrame" h,w=
_G[n.."HeightSlider"],
_G[n.."WidthSlider"]
h:SetMinMaxValues(1,150)
w:SetMinMaxValues(1,150)