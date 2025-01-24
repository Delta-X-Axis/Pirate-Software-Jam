extends Game



signal addObject

var money = 0


func _ready():
	addObject.connect(addEntity)
	var temp = get_node("Wizard")
	temp.death.connect(playerDeath)
	
	temp = get_node("Treasure")
	temp.open.connect(AddMoney)
	temp = get_node("Treasure2")
	temp.open.connect(AddMoney)
	temp = get_node("Treasure3")
	temp.open.connect(AddMoney)
	temp = get_node("Treasure4")
	temp.open.connect(AddMoney)
	temp = get_node("Treasure5")
	temp.open.connect(AddMoney)
	temp = get_node("Treasure6")
	temp.open.connect(AddMoney)


func addEntity(ref):
	add_child(ref)

func playerDeath():
	end_run.emit()
	queue_free()

func AddMoney(amt):
	money += amt
	print(money)

func _on_body_entered(body):
	if body.is_in_group("Wizard"):
		end_run.emit()
		queue_free()
