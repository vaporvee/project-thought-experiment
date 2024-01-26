extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

func open(): 
	anim.play("open")
	audio.play()

func close(): 
	anim.play_backwards("open")
	audio.play()
