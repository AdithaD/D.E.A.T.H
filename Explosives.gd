extends Ability

export (int) var area_of_effect = 1
export (int) var damage = 2

var aoe = preload("res://Scripts/AoE.gd")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _use_ability(source, target):
	var god = get_node("/root/World")
	
	var obstacle_tilemap = god.get_obstacle_tilemap()
	#var floor_tilemap = god.get_floor_tilemap()
	
	var target_position
	if target is Object:
		target_position = target.grid_position
	else:
		target_position = target
	# to improve
	var damagable = get_tree().get_nodes_in_group("damageable")
	var tiles_affected 
	if target is Object:
		tiles_affected = aoe.generate_AoE(target_position, area_of_effect)
	else:
		tiles_affected = aoe.generate_AoE(target_position, area_of_effect)
	for entity in damagable:
		if tiles_affected.find(entity.grid_position) != -1:
			entity.take_damage(damage)
	
	for tile in tiles_affected:
		if obstacle_tilemap.get_cellv(tile) != -1:
			obstacle_tilemap.set_cellv(tile, obstacle_tilemap.tile_set.find_tile_by_name("rubble"))
	
	$ExplosionAnimation.set_frame(1)
	$ExplosionAnimation.position = god.grid_to_world(target_position)
	SoundEngine.play_explosion_sfx()
	$ExplosionAnimation.visible = true
	$ExplosionAnimation.play()
	yield($ExplosionAnimation, "animation_finished")
	$ExplosionAnimation.visible = false
	
	finish_doing()

func get_details(lifecycle):
	var super_details = .get_details(lifecycle) + "\n"
	
	super_details += "Damage: %s \n" % damage
	super_details += "Explosion Radius: %s \n" % area_of_effect
	super_details += "Range: %s \n" % select_range
	return super_details
