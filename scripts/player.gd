extends CharacterBody3D


const SPEED = 5.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Camera3D = $Camera3D

@onready var light: SpotLight3D = $Camera3D/SpotLight3D

var camera_senitivity: float = 0.5

func _ready() -> void:
	capture()

func _physics_process(delta: float) -> void:
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
	if event.is_action_pressed("flashlight"):
		light.visible = !light.visible


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		capture(false)

func capture(value: bool = true) -> void:
	if value:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
