extends GruntAI

func evaluate_tile(pos):
	var score = 0
	var penetration = 0
	var shoot_range = 0
	
	var abilities = get_parent().get_node("Abilities")
	if(abilities.get_node_or_null("EnemyShootAir")):
		var enemyshoot = abilities.get_node("EnemyShootAir")
		shoot_range = enemyshoot.shoot_range
		penetration = enemyshoot.penetration
	
	var players_in_range = get_players_in_range(shoot_range, pos)
	var flyers_in_range = get_flying_players_in_range(shoot_range, pos)
	
	if len(flyers_in_range) > 0:
		score = float(player_bonus)
		score += get_highest_hitchance(pos, flyers_in_range, penetration) * hit_chance_score_multiplier
		for player in get_players_in_range(unit_check_acc_range, pos):
			score -= get_hitchance(pos, player, 0) * enemy_hit_chance_score_multiplier
			
		return score
		
		
	score = float(1)/max(get_dist_to_closest_target(pos), 1) * player_bonus
	return score

func get_target_locations():
	return god.get_flying_player_locations()
