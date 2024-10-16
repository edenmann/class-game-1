extends Node2D

var p1: CharacterBody2D
var p2: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1= $Player1
	p2= $Player2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("this is delta:" + str(delta))
	print("player 1 position:" + str(p1.position))
