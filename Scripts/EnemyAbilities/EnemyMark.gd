extends Node

enum TARGET_TYPE { player, enemy, cover, tile }

export (int) var ability_range = 5
export (int) var mark_turns = 1
var ability_name = "mark"
var target_type = TARGET_TYPE.player

func use_ability_on_player(_enemy, unit):
	if(unit.has_method("apply_mark")):
		unit.apply_mark(mark_turns)
