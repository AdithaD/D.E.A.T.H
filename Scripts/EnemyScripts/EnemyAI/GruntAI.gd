extends BFSAI
class_name GruntAI

var player_bonus = 2000
var civilian_bonus = 100

var unit_check_acc_range = 10
var hit_chance_score_multiplier = 10
var enemy_hit_chance_score_multiplier = 5

func generate_turn(abilities):
	var move_ability = abilities[0]
	
	var other_ability = abilities[1]
	if(abilities.size() > 2):
		var other_abilities = abilities.slice(1,len(abilities) - 1)
		other_ability  = other_abilities[randi() % len(other_abilities)]
		
	return [move_ability, other_ability]

func get_highest_hitchance_target(pos, targets, penetration=0):
	var best = [null, -1]
	for target in targets:
		var hit_chance = god.get_hit_chance(pos, target.grid_position, penetration, !target.can_cover, target.is_marked)
		if hit_chance > best[1]:
			best = [target, hit_chance]
	return best[0]

func get_highest_hitchance(pos, targets, penetration=0):
	var target = get_highest_hitchance_target(pos, targets, penetration)
	return get_hitchance(pos, target, penetration)
	
func get_hitchance(pos, target, penetration=0):
	return god.get_hit_chance(pos, target.grid_position, penetration, !target.can_cover, target.is_marked)
			

func evaluate_tile(pos):
	# can get within range of player/civ?
	# NO?
	# move closer
	# YES?
	var score = 0
	var penetration = 0
	var in_range = false
	
	var shoot_range = 0
	
	var abilities = get_parent().get_node("Abilities")
	if(abilities.get_node_or_null("EnemyShoot")):
		var enemyshoot = abilities.get_node("EnemyShoot")
		shoot_range = enemyshoot.shoot_range
		penetration = enemyshoot.penetration
	
	var players_in_range = get_players_in_range(shoot_range, pos)
	var civilians_in_range = get_civilians_in_range(shoot_range, pos)
	
	if len(players_in_range) > 0:
		score = float(player_bonus)
		score += get_highest_hitchance(pos, players_in_range, penetration) * hit_chance_score_multiplier
		for player in get_players_in_range(unit_check_acc_range, pos):
			score -= get_hitchance(pos, player, 0) * enemy_hit_chance_score_multiplier
			
		return score
		
	elif len(civilians_in_range) > 0:
		score = float(civilian_bonus)
		score += float(1)/max(get_dist_to_closest_target(pos), 1) * player_bonus
		
		return score
	
	score = float(1)/max(get_dist_to_closest_target(pos), 1) * player_bonus
	return score
