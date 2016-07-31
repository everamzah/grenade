local def = {
	name = "grenade:explosion",
	description = "Grenade Explosion (you hacker you!)",
	radius = 6,
	radius_damage = 6,
}

tnt.register_tnt(def)



minetest.register_craftitem("grenade:grenade", {
	description = "Grenade",
	inventory_image = "default_coal_lump.png",
	on_use = function(itemstack, user, pointed_thing)
		local v = user:get_look_dir()
		local pos = user:getpos()
		pos.y = pos.y + 1.2

		local obj = minetest.add_entity(pos, "grenade:grenade")

		obj:setvelocity({x = v.x * 4, y = v.y * 4 + 4, z = v.z * 4})
		obj:setacceleration({x = v.x / 16, y = v.y / 16 - 16, z = v.z / 16})
	end,
})

minetest.register_entity("grenade:grenade", {
	physical = true,
	collide_with_objects = true,
	weight = 5,
	textures = {"default_coal_lump.png"},
	on_activate = function(self, staticdata)
	end,
	on_step = function(self, dtime)
		--[[
		local acc = self.object:getacceleration()
		local vel = self.object:getvelocity()

		self.object:setvelocity({x = vel.x, y = vel.y, z = vel.z})
		self.object:setacceleration({x = acc.x, y = acc.y, z = acc.z})
		--]]
	end,
})
