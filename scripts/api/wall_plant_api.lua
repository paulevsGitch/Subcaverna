local S = subcaverna.translator

local function wall_place(itemstack, placer, pointed_thing)
	local under = pointed_thing.under
	local above = pointed_thing.above

	if above.y ~= under.y then
		return nil
	end

	return minetest.item_place_node(itemstack, placer, pointed_thing)
end

subcaverna.register_wall_plant = function(name, def)
	def.description = S(def.description)
	def.on_place = wall_place
	minetest.register_node(name, def)
end
