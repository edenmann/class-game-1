extends Node2D

static var p1: CharacterBody2D
static var p2: CharacterBody2D

signal p1_side_changed(side)
signal p2_side_changed(side)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1= $Player1
	p2= $Player2


# pos_dif is x position difference. player 1 position minus player 2 position. used to determine which side the player is on.

var pos_dif = p1.position[0] - p2.position[0]

func player_side(player_num):

	

	if pos_dif <= 0:
		if player_num == 1:
			return "left"
			p1_side_changed.emit("left")
		else:
			return "right"
			p1_side_changed.emit("left")
	elif pos_dif > 0:
		if player_num == 1:
			return "right"
		else:
			return "left"





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("player position difference:" + str(pos_dif))
