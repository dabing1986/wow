----------
--table init
----------
local frm = CreateFrame("Frame")
frm:Hide()
frm:RegisterEvent("ADDON_LOADED")
frm:SetScript("OnEvent",function(self, event, ...)
	local name = ...
	if event == "ADDON_LOADED" and name == "ClassicCy" then
		CCYtable = CCYtable or {true, true}
--		if CCYtable[1] == true then print("EVENTS_CCYtable[1] = true") end -- for debug
--		if CCYtable[1] == false then print("EVENTS_CCYtable[1] = false") end -- for debug
--		if CCYtable[2] == true then print("EVENTS_CCYtable[2] = true") end -- for debug
--		if CCYtable[2] == false then print("EVENTS_CCYtable[2] = false") end -- for debug
		self:UnregisterEvent("ADDON_LOADED")
		----------
		--LOADING HINT FOR DEBUG
		----------
		print("ClassicCy 交战和打断提示 loaded，输入/ccy help查看") 
	end
end)

--[[
if CCYtable[1] == true then print("CCYtable[1] = true") end -- for debug
if CCYtable[1] == false then print("CCYtable[1] = false") end -- for debug
if CCYtable[2] == true then print("CCYtable[2] = true") end -- for debug
if CCYtable[2] == false then print("CCYtable[2] = false") end -- for debug
--]]

