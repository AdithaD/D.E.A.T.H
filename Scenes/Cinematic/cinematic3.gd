extends Timer

var timer_time_left = get_time_left()
	
func timer_change_scene() -> void:
		get_tree().change_scene("res://Scenes/World.tscn")

func _process(_delta):
	timer_time_left = get_time_left()
	if timer_time_left < 1:
			timer_change_scene()
			
	
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER:
			timer_change_scene()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
