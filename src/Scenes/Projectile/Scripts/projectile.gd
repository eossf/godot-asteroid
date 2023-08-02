extends Node2D

@export var speed = 400.0

var direction := Vector2.RIGHT

func _physics_process(delta):
	var velocity = direction * speed * delta
	global_position += velocity
