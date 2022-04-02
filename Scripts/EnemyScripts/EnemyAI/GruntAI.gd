extends Node

export (int) var min_dist = 3
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
	bfs.init(100, god.get_obstacle_locations())
	var reachable = bfs.get_reachable(enemy.grid_position, enemy.tiles_per_move)
	
	var best = [enemy.grid_position, 0]

	for tile in reachable:
		if evaluate_tile(tile) > best[1]:
			best = [tile, evaluate_tile(tile)]
		
	return bfs.find_path(enemy.grid_position, best[0])

func evaluate_tile(pos):
	var player_locations = god.get_player_locations()
	var closest = [null, 9999]
	for loc in player_locations:
		if bfs.grid_distance(enemy.grid_position, loc) < closest[1]:
			closest = [loc, bfs.grid_distance(enemy.grid_position, loc)]
	
	return bfs.grid_distance(closest[0], pos)
	
#func get_action(enemy: enemy):
	
