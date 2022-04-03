extends "res://Scripts/Abilities/Ability.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _use_ability(player, target):
	if (can_use_ability(player)) :
		var obstacle_tilemap = get_node("/root/World").get_obstacle_tilemap()
		obstacle_tilemap.set_cellv(target, obstacle_tilemap.tile_set.find_tile_by_name("rubble"))
	
