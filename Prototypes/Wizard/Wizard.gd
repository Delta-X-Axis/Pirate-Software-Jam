extends CharacterBody2D


###########################
## STATE MACHINE FOR WIZARD
## 0 - Idle
## 1 - Wandering
## 2 - Attracted
## 3 - Frightened
var state = 0


var stateTimer
var transitionTime = 3.0

var movement = 75
var target


var detectArea


# Called when the node enters the scene tree for the first time.
func _ready():
	detectArea = get_node("Area2D")
	
	
	stateTimer = timer.new()
	stateTimer.wait_time = transitionTime
	stateTimer.callback.connect(setWander)
	add_child(stateTimer)
	stateTimer.start()


func idle():
	state = 0
	velocity = Vector2.ZERO
	target = null
	stateTimer.reset()
	stateTimer.start()
	return


func wander(time):
	velocity = position.direction_to(target) * movement
	detectArea.rotation = velocity.angle()
	
	move_and_slide()
	
	if (position.distance_to(target) <= 10):
		idle()


func setWander():
	state = 1
	var wanderDirection = randf_range(-PI, PI)
	var wanderDistance = randi_range(50, 300)
	
	target = position + (Vector2.from_angle(wanderDirection) * wanderDistance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match state:
		1:
			wander(delta)
