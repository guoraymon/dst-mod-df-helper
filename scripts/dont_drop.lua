AddComponentPostInit("container", function(Container, inst)
    function Container:DropAmulet()
        for k, v in pairs(self.slots) do
            if v and v.prefab == "amulet" then
                self:DropItem(v)
                return true
            end
        end
        return false
    end

    function Container:DropReviver()
        for k, v in pairs(self.slots) do
            if v and v.prefab == "reviver" then
                self:DropItem(v)
                return true
            end
        end
        return false
    end
end)

AddComponentPostInit("inventory", function(Inventory, inst)
	Inventory.oldDropEverythingFn = Inventory.DropEverything
	
	function Inventory:DropAmulet()
		for k = 0, self.maxslots do
			local v = self.itemslots[k]
			if v and v.prefab == "amulet" then
				self:DropItem(v, true, true)
				return true
			end
		end
		for k, v in pairs(self.equipslots) do
			if v and v.prefab == "amulet" then
				self:DropItem(v, true, true)
				return true
			end
		end
		return false
    end
    
	function Inventory:ReserveOneEmptySlot()
		local has_empty_slot = false
		local last_slot_item = nil
		
		for k = 0, self.maxslots do
			local v = self.itemslots[k]
			if v == nil then
				has_empty_slot = true
				break
			else
				last_slot_item = v
			end
		end
		if not has_empty_slot and last_slot_item ~= nil then
			self:DropItem(last_slot_item, true, true)
			has_empty_slot = true
		end
		return has_empty_slot
    end
    
	function Inventory:DropReviver()
		for k, v in pairs(self.itemslots) do
			if v and v.prefab == "reviver" then
				self:DropItem(v, true, true)
				return true
			end
		end
		return false
	end

	function Inventory:PlayerDropEverything(ondeath)
		local is_amulet_dropped = self.inst.components.inventory:DropAmulet()
		if not is_amulet_dropped then
			for k, v in pairs(self.equipslots) do
				if v:HasTag("backpack") and v.components.container then
					is_amulet_dropped = v.components.container:DropAmulet()
					break
				end
			end
		end
		if not is_amulet_dropped then
			local is_reviver_dropped = self.inst.components.inventory:DropReviver()
			if not is_reviver_dropped then
				for k, v in pairs(self.equipslots) do
					if v:HasTag("backpack") and v.components.container then
						is_reviver_dropped = v.components.container:DropReviver()
						break
					end
				end
			end
		end
		self.inst.components.inventory:ReserveOneEmptySlot()
	end

	function Inventory:DropEverything(ondeath, keepequip)
		if not inst:HasTag("player") then
			return Inventory:oldDropEverythingFn(ondeath, keepequip)
		else
			return Inventory:PlayerDropEverything(ondeath, keepequip)
		end
	end
end)