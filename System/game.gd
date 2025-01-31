extends Node

###########
## MENUS ##
###########

#  Pause Menu
@export var pauseScene: PackedScene
var pauseMenu


@export var endScene: PackedScene
var endCard


#############
## SIGNALS ##
#############

signal end_run
signal end_game

####################
## GAME VARIABLES ##
####################

var gamePaused: bool = false

######################
## PLAYER VARIABLES ##
######################

var playerRef

# Called when the node enters the scene tree for the first time.
func _ready():
	GameBus.endGame.connect(endRun)
	GameBus.addItem.connect(addItem)
	
	
func startWorld():
	pass
	
	
func processInputs():
	pass


func addItem(ref):
	add_child(ref)

func endRun():
	end_run.emit()
	get_tree().paused = false;
	queue_free()
	
func endGame():
	end_game.emit()
	queue_free()

func loadEndCard():
	var kids = get_children()
	
	for i in kids.size():
		kids[i].queue_free()
	
	endCard = endScene.instantiate()
	add_child(endCard)
	endCard.title.connect(endRun)
	endCard.quitGame.connect(endGame)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_finish_body_entered(body):
	if body.is_in_group("Wizard"):
		GameBus.didWin = true
		loadEndCard()
