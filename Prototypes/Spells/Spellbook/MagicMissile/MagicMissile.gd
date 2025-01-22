extends "res://Prototypes/Spells/Evocation.gd"
class_name Magic_Missile

@export var MissileScene : PackedScene = preload("res://Prototypes/Spells/Spellbook/MagicMissile/Magic_Missile.tscn")
@export var speed = 20
var missile
 
# Called when the node enters the scene tree for the first time.
func _ready():
	duration = 0.05
	cooldown = 0.5
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if missile == null:
		return
	missile.velocity = missile.position.direction_to(target) * speed
	if position.distance_to(target) < 1:
		missile.queue_free()
	else: missile.move_and_slide()

func effect():
	super.effect()
	missile = MissileScene.instantiate()
	get_parent().get_parent().add_child(missile)
	print("GP: " , missile.global_position , " | " , "target:" , target)
	missile.global_position = origin
	

func cast():
	if (!usable):
		return
	cooldownTimer.callback.connect(effect)
	cooldownTimer.start()
	usable = false
