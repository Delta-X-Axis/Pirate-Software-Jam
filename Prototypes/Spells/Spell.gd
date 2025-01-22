extends Node2D
class_name Spell

var cooldown = 0
var duration = 0
var cooldownTimer
var target

var usable:bool = true

var spell_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldownTimer = timer.new()
	cooldownTimer.wait_time = duration
	add_child(cooldownTimer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func cast():
	target = get_global_mouse_position()
	
func makeUsable():
	usable = true
	cooldownTimer.callback.disconnect(makeUsable)
	cooldownTimer.wait_time = duration
	
func effect():
	target = get_global_mouse_position()
	cooldownTimer.callback.disconnect(effect)
	cooldownTimer.wait_time = cooldown
	cooldownTimer.callback.connect(makeUsable)
	cooldownTimer.start()
