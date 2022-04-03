extends Node
class_name TurnManager

onready var god =  get_parent()

var turn = 0

enum TURN_STATE { new, player, enemy }
var state = TURN_STATE.new

signal update_turn(state)

var player_unit_counter
var should_force_end_turn = false

func _ready():
	god = get_parent()

func new_turn():
	state = TURN_STATE.new
	turn+=1
	should_force_end_turn = false
	emit_signal("update_turn", state)	
	
	conduct_turn()


func conduct_turn():
	yield(conduct_player_turn(), "completed")
	conduct_enemy_turn()
	new_turn()

	
func count_players():
	var done_count = 0	
	while done_count < god.get_player_nodes().size() && !should_force_end_turn:
		yield()
		print('counter ++')
		done_count+=1
	

	print('freedom')
	pass
	
func conduct_player_turn():
	state = TURN_STATE.player
	print('player turn')
	for player in god.get_player_nodes():
		if player.has_method("new_turn"):
			player.new_turn(funcref(self, "increment_counter"))
	
	emit_signal("update_turn", state)	
	
	player_unit_counter = count_players()
	yield(player_unit_counter, "completed")
	pass
	
func increment_counter():
	player_unit_counter = player_unit_counter.resume()
	
	
func conduct_enemy_turn():
	state = TURN_STATE.enemy
	print('enemy turn')

	emit_signal("update_turn", state)	
	
	for enemy in god.get_enemy_nodes():
		if enemy.has_method("new_turn"):
			enemy.new_turn()

	print('finsihed turn')		
func _on_NextTurn_pressed():
	should_force_end_turn = true
	player_unit_counter.resume()
	pass # Replace with function body.
