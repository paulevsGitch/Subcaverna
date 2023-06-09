local S = subcaverna.translator

minetest.register_node("subcaverna:cave_cyperus", {
	description = S("Red Grass"),
	drawtype = "mesh",
	mesh = "subcaverna_cave_cyperus.obj",
	tiles = {"subcaverna_cave_cyperus.png"},
	inventory_image = "subcaverna_cave_cyperus_item.png",
	wield_image = "subcaverna_cave_cyperus_item.png",
	paramtype = "light",
	paramtype2 = "4dir",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	is_ground_content = false,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, normal_grass = 1, flammable = 1},
	sounds = subcaverna.sounds.leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-0.4375, -0.5, -0.4375, 0.4375, 1.25, 0.4375},
	},
	on_place = function(itemstack, placer, pointed_thing)
		return minetest.item_place_node(itemstack, placer, pointed_thing, math.random(0, 3))
	end
})

local CYPERUS_ID, SURFACE_ID

local function place(pos, context)
	context.set_node(pos, CYPERUS_ID)
end

subcaverna.plants.cave_cyperus = function(context)
	if not CYPERUS_ID then
		CYPERUS_ID = minetest.get_content_id("subcaverna:cave_cyperus")
		SURFACE_ID = minetest.get_content_id("subcaverna:red_moss")
	end
	subcaverna.scatter.scatter_flat(context, 2, 10, SURFACE_ID, place)
end