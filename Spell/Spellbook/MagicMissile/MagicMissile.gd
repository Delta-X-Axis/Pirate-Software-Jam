extends Evocation
class_name Magic_Missile

var MissileScene : PackedScene = preload("res://Spell/Spellbook/MagicMissile/Projectile/Magic_Missile.tscn")
var missile

# Called when the node enters the scene tree for the first time.
func _ready():
	duration = 0.05
	cooldown = 0.45
	super._ready()

func cast():
	if (!usable):
		return
	
	usable = false
	super.cast()
		
	missile = MissileScene.instantiate()
	GameBus.addItem.emit(missile)
	missile.setVals(get_parent().position, target)
