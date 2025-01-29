extends CharacterBody2D

@export var value: int
@export var contents: Spell

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _interact():
	GameBus.points += value
	print(GameBus.points)
	return 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
