extends Node2D

var startButton
var creditsButton
var quitButton

var buttonDefaultWidth = 300

signal quitGame
signal credits
signal startRun


# Called when the node enters the scene tree for the first time.
func _ready():
	var dimensions = get_viewport()
	
	startButton = get_node("Start")
	startButton.text = "Start"
	startButton.size.x = buttonDefaultWidth
	startButton.position = Vector2(dimensions.size.x * 0.5 - (startButton.size.x / 2), dimensions.size.y * 0.5 - 70)
	startButton.pressed.connect(startButtonPressed)
	
	creditsButton = get_node("Credits")
	creditsButton.text = "Credits"
	creditsButton.size.x = buttonDefaultWidth
	creditsButton.position = Vector2(dimensions.size.x * 0.5 - (startButton.size.x / 2), dimensions.size.y * 0.5 + 50)
	creditsButton.pressed.connect(creditsButtonPressed)
	
	quitButton = get_node("Quit")
	quitButton.text = "Quit To Desktop"
	quitButton.size.x = buttonDefaultWidth
	quitButton.position = Vector2(dimensions.size.x * 0.5 - (startButton.size.x / 2), dimensions.size.y * 0.5 + 100)
	quitButton.pressed.connect(quitButtonPressed)

func startButtonPressed():
	startRun.emit()
	
func creditsButtonPressed():
	print("Credits")
	credits.emit()
	
func quitButtonPressed():
	quitGame.emit()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var dimensions = get_viewport()
	
	startButton.position = Vector2(dimensions.size.x * 0.5 - (startButton.size.x / 2), dimensions.size.y * 0.5 - 70)
	creditsButton.position = Vector2(dimensions.size.x * 0.5 - (creditsButton.size.x / 2), dimensions.size.y * 0.5 + 15)
	quitButton.position = Vector2(dimensions.size.x * 0.5 - (quitButton.size.x / 2), dimensions.size.y * 0.5 + 100)
