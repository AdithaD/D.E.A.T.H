extends Node2D
class_name PlayerUnit

export (int) var max_health
export (int) var actionPointsPerTurn
export (int) var tilesPerMove
export (int) var cooldown

var health = max_health
var actionPoints = actionPointsPerTurn

var abilities = [] 

var grid_position = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	
	abilities = $Abilities.get_children()
			
	new_turn()
	pass # Replace with function body.

func new_turn():
	actionPoints = actionPointsPerTurn
	pass

func spendActionPoint(action_cost: int):
	actionPoints -= 1
	pass

func moveTo(x: int, y: int):
	pass
