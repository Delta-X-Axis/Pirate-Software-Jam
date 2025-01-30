extends Node

var frames: Array
var icons: Array

var health: Array
var healthIndex = 4

var points

var currentFrame
@export var playerRef: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	frames.append(get_node("Missile/Frame"))
	icons.append(get_node("Missile"))
	frames.append(get_node("Treasure/Frame"))
	icons.append(get_node("Treasure"))
	frames.append(get_node("Clap/Frame"))
	icons.append(get_node("Clap"))
	currentFrame = 0
	
	health.append(get_node("Node2D/Sprite2D"))
	health.append(get_node("Node2D/Sprite2D2"))
	health.append(get_node("Node2D/Sprite2D3"))
	health.append(get_node("Node2D/Sprite2D4"))
	health.append(get_node("Node2D/Sprite2D5"))
	playerRef.getHit.connect(removeHealth)
	
	points = get_node("Sprite2D/Label")
	GameBus.getPoints.connect(setPoints)


func setSpells():
	for i in playerRef.spells.size():
		playerRef.spells[i].castSpell.connect(cooldown.bind(i))


func cooldown(num):
	icons[num].modulate = Color(0.5, 0.5, 0.5)
	playerRef.spells[num].cooldownTimer.callback.connect(resetCooldown.bind(num))


func resetCooldown(num):
	icons[num].modulate = Color(1.0, 1.0, 1.0)
	playerRef.spells[num].cooldownTimer.callback.disconnect(resetCooldown.bind(num))
	
	
func removeHealth():
	health[healthIndex].visible = false
	healthIndex -= 1


func setPoints():
	points.text = str(GameBus.points)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_wizard_select_spell(num):
	frames[currentFrame].visible = false
	frames[num].visible = true
	currentFrame = num
