|T135903:0|t驱邪术   27138

|T135959:0|t审判   20271


|T135874:0|t复仇者之盾  32700

|T135068:0|t正义防御  31789






function(n,s,t)
    --print(aura_env.name,aura_env.spell,aura_env.type)
    local type_ = ""
    if aura_env.type == "MISS" then type_ = "未命中"
    elseif aura_env.type == "PARRY" then type_ = "招架"
    elseif aura_env.type == "DODGE" then type_ = "躲闪"
    elseif aura_env.type =="IMMUNE" then type_ = "免疫"
    elseif aura_env.type == "RESIST"  then type_ = "抵抗"
    elseif aura_env.type == "BLOCK" then type_ = "格挡"
    end
    local spell_ = ""
    if aura_env.spell == "盾牌猛击" then spell_ =  "|T135806:0|t盾牌猛击"
    elseif aura_env.spell  == "破甲攻击" then spell_ = "|T132363:0|t破甲攻击"
    elseif aura_env.spell  =="嗜血"  then spell_ = "|T136012:0|t嗜血"
    elseif aura_env.spell  == "复仇" then spell_ = "|T132353:0|t复仇"
    elseif aura_env.spell  == "英勇打击" then spell_ = "|T132282:0|t英勇打击"
    elseif aura_env.spell  == "驱邪术" then spell_ = "|T135903:0|t驱邪术"
    elseif aura_env.spell  == "审判" then spell_ = "|T135959:0|t审判"
    elseif aura_env.spell  == "复仇者之盾" then spell_ = "|T135874:0|t复仇者之盾"
    end
    -- print(aura_env.name,spell_,type_)
    if WeakAuras.IsOptionsOpen()  then
        return "|cffc69b6d"..UnitName("player").."|r","|T136012:0|t嗜血","|cffc41e3a".."招架".."|r"
    else
        return  "|cffc69b6d"..aura_env.name.."|r",spell_ ,"|cffc41e3a"..type_.."|r"
    end
end






