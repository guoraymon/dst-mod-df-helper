-- 加注释，mod来源：https://steamcommunity.com/sharedfiles/filedetails/?id=362175979

GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end})

local StackRange = GetModConfigData("drop_stack") -- 堆叠范围

local function FindEntities(x, y, z)
	return TheSim:FindEntities(x, y, z, StackRange, {'_stackable', '_inventoryitem'}, {'INLIMBO', 'NOCLICK'})
end

local function Put(inst, value)
	if value ~= inst and value.prefab == inst.prefab and value.skinname == inst.skinname then
		local fx = SpawnPrefab('sand_puff')
		fx.Transform:SetPosition(value.Transform:GetWorldPosition())
		inst.components.stackable:Put(value)
	end
end

-- 普通掉落堆叠
AddPrefabPostInitAny(function(inst)
	if not TheWorld.ismastersim then return end
	if inst.components.stackable == nil or inst.components.inventoryitem == nil then return end
	inst:ListenForEvent('on_loot_dropped', function(inst)
		inst:DoTaskInTime(.5, function(inst)
			if inst and inst:IsValid() and not inst.components.stackable:IsFull() then
				local x, y, z = inst.Transform:GetWorldPosition()
				for key, value in pairs(FindEntities(x, y, z)) do
					if value and value:IsValid() and not value.components.stackable:IsFull() then Put(inst, value) end
				end
			end
		end)
	end)
end)

local function PutPut(inst, x, y, z, time, ents, prefabs)
	inst:DoTaskInTime(time + FRAMES, function(inst)
		for key, value in pairs(FindEntities(x, y, z)) do
			if value and value:IsValid() and table.contains(prefabs, value.prefab) and not table.contains(ents, value) then
				value:PushEvent('on_loot_dropped', {dropper = inst})
			end
		end
	end)
end

-- 猪王交易堆叠
AddPrefabPostInit('pigking', function(inst)
	local pigking_prefabs = {'goldnugget'}
	if IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS) then
		for i = 1, NUM_HALLOWEENCANDY do table.insert(pigking_prefabs, 'halloweencandy_' .. i) end
	end
	if not TheWorld.ismastersim then return end
	if inst.components.trader == nil then return end
	local OnGetItemFromPlayer = inst.components.trader.onaccept
	inst.components.trader.onaccept = function(inst, giver, item)
		if OnGetItemFromPlayer then
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = FindEntities(x, y, z)
			if item.components.tradable.tradefor then
				for _, v in pairs(item.components.tradable.tradefor) do table.insert(pigking_prefabs, v) end
			end
			OnGetItemFromPlayer(inst, giver, item)
			PutPut(inst, x, y, z, 2 / 3, ents, pigking_prefabs)
		end
	end
end)

-- 猪人便便堆叠
AddPrefabPostInit('pigman', function(inst)
	if not TheWorld.ismastersim then return end
	if inst.components.eater == nil then return end
	local OnEat = inst.components.eater.oneatfn
	inst.components.eater.oneatfn = function(inst, food)
		if OnEat then
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = FindEntities(x, y, z)
			OnEat(inst, food)
			PutPut(inst, x, y, z, 0, ents, {'poop'})
		end
	end
end)

-- 石果掉落堆叠
AddPrefabPostInit('rock_avocado_fruit', function(inst)
	if not TheWorld.ismastersim then return end
	if inst.components.workable == nil then return end
	local on_mine = inst.components.workable.onwork
	inst.components.workable.onwork = function(inst, miner, workleft, workdone)
		if on_mine then
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = FindEntities(x, y, z)
			on_mine(inst, miner, workleft, workdone)
			PutPut(inst, x, y, z, 0, ents, {'rock_avocado_fruit_ripe', 'rock_avocado_fruit_sprout', 'rocks'})
		end
	end
end)

-- 地皮堆叠
AddComponentPostInit('terraformer', function(self, inst)
	local GroundTiles = require('worldtiledefs')
	local OldTerraform = self.Terraform
	self.Terraform = function(self, pt, spawnturf)
		local x, y, z = inst.Transform:GetWorldPosition()
		local ents = FindEntities(x, y, z)
		local original_tile_type = TheWorld.Map:GetTileAtPoint(pt:Get())
		spawnturf = spawnturf and GroundTiles.turf[original_tile_type] or nil
		local bool = OldTerraform(self, pt, spawnturf)
		if bool and spawnturf then PutPut(inst, x, y, z, 0, ents, {'turf_' .. spawnturf.name}) end
		return bool
	end
end)

-- 刮剃堆叠
AddComponentPostInit('beard', function(self, inst)
	local OldShave = self.Shave
	self.Shave = function(self, who, withwhat)
		local x, y, z = inst.Transform:GetWorldPosition()
		local ents = FindEntities(x, y, z)
		local bool = OldShave(self, who, withwhat)
		if bool and self.prize then PutPut(inst, x, y, z, 0, ents, {self.prize}) end
		return bool
	end
end)
