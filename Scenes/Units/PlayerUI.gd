extends Control

var player

func _ready():
	player = get_parent()
	
func update_health():
	print(player.health)
	$HealthText.text = String(player.health)

func _on_PlayerUnit_update_attr():
	update_health()
	pass # Replace with function body.
