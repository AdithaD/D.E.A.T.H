extends Node
class_name Ability

export (String) var ability_name = "Ability"
export (String) var ability_description = "Ability Description"
export (Texture) var icon

export (AudioStream) var use_sound

export (Array, String) var voice_lines

export (int) var action_cost = 1
export (int) var cooldown_duration = 1

export (PackedScene) var selector

enum TARGET_TYPE { player, enemy, cover, tile, civilian }
export(TARGET_TYPE) var target_type = TARGET_TYPE.enemy

signal ability_used
signal finished_doing

var cooldown = 0

func new_turn():
	if(cooldown > 0):
		cooldown -= 1;

func can_use_ability(player):
	var can_use = player.action_points - action_cost >= 0 and cooldown == 0 and _ability_conditions(player) and player.can_be_controlled()
	return can_use

func _ability_conditions(_player):
	return true

func use_ability(player, target):
	print('%s is using ability %s on %s' % [player, name, target])
	if (can_use_ability(player)) :
		_use_ability(player, target)
		player.play_sound(use_sound)
		player.spend_action_points(action_cost)
		cooldown = cooldown_duration
		emit_signal('ability_used')

func _use_ability(_player, _target):
	pass
	
func get_details(lifecycle):
	var details = ""
	
	details += 'Action Cost: %s \n' % action_cost
	details += 'Cooldown: %s turns \n' % cooldown_duration
	
	return details

func finish_doing():
	emit_signal('finished_doing')
