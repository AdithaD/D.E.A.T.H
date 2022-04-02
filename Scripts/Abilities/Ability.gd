extends Node
class_name Ability

export (String) var ability_name = "Ability"
export (String) var ability_description = "Ability Description"
export (Texture) var icon

export (int) var action_cost = 1
export (int) var cooldownDuration = 1

enum TARGET_TYPE { player, enemy, cover, tile }
export(TARGET_TYPE) var target_type = TARGET_TYPE.enemy


var cooldown = 0

func new_turn():
	if(cooldown > 0):
		cooldown -= 1;

func can_use_ability(player):
	return player.actionPoints <= 0 || cooldown != 0


func use_ability(player, target):
	if (can_use_ability(player)) :
		_use_ability(player, target)

		player.spendActionPoint(action_cost)
		cooldown = cooldownDuration

func _use_ability(_player, _target):
	pass
