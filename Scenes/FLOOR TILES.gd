tool
extends Node

export(TileSet) var tile_set: TileSet setget _set_tile_set
export(Vector2) var texture_offset: Vector2 setget _set_texture_offset

func _set_tile_set(value: TileSet) -> void:
	tile_set = value
	_update_texture_offsets()

func _set_texture_offset(value: Vector2) -> void:
	texture_offset = value
	_update_texture_offsets()

func _update_texture_offsets() -> void:
	if !tile_set:
		return
	for tile_id in tile_set.get_tiles_ids():
		tile_set.tile_set_texture_offset(tile_id, texture_offset)
