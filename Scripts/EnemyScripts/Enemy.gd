extends Node2D
class_name Enemy

export (int) var max_health
export (int) var tiles_per_move = 5

export (int) var can_attack
export (int) var attack_range
export (int) var attack_dmg

var health
var abilities = []
var ai
var grid_position = Vector2(0, 0)
var god

func _ready():
	health = max_health
	abilities = $Abilities.get_children()
	ai = $AI
	god = get_tree().root.get_child(0)
	

func new_turn():
	if(ai.has_method("get_move")):
		var move = ai.get_move()
		grid_position = move[-1]
		position = god.get_obstacle_tilemap().map_to_world(grid_position)
		


func _on_World_new_turn():
	new_turn()
