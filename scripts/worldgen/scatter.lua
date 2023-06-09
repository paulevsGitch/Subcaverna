local node_above, node_below
local scattered
local pos = {}

subcaverna.scatter = {}

subcaverna.scatter.scatter_flat = function(context, radius, count, condition_node, place)
	local radius2 = radius * 2
	scattered = 0
	for i = 1, count do
		pos.x = math.floor(math.random() * radius2 + 0.5) - radius
        pos.z = math.floor(math.random() * radius2 + 0.5) - radius
        pos.y = 5
		node_above = context.get_node(pos)
		for j = 1, 11 do
			pos.y = pos.y - 1
			node_below = context.get_node(pos)
			if node_above == minetest.CONTENT_AIR and node_below == condition_node then
				pos.y = pos.y + 1
				place(pos, context)
				scattered = scattered + 1
				goto place_break
			end
			node_above = node_below
		end
		if i > 10 and scattered == 0 then
			goto place_end
		end
		::place_break::
	end
	::place_end::
end

subcaverna.scatter.scatter_cube = function(context, radius, chance, place)
	for x = -radius, radius do
		pos.x = x
		for y = -radius, radius do
			pos.y = y
			for z = -radius, radius do
				pos.z = z
				if chance == 1 or math.floor(math.random() * chance) == 0 and context.get_node(pos) == minetest.CONTENT_AIR then
					place(pos, context)
				end
			end
		end
	end
end

subcaverna.scatter.make_simple = function(plant, surface, radius, count)
	local PLANT_ID, SURFACE_ID

	local function place(pos, context)
		context.set_node(pos, PLANT_ID)
	end

	return function(context)
		if not PLANT_ID then
			PLANT_ID = minetest.get_content_id(plant)
			SURFACE_ID = minetest.get_content_id(surface)
		end
		subcaverna.scatter.scatter_flat(context, radius, count, SURFACE_ID, place)
	end
end