local S = subcaverna.translator

minetest.register_node("subcaverna:umbratus_log", {
	description = S("Umbratus Log"),
	tiles = {"subcaverna_umbratus_log_top.png", "subcaverna_umbratus_log_top.png", "subcaverna_umbratus_log_side.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	on_place = subcaverna.place_log,
	paramtype2 = "facedir",
	is_ground_content = false
})

minetest.register_node("subcaverna:umbratus_bark", {
	description = S("Umbratus Bark"),
	tiles = {"subcaverna_umbratus_log_side.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	on_place = subcaverna.place_log,
	paramtype2 = "facedir",
	is_ground_content = false
})

minetest.register_node("subcaverna:umbratus_cap", {
	description = S("Umbratus Cap"),
	tiles = {"subcaverna_umbratus_cap.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	is_ground_content = false
})

minetest.register_node("subcaverna:umbratus_hymenophore", {
	description = S("Umbratus Hymenophore"),
	tiles = {"subcaverna_umbratus_cap.png", "subcaverna_umbratus_hymenophore_bottom.png", "subcaverna_umbratus_hymenophore_side.png"},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	light_source = 14,
	drop = "subcaverna:umbratus_cap",
	is_ground_content = false
})

minetest.register_node("subcaverna:umbratus_planks", {
	description = S("Umbratus Planks"),
	tiles = {"subcaverna_umbratus_planks.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	is_ground_content = false
})

local box = {
	type = "fixed",
	fixed = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25}
}

minetest.register_node("subcaverna:umbratus_light_middle", {
	description = S("Umbratus Light"),
	tiles = {"subcaverna_umbratus_light_middle.png"},
	drawtype = "plantlike",
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	sunlight_propagates = true,
	light_source = 14,
	selection_box = box,
	walkable = false,
	is_ground_content = false
})

minetest.register_node("subcaverna:umbratus_light_bottom", {
	description = S("Umbratus Light"),
	tiles = {"subcaverna_umbratus_light_bottom.png"},
	drawtype = "plantlike",
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	sunlight_propagates = true,
	light_source = 14,
	selection_box = box,
	walkable = false,
	is_ground_content = false
})

box = {
	type = "fixed",
	fixed = {
		{-0.125, -0.5, -0.125, 0.125, 0.125, 0.125},
		{-0.125, -0.125, 0.125, 0.125, 0.125, 1.5}
	}
}

minetest.register_node("subcaverna:umbratus_branch", {
	description = S("Umbratus Branch"),
	tiles = {"subcaverna_umbratus_branch.png"},
	drawtype = "mesh",
	mesh = "subcaverna_umbratus_branch.obj",
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, attached_node = 1},
	sounds = subcaverna.sounds.wood(),
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	selection_box = box,
	collision_box = box,
	drop = "subcaverna:umbratus_log",
	is_ground_content = false
})

minetest.register_node("subcaverna:umbratus_placer", {
	description = S("Umbratus Placer"),
	on_place = function(itemstack, placer, pointed_thing)
		subcaverna.place_feature(pointed_thing.above, subcaverna.trees.umbratus)
	end,
	is_ground_content = false
})

minetest.register_node("subcaverna:umbratus_small", {
	description = S("Umbratus Small"),
	drawtype = "plantlike",
	tiles = {"subcaverna_umbratus_small.png"},
	inventory_image = "subcaverna_umbratus_small.png",
	wield_image = "subcaverna_umbratus_small.png",
	light_source = 5,
	groups = {snappy = 3, flora = 1, attached_node = 1, flammable = 1},
	sounds = subcaverna.sounds.leaves(),
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	is_ground_content = false
})

box = {
	type = "fixed",
	fixed = {-0.125, -0.5, -0.125, 0.125, 0.5, 0.125}
}

minetest.register_node("subcaverna:umbratus_medium_bottom", {
	description = S("Umbratus Small"),
	drawtype = "nodebox",
	tiles = {"subcaverna_umbratus_log_side.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	paramtype = "light",
	walkable = false,
	node_box = box,
	is_ground_content = false
})

box = {
	type = "fixed",
	fixed = {
		{-0.5, 0.0, -0.5, 0.5, 0.5, 0.5},
		{-0.125, -0.5, -0.125, 0.125, 0.0, 0.125}
	}
}

minetest.register_node("subcaverna:umbratus_medium_top", {
	description = S("Umbratus Small"),
	drawtype = "mesh",
	mesh = "subcaverna_umbratus_medium_top.obj",
	tiles = {
		"subcaverna_umbratus_branch.png",
		"subcaverna_umbratus_hymenophore_bottom.png",
		"subcaverna_umbratus_hymenophore_side.png",
		"subcaverna_umbratus_cap.png"
	},
	light_source = 7,
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = subcaverna.sounds.wood(),
	paramtype = "light",
	selection_box = box,
	collision_box = box,
	is_ground_content = false
})

local LOG_ID, BARK_ID, BRANCH_ID, HYMENOPHORE_ID, CAP_ID, LIGHT_MIDDLE_ID, LIGHT_BOTTOM_ID
local pos = {x = 0, y = 0, z = 0}

subcaverna.trees.umbratus = function(context)
	if not LOG_ID then
		LOG_ID = minetest.get_content_id("subcaverna:umbratus_log")
		BARK_ID = minetest.get_content_id("subcaverna:umbratus_bark")
		BRANCH_ID = minetest.get_content_id("subcaverna:umbratus_branch")
		HYMENOPHORE_ID = minetest.get_content_id("subcaverna:umbratus_hymenophore")
		CAP_ID = minetest.get_content_id("subcaverna:umbratus_cap")
		LIGHT_MIDDLE_ID = minetest.get_content_id("subcaverna:umbratus_light_middle")
		LIGHT_BOTTOM_ID = minetest.get_content_id("subcaverna:umbratus_light_bottom")
	end

	local height = math.random(5, 7)
	pos.x = 0
	pos.y = 0
	pos.z = 0

	for i = 1, height, 2 do
		pos.y = i
		if not subcaverna.can_replace(context.get_node(pos)) then
			return
		end
	end

	for i = 0, height - 4 do
		pos.y = i
		context.set_node(pos, LOG_ID)
	end
	pos.y = pos.y + 1
	context.set_node(pos, BARK_ID)

	for param2 = 2, 5 do
		local offset = minetest.wallmounted_to_dir(param2)
		pos.x = -offset.x
		pos.z = -offset.z
		if subcaverna.can_replace(context.get_node(pos)) then
			context.set_node(pos, BRANCH_ID, param2)
		end
	end

	pos.y = pos.y + 2

	for dx = -2, 2 do
		local ax = math.abs(dx)
		pos.x = dx
		for dz = -2, 2 do
			local az = math.abs(dz)
			pos.z = dz
			if (ax ~= 2 or az ~= 2) and subcaverna.can_replace(context.get_node(pos)) then
				context.set_node(pos, HYMENOPHORE_ID)

				local y = pos.y

				pos.y = pos.y - 2
				if not subcaverna.can_replace(context.get_node(pos)) then
					goto place_break
				end

				pos.y = pos.y + 1
				if not subcaverna.can_replace(context.get_node(pos)) then
					goto place_break
				end

				for i = 1, math.random(0, 2) do
					context.set_node(pos, LIGHT_MIDDLE_ID)
					pos.y = pos.y - 1
					if not subcaverna.can_replace(context.get_node(pos)) then
						pos.y = pos.y + 1
					end
				end

				context.set_node(pos, LIGHT_BOTTOM_ID)

				::place_break::
				pos.y = y
			end
		end
	end

	pos.y = pos.y + 1

	for dx = -1, 1 do
		pos.x = dx
		for dz = -1, 1 do
			pos.z = dz
			if subcaverna.can_replace(context.get_node(pos)) then
				context.set_node(pos, CAP_ID)
			end
		end
	end
end

local BOTTOM_ID, TOP_ID

subcaverna.trees.umbratus_medium = function(context)
	if not BOTTOM_ID then
		BOTTOM_ID = minetest.get_content_id("subcaverna:umbratus_medium_bottom")
		TOP_ID = minetest.get_content_id("subcaverna:umbratus_medium_top")
	end

	pos.x = 0
	pos.z = 0
	pos.y = 1

	if subcaverna.can_replace(context.get_node(pos)) then
		context.set_node(pos, TOP_ID)
		pos.y = 0
		context.set_node(pos, BOTTOM_ID)
	end
end

local SMALL_ID
local surface = minetest.get_content_id("subcaverna:red_moss")

local function place_small(pos, context)
	context.set_node(pos, SMALL_ID)
end

subcaverna.trees.umbratus_small = function(context)
	if not SMALL_ID then
		SMALL_ID = minetest.get_content_id("subcaverna:umbratus_small")
	end
	subcaverna.scatter.scatter_flat(context, 3, 5, surface, place_small)
end