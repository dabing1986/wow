function (self, unitId, unitFrame, envTable)
    --[[
    ###################
    ##                          ##
    ##       SETTINGS       ##
    ##                          ## 
    ###################
   
   envTable.forceMax is for enabling maxHP on the bars
--]]
    envTable.forceMax = false
    
    
    -- END OF SETTINGS
    
    
    local shortenNumber = function(number, significant)
        if type(number) ~= "number" then
            number = tonumber(number)
        end
        if not number then
            return
        end
        
        if type(significant) ~= "number" then
            significant = tonumber(significant)
        end
        significant = significant or 3
        
        local affixes = {
            "k",
            "m",
            "b",
            "t",
        }
        affixes[0] = ""
        
        local log, floor, max, abs = math.log, math.floor, math.max, math.abs
        
        local powerTen = floor(log(abs(number)) / log(10)) --get the log base 10
        powerTen = powerTen < 0 and 0 or powerTen --catch negative powers for numbers with an absolute value below 1
        local affix = floor(powerTen / 3) --every third power of ten (so thousands) results in a new affix
        local divNum = number / 1000^affix --get the "new" number by division with the floored amounts
        local before = powerTen%3 + 1 --determine how many digits before the .
        local after = max(0, significant - before) --and how many digits after
        
        return string.format(string.format("%%.%df%s", after, affixes[affix]), divNum)
    end
    
    envTable.healthFunc = function(unit, forceMax)
        local current, max = UnitHealth(unit), UnitHealthMax(unit)
        local percent = (current/max)*100
        
        if forceMax then
            return shortenNumber(current).."/"..shortenNumber(max).." | "..Round(percent)
        else
            if current < 100000 then
                -- body
                return current.." | "..Round(percent)
            else
                -- body
                return shortenNumber(current).." | "..Round(percent)
            end
            -- return shortenNumber(current).." | "..Round(percent)
            
        end
    end
end

