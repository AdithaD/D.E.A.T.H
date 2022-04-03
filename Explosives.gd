extends Ability

export (int) var area_of_effect = 1
export (int) var select_range = 10
export (int) var damage = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _use_ability(source, target):
	var god = get_node("/root/World")
	
	var obstacle_tilemap = god.get_obstacle_tilemap()
	var floor_tilemap = god.get_floor_tilemap()
	
	# to improve
	var enemies = get_tree().get_nodes_in_group("enemy")

	var tiles_affected = generateAoE(target)
	for enemy in enemies:
		if tiles_affected.find(enemy.grid_position) != -1:
			enemy.take_damage(damage)
	
	for tile in tiles_affected:
		if obstacle_tilemap.get_cellv(tile) != -1:
			obstacle_tilemap.set_cellv(tile, obstacle_tilemap.tile_set.find_tile_by_name("rubble"))
	
	emit_signal("ability_used")

func generateAoE(target):
	var pos = target
	var list = []
	
	for i in range(-area_of_effect, area_of_effect + 1):
		for j in range(-area_of_effect, area_of_effect + 1):
			list.append(pos + Vector2(i, j))
			
	print(list)
	return list
