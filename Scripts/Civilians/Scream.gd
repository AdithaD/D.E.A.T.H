extends EnemyAbility

export (float) var chance_to_scream

func _use_ai_ability(source):
	
	var roll = float(randi() % 100) 
	if roll <= chance_to_scream * 100:
		SoundEngine.play_civilian_scream()
	yield(get_tree().create_timer(2), "timeout")
	finish_doing()
	pass
