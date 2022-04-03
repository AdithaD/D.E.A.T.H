extends Node

var god
var enemy

const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var bfs

func _ready():
#	randomize()
	bfs = bfs_class.new()
	god = get_tree().root.get_child(0)
	enemy = get_parent()
	
func generate_turn(abilities):
	var move_ability = abilities[0]
	
	var other_ability = abilities[1]
	if(abilities.size() > 2):
		var other_abilities = abilities.slice(1,len(abilities) - 1)
		other_ability  = other_abilities[randi() % len(other_abilities)]
		
	return [move_ability, other_ability]


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
	
func get_players_in_range(ability_range, pos):
	var in_range = []
	for player in god.get_player_nodes():
		if bfs.grid_distance(player.grid_position, pos) <= ability_range:
			in_range.append(player)
	return in_range

func get_move_dist_to_closest_player(pos):
	var player_locations = god.get_player_locations()
	var closest = 9999
	for loc in player_locations:
		var path = bfs.find_path(pos, loc, true)
		if(path and (len(path) - 1 < closest)):
			closest = len(path) - 1
	
	return closest
