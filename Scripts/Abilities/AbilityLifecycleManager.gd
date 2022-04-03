extends Node

export (NodePath) var selector_path
export (PackedScene) var ability_lifecyle_scene

export (NodePath) var ability_prompt_path
onready var primary_selector = get_node(selector_path)
onready var ability_prompt = get_node(ability_prompt_path)

func submit_ability(player, ability_index):
	if get_children().size() == 0:
		var life_cycle = ability_lifecyle_scene.instance()
		add_child(life_cycle)

		life_cycle.init(player, ability_index, primary_selector)
			
		ability_prompt.set_ability(life_cycle)
		player.get_node("PlayerUI").bind_lifecycle(life_cycle)
		life_cycle.start()
