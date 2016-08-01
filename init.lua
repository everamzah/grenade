local def = {
	name = "grenade:explosion",
	description = "Grenade Explosion (you hacker you!)",
	radius = 3,
	tiles = {
		side = "default_dirt.png",
		top = "default_dirt.png",
		bottom = "default_dirt.png",
		burning = "default_dirt.png"
	},
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
		obj:setvelocity({x = v.x * 4, y = v.y * 2 + 4, z = v.z * 4})
		obj:setacceleration({x = v.x / 4, y = v.y / 2 - 4, z = v.z / 4})

		itemstack:take_item()
		return itemstack
	end,
})

minetest.register_entity("grenade:grenade", {
	physical = true,
	collide_with_objects = true,
	weight = 5,
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	textures = {"default_coal_lump.png"},
	on_activate = function(self, staticdata)
		self.timer = 0
	end,
	on_step = function(self, dtime)
		local acc = self.object:getacceleration()
		self.object:setacceleration({x = acc.x * 2 / 4, y = acc.y, z = acc.z * 2 / 4})

		self.timer = self.timer + dtime
		if self.timer > 4 then
			tnt.boom(self.object:getpos(), def)
		end
	end,
})
