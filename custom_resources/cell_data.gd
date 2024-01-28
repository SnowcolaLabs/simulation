class_name CellData
extends Object

signal cell_changed(pos: Vector2, old: Vector2)
signal nav_changed(pos: Vector2)

var pos: Vector2

var floor_data: FloorData:
	set(v):
		var old: FloorData = floor_data
		floor_data = v
		cell_changed.emit(pos, old)
	get:
		return floor_data
		
var occupant: Node2D = null:
	set(v):
		occupant = v
		cell_changed.emit(pos, pos)
	get:
		return occupant
		
var navigable: bool = true:
	set(v):
		navigable = v
		nav_changed.emit(pos)
	get:
		return navigable
		
func _init(grid_pos: Vector2) -> void:
	pos = grid_pos
		
