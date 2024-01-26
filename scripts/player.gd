extends CharacterBody3D
class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Camera3D = $Camera3D
@onready var gun_cam: Camera3D = $GravityGunLayer/SubViewportContainer/SubViewport/Node3D/Camera3D
var camera_senitivity: float = 0.5

@onready var raycast: RayCast3D = $Camera3D/RayCast3D
@onready var goal: Node3D = $Camera3D/SpringArm3D/GravityGunGoal
@onready var spring_arm: SpringArm3D = $Camera3D/SpringArm3D

@onready var sound_effect: SoundEffect = $FootSteps
var step_sound_toggle: bool
@onready var step_timer: Timer = $FootStepTimer

func _ready() -> void:
	if get_tree().current_scene is MainMenu:
		queue_free()
	capture()
	camera.make_current()
	$Camera3D/DDOF.show() # Würde den spieler im editor unsichtbar machen
	WindowManager.pause_menu.continued.connect(capture)

func _physics_process(delta: float) -> void:
	if position.y < -33:
		$GameOver.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
	gun_cam.transform = camera.transform
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sound_effect.play_key("jump")
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * delta * 50
		velocity.z = direction.z * SPEED * delta * 50
		if step_timer.is_stopped() && is_on_floor():
			sound_effect.play_key("step1")
			step_timer.start()
		elif !is_on_floor():
			step_timer.stop()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * 50)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta * 50)
		step_timer.stop()
	move_and_slide()
	
	# Pushing other objects
	for col_idx in get_slide_collision_count():
		var col := get_slide_collision(col_idx)
		if col.get_collider() is RigidBody3D:
			col.get_collider().apply_central_impulse(-col.get_normal() * 0.3)
			col.get_collider().apply_impulse(-col.get_normal() * 0.01, col.get_position())

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * camera_senitivity * 0.0025)
		camera.rotate_x(-event.relative.y * camera_senitivity * 0.0015)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -50, 80)
	if event.is_action_pressed("pause"):
		capture(false)

func capture(value: bool = true) -> void:
	if value:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_foot_step_timer_timeout() -> void:
	step_sound_toggle = !step_sound_toggle
	if step_sound_toggle:
		sound_effect.play_key("step1")
	else:
		sound_effect.play_key("step2")
