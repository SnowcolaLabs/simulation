extends Node2D

@onready var grid: Grid = $Grid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid.generate_grid()
	grid.pathfinder.initialize()

