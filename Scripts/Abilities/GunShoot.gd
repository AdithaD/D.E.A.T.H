extends Ability

export (int) var damage = 1
export (int) var penetration = 0

func _use_ability_on_unit(_player, target):
	target.take_damage(damage)
