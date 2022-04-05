extends Node

export (Array, PackedScene) var enemies
var enemy_inst = []
export (int) var base_difficulty = 8
export (float) var turn_multiplier = 0.4
export (int) var turn_spawn_period = 2

export (int) var difficulty_cap

export (NodePath) var spawn_target

onready var god = get_node("/root/World")

var difficulty_dictionary = Dictionary()

var spawn_points

var difficulties = []

var aoe = preload("res://Scripts/AoE.gd")

func _ready():
	spawn_points = $"Spawn Points".get_children()
	
	for e in enemies:
		difficulties.append(e.instance().difficulty)
	
	for i in range(0, difficulties.size()):
		var difficulty = difficulties[i]
		if difficulty_dictionary.has(difficulty):
			difficulty_dictionary[difficulty].append(enemies[i])
		else:
			difficulty_dictionary[difficulty] = [enemies[i]]
func spawn(turn):
	if turn_spawn_period == 0:
		force_spawn(turn)
	elif turn % turn_spawn_period == 0:
		force_spawn(turn)
	
func force_spawn(turn):
	var turn_difficulty = base_difficulty + turn * turn_multiplier
	
	var existant_difficulty=0
	for e in god.get_enemy_nodes():
		existant_difficulty += e.difficulty
	
	turn_difficulty = clamp(turn_difficulty, 0, difficulty_cap - existant_difficulty)
	
	var enemy_combination = generate_enemy_combination(turn_difficulty)
	
	var spawn_node = get_node(spawn_target)
	for enemy in enemy_combination:
		var spawn_point = god.world_to_grid(spawn_points[randi() % spawn_points.size()].position)
		var free_tiles = aoe.get_free_tiles_in_AoE(spawn_point, 1, god)
		
		var spawn_grid = free_tiles[randi() % free_tiles.size()]
		var enemy_instance = enemy.instance()
		enemy_instance.position = god.grid_to_world(spawn_grid)
		god.init_entity(enemy_instance)
		spawn_node.add_child(enemy_instance)
		
		
		

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
	
	
