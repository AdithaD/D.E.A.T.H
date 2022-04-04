extends Ability

export (int) var max_evac_per_turn

onready var god = get_node("/root/World")

func _use_ability(player, _target):
	var evacuation_area = get_evacuation_area(player.grid_position)

	var civilians_in_area = evacuation_area.get_all_civilians_in_area()

	var amount_evacable 
	if(civilians_in_area.size() < max_evac_per_turn):
		amount_evacable = civilians_in_area.size()
	else:
		amount_evacable = max_evac_per_turn

	var evac_list = civilians_in_area.slice(0, amount_evacable)

	for civilian in evac_list:
		civilian.on_evacuation()
		god.evacuate_civilian(civilian)
	pass

	player.disable_for_amount_of_turns(cooldown_duration)

func _ability_conditions(player):
	var ea = get_evacuation_area(player.grid_position)
	
	if(ea):
		var amnt_of_civilians = get_evacuation_area(player.grid_position).get_all_civilians_in_area().size()
		return amnt_of_civilians > 0
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
