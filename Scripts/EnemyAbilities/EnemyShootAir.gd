extends EnemyShoot

func _generate_target(source):
	var players = ai.get_flying_players_in_range(shoot_range, source.grid_position, true)
	
	if len(players) == 0:
		return null
	
	players.shuffle()
	
	var best_target = [null, -1]
	for player in players:
		var hit_chance = god.get_hit_chance(source.grid_position, player.grid_position, penetration, !player.can_cover, player.is_marked)
		if hit_chance  > best_target[1]:
			best_target = [player, hit_chance]
	
	return best_target[0]
