extends Conjuration
class_name Illusory_Treasure

@export var ChestScene : PackedScene = preload("res://Prototypes/Treasure/Illusion_Treasure/Illusion_treasure.tscn")
var chest


# Called when the node enters the scene tree for the first time.
func _ready():
<<<<<<< HEAD:Prototypes/Spells/Spellbook/Illusory Treasure/IllusoryTreasure.gd
	duration = 0.05
	cooldown = 0.5
	super._ready()
	
func effect():	
	super.effect()
=======
	duration = 0.1
	cooldown = 2.0
	super._ready()
	
	
func makeUsable():
	usable = true
	cooldownTimer.callback.disconnect(makeUsable)
	cooldownTimer.wait_time = duration
	
	
func effect():
	super.cast() # Sets the target variable to the global mouse position
>>>>>>> 95c83d31ab6f5521f0444ca80448f293436a91f3:Prototypes/Spells/Spellbook/IllusoryTreasure.gd
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
