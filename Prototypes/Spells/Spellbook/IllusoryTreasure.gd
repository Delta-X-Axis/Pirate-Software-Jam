extends Conjuration
class_name Illusory_Treasure

@export var ChestScene : PackedScene = preload("res://Prototypes/Treasure/Illusion_Treasure/Illusion_treasure.tscn")
var chest

# Called when the node enters the scene tree for the first time.
func _ready():
	duration = 5
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cast():
	cooldownTimer.callback.connect(effect)
	cooldownTimer.start()
	usable = false
