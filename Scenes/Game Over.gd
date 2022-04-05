extends Control


func _ready():
	var god = get_node('/root/World')
	$Control/CiviliansSavedLabel.text = "You managed to save %s civilians..." % god.civlians_evacuated

func _on_NewMissionButton_pressed():
	get_tree().reload_current_scene()


func _on_ExitGameButton_pressed():
	get_tree().quit()
