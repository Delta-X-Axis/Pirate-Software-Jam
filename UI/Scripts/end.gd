extends Node2D

var titleButton
var quitButton

var scoreLabel
var scoreDisplay

var timeLabel
var timeDisplay


var margin = 10

signal quitGame
signal title

# Called when the node enters the scene tree for the first time.
func _ready():
	var dimensions = get_viewport()
	
	titleButton = get_node("ReturnToMenu")
	titleButton.size.x = 300
	titleButton.text = "Return to Main Menu"
	titleButton.position = Vector2(dimensions.size.x * 0.5 - (titleButton.size.x / 2), dimensions.size.y * 0.5 - 70)
	titleButton.pressed.connect(self.titleButtonPressed)
	
	quitButton = get_node("Quit")
	quitButton.size.x = 300
	quitButton.text = "Quit To Desktop"
	quitButton.position = Vector2(dimensions.size.x * 0.5 - (quitButton.size.x / 2), dimensions.size.y * 0.5 + 50)
	quitButton.pressed.connect(self.quitButtonPressed)

	
	scoreLabel = get_node("Score Label")
	scoreLabel.size.x = 300

	scoreDisplay = get_node("Score")
	scoreDisplay.size.x = 300
	scoreDisplay.text = str(GameBus.points)
	
	

func titleButtonPressed():
	title.emit()
	
func quitButtonPressed():
	quitGame.emit()

func display():
	var dimensions = get_viewport().size

	scoreLabel.position.x = dimensions.x/2 - scoreLabel.size.x/2
	scoreLabel.position.y = dimensions.y/2 - (margin * 3)
	
	scoreDisplay.position.x = dimensions.x/2 - scoreDisplay.size.x/2 + scoreLabel.size.x/2
	scoreDisplay.position.y = dimensions.y/2 - (margin * 3)

	titleButton.position.x = dimensions.x/2 - titleButton.size.x/2
	titleButton.position.y = dimensions.y/2 + margin

	quitButton.position.x = dimensions.x/2 - quitButton.size.x/2
	quitButton.position.y = titleButton.position.y + titleButton.size.y + margin

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	display()
