extends Node2D


var player
export (NodePath) var obstacle_map_path
export (NodePath) var floor_map_path
onready var obstacle_tile_map : TileMap = get_node(obstacle_map_path)
onready var floor_tile_map : TileMap = get_node(floor_map_path)


func _ready():
	
	pass # Replace with function body.


func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var tile = obstacle_tile_map.world_to_map(mouse_pos)
	var snapped_pos = obstacle_tile_map.map_to_world(tile)
	
	var new_pos = Vector2(snapped_pos.x, snapped_pos.y + 8)
	$Sprite.global_position = new_pos
