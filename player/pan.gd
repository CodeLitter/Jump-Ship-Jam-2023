extends Node


@export var camera: Camera2D
@export var speed: float = 1.0
var dragging: bool
var drag_viewport_start: Vector2
var drag_viewport_point: Vector2
var drag_start: Vector2
var direction: Vector2


func _input(event):
	if event is InputEventMouseButton:
		dragging = (event.button_index == MOUSE_BUTTON_MIDDLE) and event.pressed
		if dragging:
			drag_viewport_start = event.position
			drag_start = camera.get_screen_center_position()
	if event is InputEventMouseMotion:
		drag_viewport_point = event.position
	camera.global_position = camera.get_screen_center_position()
	pass


func _process(delta):
	direction = Vector2(
		int(Input.is_action_pressed("scroll_right")) - int(Input.is_action_pressed("scroll_left")),
		int(Input.is_action_pressed("scroll_down")) - int(Input.is_action_pressed("scroll_up"))
	)
	if dragging:
		camera.global_position  = drag_start + (drag_viewport_start - drag_viewport_point) / camera.zoom
	camera.global_position += direction / camera.zoom * speed
	pass
