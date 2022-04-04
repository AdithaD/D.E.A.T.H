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

onready var god = get_node("/root/World")

signal selecting
signal selected
signal doing 
signal cancel
#signal completed 

func init(casting_player, ability_index, new_primary_selector):
	primary_selector = new_primary_selector
	primary_selector.connect("on_deselect", self, "_on_Selector_deselect")
	
	player = casting_player
	active_ability = player.abilities[ability_index]
	
	active_ability.connect('finished_doing', self, "on_finished_doing")
	
	if active_ability.selector != null:
		secondary_selector = active_ability.selector.instance()
		god.init_selector(secondary_selector)
	else:
		secondary_selector = god.get_new_selector(secondary_selector_scene)
	
	secondary_selector.lifecycle = self
	
	add_child(secondary_selector)

	secondary_selector.connect("on_select_player", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_select_enemy", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_select_tile", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_select_cover", self, "_on_Secondary_Selector_select")
	secondary_selector.connect("on_select_civilian", self, "_on_Secondary_Selector_select")

	secondary_selector.connect("on_deselect", self, "_on_Secondary_Selector_deselect")
	secondary_selector.connect("on_quit_selection", self, "_on_Secondary_Selector_quit_selection")
	secondary_selector.connect("on_confirm_select", self,"on_Secondary_Selector_confirm_select")
	secondary_selector.listen_to_input = false

func start():
	print('Begin Ability Lifecycle %s' % active_ability.name)
	state = LIFECYCLE.selecting

	primary_selector.listen_to_input = false
	
	secondary_selector.set_select_mode(active_ability.target_type)
	secondary_selector.listen_to_input = true
	
	secondary_selector.init()
	
	emit_signal('selecting')

func on_Secondary_Selector_confirm_select():
	move_to_doing()

func _on_Secondary_Selector_select(selected):
	if(state == LIFECYCLE.selecting):
		target = selected
		emit_signal('selected')
	pass

func move_to_doing():
	emit_signal('doing')
	secondary_selector.on_destroy()
	
	state = LIFECYCLE.doing
	
	active_ability.use_ability(player, target)
	
func cancel():
	emit_signal('cancel')
	
func on_finished_doing():
	state = LIFECYCLE.complete
	primary_selector.listen_to_input = true
	queue_free()

func _on_Secondary_Selector_deselect():
	if target == null:
		emit_signal('selecting')
	
func _on_Secondary_Selector_quit_selection():
	primary_selector.listen_to_input = true
	cancel()
	queue_free()
