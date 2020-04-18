-- 未修改，mod来源：https://steamcommunity.com/sharedfiles/filedetails/?id=856487758

--[[
	If any Klei dev finds themselves snooping around in this code, I'm fairly certain that you can completely replicate this mod by putting the following 3 lines of code at line 163 in the playeractionpicker component! Thx, luv ya!
	
	if self.inst.components.playercontroller:IsControlPressed(CONTROL_FORCE_TRADE) then
		sorted_acts = self:SortActionList({ ACTIONS.DROP }, nil, useitem)
	end
]]

local _G = GLOBAL
local invslot = _G.require("widgets/invslot")
local equipslot = _G.require("widgets/equipslot")

local function DropItem(item, owner, wholestack)
	owner.replica.inventory:DropItemFromInvTile(item, wholestack)
	return true
end

local function OnControlHook(self)
	local _oldOnControl = self.OnControl
	function self:OnControl(control, down, ...)
		if down and control == _G.CONTROL_SECONDARY and _G.TheInput:IsControlPressed(_G.CONTROL_FORCE_TRADE) and self.tile then
			return DropItem(self.tile.item, self.owner, _G.TheInput:IsControlPressed(_G.CONTROL_FORCE_STACK) and true or false)
		else
			return _oldOnControl(self, control, down, ...)
		end
	end
end

OnControlHook(invslot)
OnControlHook(equipslot)

AddComponentPostInit("playeractionpicker", function(self)
	local _oldGetInventoryActions = self.GetInventoryActions
	function self:GetInventoryActions(useitem, right)
		local sorted_acts = _oldGetInventoryActions(self, useitem, right)
		if self.inst.components.playercontroller:IsControlPressed(_G.CONTROL_FORCE_TRADE) then
			sorted_acts = self:SortActionList({ _G.ACTIONS.DROP }, nil, useitem)
		end
		return sorted_acts
	end
end)