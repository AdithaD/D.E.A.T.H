extends EnemyAbility
class_name EnemyShoot

export (int) var damage = 1
export (int) var penetration = 0
export (int) var shoot_range = 10

var god
export (PackedScene) var tracer

export (int) var burst_number = 3
export (int) var bullet_speed = 600
export (float) var burst_delay = 0.05
export (int) var bullet_length = 20

export (int) var shoot_player_chance = 0.7
export (int) var shoot_best_target_chance = 0.6

func _use_ai_ability(source):
	#randomize()
	print('enemy shooting')
	god = get_node("/root/World")
	var target = _generate_target(source)
	if target != null:
		var rand = god.get_hit_chance(source.grid_position, target.grid_position, penetration, !target.can_cover, target.is_marked)
		if(randf() < rand):
			target.take_damage(damage)
	
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
	
func _generate_target(source):
	var players = ai.get_players_in_range(shoot_range, source.grid_position)
	var civilians = ai.get_civilians_in_range(shoot_range, source.grid_position)
	var targets

	if len(players) == 0 and len(civilians) == 0:
		return null
	elif len(civilians) == 0:
		targets = players
	elif len(players) == 0:
		targets = civilians
	elif(randf() < shoot_player_chance):
		targets = players
	else:
		targets = civilians
	
	targets.shuffle()
	
	if(randf() > shoot_best_target_chance):
		return targets[0]
	
	var best_target = [null, -1]
	for target in targets:
		var hit_chance = god.get_hit_chance(source.grid_position, target.grid_position, penetration, !target.can_cover, target.is_marked)
		if hit_chance  > best_target[1]:
			best_target = [target, hit_chance]
	
	return best_target[0]
