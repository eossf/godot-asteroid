extends Area2D
class_name Asteroid

func _on_body_entered(body: Node2D):
	body.destroy()
