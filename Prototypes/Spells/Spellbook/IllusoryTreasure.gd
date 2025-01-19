extends Conjuration
class_name Illusory_Treasure

@export var ChestScene : PackedScene = preload("res://Prototypes/Treasure/Illusion_Treasure/Illusion_treasure.tscn")
var chest

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	duration = 5
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	super.cast() #Sets the target variable to the global mouse position
	chest = ChestScene.instantiate()
	##add_child(chest)
	get_parent().add_child(chest)
	chest.global_position = target
	print(target)
	
