extends Area2D

signal room_entered(name)

func _ready():
	add_to_group("Room")
	connect("body_entered", _on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_body_entered(body):
	#print("$Body Entered: ", body,"$");
	if body.is_in_group("Wizard"):
		emit_signal("room_entered", self)
	pass;
