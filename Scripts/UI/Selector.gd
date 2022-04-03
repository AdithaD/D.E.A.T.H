extends Node2D
class_name Selector
export (NodePath) var obstacle_map_path
export (NodePath) var floor_map_path
export (Texture) var selector_image
onready var obstacle_tile_map : TileMap
onready var floor_tile_map : TileMap

export(Ability.TARGET_TYPE) var target_type = Ability.TARGET_TYPE.player

var selection
var listen_to_input = true

var god
var lifecycle

onready var camera = get_node("/root/World/UserCamera")

signal on_select_player(selected_player)
signal on_select_enemy(selected_enemy)
signal on_select_tile(selected_tile)
signal on_select_cover(selected_cover)
signal on_deselect()
signal on_quit_selection()

func _ready():
	$Sprite.texture = selector_image
	god = get_node("/root/World")
	print(god)
	if obstacle_map_path != "":
		obstacle_tile_map = get_node(obstacle_map_path)

	if floor_map_path != "":
		floor_tile_map = get_node(floor_map_path)
		
	pass # Replace with function body.


func deselect():
	selection = null
	camera.unfocus()
	emit_signal("on_deselect")

func _process(_delta):
	
	if selection != null:
		if(Input.is_action_just_pressed("deselect") && listen_to_input):
			if(selection != null):
				deselect()
				

	else:
		if Input.is_action_just_pressed("deselect"):
			quit_selection()
		
		var mouse_pos = get_global_mouse_position()
		var tile = floor_tile_map.world_to_map(mouse_pos)
		var snapped_pos = floor_tile_map.map_to_world(tile)
		
		var new_pos = Vector2(snapped_pos.x, snapped_pos.y + 8)
		$Sprite.global_position = new_pos
	
	if(Input.is_action_just_pressed("select") && listen_to_input && selection == null):
		match (target_type):
			Ability.TARGET_TYPE.player:	
				select_player()
			Ability.TARGET_TYPE.enemy:
				select_enemy()
			Ability.TARGET_TYPE.cover:
				select_cover()
			Ability.TARGET_TYPE.tile:
				select_tile()	
		
		if(selection):
			print("selected %s" % selection)
	

func select_player():
	var mouse_pos = get_global_mouse_position()
	var tile = floor_tile_map.world_to_map(mouse_pos)
	var snapped_pos = floor_tile_map.map_to_world(tile)
	
	var player_units = get_tree().get_nodes_in_group("player_unit")
	
	print(snapped_pos)
	for unit in player_units:
		if unit.global_position == snapped_pos:
			selection = unit
			emit_signal("on_select_player", selection)
			camera.focusOn(unit.global_position)
			break			

	pass
func select_enemy():
	var mouse_pos = get_global_mouse_position()
	var tile = floor_tile_map.world_to_map(mouse_pos)
	var snapped_pos = floor_tile_map.map_to_world(tile)
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	

	for enemy in enemies:
		if enemy.global_position == snapped_pos:
			selection = enemy
			camera.focusOn(enemy.global_position)
			emit_signal("on_select_enemy", selection)
			break			
			
	
	pass
	
func select_cover():
	var mouse_pos = get_global_mouse_position()
	var map_coords = obstacle_tile_map.world_to_map(mouse_pos)
	selection = map_coords

	pass
	
func select_tile():
	var mouse_pos = get_global_mouse_position()
	selection = floor_tile_map.world_to_map(mouse_pos)
	
	emit_signal("on_select_tile", selection)
	pass

func set_select_mode(new_type):
	target_type = new_type
	deselect()

func quit_selection():
	print('quit seleciton')
	emit_signal("on_quit_selection")
