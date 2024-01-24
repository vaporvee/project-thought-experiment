extends CanvasLayer
class_name  PauseMenu

signal continued

func _on_continue_pressed() -> void:
	hide()
	get_tree().paused = false
	continued.emit()


func _on_restart_level_pressed() -> void:
	if !get_tree().current_scene is MainMenu:
		get_tree().reload_current_scene()
		hide()
		get_tree().paused = false


func _on_close_level_pressed() -> void:
	WindowManager.popup_close_dialog()
