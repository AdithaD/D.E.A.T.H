extends Ability

export (int) var damage = 1
export (int) var penetration = 0

func _use_ability(source, target):
	#randomize()
	var god = get_node("/root/World")
	var rand = god.get_hit_chance(source.grid_position, target.grid_position, penetration, !target.can_cover, target.is_marked)
	if(randf() < rand):
		target.take_damage(damage)
	
	finish_doing()
