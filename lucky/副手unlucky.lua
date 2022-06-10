function(event, msg, name, _, _, _, _, _, _, _, _, _, senderGUID)
    
    --error check
    if not msg then return end
    
    --判断频道
    local channel
    
    if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER" then
        channel = "PARTY"
    elseif event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER" then
        channel = "RAID"
    end
    
    --占卜
    if (string.find(msg,"占卜"))  then
        name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName, numEncounters, encounterProgress = GetSavedInstanceInfo(1)
        
        if id == 0  then
            -- body
            return false
        end
        print(id)
        
        digit1Unlucky = {2,4,7}
        digit2Unlucky = {4}
        digit3Unlucky = {2,7}
        digit4Unlucky = {3}
        digit5Unlucky = {2,8}
        digit6Unlucky = {4,8}
        digit7Unlucky = {7}
        -- 1676551830
        local digit1 = aura_env.getDigit(id, 1) -- 没有 2，4，7
        local digit2 = aura_env.getDigit(id, 2) -- 没有 4
        
        local digit3 = aura_env.getDigit(id, 3) -- no 2 7 
        local digit4 = aura_env.getDigit(id, 4) -- no 3 
        local digit5 = aura_env.getDigit(id, 5)  -- no 2 8 
        local digit6 = aura_env.getDigit(id, 6)  -- no 4 8 
        local digit7 = aura_env.getDigit(id, 7)  -- no 7 
        if aura_env.has_value (digit1Unlucky, digit1) or  aura_env.has_value (digit2Unlucky, digit2) or aura_env.has_value (digit3Unlucky, digit3) or aura_env.has_value (digit4Unlucky, digit4) or aura_env.has_value (digit5Unlucky, digit5) or aura_env.has_value (digit6Unlucky, digit6) or aura_env.has_value (digit7Unlucky, digit7)  then
            return true
        else
            -- body
            if digit1 == digit2 and digit1 == digit3 then
                -- body
                return false
            else
                return true
            end
            -- return false
        end
    end
end

