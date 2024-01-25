extends AudioStreamPlayer
class_name  SoundEffect

@export var audio_library: Array[SoundeffectResource]

func play_key(key: String) -> void:
	for res in audio_library:
		if res.key == key:
			stream = res.audio
			play()
			return
	push_error(key + " is not available in the Audio Library variable")
