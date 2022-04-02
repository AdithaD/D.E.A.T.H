extends Node

var obstacles_dict = {}
var n = 0
var direction_vectors = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]

func init(inp_n, obstacles_arr):
	if obstacles_arr == null:
		obstacles_arr = []
	n = inp_n
	obstacles_dict = obstacle_array_to_dict(obstacles_arr)

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

func find_path(start, goal):
	if start == goal:
		return [start]
	var explored = {start: null}
	var queue = [start]
	while len(queue) != 0:
		var new = queue.pop_front()
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
	
func tile_exists(a):
	return (0 <= a.x  and a.x <= n - 1) and (0 <= a.y and a.y <= n - 1)

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
