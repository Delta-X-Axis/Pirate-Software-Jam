extends CharacterBody2D

###########################
## STATE MACHINE FOR Enemy
## 0 - Idle
## 1 - Wandering
## 2 - Attracted
## 3 - Frightened
## 4 - Interacting
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

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 2.0
	navigation_agent.target_desired_distance = 2.0
	print("Target Position: ", movement_target_position);

	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func _input(event):
	if event.is_action_pressed(&"Click"):
		movement_target_position = get_global_mouse_position();
		print("Target Position: ", movement_target_position);
		set_movement_target(movement_target_position)

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	# await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	count += 1;
	if(count >= 90):
		count = 0;
		print("Next_path_position: ", next_path_position, " || Distance to Target: ", navigation_agent.distance_to_target());

	if navigation_agent.is_navigation_finished(): # This is causing the guy to quit moving immediately
		return

	current_agent_position = global_position
	next_path_position = navigation_agent.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
