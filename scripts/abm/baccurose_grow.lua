minetest.register_abm({
	label = "Baccurose Grow",
	nodenames = {"group:baccurose_vine"},
	interval = 32.0,
	chance = 16,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local name
		local y = pos.y
		local count = 0
		
		if node.name == "subcaverna:baccurose" then
			for i = -2, 2 do
				if i ~= 0 then
					pos.y = y + i
					name = minetest.get_node(pos).name
					if name == "subcaverna:baccurose_berries" then
						count = count + 1
					end
				end
			end
			if (count < 2) then
				pos.y = y
				minetest.set_node(pos, {name = "subcaverna:baccurose_berries", param2 = node.param2})
			end
			return
		end
		
		for i = 1, 2 do
			pos.y = y - i
			name = minetest.get_node(pos).name
			if name ~= "air" then
				return
			end
		end
		
		count = 0
		for i = 1, 15 do
			pos.y = y + i
			name = minetest.get_node(pos).name
			if minetest.get_item_group(name, "group:baccurose_vine") > 0 then
				count = count + 1
			end
		end
		
		if count < 15 then
			pos.y = y - 1
			minetest.set_node(pos, {name = "subcaverna:baccurose", param2 = node.param2})
		end
	end
})