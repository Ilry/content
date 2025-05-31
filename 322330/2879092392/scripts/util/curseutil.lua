local CurseUtil = {}

CurseUtil.FXPriorities = {
    yellow = 1,
    orange = 2,
    green = 3,
    opal = 4,
    purple = 5,
    red = 6,
    blue = 7,
}

local CurseFXSizes = {
    small = 0.4,
    med = 0.5,
    large = 0.75,
}

CurseUtil.GetPriorityFor = function(color)
    return CurseUtil.FXPriorities[color] or 0
end

CurseUtil.SetupFX = function(inst, target, fx)
    local heightoffset
    local scaling
    local fsym = target.components.debuffable.followsymbol

    if target:HasTag("epic") and not target:HasTag("smallepic") then
        heightoffset = 11
        scaling = CurseFXSizes["large"]
    elseif target:HasTag("smallepic") then
        heightoffset = 7
        scaling = CurseFXSizes["large"]
    elseif target:HasTag("smallcreature") then
        heightoffset = 2.25
        scaling = CurseFXSizes["small"]
    elseif target:HasTag("insect") then
        heightoffset = 4
        scaling = CurseFXSizes["small"]
    else
        heightoffset = 5
        scaling = CurseFXSizes["med"]
    end

    fx.entity:SetParent(target.entity)
    fx.Follower:FollowSymbol(target.GUID, fsym)
    fx.Follower:SetOffset(0, -heightoffset * 100, 0)
    fx.Transform:SetScale(scaling, scaling, scaling)

    if target.prefab == "lordfruitfly" then
        if inst.prefab ~= "why_arsenal_blue_curse" then
            fx.Transform:SetScale(0.3, 0.3, 0.3)
            fx.Follower:SetOffset(0, -300, 0)
        elseif inst.prefab == "why_arsenal_blue_curse" then
            target._bluecursefx.Transform:SetScale(0.4, 0.4, 0.4)
            target._bluecursefx.Follower:SetOffset(0, -225, 0)
        end
    elseif string.match(target.prefab, "leif") then
        fx.Follower:SetOffset(0, -1000, 0)
    end
end

CurseUtil.SortFX = function(target)
    local debufftbl = target and target.components.debuffable and target.components.debuffable.debuffs or nil

    if not debufftbl then return end

    local cursetbl = {}

    for k, v in pairs(debufftbl) do
        if string.sub(v.inst.prefab, 1, 12) == "why_arsenal_" and string.sub(v.inst.prefab, -6) == "_curse" then
            cursetbl[v.inst.prefab] = string.sub(v.inst.prefab, 13, -7)
        end
    end

    local priority = 0

    for k, v in pairs(cursetbl) do
        priority = math.max(CurseUtil.GetPriorityFor(v), priority)
    end

    target:PushEvent("curseprioritychanged", {priority = priority})
end

return CurseUtil