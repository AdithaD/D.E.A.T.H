extends TextureButton


var ability_button

# Called when the node enters the scene tree for the first time.
func _ready():
	if ability_button == null:
		print('this ability button doesn\'t have an ability')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
