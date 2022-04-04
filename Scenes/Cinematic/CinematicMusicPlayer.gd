extends Node2D

var cinematic_music = load("res://Assets/Sounds/Music/DEATHcinematic.wav")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func play_music():
	$Music.stream = cinematic_music
	$Music.play() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
