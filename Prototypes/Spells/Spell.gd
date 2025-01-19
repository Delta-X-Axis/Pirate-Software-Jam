extends Node2D
class_name Spell

@export var cooldown = 0
@export var duration = 0
var target

var spell_name : String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func cast():
	target = get_global_mouse_position()
