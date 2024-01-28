class_name Grid
extends TileMap

@export var width: int = 12
@export var height: int = 12
@export var cell_size: int = 128
@export var debug: bool = false:
	set(v):
		if debug == v:
			return
		debug = v
		if get_node("Debug"):
			$Debug.visible = v
@export var pathfinder: Pathfinder

var grid: Dictionary = {}



func generate_grid() -> void:
	for x in width:
		for y in height:
			var _pos := Vector2(x,y)
			grid[_pos] = CellData.new(Vector2(x, y))
			grid[_pos].floor_data = preload("res://assets/data/grass.tres")
			refresh_tile(_pos)
			if debug:
				var rect := ReferenceRect.new()
				rect.border_color = Color.AQUA
				rect.position = gridToWorld(Vector2(x, y))
				rect.size = Vector2(cell_size, cell_size)
				rect.editor_only = false
				$Debug.add_child(rect)
				var label := Label.new()
				label.position = gridToWorld(Vector2(x, y))
				label.text = "(%s, %s)" % [x, y]
				$Debug.add_child(label)
			
func gridToWorld(pos: Vector2) -> Vector2:
	return pos * cell_size
	
func worldToGrid(pos: Vector2) -> Vector2:
	return floor(pos / cell_size)
	
func refresh_tile(pos: Vector2) -> void:
	var data: CellData = grid[pos]
	set_cell(0, pos, data.floor_data.id, data.floor_data.coords)
	set_cell(1, pos)
