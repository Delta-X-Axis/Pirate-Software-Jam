extends Node2D

@onready var background = get_node("Background Cover")
@onready var menuFrame = get_node("List Color")
var menuFrameDimensions = Vector2(300, 200)
var menuPadding = 10
var menuElementNumber = 2

@onready var resumeButton = get_node("List Color/resumeButton")
signal resume

@onready var quitButton = get_node("List Color/quitButton")
signal quit

var dimensions : Vector2
var centerPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	resumeButton.text = "Resume"
	resumeButton.pressed.connect(resumePress)
	quitButton.text = "Quit to Title"
	quitButton.pressed.connect(quitPress)

func resumePress():
	resume.emit()

func quitPress():
	quit.emit()


func setCenterPosition(pos):
	centerPosition = pos

func displayPause():
	## Background
	dimensions = get_viewport().size
	background.size = Vector2(dimensions.x + 10, dimensions.y + 10)
	
	## Menu Frame
	menuFrame.size = menuFrameDimensions
	menuFrame.position.x = background.size.x / 2 - menuFrame.size.x/2
	menuFrame.position.y = background.size.y / 2 - menuFrame.size.y/2
	
	## Buttons
	resumeButton.size.x = menuFrame.size.x - menuPadding * 2
	resumeButton.size.y = menuFrame.size.y / menuElementNumber - menuPadding * 2
	resumeButton.position.x = menuPadding
	resumeButton.position.y = menuPadding
	
	quitButton.size.x = menuFrame.size.x - menuPadding * 2
	quitButton.size.y = menuFrame.size.y / menuElementNumber - menuPadding * 2
	quitButton.position.x = menuPadding
	quitButton.position.y = menuPadding + resumeButton.size.y + menuPadding
	
	position.x = centerPosition.x - (background.size.x/4)
	position.y = centerPosition.y - (background.size.y/4)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	displayPause()
