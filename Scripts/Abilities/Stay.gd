extends Ability

export (int) var select_range = 5

func _use_ability(source, target):
	target.unfollow()
