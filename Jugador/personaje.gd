class_name Personaje
extends CharacterBody2D
@onready var Sprite = $Animaciones
@export var speed = 100

func _process(delta: float) -> void:
	
	var move = false
	
	
	
	if Input.is_action_pressed("Left"):
		Sprite.play("walk_left")
		move = true
	elif Input.is_action_pressed("rigth"):
		Sprite.play("walk_rigth")
		move=true
	elif Input.is_action_pressed("Up"):
		Sprite.play("walt_back")
		move=true
	elif Input.is_action_pressed("abajo"):
		Sprite.play("walk_front")
		move = true
		
	if Input.is_action_just_pressed("abajo"):
		Sprite.play("static_front")
		move=false
		
	
	
	if not move:
		if Input.is_action_just_pressed("Up"):
			Sprite.play("run_back")
		

func _physics_process(delta: float) -> void:
	
	#Move Horizontal
	var Horizontal = Input.get_axis("Left","rigth")
	velocity.x = speed * Horizontal
	
	var vertical = Input.get_axis("Up","abajo")
	velocity.y = speed * vertical
	
	#animations


	
	
	
	
	
	move_and_slide()
	
	
	
