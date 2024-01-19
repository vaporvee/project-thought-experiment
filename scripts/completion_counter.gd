extends Node

signal unlock
signal lock

@export var nodes_needed: Array[Completer]

var unlocked: bool

func _ready():
	for node in nodes_needed:
		node.triggered.connect(complete)

func complete():
	if areAllNodesUnlocked():
		if !unlocked:
			unlock.emit()
		unlocked = true
	else:
		if unlocked:
			lock.emit()
		unlocked = false

func areAllNodesUnlocked():
	for node in nodes_needed:
		if !node.completed:
			return false
	return true
