extends Game

func _ready():
	print("Test")
	super._ready()
	print(get_node("TestWand").MaxSpeed)
