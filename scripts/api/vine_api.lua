local S = subcaverna.translator

local function is_support(node_name)
	local def = minetest.registered_nodes[node_name]
	return def and (def.walkable or (def.groups and def.groups.subcaverna_cave_vine))
end

local function vine_check(pos, dir, node)
	pos.y = pos.y + 1
	local node_name = minetest.get_node(pos).name
	pos.y = pos.y - 1

	if is_support(node_name) then
		return
	end

	minetest.dig_node(pos)
end

local function vine_place(itemstack, placer, pointed_thing)
	local pos = pointed_thing.above

	pos.y = pos.y + 1
	local node_name = minetest.get_node(pos).name
	pos.y = pos.y - 1

	if is_support(node_name) then
		return minetest.item_place_node(itemstack, placer, pointed_thing, 3)
	end
end

subcaverna.register_vine = function(name, def)
	if not def.groups then
		def.groups = {snappy = 3, flora = 1, flammable = 1, subcaverna_cave_vine = 1}
	else
		def.groups.subcaverna_cave_vine = 1
	end

	if def.texture then
		def.tiles = {def.texture}
		def.wield_image = def.texture
		def.inventory_image = def.texture
	end

	def.description = S(def.description)
	def.drawtype = def.drawtype or "plantlike"
	def.paramtype = def.paramtype or "light"
	--def.paramtype2 = def.paramtype2 or "meshoptions"
	def.sunlight_propagates = true
	def.walkable = false
	def.sounds = def.sounds or subcaverna.sounds.leaves()
	def.light_source = def.light_source or 0
	def.on_neighbour_update = vine_check
	def.on_place = vine_place

	minetest.register_node(name, def)
end
