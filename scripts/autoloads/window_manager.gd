extends Node

var close_request_window: ConfirmationDialog

func _ready() -> void:
	close_request_window = preload("res://scenes/close_game_confirmation.tscn").instantiate()
	add_child(close_request_window)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		close_request_window.popup()
