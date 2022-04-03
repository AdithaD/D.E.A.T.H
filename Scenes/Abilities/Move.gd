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
		yield(player.do_move(path.slice(1,len(path) - 1)), "completed")
	
	finish_doing()
	pass

func _ready():
#	randomize()
	god = get_tree().root.get_child(0)


	
