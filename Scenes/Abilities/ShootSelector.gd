extends "res://Scenes/Abilities/RangeSelector.gd"

func select_enemy():
	.select_enemy()
	if selection != null:
		var god = get_node("/root/World")
		var hit_chance = god.get_hit_chance(lifecycle.player.grid_position,selection.grid_position,lifecycle.active_ability.penetration)
		selection.get_node("EnemyUI").display_hit_chance(hit_chance)
		$Line2D.add_point(god.grid_to_world(lifecycle.player.grid_position))
		$Line2D.add_point(god.grid_to_world(selection.grid_position))

func deselect():
	if selection != null:
		selection.get_node("EnemyUI").clear_hit_chance()
	$Line2D.clear_points()
	.deselect()

