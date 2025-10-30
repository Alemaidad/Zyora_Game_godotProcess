extends Camera2D
@onready var Zona_Arriba: CollisionShape2D = $"../../ZonaCamara/Zona2/CollisionShape2D"
@onready var Zona_Abajo: CollisionShape2D = $"../../ZonaCamara/Zona1/CollisionShape2D"

func _ready():
	is_current()

func set_camera_limits(area: Area2D):
	var shape = area.get_node("CollisionShape2D").shape as RectangleShape2D
	var pos = area.global_position
	
	limit_left = pos.x - shape.size.x / 2
	limit_right = pos.x + shape.size.x / 2
	limit_top = pos.y - shape.size.y / 2
	limit_bottom = pos.y + shape.size.y / 2
	
	print("limites actualizados para: ", area.name)
	
