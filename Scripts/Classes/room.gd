class_name room_class

extends Area2D

var visited: bool = false;
var completed: bool = false;
var neighbors: Array[String] = [];
var area2d: Area2D = null;

signal room_entered(room)

func _input(event):
	if event.is_action_pressed(&"Click"):
		print("Room:", self.has_overlapping_bodies());
		if(self.has_overlapping_bodies()):
			print("Room:", self.get_overlapping_bodies())

# Called when the node enters the scene tree for the first time.
func _ready():
	if(self.get_child_count() < 1):
		return;
	
	area2d = self.find_child("Area2D", false);
	if(area2d == null):
		return;
	
	area2d.connect("_on_body_entered(body)", _on_body_entered(CharacterBody2D));
	# Connect on_body_entered() from area2d
	
	add_to_group("Room")
	pass # Replace with function body.

func _on_body_entered(body):
	GameBus.current_room.emit(self);
	#print("$Body Entered: ", body,"$");
	if body.is_in_group("Wizard"):
		#emit_signal("room_entered", self)
		pass;
	pass;
