#extends Node
#
#var obstacles_dict = {}
#var n = 0
#var direction_vectors = [Vector2.LEFT, Vector2.UP, Vector2.RIGHT, Vector2.DOWN]
#
#func init(inp_n, obstacles_arr):
#	if obstacles_arr == null:
#		obstacles_arr = []
#	n = inp_n
#	obstacles_dict = obstacle_array_to_dict(obstacles_arr)
#
#func find_path(start, goal):
#	var prev = {start: null}
#	var dist = {start: 0}
#	var pq = PriorityQueue.new()
#	pq.insert(start, path_heuristic(start, goal))
#	while not pq.is_empty():
#		var curr = pq.pop()
#		if curr == goal:
#			return reconstruct_path(goal, prev)
#		for neighbour in get_neighbours(curr):
#			var tentative_dist = dist[curr] + 1
#			if !(neighbour in dist) or (tentative_dist < dist[neighbour]):
#				pq.update(neighbour, tentative_dist + path_heuristic(neighbour, goal))
#				prev[neighbour] = curr
#				dist[neighbour] = tentative_dist
#	return null
#
#func reconstruct_path(goal, prev_dict):
#	var curr = goal
#	var path = []
#	while curr != null:
#		path.append(curr)
#		curr = prev_dict[curr]
#	path.invert()
#	return path
#
#func get_neighbours(a):
#	var possible_neighbours = []
#	for dir in direction_vectors:
#		var temp_neig = a + dir
#		if tile_exists(temp_neig) and !tile_is_blocked(temp_neig):
#			possible_neighbours.append(temp_neig)
#	return possible_neighbours
#
#func tile_exists(a):
#	return (0 <= a.x  and a.x <= n - 1) and (0 <= a.y and a.y <= n - 1)
#
#func tile_is_blocked(a):
#	return a in obstacles_dict
#
#func path_heuristic(a, goal):
#		return grid_distance(a, goal)
#
#func grid_distance(a, b):
#	return abs(a.x - b.x) + abs(a.y - b.y)
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
#
#func obstacle_array_to_dict(arr):
#	var out = {}
#	for val in arr:
#		out[val] = true
#	return out
##	return {(i[1], i[2]): i[0] for i in arr}
#
#class ObjSorter:
#	static func sort(a, b):
#		return b["prio"] - a["prio"]
#
#
#class PriorityQueue:
#	var items = []
##	func init(self):
##		self.items = []
#
#	func insert(item, prio):
#		items.append({"prio": prio, "item": item})
#
#	func pop():
#		if len(items) == 0:
#			return null
#		items.sort_custom(ObjSorter, "sort")
#		return items.pop_back()["item"]
#
#	# removes all matches to item and replaces with new prio
#	func update(item, prio):
#		var new_items = []
#		for temp_item in items:
#			if temp_item["item"] != item:
#				new_items.append({"prio": temp_item["prio"], "item": temp_item["item"]})
#
#		items = new_items
#		insert(item, prio)
#
#	func is_empty():
#		return len(items) == 0
