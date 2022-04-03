extends PlayerUnit

var disabled_countdown = 0

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
	pass
func on_reenable():
	visible = true
	pass
