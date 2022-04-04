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
	
	if len(players) == 0:
		return null
	
	players.shuffle()
	
	var best_target = [null, -1]
	for player in players:
		var hit_chance = god.get_hit_chance(source.grid_position, player.grid_position, penetration, !player.can_cover, player.is_marked)
		if hit_chance  > best_target[1]:
			best_target = [player, hit_chance]
	
	return best_target[0]
