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
var health = 30

var target
var playerTarget

var dmg = 1
var detectArea

var sprite


func _ready():
	detectArea = get_node("Area2D")
	
	stateTimer = timer.new()
	stateTimer.wait_time = transitionTime
	stateTimer.callback.connect(setWander)
	add_child(stateTimer)
	stateTimer.start()
	
	sprite = get_node("Sprite")


func setIdle():
	if state == 2:
		playerTarget = null
		
	sprite.stop()
		
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
	
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setIdle)
	stateTimer.wait_time = 3.0
	stateTimer.reset()
	stateTimer.start()



func setAttracted(ref):
	state = 2
	
	playerTarget = ref
	
	var runTime = randf_range(0.5, 1.5)
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setIdle)
	stateTimer.wait_time = runTime
	stateTimer.reset()


func move(time):
	velocity = position.direction_to(target) * movement
	detectArea.rotation = velocity.angle()
	
	
	var dir = velocity.angle()
	
	if dir < PI/4 && dir >-PI/4:
		sprite.play("Right")
	if dir < PI/4 * 3 && dir >PI/4:
		sprite.play("Down")
	if abs(velocity.angle_to(Vector2.LEFT)) < PI/4:
		sprite.play("Left")
	if dir < -PI/4 && dir >-PI/4*3:
		sprite.play("Up")
	
	
	
	var collision = move_and_collide(velocity * time)
	
	if collision && collision.get_collider().has_method("hit"):
		collision.get_collider().hit(dmg, position)
		setIdle()
		return
	
	if (position.distance_to(target) <= 3):
		setIdle()


func damage(val):
	health -= val

func Alive():
	if (health <= 0):
		print("Dead!")
		GameBus.addPoints(2)
		return false
	else: return true

func _process(_delta):
	if !Alive():
		self.queue_free()
	
	match state:
		1:
			move(_delta)
		2:
			target=playerTarget.position
			move(_delta)




func _on_body_entered(body):
	if (body.is_in_group("Wizard")):
		setAttracted(body)

func _on_body_exited(body):
	if (body.is_in_group("Wizard")):
		stateTimer.start()
