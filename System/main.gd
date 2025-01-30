extends Node2D


## SCENES TO LOAD ##
#  Title (May rename to Menus)
@export var startScene: PackedScene
var mainMenu

@export var creditsScene: PackedScene
var credits

#  Scene of actual run
@export var gameScene: PackedScene
var game


## on Ready
func _ready():
	loadTitle()

func loadTitle():
	mainMenu = startScene.instantiate()
	add_child(mainMenu)
	
	## Connect Title Signals
	mainMenu.quitGame.connect(quitGame)
	
	mainMenu.credits.connect(deloadTitle)
	mainMenu.credits.connect(loadCredits)
	
	mainMenu.startRun.connect(deloadTitle)
	mainMenu.startRun.connect(startRun)
	
func deloadTitle():
	mainMenu.queue_free()
	
func loadCredits():
	credits = creditsScene.instantiate()
	add_child(credits)
	
	credits.quitMenu.connect(deloadCredits)
	credits.quitMenu.connect(loadTitle)
	
	
func deloadCredits():
	credits.queue_free()
	
	
func startRun():
	## Instantiate a run
	game = gameScene.instantiate()
	add_child(game)
	
	
	GameBus.didWin = false
	## Connect signals
	game.end_run.connect(endRun)
	game.end_game.connect(quitGame)
	
func endRun():
	## Disconnect signals
	game.end_run.disconnect(endRun)
	game.end_game.disconnect(quitGame)
	
	## remove game instance and load title menu
	game.queue_free()
	loadTitle()
	
func quitGame():
	## Quit to desktop
	get_tree().quit()

func _process(_delta):
	pass
