extends "res://Prototypes/Spells/Evocation.gd"
class_name Magic_Missile

@export var MissileScene : PackedScene = preload("res://Prototypes/Spells/Spellbook/MagicMissile/Magic_Missile.tscn")
@export var speed = 500


var missile

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 10
	duration = 0.05
	cooldown = 0.75
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if missile == null: #checks if missile is spawned
		return
	missile.move_and_slide()

func effect():
	super.effect() #sets target to the global mouse position
	missile = MissileScene.instantiate()
	get_parent().get_parent().add_child(missile)
	print("GP: " , missile.global_position , " | " , "target:" , target)
	missile.global_position = origin
	
	#sets the missile on course to the target
	missile.velocity = missile.position.direction_to(target) * speed
	
	#Timer that controls range and removes the missile from the world
	var rangeTimer = timer.new()
	add_child(rangeTimer)
	rangeTimer.wait_time = 1.0
	rangeTimer.callback.connect(missile.queue_free)
	rangeTimer.start()
	
	
func cast():
	if (!usable):
		return
	cooldownTimer.callback.connect(effect)
	cooldownTimer.start()
	usable = false
	



func _on_missile_detection_body_entered(body):
	if (body.is_in_group("Enemy")):
		body.damage(damage)
		self.queue_free()
	if (body.is_in_group("Wall")):
		self.queue_free()
