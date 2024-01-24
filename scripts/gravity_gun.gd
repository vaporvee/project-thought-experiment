extends CanvasLayer
class_name GravityGunLayer

@onready var gravity_particles: GPUParticles3D = $SubViewportContainer/SubViewport/Node3D/Camera3D/MeshInstance3D/GravityParticles

@export var player: Player
var collider: RigidBody3D

@export_range(1.5,10) var spring_length_cap: float = 10

func _on_visibility_changed() -> void:
	set_physics_process(visible) # Deaktiviert die Schleife unten wenn die Gun unsichtbar ist.
func _ready() -> void:
	# Führt sie auch am Anfang aus wenn sich die visibility noch nicht geändert hat
	_on_visibility_changed()

func _physics_process(_delta):
	if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED && player.spring_arm.get_hit_length() > 1.5 &&  Input.is_action_pressed("gravity_activate"):
		gravity_particles.visible = true
		if collider:
			collider.global_position = player.goal.global_position
			if Input.is_action_just_pressed("gravity_freeze"):
				collider.freeze = true
		elif player.raycast.get_collider() is RigidBody3D:
			collider = player.raycast.get_collider()
			collider.freeze = false
			lock_vertical_rotation(collider,true)
		if Input.is_action_pressed("gravity_push") || Input.is_action_just_pressed("gravity_push"):
			player.spring_arm.spring_length += .5
		if Input.is_action_pressed("gravity_pull") || Input.is_action_just_pressed("gravity_pull"):
			player.spring_arm.spring_length -= .5
		player.spring_arm.spring_length = clamp(player.spring_arm.spring_length,2,spring_length_cap)
	else:
		gravity_particles.visible = false
		if collider:
			lock_vertical_rotation(collider,false)
		collider = null

func lock_vertical_rotation(body: RigidBody3D, locked: bool):
	if locked:
		var rot = body.rotation
		body.rotation = Vector3(0,rot.y,0)
	body.axis_lock_linear_x = locked
	body.axis_lock_linear_z = locked
	body.axis_lock_angular_x = locked
	body.axis_lock_angular_z = locked
