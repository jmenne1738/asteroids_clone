#test

extends CharacterBody2D

@export var acceleration := 10.0
@export var max_speed := 350
@export var rotation_speed := 250.0

func _physics_process(delta):
	#Vector2(x axis, y axis)
	#Y axis is either 1 or -1 depending on user input
	var input_vector := Vector2(0, Input.get_axis("move_forward", "move_backward"))
	#user input is * by acceleration to give velocity in given direction
	velocity += input_vector.rotated(rotation) * acceleration
	velocity = velocity.limit_length(max_speed)
	
	if Input.is_action_pressed("rotate_right"):
		rotate(deg_to_rad(rotation_speed * delta))
	if Input.is_action_pressed("rotate_left"):
		rotate(deg_to_rad(-1 * rotation_speed * delta))
		
	#if there is no input on the y axis
	if input_vector.y == 0:
		#move_toward moves (arg1) to (arg2) at given delta (arg3) AKA gradually slows the player when there is no Y input
		velocity = velocity.move_toward(Vector2.ZERO, 3)
	
	move_and_slide()
	
	var screen_size = get_viewport_rect().size
	
	#if player is above the top of the screen
	if global_position.y < 0:
		#teleport them to the bottom
		global_position.y = screen_size.y
	#elif player is below the screen
	elif global_position.y > screen_size.y:
		#teleport them to the top
		global_position.y = 0
	if global_position.x < 0:
		global_position.x = screen_size.x
	elif global_position.x > screen_size.x:
		global_position.x = 0
