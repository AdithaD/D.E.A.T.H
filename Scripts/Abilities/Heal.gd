extends Ability

export (int) var heal_amount = 1
export (int) var penetration = 0

func _use_ability(_source, target):
	#randomize()
	target.heal_damage(heal_amount)
	finish_doing()
