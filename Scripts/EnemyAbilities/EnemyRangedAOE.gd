extends Node

enum TARGET_TYPE { player, enemy, cover, tile }

export (int) var ability_range = 5
export (int) var damage = 1
export (int) var penetration = 0
var ability_name = "shootaoe"
var target_type = TARGET_TYPE.tile

func use_ability_on_tile(_enemy, tile):
	pass
