extends EnemyAbility

export (int) var mark_range = 5
export (int) var mark_turns = 1

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
	
	if(players.size() > 0):
		var index  = randi() % players.size()
		
		return players[index]
	
	return null
