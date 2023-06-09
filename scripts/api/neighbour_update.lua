-- on_neighbour_update(pos, dir, node)

-- Function which should be defined in node definition table
-- Will be applied when one of node neighbours will be updated (by player)
-- Parameters:
--    pos  - current node position
--    dir  - direction where neighbour is located (relative to node)
--    node - updated node (table, name + param2)

local pos2 = vector.zero()

local offsets = {
	{x = -1, y =  0, z =  0},
	{x =  1, y =  0, z =  0},
	{x =  0, y = -1, z =  0},
	{x =  0, y =  1, z =  0},
	{x =  0, y =  0, z = -1},
	{x =  0, y =  0, z =  1}
}

local dirs = {}
for i = 1, 6 do
	local offset = offsets[i]
	dirs[i] = {x = -offset.x, y = -offset.y, z = -offset.z}
end

local function check_neighbours(pos, node)
	for i, offset in ipairs(offsets) do
		pos2.x = pos.x + offset.x
		pos2.y = pos.y + offset.y
		pos2.z = pos.z + offset.z
		local node_name = minetest.get_node(pos2).name
		local def = minetest.registered_nodes[node_name]
		if def and def.on_neighbour_update then
			def.on_neighbour_update(pos2, dirs[i], node)
		end
	end
end

minetest.register_on_placenode(check_neighbours)
minetest.register_on_dignode(check_neighbours)
minetest.register_on_punchnode(check_neighbours)