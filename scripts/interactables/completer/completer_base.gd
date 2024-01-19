@tool
extends Node
class_name Completer

@export var one_shot: bool

signal triggered

var completed: bool

func toggle_complete():
	if one_shot:
		completed = true
	else:
		completed = !completed
	triggered.emit()
