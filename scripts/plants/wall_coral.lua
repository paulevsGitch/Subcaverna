subcaverna.register_wall_plant("subcaverna:wall_coral", {
	description = "Wall Coral",
	drawtype = "mesh",
	mesh = "subcaverna_wall_coral.obj",
	tiles = {"subcaverna_wall_coral.png"},
	inventory_image = "subcaverna_wall_coral_item.png",
	wield_image = "subcaverna_wall_coral_item.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	sounds = subcaverna.sounds.leaves(),
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	light_source = 5,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.0, 0.5}
	}
})