extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func create_ability_button(player, ability_index):
	var ability_button = AbilityButton.new()
	ability_button.player = player
	ability_button.ability_index = ability_index
	add_child(ability_button)

func _on_Selector_on_select_player(selected_player):
	
	for i in range(0, selected_player.abilities.size()):
		create_ability_button(selected_player, i)

	pass # Replace with function body.


func _on_Selector_on_deselect():
	print('deselected')
	for child in get_children():
		child.queue_free()
	pass # Replace with function body.
