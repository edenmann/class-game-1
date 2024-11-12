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


# startup is the time it takes for action to happen, in frames (1/60th of a second)
func player_action(action, startup: int = 0):
	var new_action = "p" + str(player) + "_" + action
	if startup > 0:
		#new_action = [new_action, startup]
		new_action = {"action": new_action,"startup": startup}
		print(new_action["action"], " startup: ", new_action["startup"] )
	elif startup == 0:
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
#each action has startup time counted in frames (1/60th of a second)

var move_left
var move_right
var jump
var crouch

func _ready():
	move_left = player_action("move_left")
	move_right = player_action("move_right")
	jump = player_action("jump", 5)
	crouch = player_action("crouch")


var on_floor: bool
var in_air: bool
var in_hit: bool

var last_velocity: float

var frame: float = 1.0/60.0
var in_startup: bool

var time_

func action_startup(action):
	in_startup = true
	await get_tree().create_timer(action["startup"]*frame).timeout
	in_startup = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	#print(delta)

	if is_on_floor():
		on_floor = true
		in_air = false

	#if not is_on_floor():
	else:
		velocity += get_gravity() * delta
		velocity.x = last_velocity

		on_floor = false
		in_air = true


	# Handle jump.
	if Input.is_action_just_pressed(jump["action"]) and is_on_floor():
		action_startup(jump)
		velocity.y = JUMP_VELOCITY
		last_velocity = velocity.x
		

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
