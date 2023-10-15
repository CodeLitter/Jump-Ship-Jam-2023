extends Area2D
class_name Place


@export var camera: Camera2D
@export var blueprint: PackedScene
@export var pool: Node
@onready var collision := $"CollisionShape2D"
var target_structure: PackedScene
var neighbors: Dictionary
var can_place: bool:
	get:
		return neighbors.is_empty()


func _input(event):
	if event.is_action_pressed("rotate"):
		collision.rotate(deg_to_rad(90))
	if event is InputEventMouseMotion:
		collision.global_position = camera.get_global_mouse_position()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and can_place:
			var instance := blueprint.instantiate() as StaticBody2D
			instance.global_position = camera.get_global_mouse_position()
			instance.global_rotation = collision.rotation
			instance.target_building = target_structure
			instance.add_to_group("player")
			if pool:
				pool.add_child(instance)
			else:
				get_tree().current_scene.add_child(instance)
			pass
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			var neighbors_to_free: Array
			var groups := blueprint.get_state().get_node_groups(0)
			for neighbor in neighbors:
				for group in groups:
					if neighbor.is_in_group(group):
						neighbors_to_free.append(neighbor)
			for neighbor in neighbors_to_free:
				neighbor.queue_free()
				neighbors.erase(neighbor)
		pass
	pass


func _on_body_entered(body):
	neighbors[body] = true
	pass


func _on_body_exited(body):
	neighbors.erase(body)
	pass
