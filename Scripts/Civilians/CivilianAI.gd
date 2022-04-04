extends BFSAI

onready var civilian = get_parent()

export (int) var go_to_evac_dist = 10

func generate_turn(abilities):
	var move_ability = abilities[0]
	
	var other_ability = abilities[1]
	if(abilities.size() > 2):
		var other_abilities = abilities.slice(1,len(abilities) - 1)
		other_ability  = other_abilities[randi() % len(other_abilities)]
		
	return [move_ability, other_ability]

func get_target_locations():
	if(civilian.follow_target != null):
		return [civilian.follow_target.grid_position]
	else:
		var locations = []
		for ea in god.get_evacuation_areas():
			if grid_distance(ea.grid_position, civilian.grid_position) < go_to_evac_dist:
				locations.append(ea.grid_position)
		
		if locations.size() > 0:
			return locations
		else :
			var reachable = bfs.get_reachable(civilian.grid_position, civilian.tiles_per_turn)
			var target = reachable[randi() % reachable.size()]
			
			return [target]
		

