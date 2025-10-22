class_name Personaje
extends CharacterBody2D
@onready var Sprite = $Animaciones
@export var speed = 100

func _process(delta):
	
	var move = false
	
	
	#Animacion de caminar
	if Input.is_action_pressed("Left") and Input.is_action_pressed("primary"):
		Sprite.play("run_left")
		move= true
	elif Input.is_action_pressed("Left"):
		Sprite.play("walk_left")
		move = true
	elif Input.is_action_pressed("rigth") and Input.is_action_pressed("primary"):
		Sprite.play("run_rigth")
		move=true
	elif Input.is_action_pressed("rigth"):
		Sprite.play("walk_rigth")
		move = true	
	elif Input.is_action_pressed("Up") and Input.is_action_pressed("primary"):
		Sprite.play("run_back")
		move=true
	elif Input.is_action_pressed("Up"):
		Sprite.play("walk_back")
		move = true
	elif Input.is_action_pressed("abajo") and Input.is_action_pressed("primary"):
		Sprite.play("run_front")
		move = true
	elif Input.is_action_pressed("abajo"):
		Sprite.play("walk_front")
		move = true
		#animacion de personaje quieto
	if not move:
		match Sprite.animation:
			"walk_left":
				Sprite.play("static_left")
			"walk_rigth":
				Sprite.play("static_rigth")
			"walk_front":
				Sprite.play("static_front")
			"walk_back":
				Sprite.play("static_back")
			"run_left":
				Sprite.play("static_left")
			"run_rigth":
				Sprite.play("static_rigth")
			"run_back":
				Sprite.play("static_back")
			"run_front":
				Sprite.play("static_front")

func _physics_process(delta):
	
	#Move Horizontal
	var Horizontal = Input.get_axis("Left","rigth")
	var vertical = Input.get_axis("Up","abajo")
	velocity.y = speed * vertical
	velocity.x = speed * Horizontal
	
	#Sprint
	if Input.is_action_pressed("primary"): 
		if Horizontal !=0:
			velocity.x = (speed * 2) * Horizontal
		if  vertical !=0:
			velocity.y = (speed * 2 ) * vertical
	move_and_slide()
	
	
	
