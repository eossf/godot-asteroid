extends Node2D
class_name Level

# 480x270 (-20 +20)
@onready var border_rect = %BorderVisualization
@onready var asteroids : Node2D = %Asteroids
@onready var screen_width : float = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var screen_height : float = ProjectSettings.get_setting("display/window/size/viewport_height")
@export var spawn_circle_radius : float = 350.0
@export var asteroid_scene : PackedScene
@export var asteroid_direction_variance : float = 15.0

@onready var screen_size = Vector2(screen_width, screen_height)

func spawm_asteroid() -> void:
	var screen_center : Vector2 = screen_size / 2.0
	# random point on circle wrapping level scene
	var angle_deg = randf_range(0.0, 360.0)
	var angle = deg_to_rad(angle_deg)
	var direction_to_point = Vector2.RIGHT.rotated(angle)
	var point:Vector2 = screen_center + direction_to_point * spawn_circle_radius
	var top_left:Vector2 = border_rect.global_position
	var bottom_right:Vector2 = border_rect.global_position + border_rect.size
	var point_asteroid:Vector2 = point.clamp(top_left, bottom_right)

	# instanciation
	var asteroid = asteroid_scene.instantiate()
	var direction_to_center = point.direction_to(screen_center)
	var dir_rotation = randfn(0.0, deg_to_rad(asteroid_direction_variance))
	asteroid.direction = direction_to_center.rotated(dir_rotation)
	asteroid.position = point_asteroid
	
	# add to node conaining all asteroids
	asteroids.add_child(asteroid)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		spawm_asteroid()
