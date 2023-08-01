extends CharacterBody2D


var speed : float = 200.0
var direction := Vector2.ZERO

func _ready():
	pass

func _physics_process(delta):
	# movement keys direction
	velocity = direction * speed
	move_and_slide()
	# rotation mouse
	var mouse_pos = get_global_mouse_position()
	var angle = global_position.angle_to_point(mouse_pos)
	rotation = angle
	
func _input(event):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
