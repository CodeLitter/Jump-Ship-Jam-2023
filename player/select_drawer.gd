extends Node2D


@export var select: Select
@export var selection_box_color: Color = Color.WHITE
@export var selection_box_fill: bool = false
@export var selection_box_thickness: float = 1
@export var selection_color: Color = Color.WHITE
@export var selection_fill: bool = false
@export var selection_thickness: float = 1


func _process(delta):
	queue_redraw()


func _draw():
	if select.is_selecting:
		var rect := Rect2()
		rect.position = to_local(select.selection_start)
		rect.end = to_local(select.selection_end)
		draw_rect(rect, selection_box_color, selection_box_fill, selection_box_thickness / select.camera.zoom.length());
	for item in select.selection:
		var unit: Sprite2D = item
		var bounds := Rect2(
			to_local(unit.global_position) - (unit.get_rect().size + Vector2.ONE * selection_thickness) / 2.0,
			unit.get_rect().size + Vector2.ONE * selection_box_thickness
		)
		draw_rect(bounds, selection_color, selection_fill, selection_thickness / select.camera.zoom.length())
