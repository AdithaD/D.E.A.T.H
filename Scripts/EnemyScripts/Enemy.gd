extends Node2D
class_name Enemy

export (int) var max_health = 5
export (int) var tiles_per_move = 5
export (bool) var can_cover = true
enum TARGET_TYPE { player, enemy, cover, tile }

var health
var abilities = []
var ai
var grid_position
var god

func _ready():
	health = max_health
	abilities = $Abilities.get_children()
	ai = $AI
	god = get_tree().root.get_child(0)

func new_turn():
	if(ai.has_method("get_move")):
		var move = ai.get_move()
		grid_position = move[-1]
		print(grid_position)
		position = god.grid_to_world(grid_position)
	
	if(ai.has_method("get_action")):
		do_action(ai.get_action())

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
			pass
	
		
func die():
	pass

func take_damage(dmg):
	health -= dmg
	if health <= 0:
		die()
