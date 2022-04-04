extends Ability

export (int) var area_of_effect = 1
export (int) var select_range = 10
export (int) var damage = 2

var aoe = preload("res://Scripts/AoE.gd")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _use_ability(_source, target):
	var god = get_node("/root/World")
	
	var obstacle_tilemap = god.get_obstacle_tilemap()
	#var floor_tilemap = god.get_floor_tilemap()
	
	# to improve
	var damagable = get_tree().get_nodes_in_group("damageable")
	
	var tiles_affected = aoe.generate_AoE(target, area_of_effect)
	for entity in damagable:
		if tiles_affected.find(entity.grid_position) != -1:
			entity.take_damage(damage)
	
	for tile in tiles_affected:
		if obstacle_tilemap.get_cellv(tile) != -1:
			obstacle_tilemap.set_cellv(tile, obstacle_tilemap.tile_set.find_tile_by_name("rubble"))
			
	SoundEngine.play_explosion_sfx()
	
	finish_doing()
