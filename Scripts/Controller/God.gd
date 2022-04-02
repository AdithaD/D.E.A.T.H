extends Node

#export (Array, NodePath) var player_unit_node_paths
#onready var player_units = load_nodes(player_unit_node_paths)


func _ready():
	print(get_player_locations())
#
	
func load_nodes(nodePaths: Array) -> Array:
	var nodes := []
	for nodePath in nodePaths:
		var node := get_node(nodePath)
		if node != null:
			nodes.append(node)
	return nodes
	
func get_player_nodes():
#	return player_units
	return get_tree().get_nodes_in_group("player_unit")
	
func get_player_locations():
	var out = []
	print(get_player_nodes())
	for player in get_player_nodes():
		out.push(player.grid_position)
	return out

func get_map():
	return []


