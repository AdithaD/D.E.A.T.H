extends Ability

export (int) var min_dist = 1
const bfs_path = "res://Scripts/Pathing/BFS.gd"
const bfs_class = preload(bfs_path)

var god
var bfs

func _use_ability(player, target):
	bfs = bfs_class.new()
	bfs.init(god)
	var path = bfs.find_path(player.grid_position, target)
	
	if(path != null):
		player.set_grid_position(path[-1])
		player.dist_moved += path.size() - 1
	finish_doing()
	pass

func _ready():
#	randomize()
	god = get_tree().root.get_child(0)


func _ability_conditions(player):
	return player.get_moveable_distance() > 0
