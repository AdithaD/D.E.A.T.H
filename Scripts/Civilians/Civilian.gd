extends EnemyUnit
class_name Civilian

func on_evacuation():
	print('civilian %s is celebrating' % self)
	pass

func play_sound(sound):
	$CivilianSound.stream = sound
	$CivilianSound.play()
