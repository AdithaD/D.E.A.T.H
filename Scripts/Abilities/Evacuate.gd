extends Ability

export (int) var max_evac_per_turn

onready var god = get_node("/root/World")

func _use_ability(player, target):
	player.loaded_civilians.append(target)
	target.remove_from_group("civilian")
	target.visible = false
	
	finish_doing()

func _ability_conditions(player):
	var ea = get_evacuation_area(player.grid_position)
	
	if(ea):
		var amnt_of_civilians = get_evacuation_area(player.grid_position).get_all_civilians_in_area().size()
		return amnt_of_civilians > 0 and player.loaded_civilians.size() <= max_evac_per_turn
	else:
		return false


func get_evacuation_area(pos):
	var evacuation_areas = god.get_active_evacuation_areas()

	for ea in evacuation_areas:
		if(ea.is_in_evacuation_area(pos)):
			return ea

func get_details(lifecycle):
	var super_details = .get_details(lifecycle) + "\n\n"
	
	
	super_details += "Your helicopter will be unavailable for a whole turn after using this ability"
	return super_details
