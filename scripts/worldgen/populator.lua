local CAVE_START = -64
local CAVE_TERRAIN = CAVE_START - 50
local HEIGHT_LIMIT = CAVE_TERRAIN - 50

local side, side_max, array_side_dy, array_side_dz, size, max_chunk, place_index
local biome_map = {}
local node_data = {}
local param2_data = {}
local index_table = {}

local feature_context = {
	get_node = function(pos)
		local index = place_index + pos.x + pos.y * array_side_dy + pos.z * array_side_dz
		return node_data[index]
	end,
	set_node = function(pos, node, param2)
		local index = place_index + pos.x + pos.y * array_side_dy + pos.z * array_side_dz
		node_data[index] = node
		param2_data[index] = param2 or 0
	end
}

local cave_map
local cave_map_2

local function init(emin, emax)
	if not side then
		side = emax.x - emin.x
		side_max = side - 15
		array_side_dy = side + 1
		array_side_dz = array_side_dy * array_side_dy
		size = array_side_dy * array_side_dz
		max_chunk = math.floor(side / 16) - 1

		for index = 1, size do
			local index_dec = index - 1
			
			local x = index_dec % array_side_dy
			if x < 15 or x > side_max then goto index_end end
			
			local y = math.floor(index_dec / array_side_dy) % array_side_dy
			if y < 15 or y > side_max then goto index_end end
			
			local z = math.floor(index_dec / array_side_dz)
			if z < 15 or z > side_max then goto index_end end
			
			table.insert(index_table, index)
			
			::index_end::
		end
		
		cave_map = PerlinNoiseMap({
			offset = 0,
			scale = 1,
			spread = {x = 200, y = 100, z = 200},
			seed = 0,
			octaves = 3,
			persist = 0.5,
			lacunarity = 2.0,
			flags = "defaults, eased",
		}, {x = array_side_dy, y = array_side_dy, z = array_side_dy})

		cave_map_2 = PerlinNoiseMap({
			offset = 0,
			scale = 1,
			spread = {x = 30, y = 30, z = 30},
			seed = 0,
			octaves = 2,
			persist = 0.5,
			lacunarity = 2.0,
			flags = "defaults, eased",
		}, {x = array_side_dy, y = array_side_dy, z = array_side_dy})
	end
end

local node_replacements = {}
local can_replace

local cave_density = {}
local cave_density_2 = {}

local function cover_terrain(use_height, min_pos)
	cave_map:get_3d_map_flat(min_pos, cave_density)
	cave_map_2:get_3d_map_flat(min_pos, cave_density_2)

	for index = 1, size do
		local y = (math.floor(index / array_side_dy) % array_side_dy) + min_pos.y
		y = (y - CAVE_TERRAIN) * 0.001 + 1.0
		if y < 0.5 then
			y = 0.5
		end
		local d = cave_density[index] + cave_density_2[index] * 0.3
		if d > y and can_replace(node_data[index]) then
			node_data[index] = minetest.CONTENT_AIR
		end
	end

	if use_height then
		--for index = 1, size do
		--	local y = (math.floor(index / array_side_dy) % array_side_dy) + min_pos.y
		--	y = (CAVE_TERRAIN - y) * 0.01
		--	if y > 0 then
		--		y = 0
		--	end
		--	local d = cave_density[index] + cave_density_2[index] * 0.3 -- + y
		--	if d > 0.5 and can_replace(node_data[index]) then
		--		node_data[index] = minetest.CONTENT_AIR
		--	end
		--end

		for _, index in ipairs(index_table) do
			if node_data[index + array_side_dy] == minetest.CONTENT_AIR then
				local x = (index % array_side_dy) + min_pos.x
				local z = (math.floor(index / array_side_dy) % array_side_dy) + min_pos.z
				local y = (math.floor(index / array_side_dz) % array_side_dy) + min_pos.y
				local h = CAVE_START + math.sin((x + z) * 0.3) * 3 - 3
				if y < h and can_replace(node_data[index]) then
					node_data[index] = biome_map[index].surface
				end
			end
		end
	else
		--for index = 1, size do
		--	local d = cave_density[index] + cave_density_2[index] * 0.3
		--	if d > 0.5 and can_replace(node_data[index]) then
		--		node_data[index] = minetest.CONTENT_AIR
		--	end
		--end

		for _, index in ipairs(index_table) do
			if node_data[index + array_side_dy] == minetest.CONTENT_AIR and can_replace(node_data[index]) then
				node_data[index] = biome_map[index].surface
			end
		end
	end
