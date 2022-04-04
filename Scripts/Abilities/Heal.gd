extends Ability

export (int) var heal_amount = 1
export (int) var penetration = 0

func _use_ability(_source, target):
	#randomize()
	var god = get_node("/root/World")
	target.heal_damage(heal_amount)
	print("heal")
	SoundEngine.play_medicHeal()
	finish_doing()
