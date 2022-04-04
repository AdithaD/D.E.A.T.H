extends Node2D
class_name PlayerUnit

export (int) var max_health
export (int) var actions_points_per_turn
export (int) var tiles_per_turn

export (bool) var can_cover = true

export (float) var move_animation_time = 0.15
var move_interval = 0.025

var health
var action_points = actions_points_per_turn
var dist_moved = 0

var abilities = [] 

var grid_position
var god
var is_marked = false
var mark_length = 0

var end_turn

var is_dead = false

signal update_attr
signal used_ability

signal death

enum SPRITE_DIRECTIONS {BOTTOM_LEFT, TOP_LEFT, TOP_RIGHT, BOTTOM_RIGHT}

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	$DeathSprite.visible=false
	
	abilities = $Abilities.get_children()
			
	emit_signal('update_attr')
	god = get_node("/root/World")
func new_turn(finish_turn):
	update_turn_effects()
	if(!can_be_controlled()):
		emit_signal('update_attr')
		finish_turn.call_func()
	else:
		end_turn = finish_turn
			
		action_points = actions_points_per_turn
		dist_moved = 0
	
		emit_signal('update_attr')

func on_end_turn():
	pass

func update_turn_effects():
	for ability in abilities:
		ability.new_turn()
		
	if(mark_length > 0):
		mark_length -= 1
	if(mark_length <= 0):
		is_marked = false

func can_be_controlled():
	return !is_dead

func get_moveable_distance():
	return tiles_per_turn - dist_moved

func spend_action_points(action_cost: int):
	action_points -= action_cost
	emit_signal('update_attr')
	if (action_points <= 0):
		end_turn.call_func()

	pass

func take_damage(dmg):
	health -= dmg
	if(health <= 0):
		die()
	SoundEngine.play_playerhurt_sfx()
	emit_signal("update_attr")
	
func die():
	is_dead = true
	$DeathSprite.set_frame(0)
	$DeathSprite.visible = true
	$AnimatedSprite.visible = false
	$DeathSprite.play()
	emit_signal('death')
	

func heal_damage(heal_amount):
	health = min(health + heal_amount, max_health)
	emit_signal("update_attr")

func on_used_ability(_index):
	emit_signal("used_ability")

	
func apply_mark(turns):
	if turns > mark_length:
		mark_length = turns
	is_marked = true
	
func do_move(path):
	var prev_loc = grid_position
	grid_position = path[-1]
	for loc in path:
		change_dir_sprite(loc - prev_loc)
		prev_loc = loc
		yield(world_move_to(god.grid_to_world(loc)), "completed")
	

func world_move_to(loc):
	var diff = loc - position
	var steps = int(move_animation_time/move_interval)
	for _i in range(0, steps):
		yield(get_tree().create_timer(move_interval), "timeout")
		position += diff/steps
	
	position = loc

func change_dir_sprite(vector):
	if(abs(vector.x) >= abs(vector.y)):
		if(vector.x >= 0):
			set_sprite_index(SPRITE_DIRECTIONS.BOTTOM_RIGHT)
		else:
			set_sprite_index(SPRITE_DIRECTIONS.TOP_LEFT)
	else:
		if(vector.y >= 0):
			set_sprite_index(SPRITE_DIRECTIONS.BOTTOM_LEFT)
		else:
			set_sprite_index(SPRITE_DIRECTIONS.TOP_RIGHT)

func set_sprite_index(index):
	$AnimatedSprite.frame = index

func _on_PlayerUnit_took_damage():
	pass # Replace with function body.
	
func play_sound(sound):
	$PlayerSound.stream = sound
	$PlayerSound.play()
