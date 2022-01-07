
if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
	return
end

--[[     Justify Module     ]]--

local _, BCM = ...
BCM.modules[#BCM.modules+1] = function()
	if bcmDB.BCM_Justify then bcmDB.justify = nil return end

	if bcmDB.justify then
		local noDel
		for k, v in pairs(bcmDB.justify) do
			_G[k]:SetJustifyH(v)
			noDel = true
		end
		if not noDel then bcmDB.justify = nil end --Cleanup db
	end
end

