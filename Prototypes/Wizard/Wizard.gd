extends CharacterBody2D


###########################
## STATE MACHINE FOR Enemy
## 0 - Idle
## 1 - Wandering
## 2 - Attracted
## 3 - Frightened
## 4 - Interacting
var state = 0

var current_spell = 0

var health = 20
var stateTimer
var transitionTime = 3.0

var movement = 55
var target

var detectArea
var treasure

var spells : Array
var spell : Spell



func _ready():
	detectArea = get_node("Area2D")
	
	stateTimer = timer.new()
	stateTimer.wait_time = transitionTime
	stateTimer.callback.connect(setWander)
	add_child(stateTimer)
	stateTimer.start()
	
	


func setIdle():
	state = 0
	
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setWander)
	
	velocity = Vector2.ZERO
	target = null
	stateTimer.wait_time = transitionTime
	stateTimer.reset()
	stateTimer.start()
	return

func setWander():
	state = 1
	var wanderDirection = randf_range(-PI, PI)
	var wanderDistance = randi_range(50, 300)
	
	target = position + (Vector2.from_angle(wanderDirection) * wanderDistance)

func setFrightened(pos):
	if state == 4:
		return
		
	state = 3
	
	var runDirection = position.direction_to(pos).rotated(PI)
	var offset = randf_range(-0.5, 0.5)
	runDirection = runDirection.rotated(offset)
	
	target = position + runDirection*1000
	
	var runTime = randf_range(2.0, 4.0)
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	stateTimer.callback.connect(setIdle)
	stateTimer.wait_time = runTime
	stateTimer.reset()
	stateTimer.start()

func setAttracted(pos):
	if state == 3:
		return
		
	state = 2
	target = pos


func interact():
	if state == 3 || treasure == null:
		return
		
	state = treasure._interact()
	velocity = Vector2.ZERO
	var interactTime = 2.0
	for dict in stateTimer.callback.get_connections():
		stateTimer.callback.disconnect(dict.callable)
	
	if state == 0:
		treasure.queue_free()
		stateTimer.callback.connect(setWander)
		return
	
	if state == 4:
		stateTimer.callback.connect(setIdle)
		stateTimer.callback.connect(treasure.queue_free)
		stateTimer.wait_time = interactTime
		stateTimer.reset()
		stateTimer.start()
		

func inputs():
<<<<<<< HEAD
	if Input.is_action_just_pressed("Click"):
		spell.cast()
	if Input.is_action_just_pressed("Select Magic Missile"):
		current_spell = 0
		print("MAGIC MISSILE!")
	if Input.is_action_just_pressed("Select Treasure Illusion"):
		current_spell = 1
		print("A treasure chest?")
	if Input.is_action_just_pressed("Select Thunderclap"):
		current_spell = 2
		print("THUNDERCLAP!")
=======
	if Input.is_action_just_pressed("Num1"):
		spells[0].cast()
>>>>>>> 95c83d31ab6f5521f0444ca80448f293436a91f3

func move():
	if state == 4:
		return
	
	velocity = position.direction_to(target) * movement
	if state == 3:
		velocity *= 1.5
	detectArea.rotation = velocity.angle()
	
	move_and_slide()
	
	if (position.distance_to(target) <= 20):
		match state:
			1:
				setIdle()
			2:
				if treasure != null:
					interact()
			3:
				setIdle()

func _process(_delta):
	match state:
		1:
			move()
		2:
			move()
		3:
			move()
			
	inputs()
	if current_spell == 0:
		spell = Magic_Missile.new()
		add_child(spell)
		spells.append(spell)
	if current_spell == 1:
		spell = Illusory_Treasure.new()
		add_child(spell)
		spells.append(spell)
	if current_spell == 2:
		spell = Thunderclap.new()
		add_child(spell)
		spells.append(spell)

func _on_body_entered(body):
	if (body.is_in_group("Enemy")):
		setFrightened(body.position)
		return
	if (body.is_in_group("Treasure")):
		if state == 3:
			return
		treasure = body
		setAttracted(body.position)
		return
