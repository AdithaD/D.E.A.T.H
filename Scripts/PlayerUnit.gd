extends Node2D


export (int) var max_health
export (int) var actionPointsPerTurn

var health = max_health

var abilities = []

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	print('super')
	
	abilities = $Abilities.get_children()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func shoot():
	print('ding')
	pass
