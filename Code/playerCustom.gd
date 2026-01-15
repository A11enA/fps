extends CharacterBody3D
#move cam w/ mouse
#move player w/ keyboard
#constrain mouse
#jump
#capture mouse
@export var gravity:float = 10

func ready() -> void:
	#capture the mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void: 
	
	if event is InputEventMouseMotion:
		#rotate player
		rotation_degrees.y -= event.screen_relative.x * .5
		#roatate up and down camera
		%Camera3D.rotation_degrees.x -= event.screen_relative.y * .2
		%Camera3D.rotation_degrees.x = clamp(%Camera3D.rotation_degrees.x, -80, 80)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("Restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("Fullscreen"):
		#bool true or false
		var fs = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
		if fs:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
func _physics_process(delta: float) -> void:
	const SPEED = 5.5 #meters per second
	#walk
	var input_direction_2D = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	#make 2d vector into 3d 
	var input_direction_3D = Vector3(input_direction_2D.x, 0, input_direction_2D.y)
	
	#this basis is player's current roation
	var direction = transform.basis * input_direction_3D
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	### jumping ###
	#gravity
	#y direction
	velocity.y -= gravity * delta
	#check for jump key
	if Input.is_action_just_pressed("jump_key"):
		velocity.y = 10
	
	move_and_slide()
