extends Node2D
class_name Enemy

export (int) var max_health = 5
export (int) var tiles_per_move = 5
export (bool) var can_cover = true

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
		
func die():
	pass

func take_damage(dmg):
	health -= dmg
	if health <= 0:
		die()

func _on_World_new_turn():
	new_turn()
