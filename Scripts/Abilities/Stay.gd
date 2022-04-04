extends Ability

func _use_ability(source, target):
	target.unfollow()
