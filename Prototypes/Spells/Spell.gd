extends Node2D
class_name Spell

@export var cooldown = 0
@export var duration = 0
var cooldownTimer
var target

var usable:bool = true

var spell_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	cooldownTimer = timer.new()
	cooldownTimer.wait_time = duration


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func cast():
	target = get_global_mouse_position()
