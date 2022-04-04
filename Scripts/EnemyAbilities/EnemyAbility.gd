extends Ability
class_name EnemyAbility

var ai

func _use_ai_ability(source):
	finish_doing()
	pass

func use_ai_ability(source):
	_use_ai_ability(source)
	
func _use_ability(source, target):
	_use_ai_ability(source)

func _generate_target(source):
	pass
