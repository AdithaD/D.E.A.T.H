extends Ability

export (int) var damage = 1
export (int) var penetration = 0

func _use_ability(_player, target):
	print('bang')
	finish_doing()
