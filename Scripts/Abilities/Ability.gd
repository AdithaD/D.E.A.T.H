extends Node
class_name Ability

export (String) var ability_name = "Ability"
export (String) var ability_description = "Ability Description"
export (Texture) var icon

export (Array, String) var voice_lines

export (int) var action_cost = 1
export (int) var cooldownDuration = 1

export (PackedScene) var selector

enum TARGET_TYPE { player, enemy, cover, tile }
export(TARGET_TYPE) var target_type = TARGET_TYPE.enemy

signal ability_used
signal finished_doing

var cooldown = 0

func new_turn():
	if(cooldown > 0):
		cooldown -= 1;

func can_use_ability(player):
	var can_use = player.action_points > 0 and cooldown == 0 and _ability_conditions(player)
	return can_use

func _ability_conditions(player):
	return true

func use_ability(player, target):
	if (can_use_ability(player)) :
		_use_ability(player, target)

		player.spend_action_points(action_cost)
		cooldown = cooldownDuration
		emit_signal('ability_used')

func _use_ability(_player, _target):
	pass

func finish_doing():
	emit_signal('finished_doing')
