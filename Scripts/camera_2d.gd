extends Camera2D

var p1
var p2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	p1 = $Player1
	p2 = $Player2
	pass # Replace with function body.


# relative position of players. player1.x + player2.x
var rel_position: float = p1.position.x + p2.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rel_position = Main.pos_dif()
	print(rel_position)

	self.position.x = rel_position
