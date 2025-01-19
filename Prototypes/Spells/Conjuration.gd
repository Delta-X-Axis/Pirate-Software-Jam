extends Spell
class_name Conjuration

# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func cast():
	target = get_global_mouse_position()
