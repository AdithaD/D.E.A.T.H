extends Control

export (PackedScene) var game

func _on_Play_pressed():
	get_tree().change_scene_to(game)


func _on_Profiles_pressed():
	$Main.visible = false
	$Profiles.visible = true


func _on_Exit_pressed():
	get_tree().quit()


func _on_Instructions_pressed():
	$Main.visible = false
	$Profiles.visible = true


func _on_Profiles_Back_pressed():
	$Main.visible = true
	$Profiles.visible = false


func _on_instructions_Back_pressed():
	$Main.visible = true
	$Instructions.visible = false # Replace with function body.
