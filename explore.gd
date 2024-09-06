extends CharacterBody3D


var speed = 2

var gravity = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#if !is_on_floor():
	#	translation.y -= gravity
	var velocity:Vector3
	if Input.is_action_pressed("ui_up"):
		velocity.z = transform.basis.z *speed
	if Input.is_action_pressed("ui_down"):
		velocity.z = -transform.basis.z *speed
	if Input.is_action_pressed("ui_left"):
		velocity.x = transform.basis.x *speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = transform.basis.x * speed

	set_velocity(velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
