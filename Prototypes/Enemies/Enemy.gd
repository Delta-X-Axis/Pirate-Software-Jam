class_name Enemy
extends CharacterBody2D


###########################
## STATE MACHINE FOR WIZARD
## 0 - Idle
## 1 - Wandering
## 2 - Attracted
## 3 - Attacking
var state = 0

var stateTimer
var transitionTime = 3.0

var movement = 50
var target
var playerTarget

var detectArea


func _ready():
	detectArea = get_node("Area2D")
	
	stateTimer = timer.new()
	stateTimer.wait_time = transitionTime
	stateTimer.callback.connect(setWander)
	add_child(stateTimer)
	stateTimer.start()


func setIdle():
	if state == 2:
		playerTarget = null
	velocity = Vector2.ZERO
	target = null
	
	state = 0
	
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setWander)
	
	stateTimer.wait_time = transitionTime
	stateTimer.reset()
	stateTimer.start()


func setWander():
	state = 1
	var wanderDirection = randf_range(-PI, PI)
	var wanderDistance = randi_range(10, 50)
	
	target = position + (Vector2.from_angle(wanderDirection) * wanderDistance)


func setAttracted(ref):
	state = 2
	
	playerTarget = ref
	
	var runTime = randf_range(0.5, 1.5)
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setIdle)
	stateTimer.wait_time = runTime
	stateTimer.reset()


func move():
	velocity = position.direction_to(target) * movement
	detectArea.rotation = velocity.angle()
	
	move_and_slide()
	
	if (position.distance_to(target) <= 10):
		setIdle()


func _process(_delta):
	match state:
		1:
			move()
		2:
			target=playerTarget.position
			move()



func _on_body_entered(body):
	if (body.is_in_group("Wizard")):
		setAttracted(body)

func _on_body_exited(body):
	if (body.is_in_group("Wizard")):
		stateTimer.start()
