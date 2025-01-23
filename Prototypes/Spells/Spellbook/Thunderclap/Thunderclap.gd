extends "res://Prototypes/Spells/Evocation.gd"
class_name Thunderclap

@export var ClapScene : PackedScene = preload("res://Prototypes/Spells/Spellbook/Thunderclap/Thunderclap.tscn")

var clap

# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 20
	cooldown = 1.5
	super._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super._process(delta)
	if clap == null: #checks if missile is spawned
		return


func effect():
	super.effect()
	
	clap = ClapScene.instantiate()
	get_parent().get_parent().add_child(clap)
	print("GP: " , clap.global_position , " | " , "target:" , target)
	clap.global_position = origin
	
	clap.look_at(target)
	
	var rangeTimer = timer.new()
	add_child(rangeTimer)
	rangeTimer.wait_time = 0.51
	rangeTimer.callback.connect(clap.queue_free)
	rangeTimer.start()
	
func cast():
	if (!usable):
		return
	cooldownTimer.callback.connect(effect)
	cooldownTimer.start()
	usable = false

func _on_body_entered(body):
	if (body.is_in_group("Enemy")):
		body.damage(damage)
