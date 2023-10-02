extends Node
class_name Command

@export var camera: Camera2D
var units: Array


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			# TODO create command with each unit in selection
			for unit in units:
				unit.agent.target_position = camera.get_global_mouse_position()
				print(unit.agent.target_position)
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
	pass


func _on_select_unit_remove(unit):
	units.erase(unit)
	pass
