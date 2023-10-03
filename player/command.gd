extends Area2D
class_name Command

@export var camera: Camera2D
@export var click_size: Vector2 = Vector2(20, 20)
@onready var collision: CollisionShape2D = $"CollisionShape2D"
var units: Array
var target: Node2D

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				collision.shape = RectangleShape2D.new()
				collision.shape.size = click_size
				collision.global_position = camera.get_global_mouse_position()
				target = null
			if event.is_released():
				for unit in units:
					if target != null and target not in units:
						# TODO call target_command
						unit.interact_with_target(target)
					else:
						# TODO call move_command
						unit.move_to_position(camera.get_global_mouse_position())
#					unit.agent.target_position = camera.get_global_mouse_position()
#					print(unit.agent.target_position)
			pass


func _process(delta):
	pass


func _on_select_drag_start():
	units.clear()
	pass


func _on_select_drag_end():
	pass


func _on_select_unit_add(unit):
	if unit not in units:
		units.push_back(unit)
		unit.death.connect(func(): units.erase(unit))
	pass


func _on_select_unit_remove(unit):
	units.erase(unit)
	pass


func _on_body_entered(body):
	target = body
	pass
