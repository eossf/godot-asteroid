@tool
extends Area2D
class_name Asteroid

var direction := Vector2.RIGHT
enum SIZE{
	SMALL,
	MEDIUM,
	BIG,
}

@export var size:SIZE:
	set(value):
		size=value
		size_changed.emit()
@export var speed = 200.0
@export var torque = 50.0
@export var asteroids_size_array:Array[AsteroidsSize]
@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D

signal size_changed

func _ready() -> void:
	if Engine.is_editor_hint():
		set_physics_process(false)

func _physics_process(delta):
	var velocity = delta * speed * direction
	global_position += velocity
	rotation_degrees += delta * torque

func _on_body_entered(body: Node2D):
	if body is Player:
		body.destroy()

func _on_size_changed():
	assert(size in range(asteroids_size_array.size()), "Index of asteroid array not valid: must be between 0-" + str(asteroids_size_array.size()))
	var shape_instance = asteroids_size_array[size].shape
	var texture_instance = asteroids_size_array[size].texture
	collision_shape_2d.shape = shape_instance
	sprite_2d.texture = texture_instance
