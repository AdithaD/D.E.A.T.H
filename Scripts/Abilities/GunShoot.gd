extends Ability

export (int) var damage = 1
export (int) var penetration = 0

func _use_ability(_player, target):
	print('bang')
	
	#randomize()
	var god = get_tree().root.get_child(0)
	var rand = god.get_hit_chance(_player.grid_position, target.grid_position, penetration, !target.can_cover, target.is_marked)
	if(randf() < rand):
		target.take_damage(damage)
	
	finish_doing()
