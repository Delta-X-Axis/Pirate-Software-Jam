class_name room_class

extends Area2D

var visited: bool = false;
var completed: bool = false;
var neighbors: Array[String] = [];
var collisionShape2D: CollisionShape2D = null;
@export var isHallway : bool = false;
@export var dimensions : Vector2 = Vector2(0, 0);

signal room_entered(room)

func _draw():
	draw_rect(collisionShape2D.shape.get_rect(), Color("red"), false);
	pass;
#func _input(event):
	#if event.is_action_pressed(&"Click"):
		#print("Room:", self.has_overlapping_bodies());
		#if(self.has_overlapping_bodies()):
			#print("Room:", self.get_overlapping_bodies())

# Called when the node enters the scene tree for the first time.
func _ready():
	if(dimensions[0] == 0 || dimensions[1] == 0):
		return;
	
	if(self.get_child_count() < 1):
		return;
	
	collisionShape2D = self.find_child("CollisionShape2D", false);
	if(collisionShape2D == null):
		return;
	else:
		collisionShape2D.shape.size = dimensions;
		# THIS CODE DOENS'T WORK!!! UGH...
	
	#collisionShape2D.connect("_on_body_entered(body)", _on_body_entered(CharacterBody2D));
	# Connect on_body_entered() from collisionShape2D
	
	add_to_group("Room")
	pass # Replace with function body.

func _on_body_entered(body):
	
	#print("$Body Entered: ", body,"$");
	if body.is_in_group("Wizard"):
		#emit_signal("room_entered", self)
		GameBus.current_room.emit(self);
		pass;

	pass;
