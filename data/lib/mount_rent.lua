MOUNT_H = {
	["war horse"] 			= {price = 10000, hours = 2, mountid = 17, level = 10, vip = false, premium = false, storage = 500561},
	["fire war horse"] 		= {price = 30000, hours = 2, mountid = 23, level = 20, vip = true, premium = false, storage = 500562},
	["sandstone scorpion"] 	= {price = 50000, hours = 1, mountid = 21, level = 10, vip = false, premium = true, storage = 500563}
}

function Player.checkRentMounts(self)

	for name, v in pairs(MOUNT_H) do
		if (self:hasMount(v.mountid)) and (self:getStorageValue(v.storage) ~= -1) and (self:getStorageValue(v.storage) <= os.time()) then
			self:removeMount(v.mountid)	
			
			local outfit = self:getOutfit()
			outfit.lookMount = 0
			self:setOutfit(outfit)

			self:sendTextMessage(MESSAGE_INFO_DESC, "The time of your mount ".. name .." has ended.")
			self:setStorageValue(v.storage, -1)
		end
	end		

	return true
end