extends "res://Explosives.gd"


func _use_ability(source, target):
	source.take_damage(9999)	
	.use_ability(source,target)
