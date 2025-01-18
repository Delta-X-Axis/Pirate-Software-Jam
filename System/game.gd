class_name Game
extends Node

###########
## MENUS ##
###########

#  Pause Menu
@export var pauseScene: PackedScene
var pauseMenu


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
	pass
	
	
func startWorld():
	pass
	
	
func processInputs():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
