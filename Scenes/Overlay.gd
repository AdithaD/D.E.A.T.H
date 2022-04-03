extends TileMap


func set_overlay(grids):
	for grid in grids:
		set_cellv(grid, 0)

func clear_overlay():
	for cell in get_used_cells():
		set_cellv(cell, -1)
	
