extends AudioStreamPlayer3D
class_name  SoundEffect3D

@export var audio_library: Array[SoundeffectResource]
@export_range(0,2) var pitch_variation: float

func play_key(key: String) -> void:
	for res in audio_library:
		if res.key == key:
			stream = res.audio
			pitch_scale = 1 + randf_range(pitch_variation * -1, pitch_variation)
			play()
			return
	push_error(key + " is not available in the Audio Library variable")
