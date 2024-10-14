extends CharacterBody2D

#@onready var camera: camera2D = get_node("")
@onready var char_animation: AnimatedSprite2D = self.get_node("AnimatedSprite2D")

# character movement is smoother when a multiple of 60.
const SPEED_MULTIPLIER = 3
const SPEED = 60.0 * SPEED_MULTIPLIER
const JUMP_VELOCITY = -400.0



static var player = 1

#direction that the characters are facing, "right", or "left" 
var facing = ""

#when a new player node is initialized, the player 
func _init():
	
	if player == 1:
		facing = "right"

	else:
		facing = "left"
		char_animation.set_flip_h(false)
		

	#face_direction()

	print(facing)
	player += 1
	print(player)

func face_direction():
	if facing == "right":
		char_animation.flip_h = false
	else:
		char_animation.flip_h = true

#takes in general action then changes to player specific action (ie: "move_left" -> "p1_move_left")
func player_action(action):
	var new_action = "p" + str(player) + "_" + action
	print(new_action)
	return new_action

var move_left = player_action("move_left")
var move_right = player_action("move_right")
var jump = player_action("jump")
var crouch = player_action("crouch")

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
