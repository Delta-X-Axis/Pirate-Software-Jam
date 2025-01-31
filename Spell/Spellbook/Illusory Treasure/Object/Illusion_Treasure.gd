extends Node

var exist = timer.new()

func _ready():
	add_child(exist)
	exist.wait_time = 1
	exist.callback.connect(queue_free)
	exist.start()

func _interact():
	return 0


