extends Area2D
class_name Select

@export var camera: Camera2D
@onready var collision: CollisionShape2D = $"CollisionShape2D"
@onready var shape: RectangleShape2D = RectangleShape2D.new()
var selection_start: Vector2:
	set(value):
		selection_start = value
		selection_end = value
		collision.global_position = value
		shape.size = Vector2.ZERO
var selection_end: Vector2:
	set(value):
		selection_end = value
		collision.global_position = lerp(selection_start, selection_end, 0.5)
		shape.size = abs(selection_end - selection_start)
var is_selecting: bool
var selection: Array


func _ready():
	collision.shape = shape


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_selecting = true
				selection_start = camera.get_global_mouse_position()
				selection.clear()
			if event.is_released():
				is_selecting = false
#				print(selection)


func _process(delta):
	if is_selecting:
		selection_end = camera.get_global_mouse_position()


func _on_body_entered(body: Node2D):
	if is_selecting and body.owner.is_in_group("selectable"):
		selection.push_back(body.owner)
#		print(body.owner.name, " Entered")
	pass


func _on_body_exited(body: Node2D):
	if is_selecting:
		selection.erase(body.owner)
#		print(body.owner.name, " Exited")
	pass
