extends AudioStreamPlayer3D

@export var voice_lines: Array[VoiceLine]

@onready var textbox: RichTextLabel = $CanvasLayer/PanelContainer/RichTextLabel

var played: bool

func _on_area_3d_body_entered(body: Node3D) -> void:
	if !played && body is Player:
		start_audio_sequence()
		played = true

func start_audio_sequence():
	$CanvasLayer/PanelContainer.show()
	for line in voice_lines:
		textbox.text = line.text
		stream = line.audio
		play()
		await finished
	$CanvasLayer/PanelContainer.hide()
