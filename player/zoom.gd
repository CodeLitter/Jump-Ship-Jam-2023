extends Node


@export var camera: Camera2D
@export var min: float = 1.0
@export var max: float = 2.0
@export var steps: int = 10
@onready var current: int = steps / 2


func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		print(camera.zoom)
		match event.button_index:
			MOUSE_BUTTON_WHEEL_UP:
				current = clamp(current + 1, 0, steps)
			MOUSE_BUTTON_WHEEL_DOWN:
				current = clamp(current - 1, 0, steps)


func _process(delta):
	camera.zoom = Vector2.ONE * lerp(min, max, current / float(steps))
