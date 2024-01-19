extends Node
class_name Completer

@export var one_shot: bool

signal completed
signal uncompleted

var toggle: bool = true

func toggle_complete():
	toggle = !toggle
	if one_shot || toggle:
		completed.emit()
	else:
		uncompleted.emit()
