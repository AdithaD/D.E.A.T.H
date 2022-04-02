extends Node

export (NodePath) var selector_path
export (PackedScene) var ability_lifecyle_scene
onready var primary_selector = get_node(selector_path)

func submit_ability(player, ability_index):
	var life_cycle = ability_lifecyle_scene.instance()
	$AbilityLifecycles.add_child(life_cycle)

	life_cycle.init(primary_selector)
	life_cycle.start(player, ability_index)
