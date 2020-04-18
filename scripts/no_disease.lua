local modmastersim = GLOBAL.TheNet:GetIsMasterSimulation()

 -- 系统设置无疾病
TUNING.DISEASE_CHANCE = 0
TUNING.DISEASE_DELAY_TIME = 0
TUNING.DISEASE_DELAY_TIME_VARIANCE = 0

if modmastersim then
	-- 治好患病植物
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