extends CharacterBody2D

#@onready var camera: camera2D = get_node("")

# character movement is smoother when a multiple of 60.
const SPEED_MULTIPLIER = 3
const SPEED = 60.0 * SPEED_MULTIPLIER
const JUMP_VELOCITY = -400.0

var move_left = "move_left"
var move_right = "move_right"
var jump = "jump"
var crouch = "crouch"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis(move_left, move_right)
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_tree_entered() -> void:
	var player = 1
	if player = 1:
		pass
	else:
		
