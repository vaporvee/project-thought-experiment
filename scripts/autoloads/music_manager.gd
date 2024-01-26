extends Node

@onready var soundeffect: SoundEffect = $SoundEffect

func _ready() -> void:
	_on_level_switched()
	LevelManager.level_switched.connect(_on_level_switched)

func _on_level_switched() -> void:
	print(get_tree().current_scene.name)
	match get_tree().current_scene.name:
		"MainMenu":
			soundeffect.play_key("main")
		"LVL1":
			soundeffect.play_key("lvl1")
		"LVL2":
			soundeffect.play_key("lvl2")
