----------
--Hint when Interrupt enemy spells ，Modified by yeunga[NGA] 2019-11-25 
----------

local frame = CreateFrame("Frame", nil, UIParent)
frame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
frame:SetScript("OnEvent", function(self, event, ...)
	local _, subevent, _, _, sourceName, sourceFlag, _, _, destName, _, _, _, _, _, extraSpellID, extraSpellName = CombatLogGetCurrentEventInfo()
	if (subevent ~= 'SPELL_INTERRUPT') then return end
	if (bit.band(sourceFlag, COMBATLOG_OBJECT_AFFILIATION_MINE) == 0) then return end
	if (not sourceName) then return end
	local msg = format("%s打断了>>%s的[%s]", sourceName or "", destName or "", extraSpellName or "")

--	if CCYtable[2] == true then print("INTERRUPT_CCYtable[2] = true") end -- for debug
--	if CCYtable[2] == false then print("INTERRUPT_CCYtable[2] = false") end -- for debug
	if CCYtable[2] == true then
		if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then SendChatMessage(msg, "INSTANCE_CHAT")
			elseif (IsInRaid()) then SendChatMessage(msg, "RAID")
			elseif (IsInGroup()) then SendChatMessage(msg, "PARTY")
			else print(msg)
		end
	end
end)

----------
--LOADING HINT FOR DEBUG
----------
--print("ClassicCy_InterruptHint 加载成功") -- for debug