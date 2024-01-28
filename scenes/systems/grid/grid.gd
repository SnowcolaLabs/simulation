class_name Grid
extends Node2D

@export var width: int = 12
@export var height: int = 12
@export var cell_size: int = 128
@export var debug: bool = false
@export var pathfinder: Pathfinder

var grid: Dictionary = {}


func generate_grid() -> void:
	for x in width:
		for y in height:
			grid[Vector2(x,y)] = null
			if debug:
				var rect := ReferenceRect.new()
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
