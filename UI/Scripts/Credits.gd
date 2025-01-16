extends Node2D

var nameContainer
var nameLabel
var name1
var name2
var name3
var name4
var name5

var margin = 10

var quitButton

signal quitMenu

var dimensions

# Called when the node enters the scene tree for the first time.
func _ready():
	nameLabel = get_node("Label")
	nameLabel.text = "Developers: "
	
	name1 = get_node("Name1")
	name1.text = "- Daran Parkman (Darredevyll)"
	
	name2 = get_node("Name2")
	name2.text = ""
	
	name3 = get_node("Name3")
	name3.text = ""
	
	name4 = get_node("Name4")
	name4.text = ""
	
	name5 = get_node("Name5")
	name5.text = ""
	
	
	quitButton = get_node("Quit")
	quitButton.text = "Main Menu"
	quitButton.pressed.connect(quitButtonPressed)

func quitButtonPressed():
	quitMenu.emit()

func display():
	dimensions = get_viewport().size
	
	## VERTICAL UP FROM CENTER
	name2.size.x = 300
	name2.position.x = dimensions.x/2 - nameLabel.size.x / 2
	name2.position.y = dimensions.y/2 - name2.size.y
	
	name1.size.x = 300
	name1.position.x = dimensions.x/2 - nameLabel.size.x / 2
	name1.position.y = name2.position.y - margin - name2.size.y
	
	nameLabel.size.x = 300
	nameLabel.position.x = dimensions.x/2 - nameLabel.size.x / 2
	nameLabel.position.y = name1.position.y - margin - name1.size.y
	
	## VERTICAL DOWN FROM CENTER
	name3.size.x = 300
	name3.position.x = dimensions.x/2 - nameLabel.size.x / 2
	name3.position.y = dimensions.y/2 + margin
	
	name4.size.x = 300
	name4.position.x = dimensions.x/2 - nameLabel.size.x / 2
	name4.position.y = name3.position.y + margin + name3.size.y
	
	name5.size.x = 300
	name5.position.x = dimensions.x/2 - nameLabel.size.x / 2
	name5.position.y = nameLabel.size.y
	name5.position.y = name4.position.y + name4.size.y + margin
	
	
	quitButton.size.x = 300
	quitButton.position.x = dimensions.x/2 - nameLabel.size.x / 2
	quitButton.position.y = name5.position.y + name5.size.y + margin + margin
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	display()
