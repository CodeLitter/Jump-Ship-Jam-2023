extends Area2D
class_name Place


@export var camera: Camera2D
@export var blueprint: PackedScene
@onready var collision := $"CollisionShape2D"
var target_structure: PackedScene
var neighbors: Dictionary
var can_place: bool:
	get:
		return neighbors.is_empty()


func _input(event):
	if event is InputEventMouseMotion:
		collision.global_position = camera.get_global_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_place:
			var instance := blueprint.instantiate() as StaticBody2D
			instance.global_position = camera.get_global_mouse_position()
			instance.target_building = target_structure
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
