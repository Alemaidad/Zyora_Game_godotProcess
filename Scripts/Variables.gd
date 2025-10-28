
extends Node

# --- Variables globales de vida ---
var max_hp: int = 100
var current_hp: int = 100

# --- Señal para notificar cambios en la vida ---
signal hp_changed(current, max)

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
