extends Node

export (int) var min_dist = 1
const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var god
var bfs
var enemy

func _ready():
	god = get_tree().root.get_child(0)
	bfs = bfs_class.new()
	enemy = get_parent()

func get_move():
	bfs.init(god)
	var reachable = bfs.get_reachable(enemy.grid_position, enemy.tiles_per_move)
	
	var best = [enemy.grid_position, 0]

	for tile in reachable:
		if evaluate_tile(tile) > best[1] and get_dist_to_closest_player(tile) >= min_dist:
			best = [tile, evaluate_tile(tile)]
		
	return bfs.find_path(enemy.grid_position, best[0])

func evaluate_tile(pos):
	return float(1)/max(get_move_dist_to_closest_player(pos), 1)
			
func get_dist_to_closest_player(pos):
	var player_locations = god.get_player_locations()
	var closest = 9999
	for loc in player_locations:
		var dist = bfs.grid_distance(pos, loc)
		if  dist < closest:
			closest = dist
	
	return closest

func get_move_dist_to_closest_player(pos):
	var player_locations = god.get_player_locations()
	var closest = 9999
	for loc in player_locations:
		var path = bfs.find_path(pos, loc)
		if(path and (len(path) - 1 < closest)):
			closest = len(path) - 1
	
	print("closest", closest, " ", pos)
	return closest
	
#func get_action(enemy: enemy):
	
