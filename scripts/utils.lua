subcaverna.can_replace = function(node_id)
	local node_name = minetest.get_name_from_content_id(node_id)
	local node = minetest.registered_nodes[node_name]
	return node.buildable_to
end

local node_data = {}
local param_data = {}
local center
local area

local context = {
	get_node = function(pos)
		return node_data[area:index(
			center.x + pos.x,
			center.y + pos.y,
			center.z + pos.z
		)]
	end,
	set_node = function(pos, node_id, param2)
		param2 = param2 or 0
		local index = area:index(
			center.x + pos.x,
			center.y + pos.y,
			center.z + pos.z
		)
		node_data[index] = node_id
		param_data[index] = param2
	end
}

subcaverna.place_feature = function(pos, feature)
	center = pos

	local p1 = {x = pos.x - 15, y = pos.y - 15, z = pos.z - 15}
	local p2 = {x = pos.x + 15, y = pos.y + 15, z = pos.z + 15}
	local vm = minetest.get_voxel_manip(p1, p2)

	p1, p2 = vm:get_emerged_area()
	area = VoxelArea(p1, p2)

	vm:get_data(node_data)
	vm:get_param2_data(param_data)

	feature(context)

	vm:set_data(node_data)
	vm:set_param2_data(param_data)
	vm:write_to_map()
end

subcaverna.get_node_id = function(node_name_def, node_name_mcl)
	if subcaverna.def then
		return minetest.get_content_id(node_name_def)
	elseif subcaverna.mcl then
		return minetest.get_content_id(node_name_mcl)
	else
		return 0
	end
end