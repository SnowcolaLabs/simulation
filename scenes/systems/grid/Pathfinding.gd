class_name Pathfinder
extends Node

var a_star: AStar2D = AStar2D.new()
@onready var main: Node2D = get_tree().get_current_scene()
@export var grid: Grid

const DIRECTIONS = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

func add_points() -> void:
	var current_id := 0
	for point: Vector2 in grid.grid:
		a_star.add_point(current_id, grid.gridToWorld(point))
		current_id += 1

func get_point_id(grid_point: Vector2) -> int:
	return a_star.get_closest_point(grid.gridToWorld(grid_point))
	
func get_world_id(world_point: Vector2) -> int:
	return a_star.get_closest_point(world_point)
	
func get_id_world_pos(id: int) -> Vector2:
	return a_star.get_point_position(id)
	
func get_id_grid_pos(id: int) -> Vector2:
	return grid.worldToGrid(get_id_world_pos(id))

func connect_point(point: Vector2) -> void:
	var point_id := get_point_id(point)
	for direction: Vector2 in DIRECTIONS:
		var neighbour := point + direction
		var neighbour_id := get_point_id(neighbour)
		if grid.grid.has(neighbour) and grid.grid[neighbour].navigable: 
			a_star.connect_points(point_id, neighbour_id)

func disconnect_point(point: Vector2) -> void:
	var point_id := get_point_id(point)
	for direction : Vector2 in DIRECTIONS:
		var neighbour: Vector2 = point + direction
		var neighbour_id := get_point_id(neighbour)
		a_star.disconnect_points(point_id, neighbour_id)
		
func connect_all_points() -> void:
	for point : Vector2 in grid.grid:
		connect_point(point)
		
func initialize() -> void:
	add_points()
	connect_all_points()
	
func get_grid_path(start: Vector2, end: Vector2) -> PackedVector2Array:
	var start_id := get_point_id(start)
	var end_id := get_point_id(end)
	var path := a_star.get_point_path(start_id, end_id)
	if grid.debug:
		$"../Debug".get_children().filter(func(c: Node) -> bool: return c is Line2D).map(func(c: Line2D) -> void: c.queue_free())
		var path_debug := Line2D.new()
		path_debug.points = path
		$"../Debug".add_child(path_debug)
	return path
