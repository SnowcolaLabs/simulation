class_name Unit
extends Area2D

@onready var main: Node2D = get_tree().get_current_scene()
@onready var grid: Grid = main.get_node("Grid")
@onready var pathfinder: Pathfinder = grid.pathfinder

var data: UnitData = UnitData.new()

var path: PackedVector2Array
var pos: Vector2:
	get:
		return pos
	set(v):
		pos = v
		
func _ready() -> void:
	pos = grid.worldToGrid(position)

func _process(delta: float) -> void:
	move(delta)

func move(delta: float) -> void:
	if path.size() > 0:
		
		if position.distance_to(path[0]) < 5:
			position = path[0]
			pos = grid.worldToGrid(path[0])
			path.remove_at(0)
		else: 
			position += (path[0] - position).normalized() * data.speed * delta
			
		
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var clicked: Vector2 = grid.worldToGrid(get_global_mouse_position())
			path = pathfinder.get_grid_path(pos, clicked)
			print(clicked, grid.worldToGrid(position))
