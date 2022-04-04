extends Node
class_name BFSAI
var god
var host

const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var bfs

func _ready():
#	randomize()
	bfs = bfs_class.new()
	god = get_node("/root/World")
	host = get_parent()
	
func generate_turn(abilities):
	pass

func get_target_locations():
	return god.get_player_locations()


func evaluate_tile(pos):
	return float(1)/max(get_dist_to_closest_target(pos), 1)
			
func get_dist_to_closest_target(pos):
	var target_locations = get_target_locations()
	var closest = 9999
	for loc in target_locations:
		var dist = bfs.grid_distance(pos, loc)
		if  dist < closest:
			closest = dist
	
	return closest
	
func get_players_in_range(ability_range, pos, alive=true):
	var in_range = []
	for player in god.get_player_nodes(alive):
		if bfs.grid_distance(player.grid_position, pos) <= ability_range:
			in_range.append(player)
	return in_range

func get_civilians_in_range(ability_range, pos, alive=true):
	var in_range = []
	for civilian in god.get_civilian_nodes(alive):
		if bfs.grid_distance(civilian.grid_position, pos) <= ability_range:
			in_range.append(civilian)
	return in_range

func get_flying_players_in_range(ability_range, pos, alive=true):
	var in_range = []
	for player in god.get_flying_player_nodes(alive):
		if bfs.grid_distance(player.grid_position, pos) <= ability_range:
			in_range.append(player)
	return in_range

func get_move_dist_to_closest_target(pos):
	var target_locations = get_target_locations()
	var closest = 9999
	for loc in target_locations:
		var path = bfs.find_path(pos, loc, true)
		if(path and (len(path) - 1 < closest)):
			closest = len(path) - 1
	
	return closest
	
func get_move(unit, min_dist):
	bfs.init(god)
	var reachable = bfs.get_reachable(unit.grid_position, unit.get_moveable_distance())
	
	var best = [unit.grid_position, 0]

	for tile in reachable:
		if evaluate_tile(tile) > best[1] and get_dist_to_closest_target(tile) >= min_dist:
			best = [tile, evaluate_tile(tile)]
		
	return bfs.find_path(unit.grid_position, best[0])

func grid_distance(a, b):
	return abs(a.x - b.x) + abs(a.y - b.y)
	
