extends CharacterBody2D

@export var max_speed : float = 200.0
var speed : float = 0.0
var direction := Vector2.ZERO
var last_direction := Vector2.ZERO
@export_range(0.0, 0.1) var acceleration_factor : float = 0.1
@export_range(0.0, 0.1) var rotation_acceleration_factor : float = 0.1
@export var projectile_scene : PackedScene

signal projectile_fired(projectile)

func _ready():
	pass

# every frame call this func
func _physics_process(delta):
	move_ship_with_direction_keys()
	rotate_ship_with_mouse()
	
func _input(event):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction != Vector2.ZERO:
		last_direction = direction

	if event.is_action_pressed("fire"):
		fire()

func fire():
	var projectile = projectile_scene.instantiate()
	projectile_fired.emit(projectile)

func move_ship_with_direction_keys():
	if direction == Vector2.ZERO:
		speed = lerp(speed, 0.0, acceleration_factor)
	else:
		speed = lerp(speed, max_speed, acceleration_factor)
	
	# movement keys direction
	velocity = last_direction * speed
	move_and_slide()

func rotate_ship_with_mouse():
	# rotation mouse
	var mouse_pos = get_global_mouse_position()
	var angle = global_position.angle_to_point(mouse_pos)
	rotation = lerp_angle(rotation, angle, rotation_acceleration_factor)
