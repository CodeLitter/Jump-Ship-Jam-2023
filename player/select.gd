extends Area2D
class_name Select


@export var camera: Camera2D
@onready var collision: CollisionShape2D = $"CollisionShape2D"
var shape: RectangleShape2D
var drag_start_position: Vector2:
	set(value):
		drag_start_position = value
		drag_end_position = value
		collision.global_position = value
		collision.shape.size = Vector2.ZERO
var drag_end_position: Vector2:
	set(value):
		drag_end_position = value
		collision.global_position = lerp(drag_start_position, drag_end_position, 0.5)
		collision.shape.size = abs(drag_end_position - drag_start_position)
var dragging: bool
#var selection: Array
signal drag_start
signal drag_end
signal unit_add(unit: Node2D)
signal unit_remove(unit: Node2D)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				collision.shape = RectangleShape2D.new()
				dragging = true
				drag_start_position = camera.get_global_mouse_position()
				drag_start.emit()
#				selection.clear()
			if event.is_released():
				collision.shape = null
				dragging = false
				drag_end.emit()


func _process(delta):
	if dragging:
		drag_end_position = camera.get_global_mouse_position()


func _on_body_entered(body: Node2D):
	if dragging and body.is_in_group("selectable"):
		unit_add.emit(body);
#		print(body.owner.name, " Entered ")
	pass


func _on_body_exited(body: Node2D):
	if dragging:
		unit_remove.emit(body.owner)
#		print(body.owner.name, " Exited ")
	pass
