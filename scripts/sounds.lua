local mcl = minetest.global_exists("mcl_sounds")
local def = minetest.global_exists("default")

local get_sound_function = function(name)
	if mcl then
		return mcl_sounds[name] or {}
	elseif def then
		return default[name] or {}
	end
end

subcaverna.sounds = {
	stone = get_sound_function("node_sound_stone_defaults"),
	leaves = get_sound_function("node_sound_leaves_defaults"),
	wood = get_sound_function("node_sound_wood_defaults")
}