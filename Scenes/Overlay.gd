extends TileMap


func set_overlay(grids, id=0):
	for grid in grids:
		set_cellv(grid, id)

func clear_overlay():
	for cell in get_used_cells():
		set_cellv(cell, -1)
	
