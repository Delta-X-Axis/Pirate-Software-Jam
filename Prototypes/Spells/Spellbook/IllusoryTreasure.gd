extends Conjuration
class_name Illusory_Treasure

@export var ChestScene : PackedScene = preload("res://Prototypes/Treasure/Illusion_Treasure/Illusion_treasure.tscn")
var chest

# Called when the node enters the scene tree for the first time.
func _ready():
	duration = 0.5
	cooldown = 2.0
	super._ready()
	
	
func makeUsable():
	usable = true
	cooldownTimer.callback.disconnect(makeUsable)
	cooldownTimer.wait_time = duration
	
func effect():
	super.cast() #Sets the target variable to the global mouse position
	chest = ChestScene.instantiate()
	get_parent().get_parent().add_child(chest)
	chest.global_position = target
	cooldownTimer.callback.disconnect(effect)
	cooldownTimer.wait_time = cooldown
	cooldownTimer.callback.connect(makeUsable)
	cooldownTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	if (!usable):
		return
	cooldownTimer.callback.connect(effect)
	cooldownTimer.start()
	usable = false
