extends Conjuration
class_name Illusory_Treasure

@export var ChestScene : PackedScene = preload("res://Prototypes/Treasure/Illusion_Treasure/Illusion_treasure.tscn")
var chest

# Called when the node enters the scene tree for the first time.
func _ready():
	duration = 0.05
	cooldown = 0.5
	super._ready()
	
func effect():	
	super.effect()
	chest = ChestScene.instantiate()
	get_parent().get_parent().add_child(chest)
	chest.global_position = target

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	if (!usable):
		return
	cooldownTimer.callback.connect(effect)
	cooldownTimer.start()
	usable = false
