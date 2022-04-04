extends Selector

var area_of_effect
var select_range

var aoe = preload("res://Scripts/AoE.gd")

func _ready():
	area_of_effect = lifecycle.active_ability.area_of_effect
	select_range = lifecycle.active_ability.select_range
func select_tile():
	var mouse_pos = get_global_mouse_position()
	var grid_pos = floor_tile_map.world_to_map(mouse_pos)
	
	if grid_distance(grid_pos, lifecycle.player.grid_position) <= select_range:
		selection = floor_tile_map.world_to_map(mouse_pos)
		get_node("/root/World/Overlay").set_overlay(aoe.generate_AoE(selection, area_of_effect), 1)
		emit_signal("on_select_tile", selection)
	
func grid_distance(a, b):
	return abs(a.x - b.x) + abs(a.y - b.y)

func _exit_tree():
	get_node("/root/World/Overlay").clear_overlay();

func deselect():
	get_node("/root/World/Overlay").clear_overlay();
	.deselect()

