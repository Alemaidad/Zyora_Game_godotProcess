class_name Personaje
extends CharacterBody2D
@export var speed = 100
@onready var Animaciones =$Animaciones

func _physics_process(delta: float) -> void:
	
	#Move Horizontal
	var Horizontal = Input.get_axis("Left","rigth")
	velocity.x = speed * Horizontal
	
	var vertical = Input.get_axis("Up","abajo")
	velocity.y = speed * vertical
	
	#hello
	
	
	
	
	move_and_slide()
	
	
	
