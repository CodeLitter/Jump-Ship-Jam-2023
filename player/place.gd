extends Area2D
class_name Place


@export var camera: Camera2D
@onready var collision := $"CollisionShape2D"
var target_structure: PackedScene:
	set(value):
		target_structure = value
#		var target_collision := target_structure.get_node("CollisionShape2D") as CollisionShape2D
#		var new_shape := RectangleShape2D.new()
#		new_shape.size = target_collision.shape.get_rect().size
#		collision.shape = new_shape
	get:
		return target_structure
var neighbors: Dictionary
var can_place: bool:
	get:
		return neighbors.is_empty()


func _input(event):
	if event is InputEventMouseMotion:
		collision.global_position = camera.get_global_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_place:
			var instance := target_structure.instantiate() as StaticBody2D
			instance.global_position = camera.get_global_mouse_position()
			get_tree().root.add_child(instance)
			pass
		pass
	pass


func _on_body_entered(body):
	neighbors[body] = true
	pass


func _on_body_exited(body):
	neighbors.erase(body)
	pass
