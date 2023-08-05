extends Node2D
class_name Projectile

@export var speed = 400.0

@onready var direction := Vector2.RIGHT.rotated(rotation)

func _physics_process(delta):
	var velocity = direction * speed * delta
	global_position += velocity
