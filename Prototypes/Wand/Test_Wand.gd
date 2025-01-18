class_name Wand
extends CharacterBody2D


@export var MaxSpeed = 1000
@export var MousePull = 1500


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func follow(time):
	var dir = get_global_mouse_position()
	dir = position.direction_to(dir)
	velocity += dir * MousePull * time
	if (position.distance_to(get_global_mouse_position()) < 10):
		velocity = Vector2.ZERO
	
	turnVelocity(time)
	
	if velocity.length() > MaxSpeed:
		velocity = velocity.normalized() * MaxSpeed
		
	move_and_slide()


func turnVelocity(time):
	var target = get_global_mouse_position()
	## Get angle between velocity and mouse direction
	var targetDirection = position.direction_to(target)
	var AngleBetween = velocity.angle_to(position.direction_to(get_global_mouse_position()))
	
	var rotationSpeed = 4 * PI * (1+(velocity.length()/1000)) * time
	
	if (abs(rotationSpeed) >= abs(AngleBetween)):
		rotationSpeed = AngleBetween
	
	velocity = velocity.rotated(AngleBetween * rotationSpeed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow(delta)
