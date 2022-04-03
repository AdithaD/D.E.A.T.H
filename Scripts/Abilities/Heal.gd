extends Ability

export (int) var heal_amount = 1
export (int) var penetration = 0

func _use_ability(source, target):
	#randomize()
	var god = get_tree().root.get_child(0)
	target.heal_damage(heal_amount)
	print("heal")
	finish_doing()
