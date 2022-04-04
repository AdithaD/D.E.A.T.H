static func generate_AoE(center, aoe_range):
	var pos = center
	var list = []
	
	for i in range(-aoe_range, aoe_range + 1):
		for j in range(-aoe_range, aoe_range + 1):
			list.append(pos + Vector2(i, j))
			
	return list

static func filter_entities_in_AoE(entities, center, aoe_range):
	var tiles_affected = generate_AoE(center, aoe_range)
	var list = []
	for entity in entities:
		if tiles_affected.find(entity.grid_position) != -1:
			list.append(entity)
			
	return list
	
static func get_free_tiles_in_AoE(center, aoe_range, god):
	var tiles_affected = generate_AoE(center, aoe_range)
	var list = []
	for tile in tiles_affected:
		if god.get_obstacle_locations().find(tile) == -1:
			list.append(tile)
	return list
