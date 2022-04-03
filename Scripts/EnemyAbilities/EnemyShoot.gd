extends Node

enum TARGET_TYPE { player, enemy, cover, tile }

export (int) var ability_range = 5
export (int) var damage = 1
var ability_name = "shoot"
var target_type = TARGET_TYPE.player

func use_ability_on_player(unit):
	unit.take_damage(damage)
