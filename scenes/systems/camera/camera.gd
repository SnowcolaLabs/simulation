extends Camera2D

var zoom_speed: float = 0.05
var zoom_min: float = 0.001
var zoom_max: float = 2.0
var drag_sensitivity: float = 1.0

@onready var start_pos: Vector2 = get_viewport_rect().size / 2

func _ready() -> void:
	position = start_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		position -= event.relative * drag_sensitivity / zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoom_speed, zoom_speed)
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoom_speed, zoom_speed)
		zoom = clamp(zoom, Vector2(zoom_min, zoom_min), Vector2(zoom_max, zoom_max))
