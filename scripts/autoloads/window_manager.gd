extends Node

var close_request_window: ConfirmationDialog
var pause_menu: PauseMenu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	close_request_window = preload("res://scenes/close_game_confirmation.tscn").instantiate()
	add_child(close_request_window)
	pause_menu = preload("res://scenes/gui/menus/pause_menu.tscn").instantiate()
	add_child(pause_menu)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		popup_close_dialog()
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		show_pause_menu()

func popup_close_dialog() -> void:
	uncapture_mouse()
	close_request_window.popup()

func show_pause_menu() -> void:
	uncapture_mouse()
	get_tree().paused = true
	pause_menu.show()

func uncapture_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		show_pause_menu()
