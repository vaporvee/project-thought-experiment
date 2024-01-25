extends CanvasLayer

func _on_close_pressed() -> void:
	get_tree().quit()


func _on_main_menu_pressed() -> void:
	hide()
	WindowManager.pause_menu.hide()
	get_tree().change_scene_to_file("res://scenes/gui/menus/main_menu.tscn")
