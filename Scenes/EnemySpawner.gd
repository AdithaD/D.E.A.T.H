extends Node

export (Array, PackedScene) var enemies
export (Array, int) var difficulties

export (int) var base_difficulty = 8
export (int) var turn_multiplier = 0.4
export (int) var turn_spawn_period = 2

export (NodePath) var spawn_target

onready var god = get_node("/root/World")

var difficulty_dictionary = Dictionary()

var spawn_points

var aoe = preload("res://Scripts/AoE.gd")

func _ready():
	spawn_points = $"Spawn Points".get_children()
	for i in range(0, enemies.size()):
		if difficulty_dictionary.has(difficulties[i]):
			difficulty_dictionary[difficulties[i]].append(enemies[i])
		else:
			difficulty_dictionary[difficulties[i]] = [enemies[i]]
func spawn(turn):
	if turn_spawn_period == 0:
		force_spawn(turn)
	elif turn % turn_spawn_period == 0:
		force_spawn(turn)
	
func force_spawn(turn):
	var turn_difficulty = base_difficulty + turn * turn_multiplier
	
	var enemy_combination = generate_enemy_combination(turn_difficulty)
	
	var spawn_node = get_node(spawn_target)
	for enemy in enemy_combination:
		var spawn_point = god.world_to_grid(spawn_points[randi() % spawn_points.size()].position)
		var free_tiles = aoe.get_free_tiles_in_AoE(spawn_point, 1, god)
		
		var spawn_grid = free_tiles[randi() % free_tiles.size()]
		var enemy_inst = enemy.instance()
		enemy_inst.position = god.grid_to_world(spawn_grid)
		god.init_entity(enemy_inst)
		spawn_node.add_child(enemy_inst)
		
		
		

func generate_enemy_combination(turn_difficulty):
	var current = 0
	var enemies = []
	
	while current < turn_difficulty:
		var allowed_difficulties = []
		for difficulty in difficulty_dictionary.keys():
			if (difficulty < turn_difficulty - current):
				allowed_difficulties.append(difficulty)
		
		if(allowed_difficulties.size() > 0):
			var target_difficulty = allowed_difficulties[randi() % allowed_difficulties.size()]
			var enemy = difficulty_dictionary[target_difficulty][randi() % difficulty_dictionary[target_difficulty].size()]
			
			enemies.append(enemy)
			current += target_difficulty
		else:
			break
	
	return enemies
	
	
