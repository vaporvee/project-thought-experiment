extends CanvasLayer

@onready var gravity_particles: GPUParticles3D = $SubViewportContainer/SubViewport/Node3D/Camera3D/MeshInstance3D/GravityParticles

func _process(_delta: float) -> void:
	gravity_particles.visible = Input.is_action_pressed("gravity_activate")
