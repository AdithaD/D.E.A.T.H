extends EnemyAbility

export (int) var damage = 1
export (int) var penetration = 0
export (int) var shoot_range = 12

var god

func _use_ai_ability(source):
	#randomize()
	print('enemy shooting')
	god = get_tree().root.get_child(0)
	var target = _generate_target(source)
	if target != null:
		var rand = god.get_hit_chance(source.grid_position, target.grid_position, penetration, !target.can_cover, target.is_marked)
		if(randf() < rand):
			target.take_damage(damage)
	
	finish_doing()
	
func _generate_target(source):
	var players = ai.get_flying_players_in_range(shoot_range, source.grid_position)
	
	if len(players) == 0:
		return null
	
	players.shuffle()
	
	var best_target = [null, -1]
	for player in players:
		var hit_chance = god.get_hit_chance(source.grid_position, player.grid_position, penetration, !player.can_cover, player.is_marked)
		if hit_chance  > best_target[1]:
			best_target = [player, hit_chance]
	
	return best_target[0]
