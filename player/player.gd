extends Camera2D
class_name Player


enum State {
	COMMAND,
	BUILD,
}


@onready var state: State = State.COMMAND


func _ready():
	for child in get_children():
		for state_name in State.keys():
			if child.is_in_group(state_name.to_lower()):
				child.set_process_input(false)


func _unhandled_input(event):
	for child in get_children():
		if child.is_in_group(State.keys()[state].to_lower()):
			child._input(event)
