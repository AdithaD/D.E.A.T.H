extends Node

enum TARGET_TYPE { player, enemy, cover, tile }

export (int) var ability_range = 5
var ability_name = "mark"
var target_type = TARGET_TYPE.player

func use_ability_on_player(unit):
	unit.apply_mark()
