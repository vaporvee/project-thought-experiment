extends Node

@onready var transition: CanvasLayer = $Transition

@export var levels: Array[PackedScene]
var level_pointer: int = 0

const PROGRESS_SAVE_PATH: String = "user://save.cfg"
var progress_save: ConfigFile = ConfigFile.new()

func  _ready() -> void:
	progress_save.load(PROGRESS_SAVE_PATH)

func next_level() -> void:
	level_pointer += 1
	if level_pointer < levels.size():
		transition.show()
		get_tree().paused = true
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_packed(levels[level_pointer])
		await get_tree().create_timer(2).timeout
		get_tree().paused = false
		transition.hide()
	else:
		get_tree().change_scene_to_file("res://scenes/gui/menus/game_finished.tscn")

func start_last_level() -> void:
	pass
