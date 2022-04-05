extends PlayerUnit

var disabled_countdown = 0
export (int) var evac_duration
var loaded_civilians = []

func disable_for_amount_of_turns(turn_amount):
	disabled_countdown = turn_amount
	on_disable()
	pass
	
func can_be_controlled():
	return disabled_countdown == 0 and .can_be_controlled()

func update_turn_effects():
	.update_turn_effects()
	if(disabled_countdown > 0):
		disabled_countdown -= 1
	if(disabled_countdown == 0 and is_in_group("inactive_unit")):
		on_reenable()

func on_disable():
	print('disabling heli')
	visible = false
	remove_from_group("player_unit")
	add_to_group("inactive_unit")
	pass
func on_reenable():
	print('enabling heli')
	add_to_group("player_unit")
	remove_from_group("inactive_unit")
	visible = true
	pass

func on_end_turn():
	if loaded_civilians.size() > 0:
		for civilian in loaded_civilians:
			god.evacuate_civilian(civilian)
		
		loaded_civilians.clear()
		get_node("/root/World/UserCamera").focus_on(global_position)
		$PlayerUI.display_voice_line("Let's get out of here!")
		yield(get_tree().create_timer(1), "timeout")
		disable_for_amount_of_turns(evac_duration)
