extends Node


var points = 0


var didWin:bool = false

signal addItem
signal endGame
signal getPoints
signal current_room


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func addPoints(num):
	points += num
	getPoints.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
