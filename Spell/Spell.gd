extends Node2D
class_name Spell

var cooldown = 0
var duration = 0
var cooldownTimer
var target

var usable:bool = true
var spell_name : String
signal castSpell

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldownTimer = timer.new()
	cooldownTimer.callback.connect(makeUsable)
	cooldownTimer.wait_time = cooldown
	add_child(cooldownTimer)


func makeUsable():
	usable = true


func cast():
	castSpell.emit()
	target = get_global_mouse_position()
	cooldownTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
