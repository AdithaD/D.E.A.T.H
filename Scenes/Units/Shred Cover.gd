extends "res://Scripts/Abilities/Ability.gd"

var tracer = preload("res://Scenes/Abilities/Tracer.tscn")
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
		submit_tracer_burst(player.global_position, obstacle_tilemap.map_to_world(target), 10, 400, 8, 0.01)

func submit_tracer_burst(start_pos, target_pos, length, speed, amount, offset):
		
		for i in range(0, amount):
			var new_tracer = tracer.instance()
			new_tracer.submit_tracer(start_pos, target_pos, length, speed)
			var duration = new_tracer.get_duration()
			add_child(new_tracer)
			yield(get_tree().create_timer(duration), "timeout")
			
		for child in get_children():
			child.queue_free()
			
	
