-- Author: Noobs.momo
aura_env.encounterLog = {
    [0] = 3600, 
    [724]= 600, 
    [725] = 1200, 
    [726] = 1800,
    [727] = 2700, 
    [728] = 3000, 
    [729] = 3600 
}

aura_env.encounterIDtoENName = {
    [0] = "Total", 
    [724]= "Kalecgos", 
    [725]= "Brutallus",
    [726] = "Felmyst",
    [727] = "Eredar Twins",
    [728] = "M'uru",
    [729] = "Kil'jaeden",
}

aura_env.encounterIDtoCNName = {
    [0] = "总计", 
    [724]= "卡雷苟斯", 
    [725]= "布鲁塔卢斯",
    [726] = "菲米丝",
    [727] = "萨洛拉丝女王",
    [728] = "穆鲁",
    [729] = "基尔加丹",
    
}

aura_env.StartNPCID = 25507 -- 炎刃保卫者
--aura_env.StartNPCID = 16346 -- for test
aura_env.EndEncounterID = 729
aura_env.BestLog = {}
aura_env.CurrentLog = {}
aura_env.CombatStartTime = nil

-- Sort table order by expiration time
aura_env.encounterKey = {}
for encounterID in pairs(aura_env.encounterLog) do
    table.insert(aura_env.encounterKey, encounterID)
end
table.sort(aura_env.encounterKey,function(v1,v2) return aura_env.encounterLog[v1] < aura_env.encounterLog[v2] end)

aura_env.CurrentLog["startTime"] = nil
for EncounterID in pairs(aura_env.encounterLog) do
    aura_env.CurrentLog[EncounterID] = nil
    aura_env.BestLog[EncounterID] = nil
end

if ItemUseInputSaved then
    if not ItemUseInputSaved.BestLog then
        ItemUseInputSaved.BestLog = aura_env.BestLog
    else
        aura_env.BestLog = ItemUseInputSaved.BestLog
    end
    
    if not ItemUseInputSaved.CurrentLog then
        ItemUseInputSaved.CurrentLog = aura_env.CurrentLog
    else
        aura_env.CurrentLog = ItemUseInputSaved.CurrentLog
    end
    
end

aura_env.UpdateCurrentLog = function(encounterID, duration)
    if ItemUseInputSaved then
        aura_env.BestLog = ItemUseInputSaved.BestLog
        aura_env.CurrentLog = ItemUseInputSaved.CurrentLog
    end
    
    if not encounterID or not duration then return end
    
    aura_env.CurrentLog[encounterID] = duration
    
    if encounterID == 0 then --refresh best log
        if aura_env.CurrentLog[0] > (aura_env.BestLog[0] or aura_env.encounterLog[0]) then
            for _,EncounterID in pairs(aura_env.encounterKey) do
                aura_env.BestLog[EncounterID] = aura_env.encounterLog[EncounterID]
            end
        else
            for _,EncounterID in pairs(aura_env.encounterKey) do
                aura_env.BestLog[EncounterID] = aura_env.CurrentLog[EncounterID]
            end
        end
        
        if ItemUseInputSaved then
            ItemUseInputSaved.BestLog= aura_env.BestLog
            ItemUseInputSaved.CurrentLog = aura_env.CurrentLog
        end
    end
end

aura_env.ResetLog = function(resetALL)
    wipe(aura_env.CurrentLog)
    aura_env.CurrentLog = {}
    aura_env.CurrentLog["startTime"] = nil
    for EncounterID in pairs(aura_env.encounterLog) do
        aura_env.CurrentLog[EncounterID] = nil
    end
    
    if ItemUseInputSaved then
        ItemUseInputSaved.CurrentLog = aura_env.CurrentLog
    end
    
    if resetALL then
        wipe(aura_env.BestLog)
        aura_env.BestLog = {}
        for EncounterID in pairs(aura_env.encounterLog) do
            aura_env.BestLog[EncounterID] = nil
        end
        
        if ItemUseInputSaved then
            ItemUseInputSaved.BestLog = aura_env.BestLog
        end
    end
    
end

aura_env.SecondsToClock = function(seconds)
    local seconds = tonumber(seconds)
    local negative=false
    local hours = ""
    local mins = ""
    local secs = ""
    local output = ""
    if seconds then
        negative=false
        if seconds < 0 then
            negative=true
            seconds=-seconds
        end
        hours = string.format("%02.f", math.floor(seconds/3600))
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)))
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60))
        
        if hours=="00" then
            if mins=="00" then
                output=secs
            else
                output=mins..":"..secs
            end
        else
            output=hours..":"..mins..":"..secs
        end
        
        if negative then
            output = "-" .. output
        end
        
        return output
    end
end

aura_env.GetNextActiveEncounterID = function()
    -- load save data
    if ItemUseInputSaved then
        aura_env.CurrentLog = ItemUseInputSaved.CurrentLog
    end
    
    for _,EncounterID in pairs(aura_env.encounterKey) do
        if EncounterID > 0 and not aura_env.CurrentLog[EncounterID] then
            return EncounterID
        end
    end
    return 0
end

aura_env.GetBestLogByEncounterID = function(EncounterID)
    if ItemUseInputSaved then
        aura_env.BestLog = ItemUseInputSaved.BestLog
        aura_env.CurrentLog = ItemUseInputSaved.CurrentLog
    end
    if not aura_env.BestLog[EncounterID] then
        return aura_env.encounterLog[EncounterID]
    end
    return min(aura_env.BestLog[EncounterID], aura_env.encounterLog[EncounterID])
end





