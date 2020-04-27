local modmastersim = GLOBAL.TheNet:GetIsMasterSimulation()

local SpawnPrefab = GLOBAL.SpawnPrefab
local TUNING = GLOBAL.TUNING

-- no more grass morphing
TUNING.GRASSGEKKO_MORPH_CHANCE = 0

if modmastersim then
	-- gekkos into grass
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