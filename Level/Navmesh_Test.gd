extends Node2D

# Note: This is a glorified text document, mainly to explain what the purpose of NavMesh Test is
#
# Navigation:
# The wizard will Flee, Loot, Doot, Continue, in order of decreasing priority
#	- Flee: When agressed, will run to last safe room / farthest corner of room (5s once danger gone)
#	- Loot: If no enemies, loot all chests in room (5s each)
#	- Doot: If no chests, "complete" room (5s)
#		- This can be solving a puzzle, reading runes, etc., but for now will be a loading bar
#	- Continue: If room complete, go to next room
#		- Will choose between all non-completed paths, favoring main path at 2:1.
#			- Player can pick which way (somehow)
#
# Enemies will pursue or patrol
#	- If see's wizard in current room, attack wizard
#		- If wizard leaves room, "gaurd" entrance for 5s
#	- Patrol will be various "random" actions:
#		- Gaurding doors: standing facing them
#		- Inspect chests/runes: Look at chests/walls
#		- Patroling: Walking around room
#		- Conversing: Standing facing another enemy

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
