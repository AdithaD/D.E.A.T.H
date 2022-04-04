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
signal on_select_civilian(selected_civilian)
signal on_select_tile(selected_tile)
signal on_select_cover(selected_cover)

signal on_deselect()
signal on_quit_selection()
signal on_confirm_select()

func _ready():
	$Sprite.texture = selector_image
	god = get_node("/root/World")
	if obstacle_map_path != "":
		obstacle_tile_map = get_node(obstacle_map_path)

	if floor_map_path != "":
		floor_tile_map = get_node(floor_map_path)
		
	pass # Replace with function body.


func init():
	pass

func deselect():
	selection = null
	camera.unfocus()
	emit_signal("on_deselect")
	

func _process(_delta):
	
	if selection != null:
		if (target_type == Ability.TARGET_TYPE.player):
			if(selection.global_position != global_position):
				var tile = floor_tile_map.world_to_map(selection.global_position)
				var snapped_pos = floor_tile_map.map_to_world(tile)
				
				var new_pos = Vector2(snapped_pos.x, snapped_pos.y + 8)
				$Sprite.global_position = new_pos
				
		if(Input.is_action_just_pressed("deselect") && listen_to_input):
			deselect()
		if(Input.is_action_just_pressed("confirm_select") && listen_to_input):
			emit_signal("on_confirm_select")

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
			Ability.TARGET_TYPE.civilian:
				select_civilian()
		if(selection):
			print("selected %s" % selection)
			SoundEngine.play_button_sound()
	

func select_player():
	var mouse_pos = get_global_mouse_position()
	var tile = floor_tile_map.world_to_map(mouse_pos)
	var snapped_pos = floor_tile_map.map_to_world(tile)
	
	var player_units = get_tree().get_nodes_in_group("player_unit")
	
	for unit in player_units:
		if unit.global_position == snapped_pos:
			if( can_select_player(unit) ):
				selection = unit
				emit_signal("on_select_player", selection)
				camera.focus_on(unit.global_position)
				break			
	pass

func select_enemy():
	var mouse_pos = get_global_mouse_position()
	var tile = floor_tile_map.world_to_map(mouse_pos)
	var snapped_pos = floor_tile_map.map_to_world(tile)
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	

	for enemy in enemies:
		if enemy.global_position == snapped_pos:
			if( can_select_enemy(enemy) ):
				selection = enemy
				camera.focus_on(enemy.global_position)
				emit_signal("on_select_enemy", selection)
				break			
			
	
	pass
	
func select_civilian():
	var mouse_pos = get_global_mouse_position()
	var tile = floor_tile_map.world_to_map(mouse_pos)
	var snapped_pos = floor_tile_map.map_to_world(tile)
	
	var civilians = get_tree().get_nodes_in_group("civilian")
	

	for civ in civilians:
		if civ.global_position == snapped_pos:
			if (can_select_civilian(civ)):
				selection = civ
				camera.focus_on(civ.global_position)
				emit_signal("on_select_civilian", selection)
				break			
			
	
	pass

func select_cover():
	var mouse_pos = get_global_mouse_position()
	var map_coords = obstacle_tile_map.world_to_map(mouse_pos)
	
	if(obstacle_tile_map.get_cellv(map_coords) != -1):
		if(can_select_cover(map_coords)):
			selection = map_coords

			camera.focus_on(obstacle_tile_map.map_to_world(map_coords))
			emit_signal("on_select_cover", selection)
	pass
	
func select_tile():
	var mouse_pos = get_global_mouse_position()
	var tile = floor_tile_map.world_to_map(mouse_pos)
	if(can_select_tile(tile)):
		selection = tile
		
		emit_signal("on_select_tile", selection)
		pass
	
func can_select_player(_selection):	
	return true

func can_select_civilian(_selection):	
	return true
	
func can_select_tile(_selection):	
	return true
	
func can_select_cover(_selection):	
	return true
	
func can_select_enemy(_selection):	
	return true

func set_select_mode(new_type):
	target_type = new_type
	deselect()
	
func on_destroy():
	pass

func quit_selection():
	on_destroy()
	emit_signal("on_quit_selection")
