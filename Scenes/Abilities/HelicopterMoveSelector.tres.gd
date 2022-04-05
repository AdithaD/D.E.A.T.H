extends Selector


const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var bfs
var reachable

func _ready():
	bfs = bfs_class.new()
	bfs.init_obs(self.god, [])
	reachable = bfs.get_reachable(lifecycle.player.grid_position, lifecycle.player.get_moveable_distance())
	get_node("/root/World/Overlay").set_overlay(reachable)
	
func select_tile():
	var mouse_pos = get_global_mouse_position()
	var grid_pos = floor_tile_map.world_to_map(mouse_pos)
	
	if reachable.find(grid_pos) != -1:
		selection = floor_tile_map.world_to_map(mouse_pos)
		emit_signal("on_select_tile", selection)
		SoundEngine.play_button_sound()
	pass

func on_destroy():
	get_node("/root/World/Overlay").clear_overlay();
	.on_destroy()
