extends Node
class_name AbilityLifecycle

export (PackedScene) var secondary_selector_scene

enum LIFECYCLE { selecting, doing, complete }
var state = LIFECYCLE.complete

var primary_selector
var secondary_selector
var active_ability
var player 
var target

func _ready():
	secondary_selector = get_node("/root/World").get_new_selector(secondary_selector_scene)
	add_child(secondary_selector)


	secondary_selector.connect("on_select_player", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_select_enemy", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_select_tile", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_select_cover", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_quit_selection", self, "_on_Secondary_Selector_quit_selection")


	secondary_selector.listen_to_input = false
	pass # Replace with function body.

func init(new_primary_selector):
	primary_selector = new_primary_selector
	primary_selector.connect("on_deselect", self, "_on_Selector_unselect")

func start(casting_player, ability_index):
	print('starting lifecycle')
	player = casting_player

	active_ability = player.abilities[ability_index]
	state = LIFECYCLE.selecting

	primary_selector.listen_to_input = false
	
	secondary_selector.set_select_mode(active_ability.target_type)
	secondary_selector.listen_to_input = true

	
func _on_Secondary_Selector_select(selected):
	if(LIFECYCLE.selecting):
		target = selected
		move_to_doing()
	pass

func move_to_doing():
	print('moving to doing')

	state = LIFECYCLE.doing
	active_ability.use_ability(player, target)
	state = LIFECYCLE.complete
	queue_free()

func _on_Selector_unselect():
	print('killing ability command')
	queue_free()
	pass

func _on_Secondary_Selector_quit_selection():
	primary_selector.listen_to_input = true
	queue_free()
