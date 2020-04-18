local modmastersim = GLOBAL.TheNet:GetIsMasterSimulation()

 -- 系统设置无草蜥蜴
TUNING.GRASSGEKKO_MORPH_CHANCE = 0

if modmastersim then
    -- 草蜥蜴变草
    local function TurnIntoGrass(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        local grass = SpawnPrefab("grass")
        grass.Transform:SetPosition(x, y, z)
        inst:Remove()
    end

    local function DelaySwap(inst)
        inst:DoTaskInTime(0, TurnIntoGrass)
    end

    AddPrefabPostInit("grassgekko", DelaySwap)
end