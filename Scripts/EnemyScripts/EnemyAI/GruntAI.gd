extends Node

export (int) var min_dist = 5
const a_start_path = "res://Scripts/Pathing/AStar.gd"
const a_star_class = preload(a_start_path)

func get_move(enemy: Enemy):
	var god = get_tree().root.get_child(0)
	var a_star = a_star_class.new()
	a_star.init(1000, god.get_obstacle_locations())
	return a_star.find_path(enemy.grid_position, Vector2(0, 2))
	
#func get_action(enemy: Enemy):
	
