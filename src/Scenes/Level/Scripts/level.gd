extends Node2D
class_name Level

# 480x270 (-20 +20)
@onready var border_rect = %BorderVisualization
@onready var asteroids : Node2D = %Asteroids
@onready var restart = %Restart
@onready var screen_width : float = ProjectSettings.get_setting("display/window/size/viewport_width")
@onready var screen_height : float = ProjectSettings.get_setting("display/window/size/viewport_height")
@onready var screen_size = Vector2(screen_width, screen_height)
@export var spawn_circle_radius : float = 350.0
@export var asteroid_scene : PackedScene
@export var asteroid_direction_variance : float = 15.0

func _ready():
	pass

func spawn_asteroid_on_border() -> void:
	var screen_center : Vector2 = screen_size / 2.0
	# random point on circle wrapping level scene
	var angle_deg = randf_range(0.0, 360.0)
	var angle = deg_to_rad(angle_deg)
	var direction_to_point = Vector2.RIGHT.rotated(angle)
	var point:Vector2 = screen_center + direction_to_point * spawn_circle_radius
	var top_left:Vector2 = border_rect.global_position
	var bottom_right:Vector2 = border_rect.global_position + border_rect.size
	var point_asteroid:Vector2 = point.clamp(top_left, bottom_right)
	var direction_to_center = point.direction_to(screen_center)
	var dir_rotation = randfn(0.0, deg_to_rad(asteroid_direction_variance))
	var random_size = randi_range(0, Asteroid.SIZE.size() - 1)
	spawm_asteroid(direction_to_center.rotated(dir_rotation), point_asteroid, random_size)

func spawm_asteroid(dir: Vector2, pos:Vector2, sz:Asteroid.SIZE) -> void:
	# instantiation
	var a = asteroid_scene.instantiate()
	# add to node containing all asteroids - must be done first
	asteroids.add_child.call_deferred(a)
	a.direction = dir
	a.position = pos
	a.size = sz
	a.destroyed.connect(_on_destroyed.bind(a))

func _on_timer_timeout():
	spawn_asteroid_on_border()

func _on_destroyed(asteroid_to_destroy: Asteroid):
	if asteroid_to_destroy.size > 0:
		for i in range(randi_range(2, 3)):
			var random_sign = [-1, 1].pick_random()
			var dir_rotation = random_sign * randfn(0.0, deg_to_rad(90.0 + asteroid_direction_variance))
			var direction = asteroid_to_destroy.direction.rotated(dir_rotation)
			spawm_asteroid(direction, asteroid_to_destroy.global_position, asteroid_to_destroy.size - 1)
	asteroid_to_destroy.queue_free()

func _on_button_pressed():
	get_tree().reload_current_scene()

func _on_player_player_destroyed():
	restart.visible = true
