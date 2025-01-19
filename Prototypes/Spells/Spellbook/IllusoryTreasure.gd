extends "res://Prototypes/Spells/Conjuration.gd"
class_name Illusory_Treasure

@export var ChestScene : PackedScene
var chest = ChestScene

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	duration = 5
	print("Ready!")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	super.cast() #Sets the target variable to the global mouse position
	chest.position = target
	add_child(chest)
	
