
extends Node
@onready var dialogue_manager = get_node("/root/DialogueManager")


# --- Variables globales de vida ---
var max_hp: int = 100
var current_hp: int = 100

# --- Señal para notificar cambios en la vida ---
signal hp_changed(current, max)

func change_escena(path: String) -> void:
	var tree := Engine.get_main_loop()
	if tree and tree is SceneTree:
		# Cerrar el cuadro de diálogo si está activo
		if dialogue_manager and dialogue_manager.has_method("hide_balloon"):
			dialogue_manager.hide_balloon()
		# Espera un instante antes de cambiar
		await tree.create_timer(1).timeout
		
		tree.change_scene_to_file(path)
	else:
		push_error("No se pudo cambiar de escena: SceneTree no disponible")

# --- Función para recibir daño ---
func take_damage(amount: int):
	current_hp -= amount
	if current_hp < 0:
		current_hp = 0
	emit_signal("hp_changed", current_hp, max_hp)

# --- Función para curar ---
func heal(amount: int):
	current_hp += amount
	if current_hp > max_hp:
		current_hp = max_hp
	emit_signal("hp_changed", current_hp, max_hp)

# --- Función para reiniciar la vida (por ejemplo, al iniciar nueva partida) ---
func reset_hp():
	current_hp = max_hp
	emit_signal("hp_changed", current_hp, max_hp)
