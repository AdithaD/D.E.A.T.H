extends Control



func _on_NewMissionButton_pressed():
	get_tree().reload_current_scene()


func _on_ExitGameButton_pressed():
	get_tree().quit()
