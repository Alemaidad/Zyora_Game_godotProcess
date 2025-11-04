class_name Personaje
extends CharacterBody2D
@onready var Sprite = $Animaciones
@export var speed = 100
@onready var control: Control = $"../Control"
@onready var Are: Area2D = $"../Zona_Nube"
const VILLAGE_DIALOG = preload("uid://dvp0rffh2jssb")

var Player_is_close = false
var DialogueIsActive = false



func _ready() -> void:
	$Camera2D.make_current()
	$"../Control".visible = false
	DialogueManager.dialogue_started.connect(on_dialogue_started)
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)

func on_dialogue_ended(dialogue):
	await get_tree().create_timer(0.4).timeout
	DialogueIsActive = false

func on_dialogue_started(dialogue):
	DialogueIsActive = true

func _process(delta):
	if Player_is_close and Input.is_action_pressed("secundary") and not DialogueIsActive:
		DialogueManager.show_dialogue_balloon(VILLAGE_DIALOG, "Start")
		control.visible = false
	
	var move = false
		
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
		
	
	if Input.is_action_pressed("Left") and Input.is_action_pressed("rigth"):
		Sprite.play("static_front")
	if not move:
		Sprite.play("static_" + Sprite.animation.split("_")[1])
	
		


func _physics_process(delta):
	if DialogueIsActive:
		return
		
	
	#Move Horizontal
	var Horizontal = Input.get_axis("Left","rigth")
	var vertical = Input.get_axis("Up","abajo")
	velocity.y = speed * vertical
	velocity.x = speed * Horizontal
	
	#Sprint
	if Input.is_action_pressed("primary"): 
		if Horizontal !=0:
			velocity.x = (speed * 1.5) * Horizontal
		if  vertical !=0:
			velocity.y = (speed * 1.5) * vertical
	move_and_slide()

	
	


func _on_zona_nube_body_entered(body: Node2D) -> void:
	Player_is_close = true
	if body.name == "Personaje":
		control.visible = true
		control.mostrar_frase_aleatoria()



func _on_zona_nube_body_exited(body: Node2D) -> void:
	Player_is_close = false
	if body.name == "Personaje":
		control.visible = false
