function (modTable)
    
    modTable.ConditionType = {
        Execute                 = 1,            -- 斩杀
        Upexecute               = 2,            -- 反斩杀
        Specified               = 3,            -- 指定单位
        Target                  = 4,            -- 目标
        WithBuff                = 5,            -- 带有指定Buff
        WithoutBuff             = 6,            -- 不带有指定Buff
        WithBuffFromPlayer      = 7,            -- 带有来源于自己的指定Buff
        WithoutBuffFromPlayer   = 8,            -- 不带有来源于自己的指定Buff
        Combat                  = 9,            -- 单位在战斗中
        NoCombat                = 10,           -- 单位不在战斗中
        PlayerCombat            = 11,           -- 玩家在战斗中
        PlayerNoCombat          = 12,           -- 玩家不在战斗中
        Focus                   = 13,           -- 焦点目标
        Mark                    = 14,           -- 标记单位
    }
    
    modTable.TypeShow = {
        Color       = 1,        -- 颜色
        Flash       = 2,        -- 闪烁
    }
    
    modTable.MarkColor = {
        [1] = "#d9cf45",       -- 黄色星星  YellowStar
        [2] = "#ed820f",       -- 橙色大饼  OrangeCirCle
        [3] = "#b30fd6",       -- 紫色菱形  PurpleDiamond
        [4] = "#24a824",       -- 绿色三角  GreenTriangle
        [5] = "#99bfd9",       -- 银色月亮  SilverMoon
        [6] = "#00a3ff",       -- 蓝色方块  BlueSquare
        [7] = "#d12e2e",       -- 红色叉子  RedCross
        [8] = "#e3d4bd",       -- 白色骷髅  WhiteSkull
    }
    
    modTable.Conditions = {
        
        -- 示例1
        -- 当目标身上存在浩劫（毁灭术技能），同时作为你的目标时，血条闪烁
        {
            enable      = false,
            name        = "元素诅咒",
            
            condition   = {5},
            value       = {
                {"元素诅咒"},
            },
            
            typeshow    = 1,
            typevalue   = "blue"       -- 目前闪烁类型不支持改颜色，这个值填什么都可以，不会读取
        },
        
        -- 示例2
        -- 当目标处于斩杀线（血量低于某值），
        -- 且该单位是自己的目标，
        -- 且带有来源于玩家自己的指定的Buff，
        -- 且玩家自己在战斗中，
        -- 那么血条变黑
        {
            enable      = false,
            name        = "奇怪又复杂的示例",
            
            condition   = {1, 4, 7, 11},
            value       = {
                {0.5},
                {},
                {"神鹤印记", "碎玉闪电"},
                {}
            },
            
            typeshow    = 1,
            typevalue   = "black"
        },
        
        {
            enable      = true,
            name        = "焦点单位",
            
            condition   = {13},
            value       = {
                {}
            },
            
            typeshow    = 1,
            typevalue   = "#33a3dc"
        },
        
        {
            enable      = true,
            name        = "标记单位",
            
            condition   = {14},
            value       = {
                {}
            },
            
            typeshow    = 1,
            typevalue   = ""
        },
    }
    
    
    -- 初始化来自配置的条件组
    local executeCondition = {
        name = "默认斩杀条件",
        enable = modTable.config._enableexecute,
        
        condition = {1},
        value = {{modTable.config._valueexecute}},
        
        typeshow = modTable.config._typeexecute,
        typevalue = modTable.config._typeValueexecute
    }
    local upexecuteCondition = {
        name = "默认反斩杀条件",
        enable = modTable.config._enableUpexecute,
        
        condition = {2},
        value = {{modTable.config._valueUpexecute}},
        
        typeshow = modTable.config._typeUpexecute,
        typevalue = modTable.config._typeValueUpexecute
    }
    if modTable.config._enableUpexecuteCombat then
        table.insert(upexecuteCondition.condition, modTable.ConditionType.Combat)
    end
    local targetCondition = {
        name = "默认目标条件",
        enable = modTable.config._enableTarget,
        
        condition = {4},
        value = {{}},
        
        typeshow = modTable.config._typeTarget,
        typevalue = modTable.config._typeValueTarget
    }
    
    local specifiedConditionList = {}
    for k, _ in pairs(modTable.config._valueSpecified) do
        table.insert(specifiedConditionList, k)
    end
    local specifiedCondition = {
        name = "默认特定单位条件",
        enable = true,
        
        condition = {3},
        value = {specifiedConditionList},
        
        typeshow = modTable.TypeShow.Color,
        typevalue = modTable.config._typeValueSpecified
    }
    
    local withBuffConditionList = {}
    for k, _ in pairs(modTable.config._valueWithBuff) do
        table.insert(withBuffConditionList, k)
    end
    local withBuffCondition = {
        name = "默认有Buff条件",
        enable = true,
        
        condition = {5},
        value = {withBuffConditionList},
        
        typeshow = modTable.TypeShow.Color,
        typevalue = modTable.config._typeValueWithBuff
    }
    
    local withoutBuffConditionList = {}
    for k, _ in pairs(modTable.config._valueWithoutBuff) do
        table.insert(withoutBuffConditionList, k)
    end
    local withoutBuffCondition = {
        name = "默认没有Buff条件",
        enable = true,
        
        condition = {6},
        value = {withoutBuffConditionList},
        
        typeshow = modTable.TypeShow.Color,
        typevalue = modTable.config._typeValueWithoutBuff
    }
    
    
    -- 默认的条件组，会依次加在自定义条件组的后面。 可根据需要自行调整这几行的顺序
    table.insert(modTable.Conditions, executeCondition)                 -- 默认斩杀条件
    table.insert(modTable.Conditions, upexecuteCondition)               -- 默认反斩杀条件
    table.insert(modTable.Conditions, targetCondition)                  -- 默认目标条件
    table.insert(modTable.Conditions, specifiedCondition)               -- 默认特定单位条件
    table.insert(modTable.Conditions, withBuffCondition)                -- 默认有Buff条件
    table.insert(modTable.Conditions, withoutBuffCondition)             -- 默认没有Buff条件
    
    
    -- local localplaterlcolor = Plater.GetNpcColor (unitFrame)
    -- if localplaterlcolor ~= nil  then
    --     Plater.SetNameplateColor (unitFrame, localcolor)
    --     return;
    -- end
    
    
    
    function modTable.CheckCondition(conditionGroup, unitFrame)
        if conditionGroup.enable ~= true then
            return false
        end
        if type(conditionGroup.condition) ~= "table" then
            return false
        end
        
        
        -- print("--------------- CheckCondition Start --------------- " .. tostring(unitFrame.namePlateUnitGUID))
        -- print("Condition Name: " .. conditionGroup.name)
        -- for i, v in pairs(conditionGroup.condition) do
        --     print(string.format("i: %d,    v: %d", i, v))
        -- end
        
        local pass = true
        for i, v in ipairs(conditionGroup.condition) do
            if v == modTable.ConditionType.Execute then
                --print("CheckCondition -- Enter Execute")
                pass = modTable.CheckexecuteCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.Upexecute then
                --print("CheckCondition -- Enter Upexecute")
                pass = modTable.CheckUpexecuteCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.Specified then
                -- print("CheckCondition -- Enter Specified")
                pass = modTable.CheckSpecifiedCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.Target then
                --print("CheckCondition -- Enter Target")
                pass = modTable.CheckTargetCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.WithBuff then
                -- print("CheckCondition -- Enter WithBuff")
                pass = modTable.CheckWithBuffCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.WithoutBuff then
                -- print("CheckCondition -- Enter WithoutBuff")
                pass = modTable.CheckWithoutBuffCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.WithBuffFromPlayer then
                -- print("CheckCondition -- Enter WithBuffFromPlayer")
                pass = modTable.CheckWithBuffFromPlayerCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.WithoutBuffFromPlayer then
                -- print("CheckCondition -- Enter WithoutBuffFromPlayer")
                pass = modTable.CheckWithoutBuffFromPlayerCondition(unitFrame, conditionGroup.value[i], conditionGroup)
                -- print("CheckCondition -- Enter WithoutBuffFromPlayer -- pass: " .. tostring(pass))
            elseif v == modTable.ConditionType.Combat then
                --print("CheckCondition -- Enter Combat")
                pass = modTable.CheckCombatCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.NoCombat then
                --print("CheckCondition -- Enter NoCombat")
                pass = modTable.CheckNoCombatCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.PlayerCombat then
                --print("CheckCondition -- Enter PlayerCombat")
                pass = modTable.CheckPlayerCombatCondition(unitFrame, conditionGroup.value[i], conditionGroup)
                -- print("CheckCondition -- Enter PlayerCombat -- pass: " .. tostring(pass))
            elseif v == modTable.ConditionType.PlayerNoCombat then
                --print("CheckCondition -- Enter PlayerNoCombat")
                pass = modTable.CheckPlayerNoCombatCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.Focus then
                --print("CheckCondition -- Enter Focus")
                pass = modTable.CheckFocusCondition(unitFrame, conditionGroup.value[i], conditionGroup)
            elseif v == modTable.ConditionType.Mark then
                --print("CheckCondition -- Enter Mark")
                pass = modTable.CheckMarkCondition(unitFrame, conditionGroup.value[i], conditionGroup)

                -- don't want mark chang color
                pass = false
            else
                print("Plater Mod -- Extened Color -- Unknown Condition: " .. tostring(v))
                pass = false
            end
            
            if pass == false then
                -- print("--------------- CheckCondition End False ---------------")
                modTable.Clear(unitFrame)
                return pass
            end
        end
        
        -- print("--------------- CheckCondition End True ---------------")
        return pass
    end
    
    function modTable.ApplyCondition(conditionGroup, unitFrame, envTable)
        if conditionGroup.typeshow == modTable.TypeShow.Color then
            envTable.FullBarFlash:Stop()
            -- if unitFrame._SelfMarkType ~= nil and (conditionGroup.typevalue == "" or conditionGroup.typevalue == nil) then
            --     -- local localplaterlcolor = Plater.GetNpcColor (unitFrame)
            --     -- if localplaterlcolor ~= nil then
            --     --     Plater.SetNameplateColor(unitFrame, localplaterlcolor)
            --     -- else
            --         Plater.SetNameplateColor(unitFrame, modTable.MarkColor[unitFrame._SelfMarkType])
            --     -- end
                
            -- else
            local localplaterlcolor = Plater.GetNpcColor (unitFrame)
            if localplaterlcolor ~= nil  and (conditionGroup.typevalue == "" or conditionGroup.typevalue == nil) then
                Plater.SetNameplateColor(unitFrame, localplaterlcolor)
            else
                -- print(conditionGroup.typevalue)
                Plater.SetNameplateColor(unitFrame, conditionGroup.typevalue)
            end
                
            -- end
        elseif conditionGroup.typeshow == modTable.TypeShow.Flash then
            Plater.SetNameplateColor(unitFrame, "red")
            envTable.FullBarFlash:Play()
        end
        
        modTable.Clear(unitFrame)
    end
    
    function modTable.CheckexecuteCondition(unitFrame, param, conditionGroup)
        if not modTable.VerifyParamNum(param[1], conditionGroup) then
            return false
        end

        -- localplaterlcolor >> CheckexecuteCondition
        local localplaterlcolor = Plater.GetNpcColor (unitFrame)
        if localplaterlcolor ~= nil  then
            return false
        end

        local percent = unitFrame.healthBar.CurrentHealth / unitFrame.healthBar.CurrentHealthMax
        
        if percent <= param[1] then
            return true
        else
            return false
        end
    end
    
    function modTable.CheckUpexecuteCondition(unitFrame, param, conditionGroup)
        if not modTable.VerifyParamNum(param[1], conditionGroup) then
            return false
        end
        -- localplaterlcolor >> CheckUpexecuteCondition
        local localplaterlcolor = Plater.GetNpcColor (unitFrame)
        if localplaterlcolor ~= nil  then
            return false
        end

        local percent = unitFrame.healthBar.CurrentHealth / unitFrame.healthBar.CurrentHealthMax
        
        if percent >= param[1] then
            return true
        else
            return false
        end
    end
    
    function modTable.CheckSpecifiedCondition(unitFrame, param, conditionGroup)

        -- localplaterlcolor >> CheckSpecifiedCondition
        local localplaterlcolor = Plater.GetNpcColor (unitFrame)
        if localplaterlcolor ~= nil  then
            return false
        end

        for _, v in ipairs(param) do
            if v == unitFrame.namePlateUnitNameLower or v == unitFrame.namePlateUnitName or v == unitFrame.namePlateNpcId then
                return true
            end
        end
        
        return false
    end
    
    function modTable.CheckTargetCondition(unitFrame, param, conditionGroup)
        if unitFrame.namePlateIsTarget then
            return true
        else
            return false
        end
    end
    
    function modTable.CheckWithBuffCondition(unitFrame, param, conditionGroup)
        for _, v in ipairs(param) do
            -- print(v)
            if Plater.NameplateHasAura(unitFrame, tonumber(v) or v) then
                -- print(tonumber(v))
                -- print("start")
                -- print(v)
                return true
            end
        end
        -- print("nothing")
        return false
    end
    
    function modTable.CheckWithoutBuffCondition(unitFrame, param, conditionGroup)
        if #param == 0 then
            return false
        end
        
        for _, v in ipairs(param) do
            if Plater.NameplateHasAura(unitFrame, tonumber(v) or v) then
                return false
            end
        end
        
        return true
    end
    
    function modTable.CheckWithBuffFromPlayerCondition(unitFrame, param, conditionGroup)
        for _, paramV in ipairs(param) do
            local id = tonumber(paramV) or paramV
            for _, v in ipairs(unitFrame.BuffFrame.PlaterBuffList) do
                if v.Caster == "player" and (v.SpellId == id or v.SpellName == id) and v.InUse == true then
                    return true
                end
            end
            for _, v in ipairs(unitFrame.BuffFrame2.PlaterBuffList) do
                if v.Caster == "player" and (v.SpellId == id or v.SpellName == id) and v.InUse == true then
                    return true
                end
            end
            if unitFrame.ExtraIconFrame.AuraCache[id] then
                return true
            end
        end
        
        return false
    end
    
    function modTable.CheckWithoutBuffFromPlayerCondition(unitFrame, param, conditionGroup)
        if #param == 0 then
            return false
        end
        
        for _, paramV in ipairs(param) do
            local id = tonumber(paramV) or paramV
            for k, v in ipairs(unitFrame.BuffFrame.PlaterBuffList) do
                if v.Caster == "player" and (v.SpellId == id or v.SpellName == id) and v.InUse == true then
                    return false
                end
            end
            for k, v in ipairs(unitFrame.BuffFrame2.PlaterBuffList) do
                if v.Caster == "player" and (v.SpellId == id or v.SpellName == id) and v.InUse == true then
                    return false
                end
            end
            if unitFrame.ExtraIconFrame.AuraCache[id] then
                return false
            end
        end
        
        return true
    end
    
    function modTable.CheckCombatCondition(unitFrame, param, conditionGroup)
        return unitFrame.InCombat
    end
    
    function modTable.CheckNoCombatCondition(unitFrame, param, conditionGroup)
        return not unitFrame.InCombat
    end
    
    function modTable.CheckPlayerCombatCondition(unitFrame, param, conditionGroup)
        return UnitAffectingCombat("player")
    end
    
    function modTable.CheckPlayerNoCombatCondition(unitFrame, param, conditionGroup)
        return not UnitAffectingCombat("player")
    end
    
    function modTable.CheckFocusCondition(unitFrame, param, conditionGroup)
        return unitFrame.IsFocus
    end
    
    function modTable.CheckMarkCondition(unitFrame, param, conditionGroup)
        -- 标记参数只取第一个
        
        -- 参数空值，只要有标记就通过
        if param[1] == nil then
            local raidMark = Plater.GetRaidMark(unitFrame)
            if raidMark ~= nil then
                unitFrame._SelfMarkType = raidMark
                return true
            else
                return false
            end
            -- 参数不为空，判断标记
        else
            if not modTable.VerifyParamNum(param[1], conditionGroup) then
                return false
            end
            
            local raidMark = Plater.GetRaidMark(unitFrame)
            return raidMark ~= nil and raidMark == param[1];
        end
    end
    
    function modTable.VerifyParamNum(param, conditionGroup)
        if type(param) == "number" then
            return true;
        else
            print("value字段有值类型错误，查看：" .. conditionGroup.name)
            return false;
        end
    end
    
    function modTable.VerifyParamStr(param, conditionGroup)
        if type(param) == "string" then
            return true;
        else
            print("value字段有值类型错误，查看：" .. conditionGroup.name)
            return false;
        end
    end
    
    function modTable.Clear(unitFrame)
        unitFrame._SelfMarkType = nil;
    end
end

