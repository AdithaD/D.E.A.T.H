extends EnemyAbility

export (int) var mark_range = 5
export (int) var mark_turns = 1

export (int) var mark_player_chance = 0.9

func _use_ai_ability(source):
	#randomize()
	var target = _generate_target(source)
	if target != null:
		var god = get_node("/root/World")
		if target.has_method("apply_mark"):
			target.apply_mark(mark_turns)
	
	
	finish_doing()
	
func _generate_target(source):
	var players = ai.get_players_in_range(mark_range, source.grid_position)
	var civilians = ai.get_civilians_in_range(mark_range, source.grid_position)
	var targets

	if len(players) == 0 and len(civilians) == 0:
		return null
	elif len(civilians) == 0:
		targets = players
	elif len(players) == 0:
		targets = civilians
	elif(randf() < mark_player_chance):
		targets = players
	else:
		targets = civilians
	
	var index  = randi() % targets.size()
	return targets[index]