end

local function heightmap_place(feature, min_x, min_y, min_z, surface)
	local px = math.random(0, 15) + min_x
	local pz = math.random(0, 15) + min_z
	local i_xz = px + pz * array_side_dz
	for py = min_y + 15, min_y, -1 do
		local index = i_xz + py * array_side_dy
		if node_data[index] == surface then
			place_index = index + array_side_dy
			feature(feature_context)
		end
	end
end

local function volume_place(feature, min_x, min_y, min_z)
	local px = math.random(0, 15) + min_x
	local py = math.random(0, 15) + min_y
	local pz = math.random(0, 15) + min_z
	place_index = px + py * array_side_dy + pz * array_side_dz
	if node_data[place_index] == minetest.CONTENT_AIR then
		feature(feature_context)
	end
end

subcaverna.feature_types = {
	HEIGHTMAP = 1,
	VOLUME = 2,
}

local biome_offsets = {
	{x =  0, y =  0, z =  0},
	{x = 15, y =  0, z =  0},
	{x =  0, y = 15, z =  0},
	{x = 15, y = 15, z =  0},
	{x =  0, y =  0, z = 15},
	{x = 15, y =  0, z = 15},
	{x =  0, y = 15, z = 15},
	{x = 15, y = 15, z = 15}
}

local biome_list = {}
local biome_list_size = 1

local function collect_biomes(min_x, min_y, min_z)
	local index = (min_z + 8) * array_side_dz + (min_y + 8) * array_side_dy + min_x + 9
	biome_list[1] = biome_map[index]
	biome_list_size = 1

	for _, offset in ipairs(biome_offsets) do
		local x = min_x + offset.x
		local y = min_y + offset.y
		local z = min_z + offset.z

		index = z * array_side_dz + y * array_side_dy + x + 1
		local biome = biome_map[index]
		
		for n = 1, biome_list_size do
			if biome_list[n].id == biome.id then
				goto search_end
			end
		end

		biome_list_size = biome_list_size + 1
		biome_list[biome_list_size] = biome

		::search_end::
	end
end

local function populate()
	for cy = 1, max_chunk do
		local min_y = cy * 16
		for cx = 1, max_chunk do
			local min_x = cx * 16
			for cz = 1, max_chunk do
				local min_z = cz * 16
				collect_biomes(min_x, min_y, min_z)
				for n = 1, biome_list_size do
					local biome = biome_list[n]
					if biome.features then
						for _, entry in ipairs(biome.features) do
							for i = 1, entry.count do
								if entry.type == subcaverna.feature_types.HEIGHTMAP then
									heightmap_place(entry.feature, min_x, min_y, min_z, biome.surface)
								elseif entry.type == subcaverna.feature_types.VOLUME then
									volume_place(entry.feature, min_x, min_y, min_z)
								end
							end
						end
					end
				end
			end
		end
	end
end

minetest.register_on_generated(function(minp, maxp, blockseed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")

	if minp.y > CAVE_START then
		return
	end
	
	vm:get_data(node_data)
	vm:get_param2_data(param2_data)

	init(emin, emax)
	subcaverna.biome_map.fill_map(emin, side, biome_map)
	cover_terrain(maxp.y > HEIGHT_LIMIT, emin)
	populate()

	vm:set_data(node_data)
	vm:set_param2_data(param2_data)

	vm:update_liquids()
	vm:write_to_map(false)
	minetest.fix_light(emin, emax)
end)

minetest.register_on_mods_loaded(function()
	for name, node in pairs(minetest.registered_nodes) do
		if node.is_ground_content == nil or node.is_ground_content == true then
			table.insert(node_replacements, minetest.get_content_id(name))
		end
	end

	table.sort(node_replacements)

	local count = #node_replacements
	if count < 8 then
		can_replace = function(node_id)
			if node_id == minetest.CONTENT_AIR then
				return false
			end
		
			for _, id in ipairs(node_replacements) do
				if id == node_id then
					return true
				end
			end
		
			return false
		end
	else
		can_replace = function(node_id)
			if node_id == minetest.CONTENT_AIR then
				return false
			end
		
			local left = 1
			local right = count

			while left <= right do
				local index = math.floor((left + right) / 2)
				if node_replacements[index] < node_id then
					left = index + 1
				elseif node_replacements[index] > node_id then
					right = index - 1
				else
					return true
				end
			end

			return false
		end
	end
end)