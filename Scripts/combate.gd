extends Node2D
@onready var barra_vida_jugador: TextureProgressBar = $player/BarraVidaJugador
@onready var texto_accion: Label = $Texto_accion
@onready var barra_vida_enemy: TextureProgressBar = $enemy/BarraVidaEnemy
@onready var objeto: Button = $Panel/Objeto
@onready var huir: Button = $Panel/Huir
@onready var atacar: Button = $Panel/Atacar
@onready var animacion_player: AnimatedSprite2D = $player/AnimatedSprite2D
@onready var animacion_enemy: AnimatedSprite2D = $enemy/animacion

var Vida_jugador = Variables.max_hp
var Vida_Enemy = Variables.max_hp
var jugadorVida = Vida_jugador
var EnemyVida = Vida_Enemy

var dano = randi_range(10,25)

var turno_jugador:bool = true
var Combate_activo:bool = true



func _ready() -> void:
	barra_vida_jugador.max_value = Variables.max_hp
	barra_vida_enemy.max_value = EnemyVida
	actualizar_barras()
	texto_accion.text = "EMPIEZA LA BATALLA"
	
	atacar.pressed.connect(_on_ataque_pressed)
	objeto.pressed.connect(_on_object_pressed)
	huir.pressed.connect(_on_huir_pressed)
	animacion_player.animation_finished.connect(_on_animated_sprite_2d_animation_finished)
	Variables.connect("hp_changed",Callable(self,"_on_hp_changed"))

func _on_hp_changed(current: int, max:int)-> void:
	barra_vida_jugador.max_value = max
	barra_vida_jugador.value = current
	
func actualizar_barras():
	barra_vida_jugador.value = jugadorVida
	barra_vida_enemy.value = EnemyVida
	
func _on_ataque_pressed():
	if not turno_jugador or not Combate_activo:
		return
	Animation_change()
	texto_accion.text = "ATACASTE, HICISTE %d DE DAÑO." % dano
	EnemyVida -= dano
	if EnemyVida <= 0:
		EnemyVida = 0
		texto_accion.text ="¡EL ENEMIGO HA PERDIDO!"	
		Combate_activo = false
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://escenas/Mapa/mapa.tscn")
	else:
		await  get_tree().create_timer(1.5).timeout
		turno_jugador = false
		turno_enemy()
	actualizar_barras()

	
func _on_object_pressed():
	pass


func _on_huir_pressed():
	var posibility_escape = randi_range(1,100)
	if posibility_escape >= 40:
		if not Combate_activo:
			return
		texto_accion.text = "Escapaste con exito"
		Combate_activo = false
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://escenas/Mapa/mapa.tscn")
	else:
		await  get_tree().create_timer(1.5).timeout
		turno_jugador = false
		turno_enemy()
	actualizar_barras()


func turno_enemy():
	if not Combate_activo:
		return
	texto_accion.text = "¡EL ENEMIGO TE ATACA!"
	await get_tree().create_timer(1.5).timeout
	jugadorVida -= dano
	animacion_enemy.play("atack_1")
	if jugadorVida <= 0:
		jugadorVida = 0
		texto_accion.text = "¡DESPIDETE!"
		Combate_activo = false
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file("res://escenas/Mapa/mapa.tscn")
	else:
		texto_accion.text = "¡RECIBISTE %d DE DAÑO!" % dano
	turno_jugador = true
	actualizar_barras()
	pass
	
func _on_animated_sprite_2d_animation_finished():
	animacion_player.play("position_combat")
func Animation_change():
	if dano <= 15:
		animacion_player.play("atack_1")
	elif dano <= 20:
		animacion_player.play("atack_3")
	else:
		animacion_player.play("atack_2")


func animation_enemy_finish() -> void:
	animacion_enemy.play("default")
