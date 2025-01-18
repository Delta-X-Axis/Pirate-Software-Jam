class_name timer
extends Node

var time = 0
var isOn = false
var wait_time = 1

signal callback

#func _init():
#	isOn = false

func start():
	isOn = true
func stop():
	isOn = false
	
func reset():
	isOn = false
	time = 0
	
func _process(delta):
	if (!isOn):
		return
		
	time += delta
		
	if (time >= wait_time):
		reset()
		callback.emit()
