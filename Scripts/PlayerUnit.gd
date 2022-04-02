extends Node2D


export (int) var max_health

var health = max_health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	print('super')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func shoot():
	print('ding')
	pass
