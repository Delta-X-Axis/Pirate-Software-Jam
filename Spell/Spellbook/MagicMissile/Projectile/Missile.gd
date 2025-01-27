extends CharacterBody2D


var speed = 500
var damage = 10
var rangeTimer: timer

func _ready():
	rangeTimer = timer.new()
	rangeTimer.wait_time = 1.0
	rangeTimer.callback.connect(kill)
	add_child(rangeTimer)


func setVals(start, target):
	global_position = start
	velocity = start.direction_to(target) * speed
	rangeTimer.start()
	
	
func move():
	move_and_slide()


func kill():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move()


func _on_body_entered(body):
	if (body.is_in_group("Enemy")):
		body.damage(damage)
		self.queue_free()
	if (body.is_in_group("Wall")):
		self.queue_free()
