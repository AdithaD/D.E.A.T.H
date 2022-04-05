extends Node2D

export (int) var area_of_effect
export (bool) var is_active

var grid_position

var tiles_in_aoe
var aoe = preload("res://Scripts/AoE.gd")

func init():
	tiles_in_aoe = aoe.generate_AoE(grid_position, area_of_effect)
	print(tiles_in_aoe)

func is_in_evacuation_area(grid_pos):
	var result = tiles_in_aoe.find(grid_pos) != -1
	return result

func get_all_civilians_in_area():
	var civilians  = get_tree().get_nodes_in_group("civilian")

	var filtered = aoe.filter_entities_in_AoE(civilians, grid_position, area_of_effect)
	print(filtered)
	return filtered
