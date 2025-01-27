extends CharacterBody2D

var time = 0.5
var damage = 10
var rangeTimer: timer


func _ready():
	rangeTimer = timer.new()
	rangeTimer.wait_time = time
	rangeTimer.callback.connect(kill)
	add_child(rangeTimer)
	rangeTimer.start()


func kill():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if (body.is_in_group("Enemy")):
		body.damage(damage)
