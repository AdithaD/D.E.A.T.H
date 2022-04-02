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
func create_icon(ability):
	var texture_button = TextureButton.new()
	texture_button.texture_normal = ability.icon
	add_child(texture_button)

func _on_Selector_on_select_player(selected_player):

	for ability in selected_player.abilities:
		create_icon(ability)
	pass # Replace with function body.


func _on_Selector_on_deselect():
	print('deselecte')
	for child in get_children():
		child.queue_free()
	pass # Replace with function body.
