subcaverna.place_log = function(itemstack, placer, pointed_thing)
	local under = pointed_thing.under
	local above = pointed_thing.above
	
	local param2 = 0
	if (above.x - under.x) ~= 0 then param2 = 12
	elseif (above.z - under.z) ~= 0 then param2 = 4 end
	
	return minetest.item_place_node(itemstack, placer, pointed_thing, param2)
end