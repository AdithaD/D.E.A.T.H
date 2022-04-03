extends Control

var turn_manager

func _ready():
	turn_manager = get_node('/root/World/TurnManager')
	turn_manager.connect("update_turn", self, "_on_TurnManager_update_turn")
	
func _on_TurnManager_update_turn(state):
	if(turn_manager.state == TurnManager.TURN_STATE.enemy):
		$NextTurn.disabled = true
		$NextTurn.text = " ENEMY TURN "
	else:
		$NextTurn.disabled = false
		$NextTurn.text = " END TURN "
		
	$TurnNumberLabel.text = "Turn %s" % turn_manager.turn
	pass
