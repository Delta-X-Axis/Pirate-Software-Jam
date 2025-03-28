extends Node
class_name Room
#This script describes the behavior and hold the metadat for the room object.

var room_ID : int #Identifier for the room
var doors : Array #Vector2 locations of all the doors in the room.
var poi : Array #Points of interest in the room
var explored = false #Completion state of the room
var adjacent : Array #Adjacent rooms


func _ready():
	pass 



func _process(delta):
	pass

#Function that adds actions to the wizards to-do list
func ExploreRoom(pois):
	var poiindex = 0
	var currpoi
	while poiindex <= pois.length:
		currpoi = pois.get(poiindex)
		currpoi.GetPriority()
		

func GetAdjacent():
	var doorindex = 0
	var currdoor
	while doorindex <= doors.length:
		currdoor = 

#Code that runs when wizard enters the room.
func RoomSetup():
	if explored = false:
		ExploreRoom() 

#Signal wizard entry here, uncomment.
	#RoomSetup()
