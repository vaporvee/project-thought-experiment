extends Area3D

signal interacted

var player_entered: bool
@onready var interaction_label: CanvasLayer = $InteractionLabel
func _on_body_entered(body):
	if body is Player:
		player_entered = true
		interaction_label.show()

func _on_body_exited(body):
	if body is Player:
		player_entered = false
		interaction_label.hide()

func _input(event):
	if player_entered && event.is_action_pressed("interact"):
		interacted.emit()
