extends EnemyAbility

func _use_ai_ability(source):
	SoundEngine.play_civilian_scream()
	yield(get_tree().create_timer(2), "timeout")
	finish_doing()
	pass
