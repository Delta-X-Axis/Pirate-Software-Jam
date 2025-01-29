extends Node

var frames: Array
var currentFrame

# Called when the node enters the scene tree for the first time.
func _ready():
	frames.append(get_node("Missile/Frame"))
	frames.append(get_node("Treasure/Frame"))
	frames.append(get_node("Clap/Frame"))
	currentFrame = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_wizard_select_spell(num):
	frames[currentFrame].visible = false
	frames[num].visible = true
	currentFrame = num
