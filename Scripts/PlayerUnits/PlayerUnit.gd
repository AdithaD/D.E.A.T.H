extends Node2D
class_name PlayerUnit

export (int) var max_health
export (int) var actions_points_per_turn
export (int) var tiles_per_turn

export (bool) var can_cover = true

var health
var action_points = actions_points_per_turn
var dist_moved = 0

var abilities = [] 

var grid_position
var god
var is_marked
var mark_length = 0

var end_turn
signal update_attr
signal used_ability

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	
	abilities = $Abilities.get_children()
			
	emit_signal('update_attr')
	god = get_tree().root.get_child(0)
	
	# temp
	yield(get_tree(), "idle_frame")
	grid_position = god.world_to_grid(position)
	
func new_turn(finish_turn):
	end_turn = finish_turn
		
	action_points = actions_points_per_turn
	dist_moved = 0
	
	for ability in abilities:
		ability.new_turn()
		
	if(mark_length > 0):
		mark_length -= 1
	if(mark_length <= 0):
		is_marked = false

	emit_signal('update_attr')


func get_moveable_distance():
	return tiles_per_turn - dist_moved

func spend_action_points(action_cost: int):
	action_points -= action_cost
	emit_signal('update_attr')
	print(action_points)
	if (action_points <= 0):
		end_turn.call_func()

	pass

func moveTo(x: int, y: int):
	pass
	
func take_damage(dmg):
	health -= dmg
	emit_signal("update_attr")

func on_used_ability(index):
	emit_signal("used_ability")

func set_grid_position(new_grid):
	grid_position = new_grid
	position = god.grid_to_world(grid_position)
	
func apply_mark(turns):
	if turns > mark_length:
		mark_length = turns
	is_marked = true 

func _on_PlayerUnit_took_damage():
	pass # Replace with function body.
