extends Node

export (int) var min_dist = 5
const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

func get_move(enemy: Enemy):
	var god = get_tree().root.get_child(0)
	var bfs = bfs_class.new()
	bfs.init(100, god.get_obstacle_locations())
#	return []
	return bfs.find_path(enemy.grid_position, Vector2(0, 2))
	
#func get_action(enemy: Enemy):
	
