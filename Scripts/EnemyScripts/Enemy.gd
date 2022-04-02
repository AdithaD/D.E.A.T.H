extends Node2D
class_name Enemy

export (int) var max_health
export (int) var tiles_per_move

export (int) var can_attack
export (int) var attack_range
export (int) var attack_dmg

var health
var abilities = []
var ai
var tile_pos

func _ready():
	health = max_health
	abilities = $Abilities.get_children()
	ai = $AI

func new_turn():
	var move = [tile_pos]
	if(ai.has_method("get_move")):
		move = ai.get_move(self)
	pass

