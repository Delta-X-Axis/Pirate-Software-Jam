extends CharacterBody2D

###########################
## STATE MACHINE FOR Enemy
## 0 - Idle - Doing Nothing
## 1 - Wandering - Walking around current room
## 2 - Attracted - Going towards treasure
## 3 - Frightened - Fleeing from enemy
## 4 - Interacting - Opening treasure chest
## 5 - Progressing - Moving to next room

var state = 0

var health = 5

var stateTimer
var transitionTime = 3.0

var movement = 55
var target

var detectArea
var treasure

var spells : Array
var current_spell = 0

var sprite

var count: int = 0;


signal addItem
signal selectSpell
signal castSpell
signal getHit

var movement_speed: float = 200.0
var movement_target_position: Vector2 = self.position; #= Vector2(60.0,180.0)
var current_agent_position: Vector2 = global_position
var next_path_position: Vector2 = movement_target_position;

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var currentRoom: Node2D = null;

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	#print("Target Position: ", movement_target_position);
	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func wander():
	# This script defines the wizard wandering around it's current room (STATE 1)
	# This script sets a random point in the current room as the wizards destination, and goes there
	if(currentRoom == null):
		return;
	
	var topLeft: Vector2 = currentRoom.get_child(0).shape.get_rect().position;
	var bottomRight: Vector2 = currentRoom.get_child(0).shape.get_rect().end;
	
	#print("Top: ", topLeft[0], " || Bottom: ", bottomRight[0]);
	#print("Left: ", topLeft[1], " || Right: ", bottomRight[1]);
	
	var randomPoint: Vector2 = Vector2(randi_range(topLeft[1], bottomRight[1]), randi_range(bottomRight[0], topLeft[0]));
	#print("RandomPoint: ", randomPoint);
	movement_target_position = randomPoint;
	set_movement_target(movement_target_position)
	pass;

func _input(event):
	if event.is_action_pressed(&"Click"):
		movement_target_position = get_global_mouse_position();
		#print("Target Position: ", movement_target_position);
		set_movement_target(movement_target_position)

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	# await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	if(count >= 90):
		count = 0;
		print("Current Room: ", currentRoom);
		wander();
		print("Next_path_position: ", next_path_position, " || Distance to Target: ", navigation_agent.distance_to_target());

	if navigation_agent.is_navigation_finished(): # This is causing the guy to quit moving immediately
		state = 0;
		count += 1;
		return

	current_agent_position = global_position
	next_path_position = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	
func _on_room_entered(room):
	print("Room Entered: ", room);
	if (room.is_in_group("Room")):
		currentRoom = room;
	return

#func _on_body_entered(body):
	#if (body.is_in_group("Treasure")):
		#if state == 3:
			#return
		#treasure = body
		#setAttracted(body.position)
		#return

func on_area_2d_area_entered(area):
	print("Area Entered: ", area);
	if (area.is_in_group("Room")):
		currentRoom = area;
	return

#func _on_spawn_area_entered(area):
	#print("PRINT");
	#print("Spawn Entered: ", area);
	#pass # Replace with function body.
#
#
#func _on_spawn_body_entered(body):
	#print("Spawn Body Entered: ", body);
	#if (body.is_in_group("Room")):
		#currentRoom = body;
	#pass # Replace with function body.


func _on_spawn_room_entered(room):
	print("Room Entered: ", room.name);
	currentRoom = room;
	pass # Replace with function body.
