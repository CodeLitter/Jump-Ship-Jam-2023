extends Area2D

@export var camera: Camera2D
@export var selection_box_color: Color = Color.WHITE
@export var selection_box_fill: bool = false
@export var selection_box_thickness: float = 1
@export var selection_color: Color = Color.WHITE
@export var selection_fill: bool = false
@export var selection_thickness: float = 1
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
	queue_redraw()


func _draw():
	if is_selecting:
		var rect := Rect2()
		rect.position = to_local(selection_start)
		rect.end = to_local(selection_end)
		draw_rect(rect, selection_box_color, selection_box_fill, selection_box_thickness / camera.zoom.length());
	for item in selection:
		var unit: Sprite2D = item
		var bounds := Rect2(
			to_local(unit.global_position) - (unit.get_rect().size + Vector2.ONE * selection_thickness) / 2.0,
			unit.get_rect().size + Vector2.ONE * selection_box_thickness
		)
		draw_rect(bounds, selection_color, selection_fill, selection_thickness / camera.zoom.length())


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
