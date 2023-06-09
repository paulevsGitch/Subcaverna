local S = subcaverna.translator

minetest.register_node("subcaverna:wood_01", {
	description = S("Wood"),
	tiles = {{name = "subcaverna_wood_01.png", align_style = "world", scale = 4}},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	is_ground_content = false
})


minetest.register_node("subcaverna:moss_01", {
	description = S("Moss"),
	tiles = {"subcaverna_moss_01.png", "default_stone.png", "default_stone.png^subcaverna_moss_side_01.png"},
	groups = {cracky = 3, soil = 1},
	sounds = subcaverna.sounds.stone({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
	is_ground_content = false
})

minetest.register_node("subcaverna:moss_02", {
	description = S("Moss"),
	tiles = {"default_stone.png^subcaverna_moss_02.png", "default_stone.png", "default_stone.png^subcaverna_moss_side_01.png"},
	groups = {cracky = 3, soil = 1},
	sounds = subcaverna.sounds.stone({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
	is_ground_content = false
})

minetest.register_node("subcaverna:moss_cover_01", {
	description = S("Moss"),
	drawtype = "nodebox",
	tiles = {"subcaverna_moss_cover_01.png"},
	inventory_image = "subcaverna_moss_cover_01.png",
	wield_image = "subcaverna_moss_cover_01.png",
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	sounds = subcaverna.sounds.leaves(),
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	connects_to = {"group:cave_moss_connect"},
	node_box = {
		type = "connected",
		connect_top = {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		connect_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		connect_front = {-0.5, -0.5, -0.5, 0.5, 0.5, -0.4375},
		connect_back = {-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5},
		connect_left = {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
		connect_right = {0.4375, -0.5, -0.5, 0.5, 0.5, 0.5}
	},
	is_ground_content = false
})

for i = 1, 3 do
	local texture =  "subcaverna_grass_0" .. i .. ".png"
	local creative = 0
	if i > 1 then creative = 1 end
	minetest.register_node("subcaverna:grass_0" .. i, {
		description = S("Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {texture},
		inventory_image = texture,
		wield_image = texture,
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flora = 1, attached_node = 1, grass = 1, normal_grass = 1, flammable = 1, not_in_creative_inventory = creative},
		sounds = subcaverna.sounds.leaves(),
		selection_box = {
			type = "fixed",
			fixed = {-0.375, -0.5, -0.375, 0.375, -0.3125, 0.375},
		},
		light_source = 3,
		drop = "subcaverna:grass_01",
		on_place = function(itemstack, placer, pointed_thing)
			local stack = ItemStack("subcaverna:grass_0" .. math.random(3))
			local ret = minetest.item_place_node(stack, placer, pointed_thing, 7 + math.random(5))
			return ItemStack("subcaverna:grass_01 " .. itemstack:get_count() - (1 - ret:get_count()))
		end,
		is_ground_content = false
	})
end

minetest.register_on_mods_loaded(function()
	for name, node in pairs(minetest.registered_nodes) do
		if not node.drawtype or node.drawtype == "normal" then
			local node_copy = table.copy(node)
			node_copy.groups = node_copy.groups or {}
			node_copy.groups.cave_moss_connect = 1
			minetest.register_node(":" .. name, node_copy)
		end
	end
end)

-- VINES --

subcaverna.register_vine("subcaverna:baccurose", {
	description = "Baccurose",
	texture = "subcaverna_vine_01.png",
	groups = {snappy = 3, flora = 1, flammable = 1, baccurose_vine = 1},
	is_ground_content = false
})

subcaverna.register_vine("subcaverna:baccurose_berries", {
	description = "Baccurose",
	texture = "subcaverna_baccurose_berries.png",
	groups = {snappy = 3, flora = 1, flammable = 1, baccurose_vine = 1, not_in_creative_inventory = 1},
	light_source = 3,
	is_ground_content = false
})

minetest.register_node("subcaverna:red_moss", {
	description = S("Moss"),
	tiles = {"subcaverna_red_moss_top.png", "default_stone.png", "default_stone.png^subcaverna_red_moss_side.png"},
	groups = {cracky = 3, soil = 1},
	sounds = subcaverna.sounds.stone({
		footstep = {name = "default_grass_footstep", gain = 0.25},
	}),
	is_ground_content = false
})

minetest.register_node("subcaverna:red_grass", {
	description = S("Red Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"subcaverna_red_grass_3.png"},
	inventory_image = "subcaverna_red_grass_3.png",
	wield_image = "subcaverna_red_grass_3.png",
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
	is_ground_content = false
})

local GRASS_ID
local surface = minetest.get_content_id("subcaverna:red_moss")

local function place_grass(pos, context)
	context.set_node(pos, GRASS_ID)
end

subcaverna.plants.red_grass = function(context)
	if not GRASS_ID then
		GRASS_ID = minetest.get_content_id("subcaverna:red_grass")
	end
	subcaverna.scatter.scatter_flat(context, 4, 50, surface, place_grass)
end