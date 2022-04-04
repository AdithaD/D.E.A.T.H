extends TileMap


func set_overlay(grids, id=0):
	for grid in grids:
		set_cellv(grid, id)
	
func clear_overlay():
	clear()

func clear_overlay_of(id):
	for grid in get_used_cells_by_id(id):
		set_cellv(grid, -1)
		
