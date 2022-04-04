extends EnemyUnit
class_name Civilian

var follow_target

func on_evacuation():
	print('civilian %s is celebrating' % self)
	pass

func play_sound(sound):
	$CivilianSound.stream = sound
	$CivilianSound.play()

func follow(player):
	follow_target = player
