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
	return 1/max(get_dist_to_closest_player(pos), 1)
			
func get_dist_to_closest_player(pos):
	var player_locations = god.get_player_locations()
	var closest = [null, 9999]
	for loc in player_locations:
		var dist = bfs.grid_distance(enemy.grid_position, loc)
		if  dist < closest[1]:
			closest = [loc, dist]
	
	return bfs.grid_distance(closest[0], pos)
	
#func get_action(enemy: enemy):
	
