extends CharacterBody3D
class_name Player


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Camera3D = $Camera3D

var camera_senitivity: float = 0.5

func _ready() -> void:
	capture()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED * delta * 50
		velocity.z = direction.z * SPEED * delta * 50
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * 50)
		velocity.z = move_toward(velocity.z, 0, SPEED * delta * 50)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * camera_senitivity * 0.0025)
		camera.rotate_x(-event.relative.y * camera_senitivity * 0.0015)
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -60, 80)
	if event.is_action_pressed("pause"):
		capture(false)
	if event.is_action_pressed("mouse_capture"):
		capture()


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		capture(false)

func capture(value: bool = true) -> void:
	if value:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE