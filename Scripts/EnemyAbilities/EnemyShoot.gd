extends EnemyAbility

export (int) var damage = 1
export (int) var penetration = 0
export (int) var shoot_range = 10

func _use_ai_ability(source):
	#randomize()
	print('enemy shooting')
	var target = _generate_target(source)
	var god = get_tree().root.get_child(0)
	var rand = god.get_hit_chance(source.grid_position, target.grid_position, penetration, !target.can_cover, target.is_marked)
	if(randf() < rand):
		target.take_damage(damage)
	
	finish_doing()
	
func _generate_target(source):
	var players = ai.get_players_in_range(shoot_range, source.grid_position)
	
	if(players.size() > 0):
		var index  = randi() % players.size()
		
		return players[index]
