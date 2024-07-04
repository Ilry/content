local stack_size = GetModConfigData("STACK_SIZE")

GLOBAL.TUNING.STACK_SIZE_LARGEITEM = stack_size
GLOBAL.TUNING.STACK_SIZE_MEDITEM = stack_size
GLOBAL.TUNING.STACK_SIZE_SMALLITEM = stack_size
GLOBAL.TUNING.STACK_SIZE_TINYITEM = stack_size
GLOBAL.TUNING.WORTOX_MAX_SOULS = stack_size


local function OnStackSizeDirty(inst)
	local self = inst.replica.stackable
	if not self then
		return
	end

	self:ClearPreviewStackSize()
	inst:PushEvent("inventoryitem_stacksizedirty")
end
	
local mod_stackable_replica = GLOBAL.require("components/stackable_replica")

mod_stackable_replica._ctor = function(self, inst)
	self.inst = inst
	self._stacksize = GLOBAL.net_shortint(inst.GUID, "stackable._stacksize", "stacksizedirty")
	self._stacksizeupper = GLOBAL.net_shortint(inst.GUID, "stackable._stacksizeupper", "stacksizedirty")
	self._ignoremaxsize = GLOBAL.net_bool(inst.GUID, "stackable._ignoremaxsize")
	self._maxsize = GLOBAL.net_shortint(inst.GUID, "stackable._maxsize")
	
	if not GLOBAL.TheWorld.ismastersim then
		inst:ListenForEvent("stacksizedirty", OnStackSizeDirty)
	end
end