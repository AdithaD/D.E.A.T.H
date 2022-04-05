extends "res://Scripts/Abilities/Move.gd"

func _use_ability(player, target):
	bfs = bfs_class.new()
	bfs.init_obs(god, [])
	var path = bfs.find_path(player.grid_position, target)
	
	if(path != null):
		SoundEngine.play_footsteps_sfx()
		yield(player.do_move(path.slice(1,len(path) - 1)), "completed")
		player.dist_moved += path.size() - 1
		SoundEngine.stop_sfxPlayer()
	finish_doing()
	pass
