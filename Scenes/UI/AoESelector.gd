extends Selector

var area_of_effect

func _ready():
	area_of_effect = lifecycle.active_ability.area_of_effect
	
func select_tile():
	var mouse_pos = get_global_mouse_position()
	var grid_pos = floor_tile_map.world_to_map(mouse_pos)
	
	selection = floor_tile_map.world_to_map(mouse_pos)
	emit_signal("on_select_tile", selection)
	
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
