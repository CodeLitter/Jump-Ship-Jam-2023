extends Node
class_name Command


var units: Array


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
