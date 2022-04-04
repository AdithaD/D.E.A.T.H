extends Ability

export (int) var heal_amount = 1

func _use_ability(_source, target):
	#randomize()
	var god = get_node("/root/World")
	target.heal_damage(heal_amount)
	print("heal")
	finish_doing()

func get_details(lifecycle):
	var super = .get_details(lifecycle) + "\n"
	
	super += "Heal Amount = %s \n" % heal_amount
	super += "Range: %s \n" % select_range
	
	return super
\
