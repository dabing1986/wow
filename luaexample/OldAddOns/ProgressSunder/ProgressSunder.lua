local EventFrame = CreateFrame("FRAME", nil, UIParent)

EventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

local spellTable = {
	1680, --ww
	23881, --BT
	23892, 
	23893, 
	23894,
	11597, -- SA
}

local ignoreList = {
	"Lava Spawn",
	"Flame Imp", 
	"Core Hound",
	"Firesworn", 
	"Core Rager",

}

local len = getn(ignoreList)


function EventFrame_OnEvent(_, _, caster, _, spellID)
	if caster == "player" then
		if tContains(spellTable, spellID) then -- Check if they cast one of the listed spells
			for i = 1, 16 do
				name, rank, count = UnitDebuff("target", i) 
				if name == "Expose Armor" then 
					ProgressSunder("EA", spellID)
					break
				end
				if name == "破甲攻击" then 
					ProgressSunder(count, spellID)
					break
				elseif i == 16 then -- No sunders
					ProgressSunder(0, spellID)
				end
			end
		end
	end
end

function ProgressSunder(sunders, spellID)
	ignoreCast = false
	for i = 1, len do 
		if UnitName("target") == ignoreList[i] then
			ignoreCast = true
			break
		end
	end
	if ignoreCast == false then
		if spellID == 11597 then -- Check if SA cast
			if sunders == "EA" then 
				C_ChatInfo.SendAddonMessage("ProgressSunders1", "IneffectiveSunder", "RAID")
			elseif sunders < 5 then
				--print("EffectiveSunder")
				C_ChatInfo.SendAddonMessage("ProgressSunders1", "EffectiveSunder", "RAID")
			else
				--print("IneffectiveSunder")
				C_ChatInfo.SendAddonMessage("ProgressSunders1", "IneffectiveSunder", "RAID")
			end
		else
			if sunders ~= "EA" and sunders < 5 then 
				--print("sub5 sunders")
				C_ChatInfo.SendAddonMessage("ProgressSunders1", "NotSunder", "RAID")
			end
		end
	end
end

EventFrame:SetScript("OnEvent", EventFrame_OnEvent)

