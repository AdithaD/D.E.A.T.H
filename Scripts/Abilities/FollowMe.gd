extends Ability

func _use_ability(source, target):
	target.follow(source)

func get_details(lifecycle):
	var super = .get_details(lifecycle) + "\n"
	
	super += "Range: %s \n" % select_range
	
	return super
