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
				var unit_target = camera.get_global_mouse_position()
				for unit in units:
					if target != null and target not in units:
						var attack_node := unit.get_node("Attack") as Area2D
						if attack_node != null and (attack_node.collision_mask & target.collision_layer) != 0:
							unit_target = target
					unit.act(unit_target)
			pass


func _process(delta):
	pass


func _on_select_drag_start():
	for unit in units:
		unit.death.disconnect(_on_select_unit_remove.bind(unit))
	units.clear()
	pass


func _on_select_drag_end():
	pass


func _on_select_unit_add(unit):
	if unit not in units:
		units.push_back(unit)
		unit.death.connect(_on_select_unit_remove.bind(unit))
	pass


func _on_select_unit_remove(unit):
	unit.death.disconnect(_on_select_unit_remove.bind(unit))
	units.erase(unit)
	pass


func _on_body_entered(body):
	target = body
	pass
