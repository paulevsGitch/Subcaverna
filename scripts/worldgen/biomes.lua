subcaverna.biome_map.register_biome({
	name = "Umbratus Forest",
	surface = "subcaverna:red_moss",
	filler = "default:stone",
	features = {
		{feature = subcaverna.trees.umbratus, count = 4, type = subcaverna.feature_types.HEIGHTMAP},
		{feature = subcaverna.trees.umbratus_medium, count = 4, type = subcaverna.feature_types.HEIGHTMAP},
		{feature = subcaverna.trees.umbratus_small, count = 4, type = subcaverna.feature_types.HEIGHTMAP},
		{feature = subcaverna.plants.cave_cyperus, count = 2, type = subcaverna.feature_types.HEIGHTMAP},
		{feature = subcaverna.plants.thorny_bloodleaf, count = 1, type = subcaverna.feature_types.HEIGHTMAP},
		{feature = subcaverna.plants.red_grass, count = 4, type = subcaverna.feature_types.HEIGHTMAP}
	},
	particles = {
		texture = {
			name = "thelimit_yellow_particle.png",
			blend = "screen",
			scale_tween = {
				style = "pulse",
				0, 1
			}
		}
	}
})

local grass = subcaverna.scatter.make_simple("subcaverna:grass_01", "subcaverna:moss_01", 4, 50)

subcaverna.biome_map.register_biome({
	name = "Test 2",
	surface = "subcaverna:moss_01",
	features = {
		{feature = grass, count = 4, type = subcaverna.feature_types.HEIGHTMAP}
	}
})