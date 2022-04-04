extends EnemyAbility

export (int) var min_dist = 1
const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var god
var bfs
var enemy

export (float) var move_animation_time = 0.15
var move_interval = 0.025

enum SPRITE_DIRECTIONS {BOTTOM_LEFT, TOP_LEFT, TOP_RIGHT, BOTTOM_RIGHT}

func _ready():
#	randomize()
	god = get_node("/root/World")
	bfs = bfs_class.new()
	
func _use_ai_ability(source):
	enemy = source
	var path = ai.get_move(source, min_dist)
	
	if(len(path) >= 2):
		yield(do_move(path.slice(1,len(path) - 1)), "completed")
	else:
		yield(get_tree().create_timer(move_interval), "timeout")
	
	finish_doing()

func do_move(path):
	var prev_loc = enemy.grid_position
	enemy.grid_position = path[-1]
	for loc in path:
		change_dir_sprite(loc - prev_loc)
		prev_loc = loc
		yield(world_move_to(god.grid_to_world(loc)), "completed")
	

func world_move_to(loc):
	var diff = loc - enemy.position
	var steps = int(move_animation_time/move_interval)
	for _i in range(0, steps):
		SoundEngine.play_footsteps_sfx()
		yield(get_tree().create_timer(move_interval), "timeout")
		enemy.position += diff/steps
		SoundEngine.stop_sfxPlayer()
	
	enemy.position = loc


func change_dir_sprite(vector):
	if(abs(vector.x) >= abs(vector.y)):
		if(vector.x >= 0):
			set_sprite_index(SPRITE_DIRECTIONS.BOTTOM_RIGHT)
		else:
			set_sprite_index(SPRITE_DIRECTIONS.TOP_LEFT)
	else:
		if(vector.y >= 0):
			set_sprite_index(SPRITE_DIRECTIONS.BOTTOM_LEFT)
		else:
			set_sprite_index(SPRITE_DIRECTIONS.TOP_RIGHT)

func set_sprite_index(index):
	enemy.get_node("AnimatedSprite").frame = index



