
function (self, unitId, unitFrame, envTable, modTable)
    envTable.FullBarFlash = envTable.FullBarFlash or Plater.CreateFlash(unitFrame.healthBar, 0.2, 100, "white")
    
    --create a texture to use for a flash behind the cast bar
    -- local backGroundFlashTexture = Plater:CreateImage (unitFrame.healthBar, [[Interface\ACHIEVEMENTFRAME\UI-Achievement-Alert-Glow]], unitFrame.healthBar:GetWidth()+50, unitFrame.healthBar:GetHeight()+40, "background", {0, 400/512, 0, 170/256})
    -- backGroundFlashTexture:SetBlendMode ("ADD", 7)
    -- backGroundFlashTexture:SetDrawLayer("OVERLAY", 7)
    -- backGroundFlashTexture:SetPoint ("center", unitFrame.healthBar, "center")
    -- backGroundFlashTexture:Hide()
    
    --create the animation hub to hold the flash animation sequence
    -- envTable.BackgroundFlash = envTable.BackgroundFlash or Plater:CreateAnimationHub (backGroundFlashTexture, 
    --     function()
    --         backGroundFlashTexture:Show()
    --     end,
    --     function()
    --         backGroundFlashTexture:Hide()
    --     end
    -- )
    
    
    function envTable.UpdateColor(unitFrame, unitId)
        if (unitFrame.IsSelf) then
            return
        end
        
        
        if IsInGroup() and
        modTable.CheckCombatCondition(unitFrame) and 
        modTable.CheckPlayerCombatCondition() and
        envTable.IfAggroAbnormal(unitFrame, unitId) then
            -- 应用Plater仇恨颜色
        else
            for _, conditionGroup in ipairs(modTable.Conditions) do
                if modTable.CheckCondition(conditionGroup, unitFrame) then
                    modTable.ApplyCondition(conditionGroup, unitFrame, envTable)
                    return;
                end
            end
            local localplaterlcolor = Plater.GetNpcColor (unitFrame)
            if localplaterlcolor ~= nil  then
                Plater.SetNameplateColor(unitFrame, localplaterlcolor)
                return
            end
        end
        
        envTable.FullBarFlash:Stop()
        Plater.RefreshNameplateColor(unitFrame)
    end
    
    function envTable.IfAggroAbnormal(unitFrame, unitId)
        local isTanking, threatStatus, threatpct = UnitDetailedThreatSituation ("player", unitId)
        
        if envTable.PlayerRole == "TANK" then
            -- 作为坦克却没抗怪，或者怪物仇恨不稳
            if isTanking == false or (threatStatus == 2 or threatStatus == 1 or threatStatus == 0) then
                return true
            end
        elseif envTable.PlayerRole == "DAMAGER" then
            -- 作为DPS在抗怪，或者怪物仇恨不稳
            if isTanking or (threatStatus == 3 or threatStatus == 2 or threatStatus == 1) then
                return true
            end
        end
        
        return false
    end
    
    function envTable.UpdatePlayerRole(unitFrame)
        local profile = Plater.db.profile
        local role = Plater:GetPlayerRole()
        
        if (role == "TANK") then
            envTable.PlayerRole = "TANK"
            
        else
            envTable.PlayerRole = "DAMAGER"
        end        
    end
end

