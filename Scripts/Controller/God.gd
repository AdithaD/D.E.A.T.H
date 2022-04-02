extends Node

#export (Array, NodePath) var player_unit_node_paths
#onready var player_units = load_nodes(player_unit_node_paths)
export (NodePath) var obstacle_map_path
export (NodePath) var floor_map_path
onready var obstacle_tile_map = get_node(obstacle_map_path)
onready var floor_tile_map = get_node(floor_map_path)
#func _ready():
#	print(get_obstacle_locations())
#
#
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
	
func get_obstacle_locations():
	return get_obstacle_tilemap().get_used_cells()


