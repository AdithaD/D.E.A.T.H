extends Panel

var ability

func _ready():
	visible = false

func set_ability(a: Ability):
	ability = a
	$NameText.text = ability.ability_name
	$DescriptionText.text = ability.ability_description

func show():
	visible = true

func hide():
	visible = false
