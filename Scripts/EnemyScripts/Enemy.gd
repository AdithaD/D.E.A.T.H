extends Node2D
class_name Enemy

export (int) var max_health = 5
export (int) var tiles_per_move = 5
export (bool) var can_cover = true

export (float) var move_animation_time = 0.15
var move_interval = 0.025

enum TARGET_TYPE { player, enemy, cover, tile }

var health
var abilities = []
var ai
var grid_position
var god

var is_marked = false

signal update_attr

func _ready():
	health = max_health
	abilities = $Abilities.get_children()
	ai = $AI
	god = get_tree().root.get_child(0)
	emit_signal('update_attr')

func new_turn():

	if(ai.has_method("get_move")):
		var move = ai.get_move()
		if(len(move) >= 2):
			yield(do_move(move.slice(1,len(move) - 1)), "completed")
	
	if(ai.has_method("get_action")):
		do_action(ai.get_action())
	
func do_move(path):
	grid_position = path[-1]
	for loc in path:
		yield(world_move_to(god.grid_to_world(loc)), "completed")
	

func world_move_to(loc):
	var diff = loc - position
	var steps = int(move_animation_time/move_interval)
	for _i in range(0, steps):
		yield(get_tree().create_timer(move_interval), "timeout")
		position += diff/steps
	
	position = loc
	

func get_ability(name):
	for x in abilities:
		if x.ability_name == name:
			return x
	return null
	

func do_action(action):
	if(action == null):
		return
	var target = action["target"]
	var ability = get_ability(action["action"])
	if(ability == null):
		return
	
	match ability.target_type:
		TARGET_TYPE.player:
			ability.use_ability_on_player(self, target)
		TARGET_TYPE.enemy:
			pass
		TARGET_TYPE.cover:
			pass
		TARGET_TYPE.tile:
			ability.use_ability_on_tile(self, target)
	
		
func die():
	pass

func take_damage(dmg):
	health -= dmg
	if health <= 0:
		die()
	emit_signal('update_attr')
