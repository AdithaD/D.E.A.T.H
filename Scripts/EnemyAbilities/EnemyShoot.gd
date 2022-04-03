extends Node

enum TARGET_TYPE { player, enemy, cover, tile }

export (int) var ability_range = 5
export (int) var damage = 1
export (int) var penetration = 0
var ability_name = "shoot"
var target_type = TARGET_TYPE.player

func use_ability_on_player(_enemy, unit):
#	randomize()
	var god = get_tree().root.get_child(0)
	var rand = god.get_hit_chance(_enemy.grid_position, unit.grid_position, penetration, !unit.can_cover, unit.is_marked)
	if(randf() < rand):
		unit.take_damage(damage)
