extends EnemyUnit
class_name Civilian

var follow_target

func _ready():
	var anim_names = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = anim_names[randi() % anim_names.size()]

func on_evacuation():
	print('civilian %s is celebrating' % self)
	pass

func new_turn_yield(end_turn):
	yield(new_turn(), "completed")
	end_turn.call_func()

func play_sound(sound):
	$CivilianSound.stream = sound
	$CivilianSound.play()

func follow(player):
	follow_target = player
func unfollow():
	follow_target = null
