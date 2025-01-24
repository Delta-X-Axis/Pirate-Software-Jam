extends "res://Prototypes/Spells/Spell.gd"
class_name Evocation

@export var damage = 0
var origin

# Called when the node enters the scene tree for the first time.
func _ready():
	origin = get_parent().position
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	origin = get_parent().position
	
func cast():
	super.cast()
