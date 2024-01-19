extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer

func open(): anim.play("open")

func close(): anim.play_backwards("open")
