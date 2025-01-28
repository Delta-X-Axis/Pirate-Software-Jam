extends Evocation
class_name Thunderclap

@export var ClapScene : PackedScene = preload("res://Spell/Spellbook/Thunderclap/Projectile/Thunderclap.tscn")
var clap

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 20
	cooldown = 1.5
	super._ready()

func cast():
	if (!usable):
		return
		
	usable = false
	super.cast()
		
	clap = ClapScene.instantiate()
	GameBus.addItem.emit(clap)
	clap.global_position = get_parent().position
	clap.look_at(target)
	
