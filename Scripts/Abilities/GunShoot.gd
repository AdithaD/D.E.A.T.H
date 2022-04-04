extends Ability

export (int) var damage = 1
export (int) var penetration = 0

export (PackedScene) var tracer

export (Color) var bullet_colour

export (int) var burst_number = 3
export (int) var bullet_speed = 600
export (float) var burst_delay = 0.05
export (int) var bullet_length = 20

export (int) var select_range = 10

func _use_ability(source, target):
	#randomize()
	var god = get_node("/root/World")
	var rand = god.get_hit_chance(source.grid_position, target.grid_position, penetration, !target.can_cover, target.is_marked)
	if(randf() < rand):
		target.take_damage(damage)
		
	print('drawing line')
	submit_tracer_burst(source.global_position, target.global_position, bullet_length, bullet_speed, burst_number, 0.05)
	
	finish_doing()

func submit_tracer_burst(start_pos, target_pos, length, speed, amount, offset):
		
		for i in range(0, amount):
			var new_tracer = tracer.instance()
			new_tracer.submit_tracer(start_pos, target_pos, length, speed)
			var duration = new_tracer.get_duration()
			add_child(new_tracer)
			yield(get_tree().create_timer(duration), "timeout")
			
		for child in get_children():
			child.queue_free()
