extends Node

var obstacles_dict = {}
var direction_vectors = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]
var god

func init(par_god):
	god = par_god
	obstacles_dict = obstacle_array_to_dict(god.get_obstacle_locations())

func get_reachable(start, dist):
	var explored = {start: 0}
	var queue = [start]
	while len(queue) != 0:
		var new = queue.pop_front()
		for neigh in get_neighbours(new):
			if explored[new] + 1 <= dist and !(neigh in explored):
				explored[neigh] = explored[new] + 1
				queue.append(neigh)
				
	return explored.keys()

func find_path(start, goal, goal_can_be_obstacle = false):
	if start == goal:
		return [start]
	var explored = {start: null}
	var queue = [start]
	while len(queue) != 0:
		var new = queue.pop_front()
		
		if(goal_can_be_obstacle):
			for neigh in get_all_neighbours(new):
				if(neigh == goal):
					explored[neigh] = new
					return reconstruct_path(goal, explored)
		
		for neigh in get_neighbours(new):
			if(neigh == goal):
				explored[neigh] = new
				return reconstruct_path(goal, explored)
			if !(neigh in explored):
				explored[neigh] = new
				queue.append(neigh)
	
	return null
	

func get_neighbours(a):
	var possible_neighbours = []
	for dir in direction_vectors:
		var temp_neig = a + dir
		if tile_exists(temp_neig) and !tile_is_blocked(temp_neig):
			possible_neighbours.append(temp_neig)
	return possible_neighbours

func get_all_neighbours(a):
	var possible_neighbours = []
	for dir in direction_vectors:
		var temp_neig = a + dir
		if tile_exists(temp_neig):
			possible_neighbours.append(temp_neig)
	return possible_neighbours
	
func tile_exists(a):
	return god.cell_exists(a)

func tile_is_blocked(a):
	return a in obstacles_dict
	
func grid_distance(a, b):
	return abs(a.x - b.x) + abs(a.y - b.y)
	
func reconstruct_path(goal, prev_dict):
	var curr = goal
	var path = []
	while curr != null:
		path.append(curr)
		curr = prev_dict[curr]
	path.invert()
	return path


func obstacle_array_to_dict(arr):
	var out = {}
	for val in arr:
		out[val] = true
	return out
#	return {(i[1], i[2]): i[0] for i in arr}
