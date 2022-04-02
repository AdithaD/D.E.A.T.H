extends Node

export (NodePath) var selector_path
export (PackedScene) var ability_lifecyle_scene

export (NodePath) var ability_prompt_path
onready var primary_selector = get_node(selector_path)
onready var ability_prompt = get_node(ability_prompt_path)

func submit_ability(player, ability_index):
	var life_cycle = ability_lifecyle_scene.instance()
	add_child(life_cycle)

	ability_prompt.set_ability(player.abilities[ability_index])
	life_cycle.connect("selecting", ability_prompt, "show")
	life_cycle.connect("doing", ability_prompt, "hide")

	ability_prompt.get_child(2).connect("pressed", life_cycle, "move_to_doing")

	life_cycle.init(primary_selector)
	life_cycle.start(player, ability_index)
	
	
