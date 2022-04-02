extends TextureButton
class_name AbilityButton

var player
var ability_index

onready var turn_manager = get_node("/root/World/TurnManager")

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_normal = player.abilities[ability_index].icon
	connect("pressed", self, "_on_Ability_Button_pressed")
	print(player.abilities[ability_index].can_use_ability(player)	)
	disabled = !player.abilities[ability_index].can_use_ability(player)

func _on_Ability_Button_pressed():
	turn_manager.submit_ability(player, ability_index)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
