extends Selector

var select_range

const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var bfs
var reachable

onready var overlay = get_node("/root/World/Overlay")

var overlay_set = false

func _ready():
	bfs = bfs_class.new()
	bfs.init_obs(self.god, [])
	
	select_range = lifecycle.active_ability.select_range
	
	

func init():
	reachable = bfs.get_reachable(lifecycle.player.grid_position, lifecycle.active_ability.select_range)
	overlay.set_overlay(reachable, 2)
	overlay_set = true
	
func on_destroy():
	if overlay_set:
		get_node("/root/World/Overlay").clear_overlay();
	.on_destroy()

func select_tile():
	var mouse_pos = get_global_mouse_position()
	var grid_pos = floor_tile_map.world_to_map(mouse_pos)
	
	if grid_distance(grid_pos, lifecycle.player.grid_position) <= select_range:
		selection = floor_tile_map.world_to_map(mouse_pos)
		emit_signal("on_select_tile", selection)
	
func grid_distance(a, b):
	return abs(a.x - b.x) + abs(a.y - b.y)

func can_select_player(selection):	
	return grid_distance(selection.grid_position, lifecycle.player.grid_position) <= select_range

func can_select_civilian(selection):	
	return grid_distance(selection.grid_position, lifecycle.player.grid_position) <= select_range
	
func can_select_tile(selection):	
	return  grid_distance(selection, lifecycle.player.grid_position) <= select_range
	
func can_select_cover(selection):	
	return  grid_distance(selection, lifecycle.player.grid_position) <= select_range
	
func can_select_enemy(selection):	
	return grid_distance(selection.grid_position, lifecycle.player.grid_position) <= select_range

#func deselect():
#	if overlay_set:
#		get_node("/root/World/Overlay").clear_overlay();
#	.deselect()
