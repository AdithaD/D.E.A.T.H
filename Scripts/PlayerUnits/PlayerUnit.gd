extends Node2D
class_name PlayerUnit

export (int) var max_health
export (int) var actionPointsPerTurn
export (int) var tilesPerMove

var health
var actionPoints = actionPointsPerTurn

var abilities = [] 

var grid_position
var god

signal update_attr

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
	actionPoints = actionPointsPerTurn
	pass

func spendActionPoint(action_cost: int):
	actionPoints -= 1
	pass

func moveTo(x: int, y: int):
	pass
	
func take_damage(dmg):
	health -= dmg
	emit_signal("update_attr")

func use_ability(index):
	abilities[index].use_ability(self)
func _on_PlayerUnit_took_damage():
	pass # Replace with function body.
