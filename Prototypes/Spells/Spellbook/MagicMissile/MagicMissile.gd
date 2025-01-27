extends Evocation
class_name Magic_Missile

var MissileScene : PackedScene = preload("res://Prototypes/Spells/Spellbook/MagicMissile/Projectile/Magic_Missile.tscn")
var missile

# Called when the node enters the scene tree for the first time.
func _ready():
	duration = 0.05
	cooldown = 1.5
	super._ready()

func cast():
	if (!usable):
		return
	
	usable = false
	super.cast()
		
	missile = MissileScene.instantiate()
	get_parent().get_parent().add_child(missile)
	missile.setVals(get_parent().position, target)
