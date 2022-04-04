extends Control

var turn_manager

onready var god = get_node("/root/World")

func _ready():
	turn_manager = get_node('/root/World/TurnManager')
	turn_manager.connect("update_turn", self, "_on_TurnManager_update_turn")
	
func _on_TurnManager_update_turn(state):
	$CiviliansSavedLabel.text = "Civilians Evacuated %s" % god.civlians_evacuated
	if(turn_manager.state == TurnManager.TURN_STATE.enemy):
		$NextTurn.disabled = true
		$NextTurn.text = " ENEMY TURN "
	elif turn_manager.state == TurnManager.TURN_STATE.civilian:
		$NextTurn.disabled = true
		$NextTurn.text = " CIVILIAN TURN "
	else:
		$NextTurn.disabled = false
		$NextTurn.text = " END TURN "
		
	$TurnNumberLabel.text = "Turn %s" % turn_manager.turn
	pass
