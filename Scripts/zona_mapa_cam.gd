extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Personaje":
		var camera_2d: Camera2D = $"../../Personaje/Camera2D"
		camera_2d.set_camera_limits(self)
