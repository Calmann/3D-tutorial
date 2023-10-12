extends CharacterBody3D

var speed := 5
var jump_force := 6
var gravity := Vector3.DOWN * 12
var mouse_rotation := 0.05
var currentHP := 10 
var maxHpHP := 10 
var damage := 1

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	velocity += gravity * delta
	get_input()
	move_and_slide();

func get_input():
	var input = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		input += transform.basis.z * speed
	if Input.is_action_pressed("move_backward"):
		input += -transform.basis.z * speed
	if Input.is_action_pressed("move_left"):
		input += transform.basis.x * speed
	if Input.is_action_pressed("move_right"):
		input += -transform.basis.x * speed
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_force
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else: 
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	velocity.x = input.x
	velocity.z = input.z
		

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-lerp(0.0, mouse_rotation, event.relative.x / 10))

func takeDamage(damage):
	currentHP -= damage
	print_debug('damage')
	if currentHP <= 0:
		die()

func die():
	get_tree().reload_current_scene()
