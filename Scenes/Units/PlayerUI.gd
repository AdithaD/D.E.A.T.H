extends Control

var player

func _ready():
	player = get_parent()
	
func update_text():
	$DisplayText.text = "HP: " + String(player.health)+ ", AP: " + String(player.action_points)

func _on_PlayerUnit_update_attr():
	update_text()
	pass # Replace with function body.
