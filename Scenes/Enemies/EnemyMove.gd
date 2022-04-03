extends EnemyAbility

export (int) var min_dist = 1
const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var god
var bfs
var enemy

export (float) var move_animation_time = 0.15
var move_interval = 0.025

func _ready():
#	randomize()
	god = get_tree().root.get_child(0)
	bfs = bfs_class.new()
	
func _use_ai_ability(source):
	enemy = source
	print('enemy moving')
	var path = get_move()
	
	if(len(path) >= 2):
			yield(do_move(path.slice(1,len(path) - 1)), "completed")
			
	finish_doing()
	pass

func do_move(path):
	enemy.grid_position = path[-1]
	print(enemy.grid_position)
	for loc in path:
		yield(world_move_to(god.grid_to_world(loc)), "completed")
	

func world_move_to(loc):
	var diff = loc - enemy.position
	var steps = int(move_animation_time/move_interval)
	for i in range(0, steps):
		yield(get_tree().create_timer(move_interval), "timeout")
		enemy.position += diff/steps
	
	enemy.position = loc
	

func get_move():
	bfs.init(god)
	var reachable = bfs.get_reachable(enemy.grid_position, enemy.get_moveable_distance())
	
	var best = [enemy.grid_position, 0]

	for tile in reachable:
		if ai.evaluate_tile(tile) > best[1] and ai.get_dist_to_closest_player(tile) >= min_dist:
			best = [tile, ai.evaluate_tile(tile)]
		
	return bfs.find_path(enemy.grid_position, best[0])


