extends Node

export (int) var amount_to_spawn = 20 
export (int) var max_batch_size = 3

export (Array, PackedScene) var civilian_types
export (NodePath) var spawn_target

var aoe = preload("res://Scripts/AoE.gd")

var god
var obs
var ground

func spawn_civilians(new_god):
	randomize()
	god = new_god
	var amount_spawned  = 0
	
	obs = god.get_obstacle_tilemap()
	ground = god.get_obstacle_tilemap()
	
	while amount_spawned < amount_to_spawn:
		var size_of_batch = randi() % max_batch_size
		
		size_of_batch = clamp(size_of_batch, 0, amount_to_spawn - amount_spawned)
		
		var all_cells = ground.get_used_cells()
		var cell_chosen = null
		var valid_spawns = null
		while (valid_spawns == null):
			cell_chosen = all_cells[randi() % all_cells.size()]
			valid_spawns = get_valid_spawns(cell_chosen, size_of_batch)
		
		var spawn_node = get_node(spawn_target)
		for spawn in valid_spawns:
			var type = civilian_types[randi() % civilian_types.size()]
			
			var new_civilian = type.instance()
			new_civilian.position = ground.map_to_world(spawn)
			spawn_node.add_child(new_civilian)
			
		
		amount_spawned += size_of_batch

func get_valid_spawns(position, batch_size):
	var possible_spawns = aoe.generate_AoE(position, 1)
	var all_obs = god.get_obstacle_locations()
	
	var valid_spawns = []
	
	for poss_spawn in possible_spawns:
		var no_obs = all_obs.find(poss_spawn) == -1
		var has_ground = ground.get_cellv(poss_spawn) != -1
		if no_obs and has_ground:
			valid_spawns.append(poss_spawn)
	
	
	if(valid_spawns.size() >= batch_size):
		return valid_spawns.slice(0, batch_size - 1)
	else:
		return null
