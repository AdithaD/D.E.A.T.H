extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var turn_manager = get_node("/root/World/TurnManager")
# Called when the node enters the scene tree for the first time.
func _ready():
		turn_manager.connect("update_turn", self, "_on_TurnManager_update_turn")
		
var selected_player
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func create_ability_button(player, ability_index):
	var ability_button = AbilityButton.new()
	ability_button.player = player
	ability_button.ability_index = ability_index
	add_child(ability_button)
	player.abilities[ability_index].connect("ability_used", self, "regenerate_buttons")

func regenerate_buttons():
	for child in get_children():
		child.queue_free()
		
	if(selected_player):
		for i in range(0, selected_player.abilities.size()):
			create_ability_button(selected_player, i)
		
func _on_Selector_on_select_player(new_selected_player):
	selected_player = new_selected_player
	regenerate_buttons()
	pass # Replace with function body.


func _on_Selector_on_deselect():
	print('deselected')

	selected_player = null
	pass # Replace with function body.


func _on_TurnManager_update_turn(state):
	if(state == TurnManager.TURN_STATE.player):
		regenerate_buttons()
	pass # Replace with function body.
