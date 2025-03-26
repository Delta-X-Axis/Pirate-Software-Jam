extends CharacterBody2D

###########################
## STATE MACHINE FOR Enemy
## 0 - Idle - Doing Nothing
## 1 - Wandering - Walking around current room
## 2 - Attracted - Going towards treasure
## 3 - Frightened - Fleeing from enemy
## 4 - Interacting - Opening treasure chest
## 5 - Completing - Completing Room
## 6 - Progressing - Moving to next room

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

var sprite : AnimatedSprite2D = null;

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

var prevRoom: Node2D = null;
var currentRoom: Node2D = null;
var nextRoom: Node2D = null;

func _ready():
	detectArea = get_node("Area2D")
	
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	
	actor_setup.call_deferred()
	
	stateTimer = timer.new()
	stateTimer.wait_time = transitionTime
	stateTimer.callback.connect(setWander)
	add_child(stateTimer)
	stateTimer.start()
	
	var spell = Magic_Missile.new()
	add_child(spell)
	spells.append(spell)
	
	spell = Illusory_Treasure.new()
	add_child(spell)
	spells.append(spell)
	
	spell = Thunderclap.new()
	add_child(spell)
	spells.append(spell)
	
	sprite = get_node("Sprite")
	get_node("PlayerUi").setSpells()

func setIdle():
	# This function defines the IDLE state (state 0)
	# Here the wizard stops moving for a short period of time
	
	state = 0
	
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setWander)
	
	movement_target_position = position;
	set_movement_target(movement_target_position);
	
	stateTimer.wait_time = transitionTime
	stateTimer.reset()
	stateTimer.start()
	sprite.stop()
	return

func setWander():
	# This script defines the wizard wandering around it's current room (STATE 1)
	# This script sets a random point in the current room as the wizards destination, and goes there
	
	if(currentRoom == null): # Might set state to IDLE if there is no current room... tbd
		return;
		
	state = 1
	
	var topLeft: Vector2 = currentRoom.get_child(0).shape.get_rect().position;
	var bottomRight: Vector2 = currentRoom.get_child(0).shape.get_rect().end;
	
	var randomPoint: Vector2 = Vector2(randf_range(topLeft[1], bottomRight[1]), randf_range(bottomRight[0], topLeft[0]));
	
	while(position.distance_to(randomPoint) < navigation_agent.target_desired_distance * 1.1):
		print("REROLL!")
		randomPoint = Vector2(randf_range(topLeft[1], bottomRight[1]), randf_range(bottomRight[0], topLeft[0]));
	
	movement_target_position = randomPoint;
	set_movement_target(movement_target_position);
	
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setIdle);
	stateTimer.wait_time = randf_range(3.0,5.0);
	stateTimer.reset()
	stateTimer.start()

func _input(event):
	if event.is_action_pressed(&"Click"):
		movement_target_position = get_global_mouse_position();
		##print("Target Position: ", movement_target_position);
		set_movement_target(movement_target_position)
		state = 1;

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	# await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target


func inputs():
	if Input.is_action_just_pressed("Click"):
		spells[current_spell].cast()
		castSpell.emit()
	if Input.is_action_just_pressed("Select Magic Missile"):
		current_spell = 0
		selectSpell.emit(current_spell)
	if Input.is_action_just_pressed("Select Treasure Illusion"):
		current_spell = 1
		selectSpell.emit(current_spell)
	if Input.is_action_just_pressed("Select Thunderclap"):
		current_spell = 2
		selectSpell.emit(current_spell)

func hit(dmg, _pos):
	health -= dmg
	if health <= 0:
		die()
		return
	getHit.emit()
	#setFrightened(pos)

func die():
	GameBus.endGame.emit()

func move():
	if navigation_agent.is_navigation_finished():
		state = 0;
	
	if state == 0 ||state == 4: # If Idle or Interacting
		return
	
	current_agent_position = global_position
	next_path_position = navigation_agent.get_next_path_position()
	
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed # Set his velocity
	if state == 3: # If frightened, run faster
		velocity *= 1.5
	detectArea.rotation = velocity.angle()
	
	var dir = velocity.angle() # Determine angle of movement
	
	# Determine which sprite to display
	if dir < PI/4 && dir >-PI/4:
		sprite.play("Right")
	if dir < PI/4 * 3 && dir >PI/4:
		sprite.play("Down")
	if abs(velocity.angle_to(Vector2.LEFT)) < PI/4:
		sprite.play("Left")
	if dir < -PI/4 && dir >-PI/4*3:
		sprite.play("Up")
	
	move_and_slide() # Move
	
	if (position.distance_to(movement_target_position) <= navigation_agent.target_desired_distance): # If close...
		match state:
			1: # Idle
				sprite.stop();
				setIdle() # Wander
			2: # Attracted
				if treasure != null: # If you aren't looting, loot
					#interact()
					pass;
			3: # Frightened
				setIdle() # Wander (you've run far enough)

func _physics_process(_delta):
	#inputs();
	move();

func _on_spawn_room_entered(room):
	print("Room Entered: ", room.name);
	currentRoom = room;
	pass # Replace with function body.
