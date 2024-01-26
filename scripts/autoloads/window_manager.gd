extends Node

var close_request_window: CanvasLayer
var pause_menu: PauseMenu

var fullscreen: bool

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	close_request_window = preload("res://scenes/gui/menus/close_game_confirmation.tscn").instantiate()
	add_child(close_request_window)
	pause_menu = preload("res://scenes/gui/menus/pause_menu.tscn").instantiate()
	add_child(pause_menu)
	
	fullscreen = DisplayServer.window_get_mode() == 4

func _process(_delta: float) -> void:
	if Input.is_action_just_released("fullscreen"):
		fullscreen = !fullscreen
		toggle_fullscreen()

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		if get_tree().current_scene is MainMenu :
			get_tree().quit()
		else:
			popup_close_dialog()
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		if !get_tree().current_scene is MainMenu :
			show_pause_menu()

func popup_close_dialog() -> void:
	uncapture_mouse()
	close_request_window.show()

func show_pause_menu() -> void:
	uncapture_mouse()
	get_tree().paused = true
	pause_menu.show()

func uncapture_mouse() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") && !get_tree().current_scene is MainMenu:
		show_pause_menu()

func toggle_fullscreen() -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
