extends CharacterBody2D

#@onready var camera: camera2D = get_node("")

# character movement is smoother when a multiple of 60.
const SPEED_MULTIPLIER = 3
const SPEED = 60.0 * SPEED_MULTIPLIER
const JUMP_VELOCITY = -600.0

static var static_player = 0
var player: int

# side that the characters are on. "left" or "right" 
var side = ""


func player_action(action):
	var new_action = "p" + str(player) + "_" + action
	print(new_action)
	return new_action


#when a new player node is initialized, the player 
func _init():

	static_player += 1
	player = static_player

	print(player)
	print(side)

	if player == 1:
		side = "left"
	else:
		side = "right"
		



	
func _on_animated_sprite_2d_ready() -> void:

	if side == "left":
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true


#takes in general action then changes to player specific action (ie: "move_left" -> "p1_move_left")

var move_left
var move_right
var jump
var crouch

func _ready():
	move_left = player_action("move_left")
	move_right = player_action("move_right")
	jump = player_action("jump")
	crouch = player_action("crouch")




func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed(jump) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	
	var direction := Input.get_axis(move_left, move_right)
	if is_on_floor():	
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func _on_main_side_changed() -> void:
	print("player " + str(player) + " flip_h: " + str($AnimatedSprite2D.flip_h))

	if $AnimatedSprite2D.flip_h == true:
		$AnimatedSprite2D.flip_h = false
	elif $AnimatedSprite2D.flip_h == false:
		$AnimatedSprite2D.flip_h = true
