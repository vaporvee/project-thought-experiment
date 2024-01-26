extends Control
class_name MainMenu

func _ready() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	LevelManager.level_pointer = 0

func _on_start_game_pressed() -> void:
	LevelManager.next_level()

func _on_quit_game_pressed() -> void:
	get_tree().quit()
