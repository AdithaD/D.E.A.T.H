extends Selector

var area_of_effect
var select_range

func _ready():
	area_of_effect = lifecycle.active_ability.area_of_effect
	select_range = lifecycle.active_ability.select_range
func select_tile():
	var mouse_pos = get_global_mouse_position()
	var grid_pos = floor_tile_map.world_to_map(mouse_pos)
	
	if grid_distance(grid_pos, lifecycle.player.grid_position) <= select_range:
		selection = floor_tile_map.world_to_map(mouse_pos)
		emit_signal("on_select_tile", selection)
	
func grid_distance(a, b):
	return abs(a.x - b.x) + abs(a.y - b.y)
		
	get_node("/root/World/Overlay").set_overlay(generateAoE(selection))
	pass

func _exit_tree():
	get_node("/root/World/Overlay").clear_overlay();

func deselect():
	get_node("/root/World/Overlay").clear_overlay();
	.deselect()
	
func generateAoE(target):
	var pos = target
	var list = []
	
	for i in range(-area_of_effect, area_of_effect + 1):
		for j in range(-area_of_effect, area_of_effect + 1):
			list.append(pos + Vector2(i, j))
			
	print(list)
	return list
