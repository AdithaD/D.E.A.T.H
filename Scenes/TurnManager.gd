extends Node
class_name TurnManager

onready var god =  get_parent()

var turn = 0

enum TURN_STATE { new, player, enemy, civilian }
var state = TURN_STATE.new

signal update_turn(state)

var player_unit_counter
var civilian_unit_counter
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

	get_node("../Spawner/EnemySpawner").spawn(turn)
		
	yield(conduct_player_turn(), "completed")

	yield(conduct_civilian_turn(),"completed")
	
	var enemy_turn = conduct_enemy_turn()
	if enemy_turn is GDScriptFunctionState:
		yield(enemy_turn, "completed")

	new_turn()

	
func count_players():
	var done_count = 0	
	while done_count < god.get_player_nodes().size() && !should_force_end_turn:
		yield()
		done_count+=1
		print(done_count)

	pass
	
func count_civilians():
	var done_count = 0	
	print(god.get_civilian_nodes().size())
	while done_count < god.get_civilian_nodes().size():
		yield()
		done_count+=1
		print(done_count)

	
	pass
	
	
func conduct_player_turn():
	state = TURN_STATE.player
	print('Player Turn Start')
	
	var players = god.get_player_nodes()
	god.check_game_over()
	
	if players.size() > 0:
		get_node("/root/World/UserCamera").move_to(players[0].position)
		get_node("/root/World/UserCamera").unfocus()
		

		for player in players:
			
			if player.has_method("new_turn"):
				player.new_turn(funcref(self, "increment_counter"))
		
		emit_signal("update_turn", state)	
		
		player_unit_counter = count_players()
		yield(player_unit_counter, "completed")
		
		for player in players:
			player.on_end_turn()
		pass
	else:
		god.game_over()
		
func increment_counter():
	player_unit_counter = player_unit_counter.resume()
	
func increment_civilian_counter():
	civilian_unit_counter = civilian_unit_counter.resume()
func conduct_enemy_turn():
	state = TURN_STATE.enemy
	print('Enemy Turn Start')

	emit_signal("update_turn", state)	
	
	for enemy in god.get_enemy_nodes():
		if enemy.has_method("new_turn"):
			get_node("/root/World/UserCamera").focus_on(enemy.position)
			yield(get_tree().create_timer(0.4), "timeout")
			enemy.new_turn()
			yield(get_tree().create_timer(1.2), "timeout")	

func conduct_civilian_turn():
	state = TURN_STATE.civilian
	print('Civilian Turn Start')
	
	get_node("../UserCamera").centre_zoom_out()

	emit_signal("update_turn", state)	
	civilian_unit_counter = count_civilians()
	for civilian in god.get_civilian_nodes():
		if civilian.has_method("new_turn"):
			#get_node("/root/World/UserCamera").focus_on(civilian.position)
			civilian.new_turn_yield(funcref(self, "increment_civilian_counter"))
	yield(civilian_unit_counter, "completed")
	
func _on_NextTurn_pressed():
	should_force_end_turn = true
	player_unit_counter.resume()
	pass # Replace with function body.
