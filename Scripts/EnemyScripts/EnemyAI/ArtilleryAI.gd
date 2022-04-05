extends GruntAI


func evaluate_tile(pos):
	var score = 0
	var shoot_range = 0
	
	var abilities = get_parent().get_node("Abilities")
	if(abilities.get_node_or_null("EnemyShootAOE")):
		var enemyshoot = get_parent().get_node("Abilities").get_node("EnemyShootAOE")
		shoot_range = enemyshoot.shoot_range
	
	var players_in_range = get_players_in_range(shoot_range, pos)
	var civilians_in_range = get_civilians_in_range(shoot_range, pos)
	
	if len(players_in_range) > 0:
		score = float(player_bonus)
		for player in get_players_in_range(unit_check_acc_range, pos):
			score -= get_hitchance(pos, player) * enemy_hit_chance_score_multiplier
			
		return score
		
	elif len(civilians_in_range) > 0:
		score = float(civilian_bonus)
		score += float(1)/max(get_dist_to_closest_target(pos), 1) * player_bonus
		
		return score
	
	score = float(1)/max(get_dist_to_closest_target(pos), 1) * player_bonus
	return score
