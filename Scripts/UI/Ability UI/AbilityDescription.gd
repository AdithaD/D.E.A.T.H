extends Panel

var ability_lifecycle

func _ready():
	visible = false
	$Button.disabled = true

func set_ability(a):
	ability_lifecycle = a
	$NameText.text = ability_lifecycle.active_ability.ability_name
	$DescriptionText.text = ability_lifecycle.active_ability.ability_description
	
	ability_lifecycle.connect("selecting", self, "show")
	ability_lifecycle.connect("selected", self, "enable_confirm")
	ability_lifecycle.connect("doing", self, "hide")
	ability_lifecycle.connect("cancel", self, "hide")
	
	$Button.connect("pressed", ability_lifecycle, "move_to_doing")
		
	disable_confirm()

func show():
	visible = true
	disable_confirm()

func hide():
	visible = false
	
func enable_confirm():
	$Button.disabled = false
	
func disable_confirm():
	$Button.disabled = true
