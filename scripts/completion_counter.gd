extends Node

signal unlock

@export var nodes_needed: Array[Completer]
var uncompleted: int

func _ready():
	uncompleted = nodes_needed.size()
	for node in nodes_needed:
		node.completed.connect(complete)

func complete():
	uncompleted -= 1
	if uncompleted == 0:
		unlock.emit()

func uncomplete():
	pass #TODO
