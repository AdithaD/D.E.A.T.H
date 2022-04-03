extends Node

#export (Array, NodePath) var player_unit_node_paths
#onready var player_units = load_nodes(player_unit_node_paths)
export (NodePath) var obstacle_map_path
export (NodePath) var floor_map_path
onready var obstacle_tile_map = get_node(obstacle_map_path)

onready var floor_tile_map = get_node(floor_map_path)

signal new_turn

func _ready():
	set_process_input(true)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		new_turn()

#func load_nodes(nodePaths: Array) -> Array:
#	var nodes := []
#	for nodePath in nodePaths:
#		var node := get_node(nodePath)
#		if node != null:
#			nodes.append(node)
#	return nodes
#
func get_player_nodes():
#	return player_units
	return get_tree().get_nodes_in_group("player_unit")
	
func get_player_locations():
	var out = []
	for player in get_player_nodes():
		out.append(player.grid_position)
	return out

func get_obstacle_tilemap():
	return obstacle_tile_map

func get_floor_tilemap():
	return floor_tile_map
	
func get_obstacle_locations():
	return get_obstacle_tilemap().get_used_cells()

func world_to_grid(world):
	return floor_tile_map.world_to_map(world)
func get_new_selector(scene):
	var new_selector = scene.instance()
	new_selector.obstacle_tile_map = obstacle_tile_map
	new_selector.floor_tile_map = floor_tile_map
	return new_selector

func grid_to_world(grid):
	return floor_tile_map.map_to_world(grid)
	
func cell_exists(grid):
	return floor_tile_map.get_cellv(grid) != -1
	

func new_turn():
	emit_signal("new_turn")
	
class Cover:
	static func raytrace(loc_a, loc_b):
		var tiles = []
		
		var x0 = loc_a.x
		var y0 = loc_a.y
		var x1 = loc_b.x
		var y1 = loc_b.y
		
		var dx = abs(x1 - x0);
		var dy = abs(y1 - y0);
		var x = x0;
		var y = y0;
		var n = 1 + dx + dy;
		var x_inc = 1 if (x1 > x0) else  -1;
		var y_inc =  1 if (y1 > y0) else -1;
		var error = dx - dy;
		dx *= 2;
		dy *= 2;

		while n > 0:
			tiles.append(Vector2(x, y))

			if (error > 0):
				x += x_inc;
				error -= dy;
			elif error < 0:
				y += y_inc;
				error += dx;
			elif error == 0:
				x += x_inc
				error -= dy
				y += y_inc
				error += dx
				n -= 1
			
			n -= 1
		
		return tiles

		
	static func get_cover(loc_a, loc_b):
		pass
		
	



