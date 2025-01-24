extends CharacterBody2D

@export var money = 0

signal open

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _interact():
	open.emit(money)
	return 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
