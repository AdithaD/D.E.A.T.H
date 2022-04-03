extends Node2D
class_name PlayerUnit

export (int) var max_health
export (int) var actionPointsPerTurn
export (int) var tilesPerMove

var health
var action_points = actionPointsPerTurn

var abilities = [] 

var grid_position = Vector2(0, 0)

signal update_attr
signal used_ability

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	
	abilities = $Abilities.get_children()
			
	new_turn()
	emit_signal('update_attr')
	pass # Replace with function body.

func new_turn():
	action_points = actionPointsPerTurn
	pass

func spend_action_points(action_cost: int):
	action_points -= 1
	emit_signal('update_attr')
	pass

func moveTo(x: int, y: int):
	pass

func on_used_ability(index):
	emit_signal("used_ability")
	
func _on_PlayerUnit_took_damage():
	pass # Replace with function body.
