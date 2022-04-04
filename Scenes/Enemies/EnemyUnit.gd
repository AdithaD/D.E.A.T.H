extends Node2D
class_name EnemyUnit

export (int) var max_health
export (int) var actions_points_per_turn
export (int) var tiles_per_turn

export (bool) var can_cover = true

var health
var action_points = actions_points_per_turn
var dist_moved = 0

var abilities = [] 

var grid_position
var god
var is_marked = false
var mark_length = 0

var ai

var is_dead = false

var end_turn
signal update_attr
signal used_ability
signal turn_complete

# Called when the node enters the scene tree for the first time.
func _ready():
	ai = $AI
	health = max_health
	
	abilities = $Abilities.get_children()
	
	for ability in abilities:
		ability.ai = ai
			
	emit_signal('update_attr')
	god = get_node("/root/World")
	

func new_turn():
	if(!is_dead):
		ai.bfs.init(god)
		
		for ability in abilities:
			ability.new_turn()
			
		action_points = actions_points_per_turn
		dist_moved = 0
		
		if(ai.has_method("generate_turn")):
			var turn = ai.generate_turn(abilities)
			
			for ability in turn:
				emit_signal("used_ability", ability)
				ability.use_ai_ability(self)
				yield(ability, "finished_doing")
		
		emit_signal('update_attr')
		emit_signal('turn_complete')
		
func take_damage(dmg):
	health -= dmg
	if health > 0 :
		SoundEngine.play_enemyHurt_sfx()
	elif health <= 0 :
		SoundEngine.play_enemyDeath_sfx()
		die()
	emit_signal("update_attr")
	
func die():
	is_dead = true
	$DeathSprite.visible = true
	$AnimatedSprite.visible = false

func get_moveable_distance():
	return tiles_per_turn - dist_moved

func spend_action_points(action_cost: int):
	action_points -= action_cost
	emit_signal('update_attr')
#	if (action_points <= 0):
#		end_turn.call_func()

	pass

func on_used_ability(_index):
	emit_signal("used_ability")

func set_grid_position(new_grid):
	grid_position = new_grid
	position = god.grid_to_world(grid_position)
	
func apply_mark(turns):
	if turns > mark_length:
		mark_length = turns
	is_marked = true 
	
func play_sound(sound):
	$EnemySound.stream = sound
	$EnemySound.play()
