class_name Wand_Keyboard
extends CharacterBody2D


@export var MaxSpeed = 300
@export var MousePull = 1500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func follow(time):
	var xInput = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	var yInput = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))

	var input = Vector2(xInput, yInput).normalized()
	
	velocity = input * MaxSpeed
		
	move_and_slide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow(delta)
