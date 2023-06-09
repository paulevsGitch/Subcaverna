local S = subcaverna.translator

minetest.register_node("subcaverna:thorny_bloodleaf", {
	description = S("Thorny Bloodleaf"),
	drawtype = "plantlike",
	tiles = {"subcaverna_thorny_bloodleaf.png"},
	inventory_image = "subcaverna_thorny_bloodleaf.png",
	wield_image = "subcaverna_thorny_bloodleaf.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, normal_grass = 1, flammable = 1},
	sounds = subcaverna.sounds.leaves(),
	selection_box = {
		type = "fixed",
		fixed = {-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375},
	},
	is_ground_content = false,
	damage_per_second = 3,
	move_resistance = 6
})

local CYPERUS_ID, SURFACE_ID

local function place(pos, context)
	context.set_node(pos, CYPERUS_ID)
end

subcaverna.plants.thorny_bloodleaf = function(context)
	if not CYPERUS_ID then
		CYPERUS_ID = minetest.get_content_id("subcaverna:thorny_bloodleaf")
		SURFACE_ID = minetest.get_content_id("subcaverna:red_moss")
	end
	subcaverna.scatter.scatter_flat(context, 2, 15, SURFACE_ID, place)
end