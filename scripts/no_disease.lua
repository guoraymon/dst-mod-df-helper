local modmastersim = GLOBAL.TheNet:GetIsMasterSimulation()

local SpawnPrefab = GLOBAL.SpawnPrefab
local TUNING = GLOBAL.TUNING

-- no more disease appearing
TUNING.DISEASE_CHANCE = 0
TUNING.DISEASE_DELAY_TIME = 0
TUNING.DISEASE_DELAY_TIME_VARIANCE = 0

if modmastersim then
	-- cure stuff if there is something diseased
	local function TurnIntoNormal(inst)
		local x, y, z = inst.Transform:GetWorldPosition()
		local normal = SpawnPrefab(inst.prefab)
		normal.Transform:SetPosition(x, y, z)
		inst:Remove()
	end
	local function DelayCure(self)
		if self:IsDiseased() or self:IsBecomingDiseased() then
			self.inst:DoTaskInTime(0, TurnIntoNormal)
		end
	end
	AddComponentPostInit("diseaseable", DelayCure)
end