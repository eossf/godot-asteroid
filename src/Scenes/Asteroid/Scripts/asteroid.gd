extends Area2D
class_name Asteroid

var direction := Vector2.RIGHT
@export var speed = 200.0
@export var torque = 50.0

func _physics_process(delta):
	var velocity = delta * speed * direction
	global_position += velocity
	rotation_degrees += delta * torque
	
func _on_body_entered(body: Node2D):
	if body is Player:
		body.destroy()
