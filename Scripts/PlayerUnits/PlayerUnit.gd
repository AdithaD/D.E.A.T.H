extends Node2D
class_name PlayerUnit

export (int) var max_health
export (int) var actionPointsPerTurn
export (int) var tilesPerMove

export (bool) var can_cover = true

export (float) var move_animation_time = 0.15
var move_interval = 0.025

var health
var action_points = actionPointsPerTurn

var abilities = [] 

var grid_position
var god
var is_marked
var mark_length = 0

signal update_attr
signal used_ability

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	
	abilities = $Abilities.get_children()
			
	new_turn()
	emit_signal('update_attr')
	god = get_tree().root.get_child(0)
	
	# temp
	yield(get_tree(), "idle_frame")
	grid_position = god.world_to_grid(position)

func new_turn():
	action_points = actionPointsPerTurn
	if(mark_length > 0):
		mark_length -= 1
	if(mark_length <= 0):
		is_marked = false

func spend_action_points(action_cost: int):
	action_points -= 1
	emit_signal('update_attr')
	pass

func take_damage(dmg):
	health -= dmg
	emit_signal("update_attr")

func on_used_ability(index):
	emit_signal("used_ability")

	
func apply_mark(turns):
	if turns > mark_length:
		mark_length = turns
	is_marked = true
	
func do_move(path):
	grid_position = path[-1]
	print(grid_position)
	for loc in path:
		yield(world_move_to(god.grid_to_world(loc)), "completed")
	

func world_move_to(loc):
	var diff = loc - position
	var steps = int(move_animation_time/move_interval)
	for i in range(0, steps):
		yield(get_tree().create_timer(move_interval), "timeout")
		position += diff/steps
	
	position = loc

func _on_PlayerUnit_took_damage():
	pass # Replace with function body.
