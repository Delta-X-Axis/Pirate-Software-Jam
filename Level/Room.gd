extends Node
class_name Room
#This script describes the behavior and hold the metadat for the room object.

var room_ID : int #Identifier for the room
var doors : Array #Vector2 locations of all the doors in the room.
var poiArray : Array #Points of interest in the room
var explored : bool = false #Completion state of the room

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
		


#Code that runs when wizard enters the room.
func RoomSetup():
	if !explored:
		ExploreRoom(poiArray)

#Signal wizard entry here, uncomment.
	#RoomSetup()
