subcaverna = {}

subcaverna.mcl = minetest.global_exists("mcl_sounds")
subcaverna.def = minetest.global_exists("default")

subcaverna.translator = minetest.get_translator("subcaverna")
subcaverna.trees = {}
subcaverna.plants = {}

local path = minetest.get_modpath("subcaverna")

dofile(path .. "/scripts/utils.lua")
dofile(path .. "/scripts/api/neighbour_update.lua")
dofile(path .. "/scripts/api/vine_api.lua")
dofile(path .. "/scripts/api/wall_plant_api.lua")
dofile(path .. "/scripts/api/log_api.lua")
dofile(path .. "/scripts/worldgen/scatter.lua")

dofile(path .. "/scripts/sounds.lua")
dofile(path .. "/scripts/nodes.lua")

dofile(path .. "/scripts/plants/umbratus.lua")
dofile(path .. "/scripts/plants/wall_coral.lua")
dofile(path .. "/scripts/plants/cave_cyperus.lua")
dofile(path .. "/scripts/plants/thorny_bloodleaf.lua")

dofile(path .. "/scripts/abm/baccurose_grow.lua")

dofile(path .. "/scripts/worldgen/populator.lua")
dofile(path .. "/scripts/worldgen/biome_map.lua")
dofile(path .. "/scripts/worldgen/biomes.lua")

-- mcl_vars.mg_overworld_min

minetest.register_on_mods_loaded(function()
	if minetest.global_exists("mcl_vars") then
		mcl_vars.mg_overworld_min = -2048
		mcl_vars.mg_bedrock_overworld_min = -2048
		mcl_vars.mg_lava_overworld_max = -2050 -- No lava in caves
		mcl_vars.mg_bedrock_overworld_min = -2048
		mcl_vars.mg_bedrock_overworld_max = -2044
	end
end)

local flags = minetest.get_mapgen_setting("mg_flags")

if flags then
	if not string.match(flags, "nocaves") then
		local index1, index2 = string.find(flags, "caves")
		if index1 then
			flags = string.sub(flags, 0, index1 - 1) .. "nocaves" .. string.sub(flags, index2 + 1)
		end
		minetest.set_mapgen_setting("mg_flags", flags, true)
	end
else
	minetest.set_mapgen_setting("mg_flags", "nocaves", true)
end