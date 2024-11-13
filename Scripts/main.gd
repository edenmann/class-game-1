extends Node2D

static var p1: CharacterBody2D
static var p2: CharacterBody2D

signal side_changed()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	

func _on_player_1_tree_entered() -> void:
	p1= $Player1

func _on_player_2_tree_entered() -> void:
	p2= $Player2


# used for camera positioning
static func pos_dif():
	return (p1.position[0] + p2.position[0])

var pos_time = 0
var p1_past_side
var p1_current_side

func player_side_change():

	if p1.position[0] <= p2.position[0]:
		p1_current_side = "left"
	elif p1.position[0] > p2.position[0]:
		p1_current_side = "right"

	if pos_time == 0:
		pos_time += 1
	
	elif pos_time > 0:
		if p1_past_side != p1_current_side:
			side_changed.emit()

	p1_past_side = p1_current_side


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_side_change()

