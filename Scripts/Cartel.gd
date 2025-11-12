extends StaticBody2D

# Cargamos la escena del pergamino
var charge_cartel = preload("res://escenas/Flotante/pergamino.tscn")

# Referencia al personaje
@onready var personaje = get_parent().get_node("Personaje")
@onready var rich_text_label: RichTextLabel = $RichTextLabel
@export var TextoCartel: String = "Texto por defecto" 

var Zona_cartel_active = false
var instancia = null
var cartel_visible = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		Zona_cartel_active = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Personaje":
		Zona_cartel_active = false


func _process(delta: float) -> void:
	if Zona_cartel_active and Input.is_action_just_pressed("secundary"):
		if not cartel_visible:
			mostrar_cartel()
		else:
			ocultar_cartel()


func mostrar_cartel() -> void:
	instancia = charge_cartel.instantiate()
	add_child(instancia)
	cartel_visible = true
	personaje.set_physics_process(false)
	
	var label = instancia.get_node("RichTextLabel")
	label.text = TextoCartel

func ocultar_cartel() -> void:
	if instancia:
		instancia.queue_free()
		instancia = null
	cartel_visible = false
	personaje.set_physics_process(true)
