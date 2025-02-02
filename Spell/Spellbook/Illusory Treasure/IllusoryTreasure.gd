extends Conjuration
class_name Illusory_Treasure

@export var ChestScene : PackedScene = preload("res://Spell/Spellbook/Illusory Treasure/Object/Illusion_treasure.tscn")
var chest


# Called when the node enters the scene tree for the first time.
func _ready():
	cooldown = 0.5
	super._ready()
	


func cast():
	if (!usable):
		return
	
	super.cast()
	
	
	
	chest = ChestScene.instantiate()
	GameBus.addItem.emit(chest)
	chest.global_position = target
	
	
	cooldownTimer.start()
	usable = false
