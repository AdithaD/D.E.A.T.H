extends EnemyAbility

export (int) var damage = 1
export (int) var area_of_effect = 1
export (int) var shoot_range = 10

func _use_ai_ability(source):
	#randomize()
	var target = _generate_target(source)
	if target != null:
		var god = get_node("/root/World")
		var obstacle_tilemap = god.get_obstacle_tilemap()
		var floor_tilemap = god.get_floor_tilemap()
		
		var tiles_affected = generateAoE(target)
		
		for tile in tiles_affected:
			if obstacle_tilemap.get_cellv(tile) != -1:
				obstacle_tilemap.set_cellv(tile, obstacle_tilemap.tile_set.find_tile_by_name("rubble"))
		
		var units = god.get_enemy_nodes() + god.get_player_nodes()
		for unit in units:
			if tiles_affected.find(unit.grid_position) != -1:
				unit.take_damage(damage)
	
	finish_doing()
	
# returns tile todo: make this actually find good target
func _generate_target(source):
	var players = ai.get_players_in_range(shoot_range, source.grid_position)
	
	if(players.size() > 0):
		var index  = randi() % players.size()
		
		return players[index].grid_position
	
	return null


func generateAoE(target):
	var pos = target
	var list = []
	
	for i in range(-area_of_effect, area_of_effect + 1):
		for j in range(-area_of_effect, area_of_effect + 1):
			list.append(pos + Vector2(i, j))
			
	return list
