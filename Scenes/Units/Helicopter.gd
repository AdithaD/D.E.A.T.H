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
	if(disabled_countdown == 0):
		on_reenable()

func on_disable():
	visible = false
	remove_from_group("player_unit")
	pass
func on_reenable():
	add_to_group("player_unit")
	visible = true
	pass

func on_end_turn():
	if loaded_civilians.size() > 0:
		for civilian in loaded_civilians:
			god.evacuate_civilian(civilian)

		
		disable_for_amount_of_turns(evac_duration)
