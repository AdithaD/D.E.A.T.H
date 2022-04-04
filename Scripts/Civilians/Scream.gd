extends EnemyAbility

func _use_ai_ability(source):
	yield(get_tree().create_timer(3), "timeout")
	finish_doing()
	SoundEngine.play_civilian_scream()
	pass
